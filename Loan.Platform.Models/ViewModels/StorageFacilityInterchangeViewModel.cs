using System.Collections.Generic;

namespace Loan.Platform.Models.ViewModels
{
    public class StorageFacilityInterchangeViewModel
    {
        public long Id { get; set; }

        public long StorageFacilityId { get; set; }

        public long RailRoadId { get; set; }

        public string RailRoadName { get; set; }

        public string MarkCode { get; set; }

        public decimal? GrossRailRoadCapacity { get; set; }

        public List<StorageFacilityInterchangeLocationViewModel> InterchangeLocations { get; set; }

        public long? UnitId { get; set; }

        public bool IsActive { get; set; }
    }
}
