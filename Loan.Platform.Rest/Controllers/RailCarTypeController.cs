using System;
using System.Collections.Generic;
using System.Linq;
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
    public class RailCarTypeController : ControllerBase
    {

        private readonly IRailCarTypeService _railCarTypeService;
        private readonly ILogger<RailCarTypeController> _logger;
        public RailCarTypeController(IRailCarTypeService railCarTypeService, ILogger<RailCarTypeController> logger)
        {
            _railCarTypeService = railCarTypeService ?? throw new ArgumentNullException(nameof(railCarTypeService));
            _logger = logger ?? throw new ArgumentNullException(nameof(logger));
        }

        [HttpGet]
        [Route("GetRailCarTypeList", Name = "GetRailCarTypeList")]
        public async Task<ActionResult<IEnumerable<RailCarType>>> GetRailCarTypeList()
        {
            try
            { 
            IEnumerable<RailCarType> railCarTypes = await _railCarTypeService.GetRailCarTypes();
            if (railCarTypes != null && railCarTypes.Count() > 0)
            {
                return Ok(railCarTypes);
            }
            return NotFound();
            }
            catch (Exception ex)
            {
                _logger.LogError("Error in GetVendorList - " + ex.Message);
                return BadRequest();
            }
        }
    }
}
