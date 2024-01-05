using System;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Loan.Platform.Business.Pact;
using Loan.Platform.Models.ViewModels;
using Swashbuckle.AspNetCore.Annotations;

namespace Loan.Platform.Rest.Controllers
{
    /// <summary>
    /// User controller.
    /// </summary>
    [Route("api/[controller]")]
    [ApiController]
    [Authorize]
    public class UtilityController : ControllerBase
    {
        private readonly ILogger<UserController> _logger;
        private readonly IUtilityService _utilityService;

        /// <summary>
        /// Parameterized Constructor of Utility Controller.
        /// </summary>
        /// <param name="userManagerService"></param>
        public UtilityController(ILogger<UserController> logger, IUtilityService utilityService = null)
        {
            _logger = logger ?? throw new ArgumentNullException(nameof(logger));
            _utilityService = utilityService ?? throw new ArgumentNullException(nameof(utilityService));
        }

        [HttpPost]
        [Route("UserVerifyEmail/{key}", Name = "UserVerifyEmail")]
        [SwaggerResponse(StatusCodes.Status200OK)]
        [SwaggerResponse(StatusCodes.Status400BadRequest)]
        public async Task<IActionResult> UserVerifyEmail([FromBody] EmailUtilityViewModel emailUtilityViewModel, string key)
        {
            try
            {
                if (!ModelState.IsValid)
                {
                    return ValidationProblem(ModelState);
                }
                return Ok(await _utilityService.UserVerifyEmail(emailUtilityViewModel, key));
            }
            catch (Exception ex)
            {
                _logger.LogError("Error in UserVerifyEmail  - " + ex.Message);
                return BadRequest(ex.Message);
            }
        }

        [HttpPost]
        [Route("UserPasswordResetEmail/{key}", Name = "UserPasswordResetEmail")]
        [SwaggerResponse(StatusCodes.Status200OK)]
        [SwaggerResponse(StatusCodes.Status400BadRequest)]
        public async Task<IActionResult> UserPasswordResetEmail([FromBody] EmailUtilityViewModel emailUtilityViewModel, string key)
        {
            try
            {
                if (!ModelState.IsValid)
                {
                    return ValidationProblem(ModelState);
                }
                return Ok(await _utilityService.UserPasswordResetEmail(emailUtilityViewModel, key));
            }
            catch (Exception ex)
            {
                _logger.LogError("Error in UserPasswordResetEmail - " + ex.Message);
                return BadRequest(ex.Message);
            }
        }


        [HttpPost]
        [Route("UserApprovalEmail/{key}", Name = "UserApprovalEmail")]
        [SwaggerResponse(StatusCodes.Status200OK)]
        [SwaggerResponse(StatusCodes.Status400BadRequest)]
        public async Task<IActionResult> UserApprovalEmail([FromBody] EmailUtilityViewModel emailUtilityViewModel, string key)
        {
            try
            {
                if (!ModelState.IsValid)
                {
                    return ValidationProblem(ModelState);
                }
                return Ok(await _utilityService.UserApprovalEmail(emailUtilityViewModel, key));
            }
            catch (Exception ex)
            {
                _logger.LogError("Error in UserApprovalEmail - " + ex.Message);
                return BadRequest(ex.Message);
            }
        }
    }
}