using System;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.StaticFiles;
using StandardRail.RailCarLounge.Business.Pact;
using StandardRail.RailCarLounge.Common.UserContext;
using StandardRail.RailCarLounge.Models.ReportModels;

namespace StandardRail.RailCarLounge.Rest.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    [Authorize]
    public class ReportController : ControllerBase
    {
        private readonly IReportService _reportService;
        private readonly string CurrentRole;

        public ReportController(IReportService reportService, IUserContext claimsProvider)
        {
            _reportService = reportService;
            CurrentRole = claimsProvider.CurrentRole;
        }

        [HttpPost]
        [Route("ActivityReport", Name = "ActivityReport")]
        public async Task<IActionResult> ActivityReport([FromBody] StorageFacilityActivityReportRequest storageActivityReportViewModel)
        {
            StorageFacilityActivityReportResponse storageFacilityActivityReportResponse = new StorageFacilityActivityReportResponse();
            try
            {
                if (string.IsNullOrEmpty(CurrentRole) || CurrentRole.StartsWith("Customer", StringComparison.OrdinalIgnoreCase) || CurrentRole.StartsWith("Vendor", StringComparison.OrdinalIgnoreCase))
                {
                    return BadRequest();
                }
                storageFacilityActivityReportResponse = await _reportService.GetStorageFacilityActivityReport(storageActivityReportViewModel);
                return File(storageFacilityActivityReportResponse.ReportStream, GetContentType("test.xlsx"), $"ActivityReport_{storageFacilityActivityReportResponse.StorageOrder}_{DateTime.Now.ToFileTime()}.xlsx");
            }
            catch (Exception ex)
            {
                await _reportService.LogReportResponse(storageActivityReportViewModel, storageFacilityActivityReportResponse, ex.Message);
                return BadRequest("Error while generating report. Please try after sometime.");
            }
        }

        private string GetContentType(string path)
        {
            var provider = new FileExtensionContentTypeProvider();
            string contentType;

            if (!provider.TryGetContentType(path, out contentType))
            {
                contentType = "application/octet-stream";
            }

            return contentType;
        }
    }
}