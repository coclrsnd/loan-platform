using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using StandardRail.RailCarLounge.Business.Pact;
using StandardRail.RailCarLounge.Models.Entities;
using StandardRail.RailCarLounge.Models.UserManagementModels;
using StandardRail.RailCarLounge.Models.ViewModels;
using Swashbuckle.AspNetCore.Annotations;

namespace StandardRail.RailCarLounge.Rest.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    [Authorize]
    public class MasterController : ControllerBase
    {
        private readonly IRailRoadService _railRoadService;

        private readonly IMasterDataService _masterDataService;

        private readonly ILogger<MasterController> _logger;

        /// <summary>
        /// Parameterized Constructor of MasterController.
        /// </summary>
        /// <param name="railRoadService">IRailRoadService</param>
        /// <param name="masterDataService">IMasterDataService</param>
        /// <param name="logger">ILogger<MasterController></param>
        public MasterController(IRailRoadService railRoadService, IMasterDataService masterDataService, ILogger<MasterController> logger)
        {
            _railRoadService = railRoadService ?? throw new ArgumentNullException(nameof(railRoadService));
            _masterDataService = masterDataService ?? throw new ArgumentNullException(nameof(masterDataService));
            _logger = logger ?? throw new ArgumentNullException(nameof(logger));
        }

        /// <summary>
        /// Endpoint to Post Request/ Save New RailRoad.
        /// </summary>
        /// <param name="railRoadModel">RailRoad</param>
        /// <returns>Saved RailRoad detail</returns>
        [HttpPost]
        [SwaggerResponse(StatusCodes.Status200OK)]
        [SwaggerResponse(StatusCodes.Status400BadRequest)]
        public async Task<IActionResult> Post([FromBody] RailRoad railRoadModel)
        {
            try
            {
                if (railRoadModel != null && railRoadModel.Id == 0)
                {
                    var storageFeature = await this._railRoadService.Save(railRoadModel);
                    return Ok(storageFeature);
                }
                return BadRequest(railRoadModel);
            }
            catch (Exception ex)
            {
                _logger.LogError("Error in SaveRailRoad - " + ex.Message);
                return BadRequest();
            }
        }

        /// <summary>
        /// Endpoint to Get Rail-Road list.
        /// </summary>
        /// <returns>List of RailRoad</returns>
        [HttpGet]
        [SwaggerResponse(StatusCodes.Status200OK)]
        [SwaggerResponse(StatusCodes.Status400BadRequest)]
        public async Task<ActionResult<IList<RailRoad>>> GetRailRoad()
        {
            try
            {
                return Ok(await this._railRoadService.GetRailRoads());
            }
            catch (Exception ex)
            {
                _logger.LogError("Error in GetRailRoad - " + ex.Message);
                return BadRequest();
            }
        }

        /// <summary>
        /// Endpoint to Get Country list.
        /// </summary>
        /// <returns>List of Country</returns>
        [HttpGet("GetCountryList")]
        [SwaggerResponse(StatusCodes.Status200OK)]
        [SwaggerResponse(StatusCodes.Status400BadRequest)]
        public async Task<ActionResult<IList<Country>>> GetAllCountries()
        {
            try
            {
                return Ok(await this._masterDataService.GetAllCountries());
            }
            catch (Exception ex)
            {
                _logger.LogError("Error in GetAllCountries - " + ex.Message);
                return BadRequest();
            }
        }

        /// <summary>
        /// Endpoint to Get State list.
        /// </summary>
        /// <param name="countryId">long</param>
        /// <returns>List of State</returns>
        [HttpGet("GetStatesByCountryID/{countryId}")]
        [SwaggerResponse(StatusCodes.Status200OK)]
        [SwaggerResponse(StatusCodes.Status400BadRequest)]
        public async Task<ActionResult<IList<State>>> GetStatesByCountryID(long countryId)
        {
            try
            {
                return Ok(await this._masterDataService.GetStateListByCountryID(countryId));
            }
            catch (Exception ex)
            {
                _logger.LogError("Error in GetStatesByCountryID - " + ex.Message);
                return BadRequest();
            }
        }

        /// <summary>
        /// Endpoint to Get Customer City list.
        /// </summary>
        /// <returns>List of [City name]/ string</returns>
        [HttpGet("GetCity/{reqFor}")]
        [SwaggerResponse(StatusCodes.Status200OK)]
        [SwaggerResponse(StatusCodes.Status400BadRequest)]
        public async Task<ActionResult<IList<string>>> GetCity(string reqFor)
        {
            try
            {
                return Ok(await this._masterDataService.GetCityList(reqFor));
            }
            catch (Exception ex)
            {
                _logger.LogError("Error in GetCity - " + ex.Message);
                return BadRequest();
            }
        }

        /// <summary>
        /// Endpoint to Get Organization list.
        /// </summary>
        /// <param name="searchText">string</param>
        /// <returns>List of Organization</returns>
        [HttpGet("GetOrganizationList/{searchText}")]
        [SwaggerResponse(StatusCodes.Status200OK)]
        [SwaggerResponse(StatusCodes.Status400BadRequest)]
        public async Task<ActionResult<IList<Organization>>> GetOrganizationList(string searchText)
        {
            try
            {
                return Ok(await this._masterDataService.GetAllOrganizations(searchText));
            }
            catch (Exception ex)
            {
                _logger.LogError("Error in GetOrganizationList - " + ex.Message);
                return BadRequest();
            }
        }

        /// <summary>
        /// Endpoint to Get Organization list.
        /// </summary>
        /// <param name="searchText">string</param>
        /// <returns>List of Organization</returns>
        [HttpGet("GetOrganizations")]
        [SwaggerResponse(StatusCodes.Status200OK)]
        [SwaggerResponse(StatusCodes.Status400BadRequest)]
        public async Task<ActionResult<IList<Organization>>> GetOrganizations()
        {
            try
            {
                return Ok(await this._masterDataService.GetOrganizations());
            }
            catch (Exception ex)
            {
                _logger.LogError("Error in GetOrganizations - " + ex.Message);
                return BadRequest();
            }
        }

        /// <summary>
        /// Endpoint to Save And Get Organization Detail.
        /// </summary>
        /// <param name="organizationModel">OrganizationViewModel</param>
        /// <returns>Organization</returns>
        [HttpPut("SaveAndGetOrganization")]
        [SwaggerResponse(StatusCodes.Status200OK)]
        [SwaggerResponse(StatusCodes.Status400BadRequest)]
        public async Task<ActionResult<Organization>> SaveAndGetOrganization(OrganizationViewModel organizationModel)
        {
            try
            {
                return await this._masterDataService.SaveAndGetOrganization(organizationModel);
            }
            catch (Exception ex)
            {
                _logger.LogError("Error in SaveAndGetOrganization - " + ex.Message);
                return BadRequest();
            }
        }

        /// <summary>
        /// Endpoint to Get Region list.
        /// </summary>
        /// <returns>List of Regions</returns>
        [HttpGet("GetRegions")]
        [SwaggerResponse(StatusCodes.Status200OK)]
        [SwaggerResponse(StatusCodes.Status400BadRequest)]
        public async Task<ActionResult<IList<Region>>> GetRegions()
        {
            try
            {
                return Ok(await this._masterDataService.GetRegions());
            }
            catch (Exception ex)
            {
                _logger.LogError("Error in GetRegions - " + ex.Message);
                return BadRequest();
            }
        }

        /// <summary>
        /// Endpoint to Get User Types.
        /// </summary>
        /// <returns>List of Regions</returns>
        [HttpGet("GetUserTypes")]
        [SwaggerResponse(StatusCodes.Status200OK)]
        [SwaggerResponse(StatusCodes.Status400BadRequest)]
        public async Task<ActionResult<IList<UserType>>> GetUserTypes()
        {
            try
            {
                return Ok(await this._masterDataService.GetUserTypes());
            }
            catch (Exception ex)
            {
                _logger.LogError("Error in GetUserTypes - " + ex.Message);
                return BadRequest();
            }
        }

        /// <summary>
        /// Endpoint to Get User Statuses.
        /// </summary>
        /// <returns>List of User Statuses</returns>
        [HttpGet("GetUserStatuses")]
        [SwaggerResponse(StatusCodes.Status200OK)]
        [SwaggerResponse(StatusCodes.Status400BadRequest)]
        public async Task<ActionResult<IList<UserStatus>>> GetUserStatuses()
        {
            try
            {
                return Ok(await this._masterDataService.GetUserStatuses());
            }
            catch (Exception ex)
            {
                _logger.LogError("Error in GetUserStatuses - " + ex.Message);
                return BadRequest();
            }
        }

        /// <summary>
        /// Endpoint To Get Interchanges list based on Vendor/Organization or/and Storage Facility Detail.
        /// </summary>
        /// <param name="orgId">long</param>
        /// <param name="sfId">long</param>
        /// <returns>List of (interchanges for requested organization or/and storage facility.</returns>
        [HttpGet]
        [Route("GetInterchanges/{orgId}/{sfId}", Name = "GetInterchanges")]
        public async Task<ActionResult<IList<StorageFacilityInterchangeViewModel>>> GetInterchanges(long orgId, long sfId)
        {
            try
            {
                var interchangesList = Ok(await _masterDataService.GetInterchangesList(orgId, sfId));
                return interchangesList;
            }
            catch (Exception ex)
            {
                _logger.LogError("Error in GetInterchanges - " + ex.Message);
                return BadRequest();
            }
        }

        /// <summary>
        /// Endpoint to Get Rail Road list
        /// </summary>
        /// <returns>List of all RailRoads.</returns>
        [HttpGet]
        [Route("GetAllRailRoads", Name = "GetAllRailRoads")]
        public async Task<ActionResult<IList<RailRoad>>> GetAllRailRoads()
        {
            try
            {
                var interchangesList = Ok(await _masterDataService.GetAllRailRoads());
                return interchangesList;
            }
            catch (Exception ex)
            {
                _logger.LogError("Error in GetAllRailRoads - " + ex.Message);
                return BadRequest();
            }
        }

        /// <summary>
        /// Endpoint to Get Region list.
        /// </summary>
        /// <param name="countryId">long</param>
        /// <returns>List of Region</returns>
        [HttpGet("GetRegionByCountryID/{countryId}")]
        [SwaggerResponse(StatusCodes.Status200OK)]
        [SwaggerResponse(StatusCodes.Status400BadRequest)]
        public async Task<ActionResult<IList<Region>>> GetRegionByCountryID(long countryId)
        {
            try
            {
                return Ok(await this._masterDataService.GetRegionByCountryID(countryId));
            }
            catch (Exception ex)
            {
                _logger.LogError("Error in GetRegionByCountryID - " + ex.Message);
                return BadRequest();
            }
        }

       /// <summary>
       /// Endpoint to Get Rate Types.
       /// </summary>
       /// <returns>List of contract rate types</returns>
        [HttpGet]
        [Route("GetAllContractRateTypes", Name = "GetAllContractRateTypes")]
        public async Task<ActionResult<IList<RateType>>> GetAllContractRateTypes()
        {
            try
            {
                var interchangesList = Ok(await _masterDataService.GetContractRateTypes());
                return interchangesList;
            }
            catch (Exception ex)
            {
                _logger.LogError("Error in GetAllContractRateTypes - " + ex.Message);
                return BadRequest();
            }
        }

        /// <summary>
        /// Endpoint to Get SwitchIn SwitchOut List.
        /// </summary>
        /// <returns>SwitchInSwitchOutList</returns>
        [HttpGet]
        [Route("GetSwitchInSwitchOutList", Name = "GetSwitchInSwitchOutList")]
        public async Task<ActionResult<SwitchInSwitchOut>> GetSwitchInSwitchOutList()
        {
            try
            {
                var SwitchInSwitchOutDetails = await _masterDataService.GetSwitchInSwitchOutList();
                return Ok(SwitchInSwitchOutDetails);
            }
            catch (Exception ex)
            {
                _logger.LogError("Error in GetSwitchInSwitchOutList - " + ex.Message);
                return BadRequest();
            }
        }
    }
}
