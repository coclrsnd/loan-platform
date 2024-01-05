namespace Loan.Platform.Models.ViewModels
{
    public class StorageFacilityInterchangeLocationViewModel
    {
        public long Id { get; set; }

        public long StorageFacilityId { get; set; }

        public long RailRoadId { get; set; }

        public long InterchangeId { get; set; }

        public long CountryId { get; set; }

        public long StateId { get; set; }

        public string City { get; set; }

        public string SPLC { get; set; }

        public string Lat { get; set; }

        public string Long { get; set; }

        public string Description { get; set; }

        public bool IsActive { get; set; }

        public string R260 { get; set; }

        public string FSAC { get; set; }
    }
}
