using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using StandardRail.RailCarLounge.Business;
using StandardRail.RailCarLounge.Business.Pact;
using StandardRail.RailCarLounge.Common.StorageAccountHelper.BlobHelper;
using StandardRail.RailCarLounge.Models.Entities;
using StandardRail.RailCarLounge.Models.ViewModels;

namespace StandardRail.RailCarLounge.Rest.Controllers
{
    /// <summary>
    ///  Opportunity Controller 
    /// </summary>
    [Route("api/[controller]")]
    [ApiController]
    [Authorize]
    public class OpportunityController : ControllerBase
    {

        private readonly ILogger<OpportunityController> _logger;
        private readonly IOpportunityService _opportunityService;
        private readonly ICustomerService _customerService;
        private readonly IOnboardVendorService _onboardVendorService;

        public OpportunityController(ILogger<OpportunityController> logger,ICustomerService customerService,IOnboardVendorService onboardVendorService,IOpportunityService opportunityService)
        {
            _logger = logger ?? throw new ArgumentNullException(nameof(logger));
            _opportunityService = opportunityService ?? throw new ArgumentNullException(nameof(opportunityService));
            _customerService = customerService ?? throw new ArgumentNullException(nameof(customerService));
            _onboardVendorService = onboardVendorService ?? throw new ArgumentNullException(nameof(onboardVendorService));
        }

        /// <summary>
        /// save Opportunity Railcars and Attachment 
        /// </summary>
        /// <param name="opportunityViewModel"></param>
        /// <returns></returns>
        [HttpPost]
        [Route("SaveOpportunity", Name = "SaveOpportunity")]
        public async Task<IActionResult> SaveOpportunity([FromBody] OpportunityViewModel opportunityViewModel)
        {
            try
            {
                var opportunity = await _opportunityService.SaveOpportunity(opportunityViewModel);
                return Ok(opportunity);
            }
            catch (Exception ex)
            {
                _logger.LogError("Error Opportunity Order. - " + ex.Message);
                return BadRequest();
            }
        }

        /// <summary>
        /// Save Opportunity Features
        /// </summary>
        /// <param name="opportunityFeaturesModels"></param>
        /// <returns></returns>
        [HttpPost]
        [Route("SaveOpportunityFeatures", Name = "SaveOpportunityFeatures")]
        public async Task<IActionResult> SaveOpportunityOrderFeatures([FromBody] IList<OpportunityFeaturesViewModel> opportunityFeaturesModels)
        {
            try
            {
                var features = await _opportunityService.SaveOpportunityFeatures(opportunityFeaturesModels);
                return Ok(features);
            }
            catch (Exception ex)
            {
                _logger.LogError("Error Place Opportunity Order Features. - " + ex.Message);
                return BadRequest();
            }
        }


        /// <summary>
        /// GetOpportunity By Id
        /// </summary>
        /// <param name="Id"></param>
        /// <returns></returns>
        [HttpGet]
        [Route("GetOpportunityById/{Id}", Name = "GetOpportunityById")]
        public async Task<IActionResult> GetOpportunityById(long Id)
        {
            try
            {
                var opportunity = await _opportunityService.GetOpportunityById(Id);
                return Ok(opportunity);
            }
            catch (Exception ex)
            {
                _logger.LogError("Error in  GetOpportunityById. - " + ex.Message);
                return BadRequest();
            }
        }

        /// <summary>
        /// Save Attachment to azure blob
        /// </summary>
        /// <returns></returns>
        [HttpPost]
        [Route("SaveAttachment", Name = "UploadOpportunityAttachment")]
        public async Task<ActionResult<OpportunityAttachmentViewModel>> UploadOpportunityAttachment()
        {
            try
            {
                OpportunityAttachmentViewModel opportunityAttachmentViewModel = new OpportunityAttachmentViewModel();
                var formCollection = await Request.ReadFormAsync();
                var file = formCollection.Files.First();
                var vendorId = Convert.ToInt32(formCollection["VendorId"]);
                var userId = Convert.ToInt32(formCollection["UserId"]);
                string folderName = Convert.ToString(formCollection["FolderName"]);
                var vendorDetails = await _onboardVendorService.GetVendorDetails(vendorId);
                var customer = await _customerService.GetCustomerForUser(userId);
                if (string.IsNullOrEmpty(folderName)) { 
                folderName = vendorDetails.Organization + "_" + customer.Name + "_" + DateTime.Now.Year.ToString() + "_" + DateTime.Now.ToString("yyyyMMddHHmmss");
                     }
                string pathString = Path.Combine(folderName + "\\documents", file.FileName);
                if (!_opportunityService.CheckValidExtension(file.FileName))
                {
                    return BadRequest("Incorrect file format. Allowed types .docx, .doc, .pdf, .png, .jpg, .jpeg, .txt, .xlsx, .csv");
                }
                AzureBlobModel azureBlobModel = new AzureBlobModel()
                {
                    FileContent = file.OpenReadStream(),
                    FileName = file.FileName,
                    ContentType = file.FileName.GetContentType(),
                };
                var response = await _opportunityService.UploadOpportunityAttachment(azureBlobModel, pathString);
                opportunityAttachmentViewModel.Path = response;
                opportunityAttachmentViewModel.FolderName = folderName;
                return Ok(opportunityAttachmentViewModel);
            }
            catch (Exception ex)
            {
                _logger.LogError("Error for uploading file - " + ex.Message);
                return BadRequest("Error for uploading file.");
            }
        }

        /// <summary>
        /// Delete Attachment
        /// </summary>
        /// <param name="deleteOpportunityAttachmentViewModel"></param>
        /// <returns></returns>
        [HttpPost]
        [Route("DeleteAttachment", Name = "DeleteOpportunityAttachment")]
        public async Task<IActionResult> DeleteOpportunityAttachment(OpportunityAttachmentViewModel deleteOpportunityAttachmentViewModel)
        {
            try
            {
                bool isOpportunityAttachmentDeleted = _opportunityService.DeleteOpportunityAttachment(deleteOpportunityAttachmentViewModel.Path);
                return Ok(isOpportunityAttachmentDeleted);
            }
            catch (Exception ex)
            {
                _logger.LogError("Error for deleting file. - " + ex.Message);
                return BadRequest("Error to deleting file.");
            }
        }

        /// <summary>
        /// Download Attachment
        /// </summary>
        /// <param name="attachmentViewModel"></param>
        /// <returns></returns>
        [HttpPost]
        [Route("DownloadAttachment", Name = "DownloadOpportunityAttachment")]
        public async Task<IActionResult> DownloadOpportunityAttachment([FromBody] OpportunityAttachmentViewModel attachmentViewModel)
        {
            try
            {
                var opportunitySummary = await _opportunityService.DownloadOpportunitySummary(attachmentViewModel.Path);
                MemoryStream dataStream = new MemoryStream(opportunitySummary);
                dataStream.Position = 0;
                return File(dataStream, _opportunityService.GetContentType(attachmentViewModel.Path), attachmentViewModel.Name);
            }
            catch (Exception ex)
            {
                _logger.LogError("Error in DownloadAttachment - " + ex.Message);
                return BadRequest();
            }
        }

        /// <summary>
        /// Download Opportunity Summary
        /// </summary>
        /// <param name="customerName"></param>
        /// <param name="fileName"></param>
        /// <returns></returns>
        [HttpGet]
        [Route("DownloadOpportunitySummary/{customerName}/{fileName}", Name = "DownloadOpportunitySummary")]
        public async Task<IActionResult> DownloadOpportunitySummary(string customerName, string fileName)
        {
            try
            {
                var AggrementPath = $"{customerName}/{fileName}";
                var OpportunitySummary = await _opportunityService.DownloadOpportunitySummary(AggrementPath);
                MemoryStream dataStream = new MemoryStream(OpportunitySummary);
                dataStream.Position = 0;
                return File(dataStream, _opportunityService.GetContentType(fileName), fileName);
            }
            catch (Exception ex)
            {
                _logger.LogError("Error Downloading Opportunity Summary. - " + ex.Message);
                return BadRequest("Error Downloading Opportunity Summary.");
            }

        }

        /// <summary>
        /// Place Order Opportunity
        /// </summary>
        /// <param name="opportunityViewModel"></param>
        /// <returns></returns>
        [HttpPost]
        [Route("PlaceOrder", Name = "PlaceOrderOpportunity")]
        public async Task<IActionResult> PlaceOrderOpportunity([FromBody] OpportunityViewModel opportunityViewModel)
        {
            var opportunity = await _opportunityService.PlaceOpportunity(opportunityViewModel);
            if(opportunity == null)
            {
                return BadRequest("Unable to Place Order.");
            }
            return Ok(opportunity);
        }

        /// <summary>
        /// Save Opportunity ReservedSpaces
        /// </summary>
        /// <param name="opportunityReservedSpacesViewModels"></param>
        /// <returns></returns>
        [HttpPost]
        [Route("SaveReservedSpaces", Name = "SaveOpportunityReservedSpaces")]
        public async Task<IActionResult> SaveOpportunityReservedSpaces(List<OpportunityReservedSpacesViewModel> opportunityReservedSpacesViewModels)
        {
            var result = await _opportunityService.SaveOpportunityReservedSpaces(opportunityReservedSpacesViewModels);
            return Ok(result);
        }

        /// <summary>
        /// Delete Opportunity ReservedSpaces
        /// </summary>
        /// <param name="Id"></param>
        /// <returns></returns>
        [HttpGet]
        [Route("DeleteReservedSpace/{Id}", Name = "DeleteOpportunityReservedSpaces")]
        public async Task<IActionResult> DeleteOpportunityReservedSpaces(long Id)
        {
            var result = await _opportunityService.DeleteOpportunityReservedSpaces(Id);
            return Ok(result);
        }

    }
}
