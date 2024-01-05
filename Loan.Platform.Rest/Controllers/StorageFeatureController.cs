using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using StandardRail.RailCarLounge.Business.Pact;
using StandardRail.RailCarLounge.Models.Entities;
using Swashbuckle.AspNetCore.Annotations;

namespace StandardRail.RailCarLounge.Rest.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    [Authorize]
    public class StorageFeatureController : ControllerBase
    {
        private readonly IStorageFeatureService _storageFeatureService;
        private readonly IStorageFacilityFeatureMappingService _storageFacilityFeatureMappingService;
        private readonly ILogger<StorageFeatureController> _logger;
        public StorageFeatureController(IStorageFeatureService storageFeatureService,
            IStorageFacilityFeatureMappingService storageFacilityFeatureMappingService, ILogger<StorageFeatureController> logger)
        {
            _storageFeatureService = storageFeatureService ?? throw new ArgumentNullException(nameof(storageFeatureService));
            _storageFacilityFeatureMappingService = storageFacilityFeatureMappingService ?? throw new ArgumentNullException(nameof(storageFacilityFeatureMappingService));
            _logger = logger ?? throw new ArgumentNullException(nameof(logger));
        }

        [HttpGet]
        [Route("GetStorageFeaturesList", Name = "GetStorageFeaturesList")]
        public async Task<ActionResult<IEnumerable<StorageFeature>>> GetStorageFeaturesList()
        {
            try
            {
                IEnumerable<StorageFeature> storageFeatures = await _storageFeatureService.GetStorageFeatures();
                if (storageFeatures != null && storageFeatures.Any())
                {
                    return Ok(storageFeatures);
                }
                return NotFound();
            }
            catch (Exception ex)
            {
                _logger.LogError("Error in GetStorageFeaturesList - " + ex.Message);
                return BadRequest();
            }
        }

        // GET api/<StorageFeatureController>/5
        [HttpGet("{id}")]
        public async Task<IActionResult> Get(int id)
        {
            try
            {
                if (id > 0)
                {
                    StorageFeature storageFeature = await _storageFeatureService.GetStorageFeatureById(id);
                    return Ok(storageFeature);
                }
                return BadRequest(id);
            }
            catch (Exception ex)
            {
                _logger.LogError("Error in GetStorageFeature - " + ex.Message);
                return BadRequest();
            }
        }

        // POST api/<StorageFeatureController>
        [HttpPost]
        [SwaggerResponse(StatusCodes.Status200OK)]
        [SwaggerResponse(StatusCodes.Status400BadRequest)]
        public async Task<IActionResult> Post([FromBody] StorageFeature model)
        {
            try
            {
                if (model != null && model.Id == 0)
                {
                    var storageFeature = await this._storageFeatureService.Save(model);
                    return Ok(storageFeature);
                }
                return BadRequest(model);
            }
            catch (Exception ex)
            {
                _logger.LogError("Error in SaveStorageFeature - " + ex.Message);
                return BadRequest();
            }
        }

        [HttpGet]
        [Route("GetStorageFeaturesByFacilityId/{facilityId}", Name = "GetStorageFeaturesByFacilityId")]
        public async Task<ActionResult<IList<StorageFeature>>> GetStorageFeaturesByFacilityId(long facilityId)
        {
            try
            {
                var storageFeatures = new List<StorageFeature>();
                var storageFacilityFeatureMappingList = await _storageFacilityFeatureMappingService.GetStorageFacilityFeatureMapping(facilityId);
                if (storageFacilityFeatureMappingList != null && storageFacilityFeatureMappingList.Count > 0)
                {
                    var allStorageFeatures = await this._storageFeatureService.GetStorageFeatures();
                    foreach (var storageFacilityFeature in storageFacilityFeatureMappingList)
                    {
                        storageFeatures.Add(allStorageFeatures.FirstOrDefault(s => s.Id == storageFacilityFeature.StorageFeatureId));
                    }
                }
                return storageFeatures;
            }
            catch (Exception ex)
            {
                _logger.LogError("Error in GetStorageFeaturesByFacilityId - " + ex.Message);
                return BadRequest();
            }
        }
    }
}
