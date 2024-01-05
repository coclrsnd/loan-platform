using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using StandardRail.RailCarLounge.Business.Pact;
using StandardRail.RailCarLounge.Models.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace StandardRail.RailCarLounge.Rest.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    [Authorize]
    public class LEContentController : ControllerBase
    {
        private readonly ILogger<LEContentController> _logger;
        private readonly ILEContentService _leContentService;
        public LEContentController(ILEContentService leContentService, ILogger<LEContentController> logger)
        {
            _leContentService = leContentService ?? throw new ArgumentNullException(nameof(leContentService));
            _logger = logger ?? throw new ArgumentNullException(nameof(logger));
        }

        [HttpGet]
        [Route("GetLEContentList", Name = "GetLEContentList")]
        public async Task<ActionResult<IEnumerable<LEContent>>> GetLEContentList()
        {
            try
            {
                IEnumerable<LEContent> leContentTypes = await _leContentService.GetLEContents();
                if (leContentTypes != null && leContentTypes.Any())
                {
                    return Ok(leContentTypes);
                }
                return NotFound();
            }
            catch (Exception ex)
            {
                _logger.LogError("Error in GetLEContentList - " + ex.Message);
                return BadRequest();
            }
        }
    }
}
