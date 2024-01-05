namespace Loan.Platform.Models.ReportModels
{
    public class CarActivity
    {
        public int Index { get; set; }

        public string CarInitial { get; set; }

        public string CarNumber { get; set; }

        public string IsLoadedEmpty { get; set; }

        public string IsHazard { get; set; }

        public string ArrivalDate { get; set; }

        public string DepartureDate { get; set; }

        public string Commodity { get; set; }

        public int Days { get; set; }

        public decimal DailyStorageRate { get; set; }

        public decimal TotalDailyAmount { get; set; }

        public decimal SwitchIn { get; set; }

        public decimal SwitchOut { get; set; }

        public decimal SpecialSwitchingAmount { get; set; }

        public decimal TotalSwitchingAmount { get; set; }

        public decimal CherryPicking { get; set; }

        public decimal Total { get; set; }
    }
}
