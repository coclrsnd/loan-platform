using System.Collections.Generic;
using System.Linq;

namespace Loan.Platform.Models.ReportModels
{
    public class StorageFacilityActivityReport
    {
        public string OrganizationName { get; set; }

        public string OrganizationAddress { get; set; }

        public string ReportFromDate { get; set; }

        public string ReportToDate { get; set; }

        public string Order { get; set; }

        public string FacilityName { get; set; }

        public string FacilityLocation { get; set; }

        public string ReportDate { get; set; }

        public int DaysInPeriod { get; set; }

        public string ContractType { get; set; }

        public int ContractedSpace { get; set; }

        public string Currency { get; set; }

        public string Commodities { get; set; }

        public int CarsAtFacility { get; set; }

        public int CarsReceived { get; set; }

        public int CarsReleased { get; set; }

        public int DaysOfStorage { get; set; }

        public bool IsAdvancedSwitchingRatesEnabled { get; set; }

        public decimal DailyRate { get; set; }

        public decimal? SwitchIn { get; set; }

        public decimal? SwitchOut { get; set; }

        public decimal? StandardSwitchIn { get; set; }

        public decimal? StandardSwitchOut { get; set; }

        public decimal? LoadedSwitchIn { get; set; }

        public decimal? LoadedSwitchOut { get; set; }

        public decimal? HazmatSwitchIn { get; set; }

        public decimal? HazmatSwitchOut { get; set; }

        public decimal? HazmatSurcharge { get; set; }

        public decimal? LoadedSurcharge { get; set; }

        public decimal TotalTakeOrPayAmount { get; set; }

        public decimal SumTotalSwitchAmount { get; set; }

        public decimal TotalAmount { get; set; }

        public int TakeOrPayDays { get; set; }

        public IEnumerable<CarActivity> CarActivities { get; set; }

        public StorageFacilityActivityReport()
        {
            this.CarActivities = new List<CarActivity>().AsEnumerable();
        }
    }
}
