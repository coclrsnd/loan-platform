using System;
using System.IO;
using System.Threading.Tasks;
using ClosedXML.Report;
using Microsoft.Extensions.Configuration;
using StandardRail.RailCarLounge.Business.Pact;
using StandardRail.RailCarLounge.Common.StorageAccountHelper.BlobHelper;
using StandardRail.RailCarLounge.Common.UserContext;
using StandardRail.RailCarLounge.Data.SqlServer.Pact;
using StandardRail.RailCarLounge.Models.Entities;
using StandardRail.RailCarLounge.Models.ReportModels;

namespace StandardRail.RailCarLounge.Business
{
    public class ReportService : IReportService
    {
        private readonly IRepository<StorageFacilityActivityReportViewModel, long> _storageFacilityActivityReportADORepository;
        private readonly IAzureBlobService _azureBlobService;
        private readonly IConfiguration _configuration;
        private readonly IUserContext _userContext;
        private readonly IRepository<ReportLog, long> _reportLogRepository;

        public ReportService(IRepository<StorageFacilityActivityReportViewModel, long> storageFacilityActivityReportADORepository,
             IAzureBlobService azureBlobService, IConfiguration configuration, IUserContext userContext, IRepository<ReportLog, long> reportLogRepository)
        {
            _storageFacilityActivityReportADORepository = storageFacilityActivityReportADORepository ?? throw new ArgumentNullException(nameof(storageFacilityActivityReportADORepository));
            _azureBlobService = azureBlobService ?? throw new ArgumentNullException(nameof(azureBlobService));
            _configuration = configuration ?? throw new ArgumentNullException(nameof(configuration));
            _userContext = userContext ?? throw new ArgumentNullException(nameof(userContext));
            _reportLogRepository = reportLogRepository ?? throw new ArgumentNullException(nameof(reportLogRepository));
        }

        async Task<StorageFacilityActivityReportResponse> IReportService.GetStorageFacilityActivityReport(StorageFacilityActivityReportRequest storageFacilityActivityReportRequest)
        {
            StorageFacilityActivityReportResponse storageFacilityActivityReportResponse = new StorageFacilityActivityReportResponse();
            var templateBlob = await GetActivityReportTemplate(storageFacilityActivityReportRequest.ContractTypeId);
            if (templateBlob != null)
            {
                var res = await _storageFacilityActivityReportADORepository.Search(new StorageFacilityActivityReportViewModel()
                {
                    StorageFacilityActivityReportRequest = storageFacilityActivityReportRequest
                });

                var template = new XLTemplate(templateBlob.FileContent);
                template.AddVariable(res[0].StorageFacilityActivityReport);
                XLGenerateResult result = template.Generate();
                if (!result.HasErrors)
                {
                    MemoryStream memoryStream = new MemoryStream();
                    AzureBlobModel azureBlobModel = new AzureBlobModel();
                    azureBlobModel.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
                    azureBlobModel.FileName = $"ActivityReport_{res[0].StorageFacilityActivityReport.Order.Trim().Replace('-', '_')}_{DateTime.Now.ToFileTime()}.xlsx";
                    azureBlobModel.FileContent = new MemoryStream();
                    template.SaveAs(memoryStream);
                    memoryStream.Position = 0;
                    memoryStream.CopyTo(azureBlobModel.FileContent);
                    azureBlobModel.FileContent.Position = 0;
                    AzureUploadResponseModel azureUploadResponseModel = await UploadActivityReport(azureBlobModel);
                    memoryStream.Position = 0;
                    storageFacilityActivityReportResponse.ReportPath = azureUploadResponseModel.fileUri;
                    storageFacilityActivityReportResponse.ReportStream = memoryStream;
                    storageFacilityActivityReportResponse.ReportStream.Position = 0;
                    storageFacilityActivityReportResponse.StorageOrder = res[0].StorageFacilityActivityReport.Order;
                }
                else
                {
                    throw new FieldAccessException("Parsing Error");
                }
            }
            await LogReportResponse(storageFacilityActivityReportRequest,storageFacilityActivityReportResponse,null);
            return storageFacilityActivityReportResponse;
        }

        private async Task<AzureBlobModel> GetActivityReportTemplate(long contractTypeId)
        {
            string templateName = string.Empty;
            switch (contractTypeId)
            {
                case 1:
                    templateName = "ActivityReportTemplate_SPOT.xlsx";
                    break;
                case 2:
                    templateName = "ActivityReportTemplate_TakeOrPay_TermBased.xlsx";
                    break;
                case 3:
                    templateName = "ActivityReportTemplate_TakeOrPay_ArrivalBased.xlsx";
                    break;
                case 4:
                    templateName = "ActivityReportTemplate_Reserve.xlsx";
                    break;
                default:
                    break;
            }

            if (string.IsNullOrEmpty(templateName))
                return default(AzureBlobModel);

            var downloadedTemplate = await _azureBlobService.DownloadAsync($"template/{templateName}", _configuration["AzureServices:ActivityReportContainer"]);
            Stream dataStream = new MemoryStream(downloadedTemplate);
            dataStream.Position = 0;
            AzureBlobModel model = new AzureBlobModel()
            {
                FileContent = dataStream,
                FileName = templateName,
                ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",
            };

            return model;
        }

        private async Task<AzureUploadResponseModel> UploadActivityReport(AzureBlobModel azureBlobModel)
        {
            var uploadResult = await _azureBlobService.UploadAsync(azureBlobModel, _configuration["AzureServices:ActivityReportContainer"], azureBlobModel.FileName);
            return uploadResult;
        }

        private string SaveStreamAsFile(string filePath, Stream inputStream, string fileName)
        {
            DirectoryInfo info = new DirectoryInfo(filePath);
            if (!info.Exists)
            {
                info.Create();
            }

            string path = Path.Combine(filePath, fileName);
            using (FileStream outputFileStream = new FileStream(path, FileMode.Create))
            {
                inputStream.CopyTo(outputFileStream);
            }

            return path;
        }


        public async Task LogReportResponse(StorageFacilityActivityReportRequest storageFacilityActivityReportRequest, StorageFacilityActivityReportResponse storageFacilityActivityReportResponse,String errorMessage)
        {
            var reportLog = new ReportLog()
            {
                CustomerId = storageFacilityActivityReportRequest.CustomerId,
                ContractId = storageFacilityActivityReportRequest.ContractId,
                ContractTypeId = storageFacilityActivityReportRequest.ContractTypeId,
                Status = errorMessage == null,
                ReportURL = storageFacilityActivityReportResponse != null ? storageFacilityActivityReportResponse.ReportPath : null,
                FromDate = storageFacilityActivityReportRequest.FromDate.Date,
                ToDate = storageFacilityActivityReportRequest.ToDate?.Date,
                ErrorMsg = errorMessage,
            };
            reportLog.OrganizationId = _userContext.OrganizationId != null ? _userContext.OrganizationId.Value : 0;
            reportLog.TenantId = _userContext.TenantId != null ? _userContext.TenantId.Value : 0;
            reportLog.CreatedBy = _userContext.UserId != null ? _userContext.UserId.Value : 0;
            reportLog.CreatedTime = DateTime.UtcNow;
            reportLog.ModifiedBy = _userContext.UserId != null ? _userContext.UserId.Value : 0;
            reportLog.ModifiedTime = DateTime.UtcNow;
           
            await _reportLogRepository.Create(reportLog);

        }
    }
}
