using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.StaticFiles;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.Logging;
using StandardRail.RailCarLounge.Business.Pact;
using StandardRail.RailCarLounge.Common.StorageAccountHelper.BlobHelper;
using StandardRail.RailCarLounge.Models.Entities;
using StandardRail.RailCarLounge.Models.ViewModels;
using Swashbuckle.AspNetCore.Annotations;

namespace StandardRail.RailCarLounge.Rest.Controllers
{
    /// <summary>
    /// Contract Controller.
    /// </summary>
    [Route("api/[controller]")]
    [ApiController]
    [Authorize]
    public class ContractController : ControllerBase
    {
        private readonly IContractService _contractService;
        private readonly IContractSFFeatureMappingService _contractSFFeatureMappingService;
        private readonly IContractNoteMappingService _contractNoteMappingService;
        private readonly IContractAttachmentMappingService _contractAttachmentMappingService;
        private readonly IConfiguration _configuration;
        private readonly IAzureBlobService _azureBlobService;
        private readonly IAuditLogService _auditLogService;
        private readonly ILogger<ContractController> _logger;

        /// <summary>
        /// Parameterized Constructor of Contract Controller.
        /// </summary>
        /// <param name="contractService">IContractService</param>
        /// <param name="contractSFFeatureMappingService">IContractSFFeatureMappingService</param>
        /// <param name="contractNoteMappingService">IContractNoteMappingService</param>
        /// <param name="contractAttachmentMappingService">IContractAttachmentMappingService</param>
        /// <param name="configuration">IConfiguration</param>
        /// <param name="azureBlobService">IAzureBlobService</param>
        /// <param name="auditLogService">IAuditLogService</param>
        public ContractController(IContractService contractService, IContractSFFeatureMappingService contractSFFeatureMappingService,
            IContractNoteMappingService contractNoteMappingService, IContractAttachmentMappingService contractAttachmentMappingService,
            IConfiguration configuration, IAzureBlobService azureBlobService, IAuditLogService auditLogService, ILogger<ContractController> logger)
        {
            _contractService = contractService ?? throw new ArgumentNullException(nameof(contractService));
            _contractSFFeatureMappingService = contractSFFeatureMappingService ?? throw new ArgumentNullException(nameof(contractSFFeatureMappingService));
            _contractNoteMappingService = contractNoteMappingService ?? throw new ArgumentNullException(nameof(contractNoteMappingService));
            _contractAttachmentMappingService = contractAttachmentMappingService ?? throw new ArgumentNullException(nameof(contractAttachmentMappingService));
            _configuration = configuration ?? throw new ArgumentNullException(nameof(configuration));
            _azureBlobService = azureBlobService ?? throw new ArgumentNullException(nameof(azureBlobService));
            _auditLogService = auditLogService ?? throw new ArgumentNullException(nameof(auditLogService));
            _logger = logger ?? throw new ArgumentNullException(nameof(logger));
        }

        /// <summary>
        /// Endpoint to Get-StorageOrderDetails list.
        /// </summary>
        /// <param name="contractViewModel">ContractViewModel</param>
        /// <returns>ContractViewModel</returns>
        [HttpPost]
        [Route("GetStorageOrderDetails", Name = "GetStorageOrderDetails")]
        public async Task<ActionResult<ContractViewModel>> GetStorageOrderDetails(ContractViewModel contractViewModel)
        {
            try
            {
                var storageOrderDetails = await _contractService.GetStorageOrderDetails(contractViewModel);
                return Ok(storageOrderDetails);
            }
            catch (Exception ex)
            {
                _logger.LogError("Error in GetStorageOrderDetails - " + ex.Message);
                return BadRequest();
            }
        }

        /// <summary>
        ///  Endpoint to save new contract.
        /// </summary>
        /// <param name="contractViewModel">ContractViewModel</param>
        /// <returns>ContractViewModel</returns>
        //[HttpPost]
        //[Route("SaveStorageOrder", Name = "SaveStorageOrder")]
        //public async Task<ActionResult<ContractViewModel>> SaveStorageOrder(ContractViewModel contractViewModel)
        //{
        //    try
        //    {
        //        var storageOrderDetails = await _contractService.SaveStorageOrder(contractViewModel);
        //        if (storageOrderDetails != null && storageOrderDetails.Id > 0 && contractViewModel.StorageFeatureIds != null && contractViewModel.StorageFeatureIds.Count >= 1)
        //        {
        //            contractViewModel.Id = storageOrderDetails.Id;
        //            await _contractSFFeatureMappingService.SaveContractSFFeatureMappingAsync(contractViewModel);
        //        }
        //        return Ok(storageOrderDetails);
        //    }
        //    catch (Exception ex)
        //    {
        //        _logger.LogError("Error in SaveStorageOrder - " + ex.Message);
        //        return BadRequest();
        //    }
        //}

        /// <summary>
        ///  Endpoint to update new contract.
        /// </summary>
        /// <param name="contractViewModel">ContractViewModel</param>
        /// <returns></returns>
        [HttpPost]
        [Route("UpdateStorageOrder", Name = "UpdateStorageOrder")]
        public async Task<IActionResult> UpdateStorageOrder(ContractViewModel contractViewModel)
        {
            try
            {
                if (contractViewModel != null && contractViewModel.Id > 0)
                {
                    await _contractService.UpdateStorageOrder(contractViewModel);

                    if (contractViewModel.StorageFeatureIds != null && contractViewModel.StorageFeatureIds.Count >= 1)
                    {
                        await _contractSFFeatureMappingService.DeleteContractSFFeatureMappingAsync(contractViewModel.Id);
                        await _contractSFFeatureMappingService.SaveContractSFFeatureMappingAsync(contractViewModel);
                    }
                    return Ok();
                }
                return BadRequest();
            }
            catch (Exception ex)
            {
                _logger.LogError("Error in UpdateStorageOrder - " + ex.Message);
                return BadRequest();
            }
        }

        /// <summary>
        /// Endpoint to Get-StorageOrderDetailsById list.
        /// </summary>
        /// <param name="Id">long</param>
        /// <returns>ContractViewModel</returns>
        [HttpGet]
        [Route("GetStorageOrderDetailsById/{Id}", Name = "GetStorageOrderDetailsById")]
        public async Task<ActionResult<ContractViewModel>> GetStorageOrderDetailsById(long Id)
        {
            try
            {
                var storageOrderDetails = await _contractService.GetStorageOrderDetailsById(Id);
                var hasAccess = await _contractService.CheckStorageOrderDetailsAccess(storageOrderDetails.CustomerId,storageOrderDetails.VendorId);
                if (hasAccess)
                {
                    return storageOrderDetails;
                }
                return Unauthorized();
            }
            catch (Exception ex)
            {
                _logger.LogError("Error in GetStorageOrderDetailsById - " + ex.Message);
                return BadRequest();
            }
        }

        /// <summary>
        /// Endpoint to Get-StorageOrder list.
        /// </summary>
        /// <param name="searchText">string</param>
        /// <returns>List of Contract</returns>
        [HttpGet("GetStorageOrderList/{searchText}")]
        [SwaggerResponse(StatusCodes.Status200OK)]
        [SwaggerResponse(StatusCodes.Status400BadRequest)]
        public async Task<ActionResult<IList<Contract>>> GetStorageOrderList(string searchText)
        {
            try
            {
                return Ok(await this._contractService.GetStorageOrderList(searchText));
            }
            catch (Exception ex)
            {
                _logger.LogError("Error in GetStorageOrderList - " + ex.Message);
                return BadRequest();
            }
        }

        /// <summary>
        /// Endpoint to Get-StorageOrderB-yCustomer.
        /// </summary>
        /// <param name="Id">Long</param>
        /// <returns>List of Contract</returns>
        [HttpGet("GetStorageOrderByCustomer/{Id}")]
        [SwaggerResponse(StatusCodes.Status200OK)]
        [SwaggerResponse(StatusCodes.Status400BadRequest)]
        public async Task<ActionResult<List<StorageOrderModel>>> GetStorageOrderByCustomer(long Id)
        {
            try
            {
                return Ok(await this._contractService.GetStorageOrderbyCustomer(Id));
            }
            catch (Exception ex)
            {
                _logger.LogError("Error in GetStorageOrderByCustomer - " + ex.Message);
                return BadRequest();
            }
        }

        /// <summary>
        /// Endpoint to SaveNotes.
        /// </summary>
        /// <param name="noteModel">NoteViewModel</param>
        /// <returns>NoteViewModel</returns>
        [HttpPost]
        [Route("SaveNotes", Name = "SaveNotes")]
        public async Task<ActionResult<NoteViewModel>> SaveNotes(NoteViewModel noteModel)
        {
            try
            {
                var savedNote = await _contractNoteMappingService.SaveContractNoteMappingAsync(noteModel);
                return Ok(savedNote);
            }
            catch (Exception ex)
            {
                _logger.LogError("Error in SaveNotes - " + ex.Message);
                return BadRequest();
            }
        }

        /// <summary>
        /// Endpoint to Get-NotesByContractId list.
        /// </summary>
        /// <param name="Id">long</param>
        /// <returns>List of NoteViewModel</returns>
        [HttpGet]
        [Route("GetNotesByContractId/{Id}", Name = "GetNotesByContractId")]
        public async Task<ActionResult<IList<NoteViewModel>>> GetNotesByContractId(long Id)
        {
            try
            {
                var notes = await _contractNoteMappingService.GetNotesByContractId(Id);
                return Ok(notes);
            }
            catch (Exception ex)
            {
                _logger.LogError("Error in GetNotesByContractId - " + ex.Message);
                return BadRequest();
            }
        }

        /// <summary>
        /// Endpoint to Get-AttachmentsByContractId list.
        /// </summary>
        /// <param name="Id">long</param>
        /// <returns>>List of AttachmentViewModel</returns>
        [HttpGet]
        [Route("GetAttachmentsByContractId/{Id}", Name = "GetAttachmentsByContractId")]
        public async Task<ActionResult<IList<AttachmentViewModel>>> GetAttachmentsByContractId(long Id)
        {
            try
            {
                var attachments = await _contractAttachmentMappingService.GetAttachmentsByContractId(Id);
                return Ok(attachments);
            }
            catch (Exception ex)
            {
                _logger.LogError("Error in GetAttachmentsByContractId - " + ex.Message);
                return BadRequest();
            }
        }

        /// <summary>
        /// Endpoint to SaveAttachment.
        /// </summary>
        /// <returns>ActionResult of AttachmentViewModel</returns>
        [HttpPost, RequestSizeLimit(5242880)]
        [Route("SaveAttachment", Name = "SaveAttachment")]
        public async Task<ActionResult<AttachmentViewModel>> SaveAttachment()
        {
            try
            {
                var formCollection = await Request.ReadFormAsync();
                var file = formCollection.Files.First();
                var contractId = formCollection["ContractId"];
                if (file != null && file.Length > 0)
                {
                    string folderName = "ContractId_" + contractId;
                    string pathString = System.IO.Path.Combine(folderName, file.FileName);

                    if (!this._contractAttachmentMappingService.CheckValidExtension(pathString))
                    {
                        return BadRequest("Incorrect file format. Allowed types .docx, .doc, .pdf, .png, .jpg, .jpeg, .txt, .xlsx, .csv");
                    }
                    AzureBlobModel azureBlobModel = new AzureBlobModel()
                    {
                        FileContent = file.OpenReadStream(),
                        FileName=file.FileName,
                        ContentType= file.FileName.GetContentType(),
                    };

                    var uploadResult = await _azureBlobService.UploadAsync(azureBlobModel, _configuration["AzureServices:StorageOrderAttachmentContainer"], pathString);
                    AttachmentViewModel attachmentViewModel = new AttachmentViewModel();
                    attachmentViewModel.ContractId = Convert.ToInt32(contractId);
                    attachmentViewModel.FileName = file.FileName;
                    attachmentViewModel.Path = uploadResult.fileUri;
                    var savedAttachment = await this._contractAttachmentMappingService.SaveContractAttachmentMappingAsync(attachmentViewModel);
                    return Ok(savedAttachment);
                }
                return Ok(new AttachmentViewModel());
            }
            catch (Exception ex)
            {
                _logger.LogError("Error in SaveAttachment - " + ex.Message);
                return BadRequest();
            }
        }

        /// <summary>
        /// Endpoint to ValidateAndExpire.
        /// </summary>
        /// <param name="Id">long</param>
        /// <returns>bool</returns>
        [HttpGet]
        [Route("ValidateAndExpire/{Id}", Name = "ValidateAndExpire")]
        public async Task<ActionResult<bool>> ValidateAndExpire(long Id)
        {
            try
            {
                var isExpired = await _contractService.ValidateAndExpire(Id);
                return isExpired;
            }
            catch (Exception ex)
            {
                _logger.LogError("Error in ValidateAndExpire - " + ex.Message);
                return BadRequest();
            }
        }

        /// <summary>
        /// Endpoint to DownloadAttachment.
        /// </summary>
        /// <param name="fileName">string</param>
        /// <param name="contractId">string</param>
        /// <returns>IActionResult</returns>
        [HttpGet]
        [Route("DownloadAttachment", Name = "DownloadAttachment")]
        public async Task<IActionResult> DownloadAttachment(string fileName, string contractId)
        {
            try
            {
                string folderName = "ContractId_" + contractId;
                string pathString = System.IO.Path.Combine(folderName, fileName);
                var result = await _azureBlobService.DownloadAsync(pathString, _configuration["AzureServices:StorageOrderAttachmentContainer"]);
                MemoryStream dataStream = new MemoryStream(result);
                dataStream.Position = 0;
                return File(dataStream, GetContentType(fileName), fileName);
            }
            catch (Exception ex)
            {
                _logger.LogError("Error in DownloadAttachment - " + ex.Message);
                return BadRequest();
            }
        }

        /// <summary>
        /// Endpoint to Get-ContentType.
        /// </summary>
        /// <param name="path">string</param>
        /// <returns>string</returns>
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

        /// <summary>
        /// Endpoint to Get-AuditLogsByContractId.
        /// </summary>
        /// <param name="Id">Id</param>
        /// <returns>List of AuditLogViewModel</returns>
        [HttpGet]
        [Route("GetAuditLogsByContractId/{Id}", Name = "GetAuditLogsByContractId")]
        public async Task<ActionResult<IList<AuditLogViewModel>>> GetAuditLogsByContractId(long Id)
        {
            try
            {
                var auditLogs = await _auditLogService.GetAuditLogsByContractId(Id);
                return Ok(auditLogs);
            }
            catch (Exception ex)
            {
                _logger.LogError("Error in GetAuditLogsByContractId - " + ex.Message);
                return BadRequest();
            }
        }

        /// <summary>
        /// Endpoint to Get-AuditLogsOnFilter.
        /// </summary>
        /// <param name="AuditLogFilterViewModel">AuditLogFilterViewModel</param>
        /// <returns>List of AuditLogFilterViewModel</returns>
        [HttpPost]
        [Route("GetAuditLogsOnFilter", Name = "GetAuditLogsOnFilter")]
        public async Task<ActionResult<AuditLogFilterViewModel>> GetAuditLogsOnFilter([FromBody] AuditLogFilterViewModel auditLogFilterViewModel)
        {
            try
            {
                var auditLogs = await _auditLogService.GetAuditLogsOnFilter(auditLogFilterViewModel);
                return Ok(auditLogs);
            }
            catch (Exception ex)
            {
                _logger.LogError("Error in GetAuditLogsByContractId - " + ex.Message);
                return BadRequest();
            }
        }

        /// <summary>
        /// SaveContractDetail
        /// </summary>
        /// <param name="contractViewModel">ContractViewModel</param>
        /// <returns></returns>
        [HttpPost]
        [Route("SaveContractDetail", Name = "SaveContractDetail")]
        public async Task<IActionResult> SaveContractDetail(ContractViewModel contractViewModel)
        {
            try
            {
                if (contractViewModel == null)
                {
                    return BadRequest("ContractViewModel cannot be null.");
                }
                contractViewModel = await this._contractService.SaveContractDetail(contractViewModel);
                return Ok(contractViewModel);
            }
            catch (Exception ex)
            {
                _logger.LogError("Error in SaveContractDetail - " + ex.Message);
                return BadRequest();
            }
        }

    }
}
