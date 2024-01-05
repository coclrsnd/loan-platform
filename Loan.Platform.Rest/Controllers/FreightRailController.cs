using System;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using StandardRail.RailCarLounge.Business.Pact;
using StandardRail.RailCarLounge.Models.FreightRailModels;

namespace StandardRail.RailCarLounge.Rest.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    [Authorize]
    public class FreightRailController : ControllerBase
    {
        private readonly IFreightRailService _freightRailService;
        private readonly ILogger<FreightRailController> _logger;

        public FreightRailController(IFreightRailService freightRailService, ILogger<FreightRailController> logger)
        {
            _freightRailService = freightRailService ?? throw new ArgumentNullException(nameof(freightRailService));
            _logger = logger ?? throw new ArgumentNullException(nameof(logger));
        }

        [HttpPost("SearchByCity")]
        public async Task<IActionResult> SearchByCity(string city, string countries, string states)
        {
            try
            {
                if (!string.IsNullOrEmpty(city))
                {
                    GeocodeSingleSearchResponse geocodeSingleSearchResponse = await _freightRailService.SearchByCity(city, countries, states);
                    if (geocodeSingleSearchResponse != null && geocodeSingleSearchResponse.Err == 0)
                    {
                        var distinctCityState = geocodeSingleSearchResponse.Locations.Select(e => new { e.Address.City, e.Address.State }).Distinct().ToList();
                        return Ok(distinctCityState);
                    }
                }
                return BadRequest();
            }
            catch (Exception ex)
            {
                _logger.LogError("Error in SearchByCity - " + ex.Message);
                return BadRequest();
            }
        }

        [HttpPost("GeocodeStation")]
        public async Task<IActionResult> GetGeocodeStation(string city, string state, string mark)
        {
            try
            {
                if (!string.IsNullOrEmpty(city) && !string.IsNullOrEmpty(state))
                {
                    try
                    {
                        var geocodeStations = await _freightRailService.GetGeocodeStation(city, state, mark);
                        return Ok(geocodeStations);
                    }
                    catch (System.Exception e)
                    {

                        return BadRequest(e.Message);
                    }

                }
                return BadRequest();
            }
            catch (Exception ex)
            {
                _logger.LogError("Error in GetGeocodeStation - " + ex.Message);
                return BadRequest();
            }
        }

    }
}
