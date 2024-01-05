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
    public class ContractTypeController : ControllerBase
    {
        private readonly IContractTypeService _contractTypeService;
        private readonly ILogger<ContractTypeController> _logger;

        public ContractTypeController(IContractTypeService contractTypeService, ILogger<ContractTypeController> logger)
        {
            this._contractTypeService = contractTypeService ?? throw new ArgumentNullException(nameof(contractTypeService));
            _logger = logger ?? throw new ArgumentNullException(nameof(logger));
        }

        [HttpGet]
        [Route("GetContractTypeList", Name = "GetContractTypeList")]
        public async Task<ActionResult<IList<ContractType>>> GetContractTypeList()
        {
            try
            { 
            var contractTypes = await _contractTypeService.GetContractTypeList();
            return Ok(contractTypes);
            }
            catch (Exception ex)
            {
                _logger.LogError("Error in GetContractTypeList - " + ex.Message);
                return BadRequest();
            }
        }

    }
}
