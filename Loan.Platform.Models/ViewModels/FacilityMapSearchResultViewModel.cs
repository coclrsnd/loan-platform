using System;
using System.Collections.Generic;
using System.Data;
using System.Net;

namespace Loan.Platform.Models.ViewModels
{
    public class FacilityMapSearchViewModel
    {
        public FacilityMapSearchResultViewModel FacilityMapSearchResultViewModel { get; set; }

        public FacilityMapSearchRequestModel FacilityMapSearchRequest { get; set; }

        public FacilityMapSearchViewModel()
        {
            this.FacilityMapSearchRequest = new FacilityMapSearchRequestModel();
            this.FacilityMapSearchResultViewModel = new FacilityMapSearchResultViewModel();
        }
    }

    public class FacilityMapSearchResultViewModel
    {
        public List<StorageFacilityResultViewModel> StorageFacilityViewModels { get; set; }

        public string StorageFacilityMapPoints { get; set; }

        public string OriginDestinationRoutePath { get; set; }

        public HttpStatusCode Status { get; set; }

        public string ResponseMessage { get; set; }
    }

    public class StorageFacilityResultViewModel
    {
        public long Id { get; set; }

        public string Name { get; set; }

        public string Interchanges { get; set; }

        public string Lat { get; set; }

        public string Long { get; set; }

        public int? Capacity { get; set; }

        public int? AvailableCars { get; set; }

        public double? Rating { get; set; }

        public string City { get; set; }

        public long? State { get; set; }

        public string StateCode { get; set; }

        public string Description { get; set; }

        public decimal? DailyStorageRate { get; set; }

        public int? MilesAway { get; set; }

        public List<StorageFeatureViewModel> StorageFeatures { get; set; }

        public long? VendorId { get; set; }

        public string CurrencyCode { get; set; }

    }

    public class FacilityMapSearchRequestModel
    {
        public bool isMulticityEnable { get; set; }
        public RouteStation Origin { get; set; }
        public RouteStation Destination { get; set; }
        public string Railroads { get; set; }
        public long? RegionId { get; set; }
        public DateTime? EffectiveDate { get; set; }
        public DateTime? ExpiryDate { get; set; }
        public int? DailyRate { get; set; }
        public int? SwitchingFee { get; set; }
        public List<StorageFeatureViewModel> Features { get; set; }
        public string SPLCs { get; set; }
        public DataTable SPLCMilesMap { get; set; }
    }



    public class RouteStation
    {
        public string StationName { get; set; }
        public string State { get; set; }
        public string Railroad { get; set; }
        public double Latitude { get; set; }
        public double Longitude { get; set; }
        public List<Station> Stations { get; set; }
        public object SPLC { get; set; }
    }

    public class Station
    {
        public string Format { get; set; }
        public string Name { get; set; }
        public string Railroad { get; set; }
    }

}
