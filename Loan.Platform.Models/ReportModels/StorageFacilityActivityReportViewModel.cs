namespace Loan.Platform.Models.ReportModels
{
    public class StorageFacilityActivityReportViewModel
    {
        public StorageFacilityActivityReport StorageFacilityActivityReport { get; set; }

        public StorageFacilityActivityReportRequest StorageFacilityActivityReportRequest { get; set; }

        public StorageFacilityActivityReportViewModel()
        {
            this.StorageFacilityActivityReport = new StorageFacilityActivityReport();
            this.StorageFacilityActivityReportRequest = new StorageFacilityActivityReportRequest();
        }
    }
}
