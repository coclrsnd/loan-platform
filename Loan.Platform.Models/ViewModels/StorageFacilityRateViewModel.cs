using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Loan.Platform.Models.ViewModels
{
    public class StorageFacilityRateViewModel
    {
        public long Id { get; set; }

        public long StorageFacilityId { get; set; }

        public short? CurrencyId { get; set; }

        //public decimal PercentageMargin { get; set; }

        public decimal? DailyStorageRate { get; set; }

        public decimal? SwitchIn { get; set; }

        public decimal? SwitchOut { get; set; }

        public decimal? SwitchingRate { get; set; }

        public decimal? SpecialSwitchingRate { get; set; }

        public decimal? HazmatSwitchInRate { get; set; }

        public decimal? HazmatSwitchOutRate { get; set; }

        public decimal? LoadedSwitchInRate { get; set; }

        public decimal? LoadedSwitchOutRate { get; set; }

        public decimal? CherryPickingRate { get; set; }

        public decimal? ReservationRate { get; set; }

        public string EffectiveDate { get; set; }

        public string ExpiryDate { get; set; }

        public bool IsActive { get; set; }
    }
}
