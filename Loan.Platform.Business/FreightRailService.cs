using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Text;
using System.Text.Json;
using System.Threading.Tasks;
using Microsoft.Extensions.Configuration;
using StandardRail.RailCarLounge.Business.Helpers;
using StandardRail.RailCarLounge.Business.Pact;
using StandardRail.RailCarLounge.Models.FreightRailModels;
using StandardRail.RailCarLounge.Models.ViewModels;

namespace StandardRail.RailCarLounge.Business
{
    public class FreightRailService : IFreightRailService
    {
        private readonly IHttpClientFactory _httpClientFactory;
        private IConfiguration _configuration { get; }
        private string authToken { get; set; }

        public FreightRailService(IConfiguration configuration, IHttpClientFactory httpClientFactory)
        {
            _configuration = configuration ?? throw new ArgumentNullException(nameof(configuration));
            _httpClientFactory = httpClientFactory ?? throw new ArgumentNullException(nameof(httpClientFactory));
            authToken = _configuration["authToken"];
        }

        public async Task<GeocodeSingleSearchResponse> SearchByCity(string city, string countries = null, string states = null)
        {
            SingleSearchRequest singleSearchRequest = new SingleSearchRequest();
            GeocodeSingleSearchResponse geocodeSingleSearchResponse = default;
            singleSearchRequest.Query = new FieldQuery()
            {
                Field = "City",
                Value = city
            };
            singleSearchRequest.IncludeOnly = "City";
            singleSearchRequest.Country = countries;
            singleSearchRequest.MaxResults = 20;
            singleSearchRequest.States = states;

            string queryString = GenerateSingleSearchQuery(singleSearchRequest);
            string singleSearchAPIURL = _configuration["SingleSearchAPI"];
            var httpClient = _httpClientFactory.CreateClient();
            var httpResponseMessage = await httpClient.GetAsync($"{singleSearchAPIURL}/search?{queryString}");

            if (httpResponseMessage.IsSuccessStatusCode)
            {
                geocodeSingleSearchResponse = JsonSerializer.Deserialize<GeocodeSingleSearchResponse>(httpResponseMessage.Content.ReadAsStringAsync().Result);
            }
            return geocodeSingleSearchResponse;

        }

        public async Task<List<GeocodeStation>> GetGeocodeStation(string city, string state, string mark = null)
        {
            GeocodeStationRequest geocodeStationRequest = new GeocodeStationRequest()
            {
                Format = "StationState",
                Name = $"{city}*, {state}",
                Railroad = mark,
                IntermodalOnlyStations = true,
            };
            string queryString = GenerateGeocodeStationSearchQuery(geocodeStationRequest);
            string freightRailAPIURL = _configuration["FreightRailAPI"];
            var httpClient = _httpClientFactory.CreateClient();
            var httpResponseMessage = await httpClient.GetAsync($"{freightRailAPIURL}/geocode/Station?{queryString}");
            GeocodeStationResponse geocodeStationResponse = default;
            List<GeocodeStation> geocodeStations = new List<GeocodeStation>();
            if (!httpResponseMessage.IsSuccessStatusCode)
            {
                //var res = httpResponseMessage.Content.ReadAsStringAsync().Result;
                //throw new Helpers.AppException(res);
            }
            else
            {
                geocodeStationResponse = JsonSerializer.Deserialize<GeocodeStationResponse>(httpResponseMessage.Content.ReadAsStringAsync().Result);

                if (geocodeStationResponse != null && geocodeStationResponse.GeocodeInfos != null && geocodeStationResponse.GeocodeInfos.Count > 0)
                {
                    if (!string.IsNullOrEmpty(mark))
                    {
                        var markGeocodeInfos = geocodeStationResponse.GeocodeInfos.Where(e => e.Railroad.Trim().ToLower().Equals(mark.Trim().ToLower()));
                        if (markGeocodeInfos != null && markGeocodeInfos.Any())
                        {
                            geocodeStationResponse.GeocodeInfos = markGeocodeInfos.ToList();
                        }
                        else
                        {
                            return geocodeStations;
                        }
                    }
                    foreach (GeocodeInfo geocodeInfo in geocodeStationResponse.GeocodeInfos)
                    {
                        geocodeStations.Add(new GeocodeStation()
                        {
                            StationFullName = $"{geocodeInfo.StationName}-{geocodeInfo.Railroad}",
                            StationName = geocodeInfo.StationName,
                            Railroad = geocodeInfo.Railroad,
                            Latitude = geocodeInfo.Latitude / 1000000,
                            Longitude = geocodeInfo.Longitude / 1000000,
                            StationState = geocodeInfo.Stations.FirstOrDefault(e => e.Format == "StationState")?.Name.ToString(),
                            SPLC = Convert.ToInt32(geocodeInfo.Stations.FirstOrDefault(e => e.Format == "SPLC")?.Name),
                            R260 = geocodeInfo.Stations.FirstOrDefault(e => e.Format == "R260")?.Name.ToString(),
                            FSAC = Convert.ToInt32(geocodeInfo.Stations.FirstOrDefault(e => e.Format == "FSAC")?.Name),
                        });
                    }
                }
            }
            return geocodeStations;
        }

        public async Task<RailReport> GetDetailedGeocodeRouteReportForSPLC(FacilityMapSearchRequestModel facilityMapSearchRequest)
        {
            RailReport railReport = new RailReport();
            RailReportRequest railReportRequest = new RailReportRequest();
            railReportRequest.Stops.Add(new Stop() { Format = "StationState", Name = facilityMapSearchRequest.Origin.Stations.Find(e => e.Format == "StationState").Name, Railroad = facilityMapSearchRequest.Railroads });
            railReportRequest.Stops.Add(new Stop() { Format = "StationState", Name = facilityMapSearchRequest.Destination.Stations.Find(e => e.Format == "StationState").Name, Railroad = facilityMapSearchRequest.Railroads });
            railReportRequest.Options = new Options() { DistUnit = "Miles", RoutingPreference = "Practical", AmtrakRoutes = false, IntermodalOnlyStations=true };
            railReportRequest.Report = "DetailedGeocode";

            string jsonString = JsonSerializer.Serialize(railReportRequest);

            HttpContent httpContent = new StringContent(jsonString, System.Text.Encoding.UTF8, "application/json");

            var httpClient = _httpClientFactory.CreateClient();
            string freightRailAPIURL = _configuration["FreightRailAPI"];
            var httpResponseMessage = await httpClient.PostAsync($"{freightRailAPIURL}/route/Report?authToken={authToken}", httpContent);

            if (httpResponseMessage.IsSuccessStatusCode)
            {
                railReport = JsonSerializer.Deserialize<RailReport>(httpResponseMessage.Content.ReadAsStringAsync().Result);
            }
            return railReport;
        }

        public async Task<(HttpStatusCode, string)> GetRoutePath(FacilityMapSearchRequestModel facilityMapSearchRequest)
        {
            string response = string.Empty;
            HttpStatusCode httpStatusCode = HttpStatusCode.OK;
            RailRoutePath railRoutePath = new RailRoutePath();
            railRoutePath.Stops.Add(new Stop() { Format = "StationState", Name = facilityMapSearchRequest.Origin.Stations.Find(e => e.Format == "StationState").Name, Railroad = facilityMapSearchRequest.Railroads });
            railRoutePath.Stops.Add(new Stop() { Format = "StationState", Name = facilityMapSearchRequest.Destination.Stations.Find(e => e.Format == "StationState").Name, Railroad = facilityMapSearchRequest.Railroads });
            railRoutePath.Options = new Options() { DistUnit = "Miles", RoutingPreference = "Practical", AmtrakRoutes = false,IntermodalOnlyStations=true };

            string jsonString = JsonSerializer.Serialize(railRoutePath);
            HttpContent httpContent = new StringContent(jsonString, System.Text.Encoding.UTF8, "application/json");

            var httpClient = _httpClientFactory.CreateClient();
            string freightRailAPIURL = _configuration["FreightRailAPI"];
            var httpResponseMessage = await httpClient.PostAsync($"{freightRailAPIURL}/route/path?authToken={authToken}", httpContent);

            if (httpResponseMessage.IsSuccessStatusCode)
            {
                response = httpResponseMessage.Content.ReadAsStringAsync().Result;
            }
            else
            {
                httpStatusCode = httpResponseMessage.StatusCode;
                var errorMessage = JsonSerializerExtensions.DeserializeAnonymousType(httpResponseMessage.Content.ReadAsStringAsync().Result, new { ErrorDetails = "" }).ErrorDetails;
                response = errorMessage;
            }
            return (httpStatusCode, response);
        }

        private string GenerateSingleSearchQuery(SingleSearchRequest singleSearchRequest)
        {
            if (singleSearchRequest == null)
                return String.Empty;

            StringBuilder query = new StringBuilder();
            if (singleSearchRequest.Query != null)
            {
                if (!string.IsNullOrEmpty(singleSearchRequest.Query.Field))
                    query.Append("query=" + singleSearchRequest.Query.Field + ":" + "" + singleSearchRequest.Query.Value + "");
                else
                    query.Append("query=" + singleSearchRequest.Query.Value.ToString());
            }
            if (!string.IsNullOrEmpty(singleSearchRequest.IncludeOnly))
            {
                query.Append("&includeOnly=" + singleSearchRequest.IncludeOnly);
            }
            if (!string.IsNullOrEmpty(singleSearchRequest.Country))
            {
                query.Append("&countries=" + singleSearchRequest.Country);
            }
            if (!string.IsNullOrEmpty(singleSearchRequest.States))
            {
                query.Append("&states=" + singleSearchRequest.States);
            }

            query.Append("&maxResult=" + (singleSearchRequest.MaxResults > 0 ? singleSearchRequest.MaxResults : 10));
            query.Append($"&authToken={authToken}");

            return query.ToString();
        }

        private string GenerateGeocodeStationSearchQuery(GeocodeStationRequest geocodeStationRequest)
        {
            if (geocodeStationRequest == null)
                return String.Empty;

            StringBuilder query = new StringBuilder();
            if (!string.IsNullOrEmpty(geocodeStationRequest.Format))
            {
                query.Append("format=" + geocodeStationRequest.Format);
            }
            if (!string.IsNullOrEmpty(geocodeStationRequest.Name))
            {
                query.Append("&name=" + geocodeStationRequest.Name);
            }
            if (geocodeStationRequest.IntermodalOnlyStations)
            {
                query.Append("&intermodalOnlyStation=" + geocodeStationRequest.IntermodalOnlyStations);
            }

            query.Append($"&authToken={authToken}");

            return query.ToString();
        }
    }
}
