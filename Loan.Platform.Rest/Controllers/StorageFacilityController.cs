using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using StandardRail.RailCarLounge.Business.Pact;
using StandardRail.RailCarLounge.Models.Entities;
using StandardRail.RailCarLounge.Models.ViewModels;
using Swashbuckle.AspNetCore.Annotations;

namespace StandardRail.RailCarLounge.Rest.Controllers
{
    /// <summary>
    /// StorageFacility Controller.
    /// </summary>
    [Route("api/[controller]")]
    [ApiController]
    [Authorize]
    public class StorageFacilityController : ControllerBase
    {
        private readonly IStorageFacilityService _storageFacilityService;
        private readonly ILogger<StorageFeatureController> _logger;

        /// <summary>
        /// Parameterized Constructor of StorageFacilityController.
        /// </summary>
        /// <param name="storageFacilityService">IStorageFacilityService</param>
        /// <param name="logger">ILogger<StorageFeatureController></param>
        public StorageFacilityController(IStorageFacilityService storageFacilityService, ILogger<StorageFeatureController> logger)
        {
            _storageFacilityService = storageFacilityService ?? throw new ArgumentNullException(nameof(storageFacilityService));
            _logger = logger ?? throw new ArgumentNullException(nameof(logger));
        }

        /// <summary>
        /// Endpoint to Save Storage Facility Data.
        /// </summary>
        /// <param name="model">StorageFacilityViewModel</param>
        /// <returns>Saved Storage Facility Detail</returns>
        [HttpPost]
        [SwaggerResponse(StatusCodes.Status200OK)]
        [SwaggerResponse(StatusCodes.Status400BadRequest)]
        public async Task<IActionResult> Post([FromBody] StorageFacilityViewModel model)
        {
            try
            {
                if (model != null && model.Id == 0)
                {
                    var storageFeature = await this._storageFacilityService.Save(model);
                    return Ok(storageFeature);
                }
                return BadRequest(model);
            }
            catch (Exception ex)
            {
                _logger.LogError("Error in SaveStorageFacility - " + ex.Message);
                return BadRequest();
            }
        }

        /// <summary>
        /// Endpoint to Get Storage Facility by Vendor ID.
        /// </summary>
        /// <param name="vendorId">long</param>
        /// <returns>List of Storage Facility that contains requested vendor ID</returns>
        [HttpGet]
        [Route("GetStorageFacilitiesByVendorId/{vendorId}", Name = "GetStorageFacilitiesByVendorId")]
        public async Task<ActionResult<IList<StorageFacility>>> GetStorageFacilitiesByVendorId(long vendorId)
        {
            try
            {
                var storageFacilityList = await _storageFacilityService.GetStorageFacilitiesByVendorId(vendorId);
                return Ok(storageFacilityList);
            }
            catch (Exception ex)
            {
                _logger.LogError("Error in GetStorageFacilitiesByVendorId - " + ex.Message);
                return BadRequest();
            }
        }

        /// <summary>
        /// Endpoint to Search Storage facilities.
        /// </summary>
        /// <param name="facilityMapSearchRequest">FacilityMapSearchRequestModel</param>
        /// <returns>List of FacilityMapSearchResultViewModel.</returns>
        [HttpPost]
        [Route("SearchStorageFacilities", Name = "SearchStorageFacilities")]
        public async Task<IActionResult> SearchStorageFacilities([FromBody] FacilityMapSearchRequestModel facilityMapSearchRequest)
        {
            try
            {
                var storageFacilitiesSearchResult = await _storageFacilityService.SearchStorageFacilities(facilityMapSearchRequest);
                return Ok(storageFacilitiesSearchResult);
            }
            catch (Exception ex)
            {
                _logger.LogError("Error in SearchStorageFacilities - " + ex.Message);
                return BadRequest();
            }
        }

        /// <summary>
        /// Endpoint to Get Storage Facilities for requested Organization/Vendor ID.
        /// </summary>
        /// <param name="organizationID">long</param>
        /// <returns>List of First(50) Storage Facility</returns>
        [HttpGet]
        [Route("GetStorageFacilities/{orgId}", Name = "GetStorageFacilities")]
        public async Task<ActionResult<IList<StorageFacility>>> GetStorageFacilities(long orgId)
        {
            try
            {
                var storageFacilityList = await _storageFacilityService.GetStorageFacilities(orgId);
                return Ok(storageFacilityList);
            }
            catch (Exception ex)
            {
                _logger.LogError("Error in GetStorageFacilities - " + ex.Message);
                return BadRequest();
            }
        }

    }
}
