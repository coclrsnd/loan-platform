using Microsoft.EntityFrameworkCore;

namespace StandardRail.RailCarLounge.Models.Entities
{
    public class StorageFacilityInterchange : EntityBase
    {
        public long Id { get; set; }

        public long StorageFacilityId { get; set; }

        public long RailRoadId { get; set; }

        public string RailRoadName { get; set; }

        public string MarkCode { get; set; }

        [Precision(18, 2)]
        public decimal? GrossRailRoadCapacity { get; set; }

        public long? UnitId { get; set; }

        // Navigation Properties
        public StorageFacility StorageFacility { get; set; }
    }
}
