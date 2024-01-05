using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Loan.Platform.Models.ViewModels
{
    public class ContractRatesViewModel
    {
        public long Id { get; set; }

        public long ContractId { get; set; }

        public long RateTypeId { get; set; }

        public decimal? SwitchIn { get; set; }

        public decimal? SwitchOut { get; set; }

        public decimal? SpecialSwitchingRate { get; set; }

        public decimal? DailyStorageRate { get; set; }

        public decimal? SwitchingRate { get; set; }

        public decimal? HazmatSurcharge { get; set; }

        public decimal? LoadedSurcharge { get; set; }

        public decimal? CherryPickingRate { get; set; }

        public decimal? ReservationRate { get; set; }

        public decimal? ListingFee { get; set; }

        public decimal? BookingFee { get; set; }
       // public AdvancedSwitchingRates AdvancedSwitchingRates { get; set; }

        public bool IsAdvancedHazmatSwitchingEnabled { get; set; }

        public bool IsAdvancedLoadedSwitchingEnabled { get; set; }

        public decimal? HazmatSwitchIn { get; set; }

        public decimal? HazmatSwitchOut { get; set; }

        public decimal? LoadedSwitchIn { get; set; }

        public decimal? LoadedSwitchOut { get; set; }

        public decimal? StandardSwitchIn { get; set; }

        public decimal? StandardSwitchOut { get; set; }

    }
}
