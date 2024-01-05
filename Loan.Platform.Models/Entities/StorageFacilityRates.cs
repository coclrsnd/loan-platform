using System;
using Microsoft.EntityFrameworkCore;

namespace StandardRail.RailCarLounge.Models.Entities
{
    public class StorageFacilityRate : EntityBase
    {
        public long Id { get; set; }

        public long StorageFacilityId { get; set; }

        public short? CurrencyId { get; set; }

        [Precision(18, 2)]
        public decimal? DailyStorageRate { get; set; }

        [Precision(18, 2)]
        public decimal? SwitchIn { get; set; }

        [Precision(18, 2)]
        public decimal? SwitchOut { get; set; }

        [Precision(18, 2)]
        public decimal? SwitchingRate { get; set; }

        [Precision(18, 2)]
        public decimal? SpecialSwitchingRate { get; set; }

        [Precision(18, 2)]
        public decimal? HazmatSwitchInRate { get; set; }

        [Precision(18, 2)]
        public decimal? HazmatSwitchOutRate { get; set; }

        [Precision(18, 2)]
        public decimal? LoadedSwitchInRate { get; set; }

        [Precision(18, 2)]
        public decimal? LoadedSwitchOutRate { get; set; }

        [Precision(18, 2)]
        public decimal? CherryPickingRate { get; set; }

        [Precision(18, 2)]
        public decimal? ReservationRate { get; set; }

        public DateTime EffectiveDate { get; set; }

        public DateTime? ExpiryDate { get; set; }

        //Navigation Properties
        public virtual StorageFacility StorageFacility { get; set; }

        public virtual Currency Currency { get; set; }
    }
}
