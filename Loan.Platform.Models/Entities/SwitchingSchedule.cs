namespace StandardRail.RailCarLounge.Models.Entities
{
    public class SwitchingSchedule : EntityBase
    {
        public long Id { get; set; }

        public long StorageFacilityId { get; set; }

        public long RailRoadId { get; set; }

        public bool? OnMonday { get; set; }

        public bool? OnTuesday { get; set; }

        public bool? OnWednesday { get; set; }

        public bool? OnThursday { get; set; }

        public bool? OnFriday { get; set; }

        public bool? OnSaturday { get; set; }

        public bool? OnSunday { get; set; }

        //Navigation Properties
        public virtual RailRoad RailRoad { get; set; }

        public virtual StorageFacility StorageFacility { get; set; }
    }
}
