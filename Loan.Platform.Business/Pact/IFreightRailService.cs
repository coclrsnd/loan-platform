using System.Collections.Generic;
using System.Net;
using System.Threading.Tasks;
using StandardRail.RailCarLounge.Models.FreightRailModels;
using StandardRail.RailCarLounge.Models.ViewModels;

namespace StandardRail.RailCarLounge.Business.Pact
{
    /// <summary>
    /// Trimble Freight Rail API services
    /// </summary>
    public interface IFreightRailService
    {
        Task<RailReport> GetDetailedGeocodeRouteReportForSPLC(FacilityMapSearchRequestModel facilityMapSearchRequest);

        Task<(HttpStatusCode, string)> GetRoutePath(FacilityMapSearchRequestModel facilityMapSearchRequest);

        Task<List<GeocodeStation>> GetGeocodeStation(string city, string state, string mark = null);

        Task<GeocodeSingleSearchResponse> SearchByCity(string city, string countries = null, string states = null);
    }
}
