using System;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Loan.Platform.Business.Pact;
using Loan.Platform.Models.Accounts;

namespace Loan.Platform.Rest.Controllers
{
    [Authorize]
    [Route("api/[controller]")]
    [ApiController]
    public class AccountsController : ControllerBase
    {
        private readonly IAccountService _accountService;

        private readonly ILogger<AccountsController> _logger;

        public AccountsController(IAccountService accountService, ILogger<AccountsController> logger)
        {
            _accountService = accountService ?? throw new ArgumentNullException(nameof(accountService));
            _logger = logger ?? throw new ArgumentNullException(nameof(logger));
        }

        [AllowAnonymous]
        [HttpPost("register")]
        public async Task<IActionResult> Register(RegisterRequest model)
        {
            try
            {
                if (!ModelState.IsValid || !model.AgreeTermsAndConditions)
                {
                    return new ObjectResult("Forbidden") { StatusCode = 403 };
                }
                await _accountService.Register(model, Request.Headers["origin"]);
                return Ok(new { message = "Registration successful, please check your email for verification instructions" });
            }
            catch (Exception ex)
            {
                _logger.LogError("Error in Register - " + ex.Message);
                return BadRequest();
            }
        }


        [AllowAnonymous]
        [HttpPost("verify-email")]
        public async Task<IActionResult> VerifyEmail(VerifyEmailRequest model)
        {
            try
            {
                if (await _accountService.VerifyEmail(model.Token))
                {
                    return Ok(new { message = "Verification successful, you will receive an email with password post verification and approval by administrator." });
                }

                return BadRequest();
            }
            catch (Exception ex)
            {
                _logger.LogError("Error in VerifyEmail - " + ex.Message);
                return BadRequest();
            }
        }

        [AllowAnonymous]
        [HttpPost("forgot-password")]
        public async Task<IActionResult> ForgotPassword(ForgotPasswordRequest model)
        {
            try
            {
                await _accountService.ForgotPassword(model, Request.Headers["origin"]);
                return Ok(new { message = "Please check your email for password reset instructions or contact the administrator." });
            }
            catch (Exception ex)
            {
                _logger.LogError("Error in ForgotPassword - " + ex.Message);
                return BadRequest();
            }
        }

        [AllowAnonymous]
        [HttpPost("validate-reset-token")]
        public IActionResult ValidateResetToken(ValidateResetTokenRequest model)
        {
            try
            {
                _accountService.ValidateResetToken(model);
                return Ok(new { message = "Token is valid" });
            }
            catch (Exception ex)
            {
                _logger.LogError("Error in ValidateResetToken - " + ex.Message);
                return BadRequest();
            }
        }

        [AllowAnonymous]
        [HttpPost("reset-password")]
        public async Task<IActionResult> ResetPassword(ResetPasswordRequest model)
        {
            try
            {
                if (await _accountService.ResetPassword(model))
                {
                    return Ok(new { message = "Password reset successful!" });
                }
                return BadRequest("Password reset failed!");
            }
            catch (Exception ex)
            {
                _logger.LogError("Error in ResetPassword - " + ex.Message);
                return BadRequest();
            }
        }
    }
}
