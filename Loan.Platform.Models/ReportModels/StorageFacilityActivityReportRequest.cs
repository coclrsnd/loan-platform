using System;
using System.IO;

namespace Loan.Platform.Models.ReportModels
{
    public class StorageFacilityActivityReportRequest
    {
        public long CustomerId { get; set; }

        public long ContractId { get; set; }

        public long ContractTypeId { get; set; }

        public DateTime FromDate { get; set; }

        public DateTime? ToDate { get; set; }
    }

    public class StorageFacilityActivityReportResponse
    {
        public string ReportPath { get; set; }

        public MemoryStream ReportStream { get; set; }

        public string StorageOrder { get; set; }
    }
}
