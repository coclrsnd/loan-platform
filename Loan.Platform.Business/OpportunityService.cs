using System;
using System.Collections.Generic;
using System.Data;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Linq.Dynamic.Core;
using System.Net.Http;
using System.Text;
using System.Threading.Tasks;
using AutoMapper;
using DocumentFormat.OpenXml.Office.CustomUI;
using DocumentFormat.OpenXml.Spreadsheet;
using Microsoft.AspNetCore.Components.Forms;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.StaticFiles;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.Logging;
using MoreLinq;
using SharpDocx;
using StandardRail.RailCarLounge.Business.Pact;
using StandardRail.RailCarLounge.Common.Helpers;
using StandardRail.RailCarLounge.Common.StorageAccountHelper.BlobHelper;
using StandardRail.RailCarLounge.Common.UserContext;
using StandardRail.RailCarLounge.Data.SqlServer.Pact;
using StandardRail.RailCarLounge.Models.Entities;
using StandardRail.RailCarLounge.Models.OpportunityOrderSummary;
using StandardRail.RailCarLounge.Models.ViewModels;

namespace StandardRail.RailCarLounge.Business
{
    public class OpportunityService : IOpportunityService
    {
        #region Private members
        private readonly IRepository<OpportunityDTViewModel, long> _opportunityDTRepository;
        private readonly IAzureBlobService _azureBlobService;
        private readonly IConfiguration _configuration;
        private readonly ICommonService _commonService;
        private readonly IRepository<Vendor, long> _vendorRepository;
        IRepository<OpportunityFeatures, long> _featureRepository;
        private readonly IRepository<User, long> _userRepository;
        private readonly IRepository<OpportunityReservedSpaces, long> _opportunityReservedSpacesRepository;
        private DataTable dtFeature = null;
        private DataTable dtOpportunityRailcarDetails = null;
        private DataTable dtOpportunityAttachments = null;
        private DataTable dtOpportunity = null;
        private readonly IMapper _mapper;
        private long? UserId;
        private long? TenantId;
        private long? OrganizationId;
        private readonly string CurrentRole;
        private readonly ILogger<OpportunityService> _logger;
        private readonly IRepository<OpportunitySummaryDetailsDTViewModel, long> _opportunitySummaryADORepository;
        private readonly IRepository<Customer, long> _customerRepository;
        #endregion

        #region Constructor
        public OpportunityService(IRepository<OpportunityFeatures, long> featureRepository, IRepository<OpportunityDTViewModel, long> opportunityDTRepository,
            IMapper mapper, IUserContext userContext, IAzureBlobService azureBlobService,
            IConfiguration configuration, ICommonService commonService, IRepository<User, long> userRepository, IRepository<OpportunityReservedSpaces, long> opportunityReservedSpacesRepository, ILogger<OpportunityService> logger, IRepository<OpportunitySummaryDetailsDTViewModel, long> opportunitySummaryADORepository, IRepository<Vendor, long> vendorRepository, IRepository<Customer, long> customerRepository)
        {
            _featureRepository = featureRepository ?? throw new ArgumentNullException(nameof(featureRepository));
            _opportunityDTRepository = opportunityDTRepository ?? throw new ArgumentNullException(nameof(opportunityDTRepository));
            _userRepository = userRepository ?? throw new ArgumentNullException(nameof(userRepository));
            _opportunityReservedSpacesRepository = opportunityReservedSpacesRepository ?? throw new ArgumentNullException(nameof(opportunityReservedSpacesRepository));
            UserId = userContext.UserId;
            TenantId = userContext.TenantId;
            OrganizationId = userContext.OrganizationId;
            CurrentRole = userContext.CurrentRole;
            _mapper = mapper ?? throw new ArgumentNullException(nameof(mapper));
            _azureBlobService = azureBlobService ?? throw new ArgumentNullException(nameof(azureBlobService));
            _configuration = configuration ?? throw new ArgumentNullException(nameof(configuration));
            _commonService = commonService ?? throw new ArgumentNullException(nameof(commonService));
            _logger = logger ?? throw new ArgumentNullException(nameof(logger));
            _opportunitySummaryADORepository = opportunitySummaryADORepository ?? throw new ArgumentNullException(nameof(opportunitySummaryADORepository));
            _vendorRepository = vendorRepository ?? throw new ArgumentNullException(nameof(vendorRepository));
            _customerRepository = customerRepository ?? throw new ArgumentNullException(nameof(customerRepository));
        }
        #endregion

        #region Public methods

        /// <inheritdoc cref="StandardRail.RailCarLounge.Business.Pact.IOpportunityService"/>
        public async Task<OpportunityViewModel> SaveOpportunity(OpportunityViewModel opportunityViewModel)
        {
            var customer = (await _customerRepository.GetByCondition(t => t.OrganizationId == opportunityViewModel.OrganizationId)).FirstOrDefault();
            if(customer != null)
            {
                opportunityViewModel.CustomerId = customer.Id;
            }
            OpportunityDTViewModel opportunityDTViewModel = new OpportunityDTViewModel();
            opportunityDTViewModel.Opportunity = PrepareOpportunityDt(opportunityViewModel);
            opportunityDTViewModel.OpportunityRailcarDetails = PrepareOpportunityRailcarDetailsDT(opportunityViewModel);
            opportunityDTViewModel.OpportunityAttachments = PrepareOpportunityAttachmentsDT(opportunityViewModel);
            await _opportunityDTRepository.Create(opportunityDTViewModel);
            opportunityViewModel.Id = opportunityDTViewModel.Opportunity.AsEnumerable()
               .Select(r => r.Field<long>("Id")).FirstOrDefault();
            return opportunityViewModel;
        }

        /// <inheritdoc cref="StandardRail.RailCarLounge.Business.Pact.IOpportunityService"/>
        public async Task<List<OpportunityFeaturesViewModel>> SaveOpportunityFeatures(IList<OpportunityFeaturesViewModel> opportunityFeaturesModels)
        {
            IList<OpportunityFeatures> opportunityFeatures = new List<OpportunityFeatures>();
            foreach (var opportunityFeature in opportunityFeaturesModels)
            {
                opportunityFeatures.Add(this._mapper.Map<OpportunityFeatures>(opportunityFeature));
            }
            var opportunityFeaturesDBModel = await _featureRepository.SaveEntities(opportunityFeatures);
            List<OpportunityFeaturesViewModel> opportunityFeaturesViewModels = new List<OpportunityFeaturesViewModel>();
            foreach (var feature in opportunityFeaturesDBModel)
            {
                opportunityFeaturesViewModels.Add(this._mapper.Map<OpportunityFeaturesViewModel>(feature));
            }
            return opportunityFeaturesViewModels;
        }

        /// <inheritdoc cref="StandardRail.RailCarLounge.Business.Pact.IOpportunityService"/>
        public async Task<OpportunityViewModel> GetOpportunityById(long opportunityId)
        {
            var opportunityDT = await _opportunityDTRepository.GetById(opportunityId);
            OpportunityViewModel opportunityViewModel = MapOpportunityViewModel(opportunityDT);
            return opportunityViewModel;
        }

        /// <inheritdoc cref="StandardRail.RailCarLounge.Business.Pact.IOpportunityService"/>
        public async Task<OpportunityViewModel> PlaceOpportunity(OpportunityViewModel opportunity)
        {
            string bookingDate = "";
            var user = await _userRepository.GetById((long)UserId);
            var startDate = DateTime.Parse(opportunity.StartDate).ToString("MM-dd-yyyy");
            var endDate = DateTime.Parse(opportunity.EndDate).ToString("MM-dd-yyyy");
            if (opportunity != null)
            {
                var opportunityName = opportunity.Name.Split('-');
                if (opportunityName.Length > 2)
                {
                    string vendorName = opportunityName[0];
                    var customer = (await _customerRepository.GetByCondition(t => t.OrganizationId == opportunity.OrganizationId)).FirstOrDefault();
                    if (string.IsNullOrEmpty(opportunity.AgreementPath))
                    {
                        opportunity.AgreementPath = $"{vendorName}_{customer.Organization.Name}_{DateTime.Now.Year}_{DateTime.Now.ToString("yyyyMMddHHmmss")}/{_configuration["OpportunityOrderEmailConfig:OpportunityAttachmentFileName"]}";
                    }
                    else
                    {
                        opportunity.AgreementPath = $"{opportunity.AgreementPath}/{_configuration["OpportunityOrderEmailConfig:OpportunityAttachmentFileName"]}";
                    }
                    opportunity.BookingStatus = 3;
                    opportunity.OpportunityAttachments = null;
                    opportunity.OpportunityRailCars = null;
                    bookingDate = opportunity.BookingDate;
                    var opportunityViewModel = await SaveOpportunity(opportunity);

                    opportunity = await GetOpportunityById(opportunity.Id);
                    opportunity.BookingDate = DateTime.Parse(bookingDate).ToString("MM-dd-yyyy");
                    opportunity.StartDate = startDate;
                    opportunity.EndDate = endDate;

                    if (opportunityViewModel != null)
                    {
                        var opportunitySummaryDetailsDTViewModel = await _opportunitySummaryADORepository.GetById(opportunity.Id);
                        if (opportunitySummaryDetailsDTViewModel != null)
                        {
                            var vendor = _vendorRepository.GetByCondition(t => t.Id == opportunity.VendorId).Result.FirstOrDefault();
                            var orderSummaryStream = await GenerateOpportunityOrderSummary(opportunity, user, opportunitySummaryDetailsDTViewModel, vendor, customer);
                            byte[] opportunitySummary = orderSummaryStream.ToArray();

                            AzureBlobModel azureBlobModel = new AzureBlobModel();
                            azureBlobModel.FileName = "Order Summary.docx";
                            azureBlobModel.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
                            azureBlobModel.FileContent = orderSummaryStream;
                            var AzureUploadResponse = await _azureBlobService.UploadAsync(azureBlobModel, _configuration["AzureServices:OpportunityAttachmentContainer"], opportunity.AgreementPath);

                            if (!string.IsNullOrWhiteSpace(AzureUploadResponse.fileUri))
                            {
                                await _commonService.SendOpportunityOrderPlacedEmailAsync(user, user.EmailId, opportunity, opportunitySummary, customer);
                                await _commonService.SendStorageOpportunityEmailAsync(user, opportunity, opportunitySummary);

                                await _commonService.SendOpportunityOrderPlacedEmailToVendorAsync(opportunity, vendor, opportunitySummary);
                                return opportunity;

                            }
                        }
                    }
                }
            }
            return null;
        }

        #endregion

        #region Private methods to prepare DataTables

        private void CreateOpportunityDT()
        {
            dtOpportunity = new DataTable();
            dtOpportunity.Columns.Add("Id", typeof(long));
            dtOpportunity.Columns.Add("Name", typeof(string));
            dtOpportunity.Columns.Add("StartDate", typeof(DateTime));
            dtOpportunity.Columns.Add("EndDate", typeof(DateTime));
            dtOpportunity.Columns.Add("BookingStatus", typeof(long));
            dtOpportunity.Columns.Add("AgreementPath", typeof(string));
            dtOpportunity.Columns.Add("VendorId", typeof(long));
            dtOpportunity.Columns.Add("CustomerId", typeof(long));
            dtOpportunity.Columns.Add("FacilityId", typeof(long));
            dtOpportunity.Columns.Add("IsActive", typeof(bool));
            dtOpportunity.Columns.Add("CreatedTime", typeof(DateTime));
            dtOpportunity.Columns.Add("CreatedBy", typeof(long));
            dtOpportunity.Columns.Add("ModifiedTime", typeof(DateTime));
            dtOpportunity.Columns.Add("ModifiedBy", typeof(long));
            dtOpportunity.Columns.Add("OrganizationId", typeof(long));
            dtOpportunity.Columns.Add("TenantId", typeof(long));
        }

        private DataTable PrepareOpportunityDt(OpportunityViewModel opportunityViewModel)
        {
                if (dtOpportunity == null)
                {
                    CreateOpportunityDT();
                }
                dtOpportunity.Rows.Add(opportunityViewModel.Id, opportunityViewModel.Name, opportunityViewModel.StartDate, opportunityViewModel.EndDate,
                    opportunityViewModel.BookingStatus, opportunityViewModel.AgreementPath, opportunityViewModel.VendorId, opportunityViewModel.CustomerId, opportunityViewModel.FacilityId,
                true, DateTime.UtcNow, UserId, DateTime.UtcNow, UserId, OrganizationId, TenantId);
                return dtOpportunity;
            }

        private void CreateOpportunityRailcarDetailsDT()
        {
            dtOpportunityRailcarDetails = new DataTable();
            dtOpportunityRailcarDetails.Columns.Add("Id", typeof(long));
            dtOpportunityRailcarDetails.Columns.Add("OpportunityID", typeof(long));
            dtOpportunityRailcarDetails.Columns.Add("ExpectedNumberOfCars", typeof(long));
            dtOpportunityRailcarDetails.Columns.Add("LEId", typeof(long));
            dtOpportunityRailcarDetails.Columns.Add("Commodity", typeof(string));
            dtOpportunityRailcarDetails.Columns.Add("IsHazmat", typeof(bool));
            dtOpportunityRailcarDetails.Columns.Add("CarType", typeof(long));
            dtOpportunityRailcarDetails.Columns.Add("RailcarIds", typeof(string));
            dtOpportunityRailcarDetails.Columns.Add("IsActive", typeof(bool));
            dtOpportunityRailcarDetails.Columns.Add("CreatedTime", typeof(DateTime));
            dtOpportunityRailcarDetails.Columns.Add("CreatedBy", typeof(long));
            dtOpportunityRailcarDetails.Columns.Add("ModifiedTime", typeof(DateTime));
            dtOpportunityRailcarDetails.Columns.Add("ModifiedBy", typeof(long));
            dtOpportunityRailcarDetails.Columns.Add("OrganizationId", typeof(long));
            dtOpportunityRailcarDetails.Columns.Add("TenantId", typeof(long));
        }

        private DataTable PrepareOpportunityRailcarDetailsDT(OpportunityViewModel opportunityView)
        {
            if (dtOpportunityRailcarDetails == null)
            {
                CreateOpportunityRailcarDetailsDT();
            }
            if (opportunityView.OpportunityRailCars != null && opportunityView.OpportunityRailCars.Count > 0)
            {
                foreach (var opportunityRailcarDetail in opportunityView.OpportunityRailCars)
                {
                    dtOpportunityRailcarDetails.Rows.Add(opportunityRailcarDetail.Id, opportunityView.Id, opportunityRailcarDetail.ExpectedNumberOfCars, opportunityRailcarDetail.LEId, opportunityRailcarDetail.Commodity,
                    opportunityRailcarDetail.IsHazmat, opportunityRailcarDetail.CarType, opportunityRailcarDetail.RailCarIds,
                    opportunityRailcarDetail.IsActive, DateTime.UtcNow, UserId, DateTime.UtcNow, UserId, OrganizationId, TenantId);
                }
            }

            return dtOpportunityRailcarDetails;
        }

        private void CreateOpportunityAttachmentsDT()
        {
            dtOpportunityAttachments = new DataTable();
            dtOpportunityAttachments.Columns.Add("Id", typeof(long));
            dtOpportunityAttachments.Columns.Add("OpportunityID", typeof(long));
            dtOpportunityAttachments.Columns.Add("Name", typeof(string));
            dtOpportunityAttachments.Columns.Add("Path", typeof(string));
            dtOpportunityAttachments.Columns.Add("IsActive", typeof(bool));
            dtOpportunityAttachments.Columns.Add("CreatedTime", typeof(DateTime));
            dtOpportunityAttachments.Columns.Add("CreatedBy", typeof(long));
            dtOpportunityAttachments.Columns.Add("ModifiedTime", typeof(DateTime));
            dtOpportunityAttachments.Columns.Add("ModifiedBy", typeof(long));
            dtOpportunityAttachments.Columns.Add("OrganizationId", typeof(long));
            dtOpportunityAttachments.Columns.Add("TenantId", typeof(long));
            dtOpportunityAttachments.Columns.Add("Size", typeof(string));
            dtOpportunityAttachments.Columns.Add("CreatedDate", typeof(DateTime));
        }

        private DataTable PrepareOpportunityAttachmentsDT(OpportunityViewModel opportunityView)
        {
            if (dtOpportunityAttachments == null)
            {
                CreateOpportunityAttachmentsDT();
            }
            if (opportunityView.OpportunityAttachments != null && opportunityView.OpportunityAttachments.Count > 0)
            {
                foreach (var opportunityAttachment in opportunityView.OpportunityAttachments)
                {
                    dtOpportunityAttachments.Rows.Add(opportunityAttachment.Id, opportunityView.Id, opportunityAttachment.Name, opportunityAttachment.Path,
                    opportunityAttachment.IsActive, DateTime.UtcNow, UserId, DateTime.UtcNow, UserId, OrganizationId, TenantId, opportunityAttachment.Size, opportunityAttachment.CreatedDate);
                }
            }
            return dtOpportunityAttachments;
        }

        #endregion

        #region private methods for mapping OpportunityViewModel

        private OpportunityViewModel MapOpportunityViewModel(OpportunityDTViewModel opportunityDTViewModel)
        {

            OpportunityViewModel opportunityViewModel = new OpportunityViewModel();

            if (opportunityDTViewModel.Opportunity != null && opportunityDTViewModel.Opportunity.Rows.Count > 0)
            {
                DataRow dr = opportunityDTViewModel.Opportunity.Rows[0];

                opportunityViewModel.Id = Convert.ToInt32(dr["Id"]);
                opportunityViewModel.Name = Convert.ToString(dr["Name"]);
                opportunityViewModel.StartDate = dr["StartDate"].ToDateTimeFormat();
                opportunityViewModel.EndDate = dr["EndDate"].ToDateTimeFormat();
                opportunityViewModel.BookingStatus = Convert.ToInt64(dr["BookingStatus"]);
                opportunityViewModel.AgreementPath = Convert.ToString(dr["AgreementPath"]);
                opportunityViewModel.VendorId = Convert.ToInt64(dr["VendorId"]);
                opportunityViewModel.CustomerId = Convert.ToInt64(dr["CustomerId"]);
                opportunityViewModel.FacilityId = Convert.ToInt64(dr["FacilityId"]);
                opportunityViewModel.OrganizationId = Convert.ToInt64(dr["OrganizationId"]);
                opportunityViewModel.TotalNoApproxSpaces = DBFieldsMappingHelper.GetNullableInt64Value(dr, "TotalNoApproxSpaces");
                opportunityViewModel.TotalNoReservedSpaces = DBFieldsMappingHelper.GetNullableInt64Value(dr, "TotalNoReservedSpaces");
                opportunityViewModel.OpportunityRailCars = MapOpportunityRailcarDetails(opportunityDTViewModel.OpportunityRailcarDetails);
                opportunityViewModel.OpportunityAttachments = MapOpportunityAttachments(opportunityDTViewModel.OpportunityAttachments);
            }
            return opportunityViewModel;
        }

        private List<OpportunityAttachmentViewModel> MapOpportunityAttachments(DataTable dt)
        {
            List<OpportunityAttachmentViewModel> opportunityAttachments = new List<OpportunityAttachmentViewModel>();
            if (dt != null && dt.Rows.Count > 0)
            {
                foreach (DataRow dr in dt.Rows)
                {
                    var opportunityAttachment = new OpportunityAttachmentViewModel();
                    opportunityAttachment.Id = Convert.ToInt64(dr["id"]);
                    opportunityAttachment.OpportunityId = Convert.ToInt64(dr["OpportunityId"]);
                    opportunityAttachment.Name = Convert.ToString(dr["Name"]);
                    opportunityAttachment.Path = Convert.ToString(dr["Path"]);
                    opportunityAttachment.Size = Convert.ToString(dr["Size"]);
                    opportunityAttachment.CreatedDate = Convert.ToString(dr["CreatedDate"].ToDateTimeFormat());
                    opportunityAttachment.IsActive = true;
                    opportunityAttachments.Add(opportunityAttachment);
                }
            }
            return opportunityAttachments;
        }

        private List<OpportunityRailcarDetailsViewModel> MapOpportunityRailcarDetails(DataTable dt)
        {
            List<OpportunityRailcarDetailsViewModel> opportunityRailcarDetails = new List<OpportunityRailcarDetailsViewModel>();
            if (dt != null && dt.Rows.Count > 0)
            {
                foreach (DataRow dr in dt.Rows)
                {
                    var opportunityRailcarDetail = new OpportunityRailcarDetailsViewModel();
                    opportunityRailcarDetail.Id = Convert.ToInt64(dr["id"]);
                    opportunityRailcarDetail.OpportunityID = Convert.ToInt64(dr["OpportunityId"]);
                    opportunityRailcarDetail.ExpectedNumberOfCars = DBFieldsMappingHelper.GetNullableInt64Value(dr, "ExpectedNumberOfCars");
                    opportunityRailcarDetail.RailCarIds = Convert.ToString(dr["RailcarIds"]);
                    opportunityRailcarDetail.LEId = Convert.ToInt64(dr["LEId"]);
                    opportunityRailcarDetail.LandE = Convert.ToString(dr["LandE"]);
                    opportunityRailcarDetail.CarType = Convert.ToInt64(dr["CarType"]);
                    opportunityRailcarDetail.CarTypeName = Convert.ToString(dr["CarTypeName"]);
                    opportunityRailcarDetail.Commodity = Convert.ToString(dr["Commodity"]);
                    opportunityRailcarDetail.IsHazmat = Convert.ToBoolean(dr["IsHazmat"]);
                    opportunityRailcarDetail.Hazmat = opportunityRailcarDetail.IsHazmat ? "Yes" : "No";
                    opportunityRailcarDetail.IsActive = true;
                    opportunityRailcarDetails.Add(opportunityRailcarDetail);
                }
            }
            return opportunityRailcarDetails;

        }
        #endregion

        private void CreateFeaturesDT()
        {
            dtFeature = new DataTable();
            dtFeature.Columns.Add("Id", typeof(long));
            dtFeature.Columns.Add("OpportunityId", typeof(long));
            dtFeature.Columns.Add("FeatureId", typeof(long));
            dtFeature.Columns.Add("Comments", typeof(string));
            dtFeature.Columns.Add("IsActive", typeof(bool));
            dtFeature.Columns.Add("CreatedTime", typeof(DateTime));
            dtFeature.Columns.Add("CreatedBy", typeof(long));
            dtFeature.Columns.Add("ModifiedTime", typeof(DateTime));
            dtFeature.Columns.Add("ModifiedBy", typeof(long));
            dtFeature.Columns.Add("OrganizationId", typeof(long));
            dtFeature.Columns.Add("TenantId", typeof(long));
        }

        /// <inheritdoc cref="StandardRail.RailCarLounge.Business.Pact.IOpportunityService"/>
        public void SaveOpportunityAttachments(OpportunityAttachmentViewModel opportunityAttachments)
        {
            throw new NotImplementedException();
        }

        /// <inheritdoc cref="StandardRail.RailCarLounge.Business.Pact.IOpportunityService"/>
        public async Task<string> UploadOpportunityAttachment(AzureBlobModel azureBlobModel, string filePath)
        {
            var azureUploadResponse = await _azureBlobService.UploadAsync(azureBlobModel, _configuration["AzureServices:OpportunityAttachmentContainer"], filePath);
            if (azureUploadResponse.fileUri.Contains(filePath))
            {
                return filePath;
            }
            return filePath;
        }

        /// <inheritdoc cref="StandardRail.RailCarLounge.Business.Pact.IOpportunityService"/>
        public bool DeleteOpportunityAttachment(string filePath)
        {
            string attachmentPath = $"{filePath}";
            bool isDeleted = _azureBlobService.DeleteBlob(_configuration["AzureServices:OpportunityAttachmentContainer"], attachmentPath);
            return isDeleted;
        }

        /// <inheritdoc cref="StandardRail.RailCarLounge.Business.Pact.IOpportunityService"/>
        public bool CheckValidExtension(string filePath)
        {
            string validExtensions = _configuration["ValidFileExtensions"];
            if (string.IsNullOrEmpty(validExtensions))
            {
                return true;
            }
            if (!string.IsNullOrEmpty(filePath))
            {
                string ext = Path.GetExtension(filePath);

                string[] validExtensionList = validExtensions.Split(',');
                if (validExtensionList.Contains(ext.ToLower()))
                {
                    return true;
                }
                return false;
            }
            return false;
        }

        /// <inheritdoc cref="StandardRail.RailCarLounge.Business.Pact.IOpportunityService"/>
        public async Task<byte[]> DownloadOpportunitySummary(string agreementPath)
        {
            var opportunitySummary = await _azureBlobService.DownloadAsync(agreementPath, _configuration["AzureServices:OpportunityAttachmentContainer"]);
            return opportunitySummary;
        }

        /// <inheritdoc cref="StandardRail.RailCarLounge.Business.Pact.IOpportunityService"/>
        public string GetContentType(string path)
        {
            var provider = new FileExtensionContentTypeProvider();
            string contentType;

            if (!provider.TryGetContentType(path, out contentType))
            {
                contentType = "application/octet-stream";
            }

            return contentType;
        }

        /// <inheritdoc cref="StandardRail.RailCarLounge.Business.Pact.IOpportunityService"/>
        public IList<OpportunityFeaturesViewModel> GetOpportunityFeatures(long OpportunityId)
        {
            var features = _featureRepository.GetByCondition(m => m.OpportunityId == OpportunityId && m.IsActive == true).Result.ToList();
            IList<OpportunityFeaturesViewModel> featuresList = new List<OpportunityFeaturesViewModel>();
            foreach (var feature in features)
            {
                featuresList.Add(this._mapper.Map<OpportunityFeaturesViewModel>(feature));
            }
            return featuresList;
        }

        /// <inheritdoc cref="StandardRail.RailCarLounge.Business.Pact.IOpportunityService"/>
        public async Task<List<OpportunityReservedSpacesViewModel>> SaveOpportunityReservedSpaces(IList<OpportunityReservedSpacesViewModel> opportunityReservedSpaces)
        {
            IList<OpportunityReservedSpaces> reservedSpaces = new List<OpportunityReservedSpaces>();
            foreach (var reservedSpace in opportunityReservedSpaces)
            {
                reservedSpaces.Add(this._mapper.Map<OpportunityReservedSpaces>(reservedSpace));
            }
            var reservedSpacesViewModels = await _opportunityReservedSpacesRepository.SaveEntities(reservedSpaces);
            List<OpportunityReservedSpacesViewModel> reservedSpacesViewModel = new List<OpportunityReservedSpacesViewModel>();
            foreach (var reservedSpaceViewModel in reservedSpacesViewModels)
            {
                reservedSpacesViewModel.Add(this._mapper.Map<OpportunityReservedSpacesViewModel>(reservedSpaceViewModel));
            }
            return reservedSpacesViewModel;
        }

        /// <inheritdoc cref="StandardRail.RailCarLounge.Business.Pact.IOpportunityService"/>
        public async Task<bool> DeleteOpportunityReservedSpaces(long Id)
        {
            var reservedSpace = await _opportunityReservedSpacesRepository.GetById(Id);
            reservedSpace.IsActive = false;
            await _opportunityReservedSpacesRepository.Update(reservedSpace);
            return true;
        }

        /// <inheritdoc cref="StandardRail.RailCarLounge.Business.Pact.IOpportunityService"/>
        public async Task<MemoryStream> GenerateOpportunityOrderSummary(OpportunityViewModel opportunityViewModel, User user, OpportunitySummaryDetailsDTViewModel opportunitySummaryDetailsDTViewModel, Vendor vendor, Customer customer)
        {
            try
            {
                var templateFile = await _azureBlobService.DownloadAsync(_configuration["OpportunityOrderEmailConfig:OpportunitySummaryTemplatePath"], _configuration["AzureServices:OpportunityAttachmentContainer"]);
                var OSModel = CreateViewModel(opportunityViewModel, user, opportunitySummaryDetailsDTViewModel, vendor, customer);
                var tempFilePath = $"{Path.GetTempPath()}OrderSummary\\";
                Directory.CreateDirectory(tempFilePath);
                tempFilePath = $"{tempFilePath}{Guid.NewGuid()}.cs.docx";
                _logger.LogInformation($"Temp file path for order summary:- {tempFilePath}");
                File.WriteAllBytes(tempFilePath, templateFile);
                var document = DocumentFactory.Create(tempFilePath, OSModel);
                var streamdata = document.Generate();
                FileInfo info = new FileInfo(tempFilePath);
                if (info.Exists)
                {
                    info.Delete();
                }
                return streamdata;
            }
            catch (SharpDocxCompilationException ex)
            {
                _logger.LogError($"Exeception Thrown :- {ex.Message}");
                _logger.LogError($"Error Occured:- {ex.Errors}");
            }
            catch (Exception ex)
            {
                _logger.LogError(ex.Message);
            }
            return null;
        }
        private OSModel CreateViewModel(OpportunityViewModel opportunityViewModel, User user, OpportunitySummaryDetailsDTViewModel opportunitySummaryDetailsDTViewModel, Vendor vendor, Customer customer)
        {
            return new OSModel()
            {
                OrderNo = opportunityViewModel.Name,
                BookingDate = opportunityViewModel.BookingDate,
                Company = user.CompanyName,
                Name = $"{user.FirstName} {user.LastName}",
                Address = user.Address,
                ContactNo = user.ContactNo,
                Email = user.EmailId,
                StorageFacilityName = opportunitySummaryDetailsDTViewModel.OpportunitySummaryDT.Rows[0][0].ToString(),
                InterchangeRR = opportunitySummaryDetailsDTViewModel.OpportunitySummaryDT.Rows[0][1].ToString(),
                Vendor = vendor.Organization,
                StartDate = opportunityViewModel.StartDate,
                EndDate = opportunityViewModel.EndDate,
                ApproxSpaces = string.IsNullOrWhiteSpace(opportunityViewModel.TotalNoApproxSpaces.ToString()) ? "Not Available" : opportunityViewModel.TotalNoApproxSpaces.ToString(),
                OpportunityRailCars = opportunityViewModel.OpportunityRailCars,
                ReservedSpaceDetails = opportunitySummaryDetailsDTViewModel.OpportunityReservedSpacesDT.AsEnumerable().Select(row =>
                                                new OpportunityReservedSpacesTemplateModel
                                                {
                                                    EffectiveDate = row.Field<DateTime>("EffectiveDate").Date.ToString("MM-dd-yyyy", CultureInfo.InvariantCulture),
                                                    ExpirationDate = row.Field<DateTime>("ExpirationDate").Date.ToString("MM-dd-yyyy", CultureInfo.InvariantCulture),
                                                    ReservedSpaces = row.Field<long>("ReservedSpaces")
                                                }).ToList()
            };
        }
    }
}
