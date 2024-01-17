using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Loan.Platform.Business.Pact;
using Loan.Platform.Models.CustomModels;
using Loan.Platform.Models.Entities;
using Loan.Platform.Models.UserManagementModels;
using Loan.Platform.Models.ViewModels;
using Swashbuckle.AspNetCore.Annotations;

namespace Loan.Platform.Rest.Controllers
{
    /// <summary>
    /// User controller.
    /// </summary>
    [Route("api/[controller]")]
    [ApiController]
    //[Authorize]
    public class UserController : ControllerBase
    {
        private readonly IUserManagerService _userManagerService;
        private readonly ILogger<UserController> _logger;

        /// <summary>
        /// Parameterized Constructor of User Controller.
        /// </summary>
        /// <param name="userManagerService"></param>
        public UserController(IUserManagerService userManagerService, ILogger<UserController> logger)
        {
            _userManagerService = userManagerService ?? throw new ArgumentNullException(nameof(userManagerService));
            _logger = logger ?? throw new ArgumentNullException(nameof(logger));
        }

        /// <summary>
        /// Endpoint to check user credentials on Login.
        /// </summary>
        /// <param name="model">Login</param>
        /// <returns>Security detail of users or reject request if credentials not valid</returns>
        [HttpPost]
        [AllowAnonymous]
        [Route("Login", Name = "Login")]
        public async Task<IActionResult> Login([FromBody] Login model)
        {
            try
            {
                if (model != null)
                {
                    var securityContext = await this._userManagerService.Login(model);
                    if (securityContext != null)
                    {
                        return Ok(securityContext);
                    }
                    else
                    {
                        return BadRequest("Username or password is incorrect.");
                    }
                }
                return StatusCode(StatusCodes.Status500InternalServerError, new Response()
                {
                    StatusCode = StatusCodes.Status500InternalServerError,
                    Status = "Error",
                    Message = "Login Model is null"
                });
            }
            catch (Exception ex)
            {
                _logger.LogError("Error in Login - " + ex.Message);
                return BadRequest();
            }
        }

        /// <summary>
        /// Endpoint to Approve Reject user detail.
        /// </summary>
        /// <param name="userId">int</param>
        /// <param name="userRoleId">int</param>
        /// <param name="isApprove">bool</param>
        /// <returns>Status of current request</returns>
        [HttpPost]
        [Route("ApproveRejectUser", Name = "ApproveRejectUser")]
        [SwaggerResponse(StatusCodes.Status200OK)]
        [SwaggerResponse(StatusCodes.Status400BadRequest)]
        public async Task<IActionResult> ApproveRejectUser(SignUpUserViewModel user, bool isApprove)
        {
            try
            {
                if (user != null)
                {
                    var response = await this._userManagerService.ApproveRejectUser(user, isApprove);
                    return StatusCode(response.StatusCode, response);
                }
                return StatusCode(StatusCodes.Status500InternalServerError, new Response()
                {
                    StatusCode = StatusCodes.Status500InternalServerError,
                    Status = "Error",
                    Message = "UserId is null"
                });
            }
            catch (Exception ex)
            {
                _logger.LogError("Error in ApproveRejectUser - " + ex.Message);
                return BadRequest();
            }
        }

        /// <summary>
        /// Endpoint to Get users list.
        /// </summary>
        /// <param name="userViewModel"></param>
        /// <returns>List of users</returns>
        [HttpPost]
        [Route("GetUserDetails", Name = "GetUserDetails")]
        public async Task<ActionResult<UserFilterViewModel>> GetUserDetails(UserFilterViewModel userViewModel)
        {
            try
            {
                var userDetails = await _userManagerService.GetUserDetails(userViewModel);
                return Ok(userDetails);
            }
            catch (Exception ex)
            {
                _logger.LogError("Error in GetUserDetails - " + ex.Message);
                return BadRequest();
            }
        }

        /// <summary>
        /// Endpoint to get user detail for requested id.
        /// </summary>
        /// <param name="id">long</param>
        /// <returns>User detail for requested ID.</returns>
        [HttpGet]
        [Route("GetUserById/{id}", Name = "GetUserById/{id}")]
        [SwaggerResponse(StatusCodes.Status200OK)]
        [SwaggerResponse(StatusCodes.Status400BadRequest)]
        public async Task<ActionResult<User>> GetUserById(long id)
        {
            try
            {
                var userDetails = await _userManagerService.GetUserById(id);
                return Ok(userDetails);
            }
            catch (Exception ex)
            {
                _logger.LogError("Error in GetUserById - " + ex.Message);
                return BadRequest();
            }
        }

        /// <summary>
        /// Endpoint to update user detail.
        /// </summary>
        /// <param name="userModel">UserViewModel</param>
        /// <returns></returns>
        [HttpPut]
        [Route("UpdateUserDetail", Name = "UpdateUserDetail")]
        [SwaggerResponse(StatusCodes.Status200OK)]
        [SwaggerResponse(StatusCodes.Status400BadRequest)]
        public async Task<IActionResult> UpdateUserDetail([FromBody] User userModel)
        {
            try
            {
                await _userManagerService.UpdateUserDetail(userModel);
                return Ok();
            }
            catch (Exception ex)
            {
                _logger.LogError("Error in UpdateUserDetail - " + ex.Message);
                return BadRequest();
            }
        }

        /// <summary>
        /// Endpoint to Approve Reject user detail.
        /// </summary>
        /// <param name="userId">int</param>
        /// <param name="userRoleId">int</param>
        /// <param name="isApprove">bool</param>
        /// <returns>Status of current request</returns>
        [HttpPost]
        [Route("ApproveRejectUsers", Name = "ApproveRejectUsers")]
        [SwaggerResponse(StatusCodes.Status200OK)]
        [SwaggerResponse(StatusCodes.Status400BadRequest)]
        public async Task<IActionResult> ApproveRejectUsers([FromBody] ApproveRejectUserViewModel usersForApproveReject)
        {
            try
            {
                if (usersForApproveReject != null && usersForApproveReject.Users != null && usersForApproveReject.Users.Count > 0)
                {
                    var response = await this._userManagerService.ApproveRejectUsers(usersForApproveReject);
                    if (response)
                        return Ok();
                }
                return BadRequest();
            }
            catch (Exception ex)
            {
                _logger.LogError("Error in ApproveRejectUsers - " + ex.Message);
                return BadRequest();
            }
        }

        /// <summary>
        /// Refresh Token.
        /// </summary>
        /// <param name="id">long</param>
        /// <returns>refreshed security context.</returns>
        [HttpGet]
        [Route("GetRefreshToken", Name = "GetRefreshToken")]
        [SwaggerResponse(StatusCodes.Status200OK)]
        [SwaggerResponse(StatusCodes.Status400BadRequest)]
        public ActionResult<SecurityContext> GetRefreshToken()
        {
            try
            {
                var httpRequest = HttpContext.Request;
                string token = Convert.ToString(httpRequest.Headers["RefreshToken"]);
                return _userManagerService.GetRefreshToken(token);
            }
            catch (Exception ex)
            {
                _logger.LogError("Error in GetRefreshToken - " + ex.Message);
                return BadRequest();
            }
        }

        /// <summary>
        /// Create Super Admin User
        /// </summary>
        /// <param name="key"></param>
        /// <returns></returns>
        [HttpPost]
        [AllowAnonymous]
        [Route("CreateSuperAdminUser", Name = "CreateSuperAdminUser")]
        [SwaggerResponse(StatusCodes.Status200OK)]
        [SwaggerResponse(StatusCodes.Status400BadRequest)]
        public async Task<IActionResult> CreateSuperAdminUser([FromBody] string key)
        {
            try
            {
                if (!string.IsNullOrEmpty(key))
                {
                    if (await this._userManagerService.CreateSuperAdminUser(key))
                    {
                        return Ok();
                    }

                }
                return BadRequest();
            }
            catch (Exception ex)
            {
                _logger.LogError("Error in CreateSuperAdminUser - " + ex.Message);
                return BadRequest();
            }
        }

        [HttpPost]
        [Route("ChangePassword", Name = "ChangePassword")]
        [SwaggerResponse(StatusCodes.Status200OK)]
        [SwaggerResponse(StatusCodes.Status400BadRequest)]
        public async Task<IActionResult> ChangePassword([FromBody] ChangePasswordRequest changePasswordRequest)
        {
            try
            {
                string result = await _userManagerService.ChangePassword(changePasswordRequest);
                return result.Equals("success",StringComparison.OrdinalIgnoreCase) ? Ok() : BadRequest(result);                
            }
            catch (Exception ex)
            {
                _logger.LogError("Error in ChangePassword - " + ex.Message);
                return BadRequest();
            }
        }

        /// <summary>
        /// Update Current Role.
        /// </summary>
        /// <param name="id">long</param>
        /// <returns>Updated security context.</returns>
        [HttpGet]
        [Route("UpdateCurrentRole", Name = "UpdateCurrentRole")]
        [SwaggerResponse(StatusCodes.Status200OK)]
        [SwaggerResponse(StatusCodes.Status400BadRequest)]
        public ActionResult<SecurityContext> UpdateCurrentRole(string updatedRole)
        {
            try
            {
                var httpRequest = HttpContext.Request;
                string token = Convert.ToString(httpRequest.Headers["RefreshToken"]);
                return _userManagerService.UpdateCurrentRole(token, updatedRole);
            }
            catch (Exception ex)
            {
                _logger.LogError("Error in UpdateCurrentRole - " + ex.Message);
                return BadRequest();
            }
        }



        /// <summary>
        /// Create Super Admin User
        /// </summary>
        /// <param name="key"></param>
        /// <returns></returns>
        [HttpPost]
        [Route("CreateAdminUsers", Name = "CreateAdminUsers")]
        [SwaggerResponse(StatusCodes.Status200OK)]
        [SwaggerResponse(StatusCodes.Status400BadRequest)]
        public async Task<IActionResult> CreateAdminUsers([FromQuery] string key, [FromBody] IList<AdminUserModel> userEmails)
        {
            try
            {
                if (!string.IsNullOrEmpty(key))
                {
                    if (await this._userManagerService.CreateAdminUsers(key, userEmails))
                    {
                        return Ok();
                    }

                }
                return BadRequest();
            }
            catch (Exception ex)
            {
                _logger.LogError("Error in GetVendorList - " + ex.Message);
                return BadRequest(ex.Message);
            }
        }
    }
}
