namespace Loan.Platform.Models.ViewModels
{
    public class StorageOrderRibbon
    {
        public long TotalRiders { get; set; }

        public long TotalActiveOrders { get; set; }

        public long TotalExpiredOrders { get; set; }

        public long TotalContractedSpaces { get; set; }

        public long TotalCarsStored { get; set; }

        public decimal? TotalOrdersAmount { get; set; }

        public decimal? AverageMonthlyAmount { get; set; }
    }
}
