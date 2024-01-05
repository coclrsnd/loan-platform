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
    /// <summary>
    /// Customer Controller.
    /// </summary>
    [Route("api/[controller]")]
    [ApiController]
    [Authorize]
    public class CustomerController : ControllerBase
    {
        private readonly IVendorService _vendorService;
        private readonly ICustomerService _customerService;
        private readonly ILogger<CustomerController> _logger;
        private long? UserId;
        private readonly string CurrentRole;

        /// <summary>
        /// Parameterized Constructor of Customer Controller.
        /// </summary>
        /// <param name="customerService">ICustomerService</param>
        public CustomerController(ICustomerService customerService, IVendorService vendorService, IUserContext claimsProvider,
            ILogger<CustomerController> logger)
        {
            _customerService = customerService ?? throw new ArgumentNullException(nameof(customerService));
            _vendorService = vendorService ?? throw new ArgumentNullException(nameof(vendorService));
            _logger = logger ?? throw new ArgumentNullException(nameof(logger));
            UserId = claimsProvider.UserId;
            CurrentRole = claimsProvider.CurrentRole;
        }

        /// <summary>
        /// Endpoint to Get-Customer list.
        /// </summary>
        /// <returns>List of Customer</returns>
        [HttpGet]
        [Route("GetCustomerList", Name = "GetCustomerList")]
        public async Task<ActionResult<IList<Customer>>> GetCustomerList()
        {
            try
            {
                var customerList = await _customerService.GetCustomerList();
                return Ok(customerList);
            }
            catch (Exception ex)
            {
                _logger.LogError("Error in GetCustomerList - " + ex.Message);
                return BadRequest();
            }
        }

        /// <summary>
        /// Endpoint to On-Board new customer.
        /// </summary>
        /// <param name="customerModel">CustomerViewModel</param>
        /// <returns>Saved Customer detail</returns>
        [HttpPost]
        [SwaggerResponse(StatusCodes.Status200OK)]
        [SwaggerResponse(StatusCodes.Status400BadRequest)]
        [Route("OnBoardCustomer", Name = "OnBoardCustomer")]
        public async Task<IActionResult> OnBoardCustomer([FromBody] CustomerViewModel customerModel)
        {
            try
            {
                var customerList = await _customerService.OnBoardNewCustomers(customerModel);
                return Ok(customerList);
            }
            catch (Exception ex)
            {
                _logger.LogError("Error in OnBoardCustomer - " + ex.Message);
                return BadRequest();
            }
        }

        /// <summary>
        /// Endpoint to Get Customers list on filter
        /// </summary>
        /// <param name="customerFilterModel">CustomerFilterViewModel</param>
        /// <returns>list of customer with pagination detail</returns>
        [HttpPost]
        [SwaggerResponse(StatusCodes.Status200OK)]
        [SwaggerResponse(StatusCodes.Status400BadRequest)]
        [Route("GetCustomerListOnFilter", Name = "GetCustomerListOnFilter")]
        public async Task<ActionResult<CustomerFilterViewModel>> GetCustomerListOnFilter([FromBody] CustomerFilterViewModel customerFilterModel)
        {
            try
            {
                var customerList = await _customerService.GetCustomersOnFilter(customerFilterModel);
                return customerList;
            }
            catch (Exception ex)
            {
                _logger.LogError("Error in GetCustomerListOnFilter - " + ex.Message);
                return BadRequest();
            }
        }


        /// <summary>
        /// Endpoint to Get Customer detail by ID
        /// </summary>
        /// <param name="id">long</param>
        /// <returns>Customer detail of selected ID</returns>
        [HttpGet]
        [SwaggerResponse(StatusCodes.Status200OK)]
        [SwaggerResponse(StatusCodes.Status400BadRequest)]
        [Route("GetCustomerByID/{id}", Name = "GetCustomerByID/{id}")]
        public async Task<IActionResult> GetCustomerByID(long id)
        {
            try
            {
                var hasAccess = await this._customerService.CheckCustomerDetailsAccess(id, 0);
                if (hasAccess)
                {
                    var customerList = await _customerService.GetCustomerById(id);
                    return Ok(customerList);
                }
                else
                {
                    var vendor = await _vendorService.GetVendorForUser(UserId.Value);
                    hasAccess = await this._customerService.CheckCustomerDetailsAccess(id, vendor.Id);
                    if (hasAccess)
                    {
                        var customerList = await _customerService.GetCustomerById(id);
                        return Ok(customerList);
                    }
                }
                return Unauthorized();
            }
            catch (Exception ex)
            {
                _logger.LogError("Error in GetCustomerByID - " + ex.Message);
                return BadRequest();
            }
        }

        /// <summary>
        /// Endpoint to Update customer detail
        /// </summary>
        /// <param name="customerModel">CustomerViewModel</param>
        /// <returns>if customer saved successfully then response should be greter than zero</returns>
        [HttpPut]
        [SwaggerResponse(StatusCodes.Status200OK)]
        [SwaggerResponse(StatusCodes.Status400BadRequest)]
        [Route("UpdateCustomer", Name = "UpdateCustomer")]
        public async Task<IActionResult> UpdateCustomer([FromBody] CustomerViewModel customerModel)
        {
            try
            {
                await _customerService.UpdateCustomerDetail(customerModel);
                return Ok();
            }
            catch (Exception ex)
            {
                _logger.LogError("Error in UpdateCustomer - " + ex.Message);
                return BadRequest();
            }
        }

        /// <summary>
        /// Get Customers based on searchText.
        /// </summary>
        /// <param name="searchText"></param>
        /// <returns>List of customerautocompleteviewmodel</returns>
        [HttpGet("GetCustomers/{searchText}")]
        public async Task<ActionResult<IList<CustomerAutoCompleteViewModel>>> GetCustomers(string searchText)
        {
            try
            {
                var customerList = await _customerService.GetCustomers(searchText);
                return Ok(customerList);
            }
            catch (Exception ex)
            {
                _logger.LogError("Error in GetCustomers - " + ex.Message);
                return BadRequest();
            }
        }

        /// <summary>
        /// Get customer for user.
        /// </summary>
        /// <param name="userId"></param>
        /// <returns>CustomerAutoCompleteViewModel model</returns>
        [HttpGet("GetCustomerForUser/{userId}")]
        public async Task<ActionResult<CustomerAutoCompleteViewModel>> GetCustomerForUser(long userId)
        {
            try
            {
                var customer = await _customerService.GetCustomerForUser(userId);
                return customer;
            }
            catch (Exception ex)
            {
                _logger.LogError("Error in GetCustomerForUser - " + ex.Message);
                return BadRequest();
            }
        }

        /// <summary>
        /// Get percentage margin for customer.
        /// </summary>
        /// <param name="storageOrderId"></param>
        /// <param name="customerId"></param>
        /// <returns>decimal value</returns>
        [HttpGet("GetPercentageMarginForCustomer/{storageOrderId}/{customerId}")]
        public async Task<ActionResult<decimal>> GetPercentageMarginForCustomer(long storageOrderId,long customerId)
        {
            try
            {
                if (!string.IsNullOrEmpty(CurrentRole) && !CurrentRole.StartsWith("Vendor", StringComparison.OrdinalIgnoreCase) && !CurrentRole.StartsWith("Customer", StringComparison.OrdinalIgnoreCase))
                {
                    var customer = await _customerService.GetPercentageMarginForCustomer(storageOrderId, customerId);
                    return customer;
                }
                else
                {
                    return BadRequest();
                }
                    
            }
            catch (Exception ex)
            {
                _logger.LogError("Error in GetPercentageMarginForCustomer - " + ex.Message);
                return BadRequest();
            }
        }
    }
}