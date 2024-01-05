using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using StandardRail.RailCarLounge.Business.Pact;
using StandardRail.RailCarLounge.Models.Entities;

namespace StandardRail.RailCarLounge.Rest.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    [Authorize]
    public class CurrencyController : ControllerBase
    {
        private readonly ICurrencyService _currencyService;
        private readonly ILogger<CurrencyController> _logger;

        public CurrencyController(ICurrencyService currencyService, ILogger<CurrencyController> logger)
        {
            this._currencyService = currencyService ?? throw new ArgumentNullException(nameof(currencyService));
            _logger = logger ?? throw new ArgumentNullException(nameof(logger));
        }

        [HttpGet]
        [Route("GetCurrencyList", Name = "GetCurrencyList")]
        public async Task<ActionResult<IList<Currency>>> GetCurrencyList()
        {
            try
            { 
            var currencyDetails = await _currencyService.GetCurrencyList();
            return Ok(currencyDetails);
            }
            catch (Exception ex)
            {
                _logger.LogError("Error in GetCurrencyList - " + ex.Message);
                return BadRequest();
            }
        }

    }
}
