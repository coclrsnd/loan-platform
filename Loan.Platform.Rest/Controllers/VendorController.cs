using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using StandardRail.RailCarLounge.Business.Pact;
using StandardRail.RailCarLounge.Common.UserContext;
using StandardRail.RailCarLounge.Models.Entities;
using StandardRail.RailCarLounge.Models.ViewModels;
using Swashbuckle.AspNetCore.Annotations;

namespace StandardRail.RailCarLounge.Rest.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    [Authorize]
    public class VendorController : ControllerBase
    {
        private readonly IOnboardVendorService _onboardVendorService;
        private readonly IVendorService _vendorService;
        private readonly ICustomerService _customerService;
        private readonly ILogger<VendorController> _logger;
        private long? UserId;
        private readonly string CurrentRole;
        public VendorController(IOnboardVendorService onboardVendorService, IVendorService vendorService,
            ICustomerService customerService, IUserContext claimsProvider, ILogger<VendorController> logger)
        {
            _onboardVendorService = onboardVendorService ?? throw new ArgumentNullException(nameof(onboardVendorService));
            _vendorService = vendorService ?? throw new ArgumentNullException(nameof(vendorService));
            _customerService = customerService ?? throw new ArgumentNullException(nameof(customerService));
            _logger = logger ?? throw new ArgumentNullException(nameof(logger));
            UserId = claimsProvider.UserId;
            CurrentRole = claimsProvider.CurrentRole;
        }

        /// <summary>
        /// Endpoint to save Vendor details.
        /// </summary>
        /// <param name="vendor">vendor view model</param>
        /// <returns>200 status code</returns>
        [HttpPost]
        [Route("SaveVendor", Name = "SaveVendor")]
        [SwaggerResponse(StatusCodes.Status200OK)]
        [SwaggerResponse(StatusCodes.Status400BadRequest)]
        public async Task<IActionResult> SaveVendor([FromBody] VendorViewModel vendor)
        {
            try
            {
                if (vendor != null)
                {
                    var savedVendor = await this._onboardVendorService.Save(vendor);
                    return Ok(savedVendor);
                }
                return BadRequest(vendor);
            }
            catch (Exception ex)
            {
                _logger.LogError("Error in SaveVendor - " + ex.Message);
                return BadRequest();
            }
        }

        ///// <summary>
        ///// Endpoint to get alll vendor list.
        ///// </summary>
        ///// <returns>list of vendors</returns>

        [HttpGet]
        [Route("GetVendorList", Name = "GetVendorList")]
        public async Task<ActionResult<IList<VendorAutoCompleteViewModel>>> GetVendorList()
        {
            try
            {
                var vendorList = await _onboardVendorService.GetVendorList();
                return Ok(vendorList);
            }
            catch (Exception ex)
            {
                _logger.LogError("Error in GetVendorList - " + ex.Message);
                return BadRequest();
            }
        }

        /// <summary>
        /// Endpoint to Get Vendor list.
        /// </summary>
        /// <param name="searchText">string</param>
        /// <returns>List of Vendors</returns>
        [HttpGet("GetVendorList/{searchText}")]
        [SwaggerResponse(StatusCodes.Status200OK)]
        [SwaggerResponse(StatusCodes.Status400BadRequest)]
        public async Task<ActionResult<IList<VendorAutoCompleteViewModel>>> GetVendorList(string searchText)
        {
            try
            {
                return Ok(await this._onboardVendorService.GetVendorList(searchText));
            }
            catch (Exception ex)
            {
                _logger.LogError("Error in GetVendorList - " + ex.Message);
                return BadRequest();
            }
        }

        /// <summary>
        /// Get vendor details by Id.
        /// </summary>
        /// <param name="vendorId"></param>
        /// <returns>vendor object</returns>
        [HttpGet]
        [Route("GetVendorDetails/{vendorId}", Name = "GetVendorDetails")]
        public async Task<IActionResult> GetVendorDetails(int vendorId)
        {
            try
            {
                var hasAccess = await this._vendorService.CheckVendorDetailsAccess(vendorId, 0);
                if (hasAccess)
                {
                    var vendorList = await _onboardVendorService.GetVendorDetails(vendorId);
                    return Ok(vendorList);
                }
                else
                {
                    var customer = await _customerService.GetCustomerForUser(UserId.Value);
                    hasAccess = await this._vendorService.CheckVendorDetailsAccess(vendorId, customer.Id);
                    if (hasAccess)
                    {
                        var vendorList = await _onboardVendorService.GetVendorDetails(vendorId);
                        return Ok(vendorList);
                    }
                }
                return Unauthorized();
            }
            catch (Exception ex)
            {
                _logger.LogError("Error in GetVendorDetails - " + ex.Message);
                return BadRequest();
            }
        }

        /// <summary>
        /// Endpoint to Get Vendor list on filter
        /// </summary>
        /// <param name="vendorFilterModel">VendorFilterViewModel</param>
        /// <returns>list of customer with pagination detail</returns>
        [HttpPost]
        [SwaggerResponse(StatusCodes.Status200OK)]
        [SwaggerResponse(StatusCodes.Status400BadRequest)]
        [Route("GetVendorsOnFilter", Name = "GetVendorsOnFilter")]
        public async Task<ActionResult<VendorFilterViewModel>> GetVendorsOnFilter([FromBody] VendorFilterViewModel vendorFilterModel)
        {
            try
            {
                var vendorsList = await _onboardVendorService.GetVendorsOnFilter(vendorFilterModel);
                return vendorsList;
            }
            catch (Exception ex)
            {
                _logger.LogError("Error in GetVendorsOnFilter - " + ex.Message);
                return BadRequest();
            }
        }

        /// <summary>
        /// Endpoint to get vendor list for autocomplete.
        /// </summary>
        /// <param name="searchText"></param>
        /// <returns>List of vendor</returns>
        [HttpGet("GetVendorListForAutoComplete/{searchText}")]
        public async Task<ActionResult<IList<Vendor>>> GetVendorListForAutoComplete(string searchText)
        {
            try
            {
                var vendorList = await _vendorService.GetVendorList(searchText);
                return Ok(vendorList);
            }
            catch (Exception ex)
            {
                _logger.LogError("Error in GetVendorListForAutoComplete - " + ex.Message);
                return BadRequest();
            }
        }

        /// <summary>
        ///  Get vendor for user.
        /// </summary>
        /// <param name="userId"></param>
        /// <returns>vendor object</returns>
        [HttpGet("GetVendorForUser/{userId}")]
        public async Task<ActionResult<Vendor>> GetVendorForUser(long userId)
        {
            try
            {
                var vendorList = await _vendorService.GetVendorForUser(userId);
                return vendorList;
            }
            catch (Exception ex)
            {
                _logger.LogError("Error in GetVendorForUser - " + ex.Message);
                return BadRequest();
            }
        }

        /// <summary>
        /// Get percentage margin for vendor
        /// </summary>
        /// <param name="storageOrderId"></param>
        /// <param name="vendorId"></param>
        /// <returns>decimal value</returns>
        [HttpGet("GetPercentageMarginForVendor/{storageOrderId}/{vendorId}")]
        public async Task<ActionResult<decimal>> GetPercentageMarginForVendor(long storageOrderId,long vendorId)
        {
            try
            {
                if (!string.IsNullOrEmpty(CurrentRole) && !CurrentRole.StartsWith("Customer", StringComparison.OrdinalIgnoreCase))
                {
                    var vendor =  await _vendorService.GetPercentageMarginForVendor(storageOrderId, vendorId);
                    return vendor;
                }
                else
                    return BadRequest();
            }
            catch (Exception ex)
            {
                _logger.LogError("Error in GetPercentageMarginForVendor - " + ex.Message);
                return BadRequest();
            }
        }
    }
}
