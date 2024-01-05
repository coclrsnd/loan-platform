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

namespace StandardRail.RailCarLounge.Rest.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    [Authorize]
    public class SavedSearchController : ControllerBase
    {
        private readonly ISavedSearchService _savedSearchService;
        private readonly ILogger<SavedSearchController> _logger;

        public SavedSearchController(ISavedSearchService savedSearchService, ILogger<SavedSearchController> logger)
        {
            this._savedSearchService = savedSearchService ?? throw new ArgumentNullException(nameof(savedSearchService));
            _logger = logger ?? throw new ArgumentNullException(nameof(logger));
        }


        [HttpPost]
        [Route("SaveSearch", Name = "SaveSearch")]
        public async Task<ActionResult<SavedSearch>> SaveSearch(SavedSearchViewModel savedSearch)
        {
            try
            {
                var saveSearchDetails = await _savedSearchService.SaveSearch(savedSearch);
                return Ok(saveSearchDetails);
            }
            catch (Exception ex)
            {
                _logger.LogError("Error in SaveSearch - " + ex.Message);
                return BadRequest();
            }
        }

        [HttpGet]
        [Route("GetAllSavedSearch", Name = "GetAllSavedSearch")]
        public async Task<ActionResult<List<SavedSearchViewModel>>> GetAllSavedSearch()
        {
            try
            {
                var saveSearchDetails = await _savedSearchService.GetAllSavedSearch();
                return saveSearchDetails;
            }
            catch (Exception ex)
            {
                _logger.LogError("Error in GetAllSavedSearch - " + ex.Message);
                return BadRequest();
            }
        }

        [HttpGet]
        [Route("GetSavedSearchForDashboard", Name = "GetSavedSearchForDashboard")]
        public async Task<ActionResult<List<SavedSearchViewModel>>> GetSavedSearchForDashboard()
        {
            try
            {
                var saveSearchDetails = await _savedSearchService.GetSavedSearchForDashboard();
                return Ok(saveSearchDetails);
            }
            catch (Exception ex)
            {
                _logger.LogError("Error in GetSavedSearchForDashboard - " + ex.Message);
                return BadRequest();
            }
        }
    }
}
