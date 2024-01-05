using System;
using System.Threading.Tasks;
using StandardRail.RailCarLounge.Models.ReportModels;

namespace StandardRail.RailCarLounge.Business.Pact
{
    public interface IReportService
    {
        public Task<StorageFacilityActivityReportResponse> GetStorageFacilityActivityReport(StorageFacilityActivityReportRequest storageFacilityActivityReportRequest);

        public Task LogReportResponse(StorageFacilityActivityReportRequest storageFacilityActivityReportRequest, StorageFacilityActivityReportResponse storageFacilityActivityReportResponse, String errorMessage);

    }
}
