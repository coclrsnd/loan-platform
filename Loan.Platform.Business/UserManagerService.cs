using System;
using System.Collections.Generic;
using System.IdentityModel.Tokens.Jwt;
using System.Linq;
using System.Security.Claims;
using System.Text;
using System.Threading.Tasks;
using System.Transactions;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Identity;
using Microsoft.Extensions.Configuration;
using Microsoft.IdentityModel.Tokens;
using Loan.Platform.Business.Pact;
using Loan.Platform.Common.EmailService;
using Loan.Platform.Common.Helpers;
using Loan.Platform.Common.UserContext;
using Loan.Platform.Data.SqlServer.Pact;
using Loan.Platform.Models.CustomModels;
using Loan.Platform.Models.Entities;
using Loan.Platform.Models.Enums;
using Loan.Platform.Models.UserManagementModels;
using Loan.Platform.Models.ViewModels;

namespace Loan.Platform.Business
{
    public class UserManagerService : IUserManagerService
    {
        private readonly IEmailService _emailService;
        private readonly UserManager<ApplicationUser> userManager;
        private readonly RoleManager<IdentityRole> roleManager;
        private readonly IConfiguration _configuration;
        private readonly IRepository<User, long> _userRepository;
        private readonly IRepository<SignUpUser, long> _signUpUserRepository;
        private readonly IRepository<UserFilterViewModel, long> _userViewModelRepository;
        private readonly IRepository<UserRoleMapping, long> _userRoleMappingRepository;
        private readonly IRepository<UserRoles, long> _userRolesRepository;
        private readonly IRepository<UserRoleAppFeatureMapping, long> _userRoleAppFeatureRepository;
        private readonly IRepository<UserStatus, long> _userStatusRepository;
        private readonly IRepository<MailConfiguration, long> _mailConfigurationRepository;
        private readonly ICommonService _commonService;

        private long? UserId;

        public UserManagerService(UserManager<ApplicationUser> userManager, RoleManager<IdentityRole> roleManager, IConfiguration configuration,
            IRepository<User, long> userRepository,
            IRepository<UserRoleMapping, long> userRoleMappingRepository, IRepository<SignUpUser, long> signUpUserRepository,
            IRepository<UserFilterViewModel, long> userViewModelRepository,
            IRepository<UserRoles, long> userRolesRepository, IRepository<UserRoleAppFeatureMapping, long> UserRoleAppFeatureRepository,
            IEmailService emailService, IRepository<MailConfiguration, long> mailConfigurationRepository,
            IRepository<UserStatus, long> userStatusRepository, IUserContext claimsProvider, ICommonService commonService)
        {
            _emailService = emailService ?? throw new ArgumentNullException(nameof(emailService));
            this.userManager = userManager ?? throw new ArgumentNullException(nameof(userManager));
            this.roleManager = roleManager ?? throw new ArgumentNullException(nameof(roleManager));
            _configuration = configuration ?? throw new ArgumentNullException(nameof(configuration));
            _userRepository = userRepository ?? throw new ArgumentNullException(nameof(userRepository));
            _userRoleMappingRepository = userRoleMappingRepository ?? throw new ArgumentNullException(nameof(userRoleMappingRepository));
            _userViewModelRepository = userViewModelRepository ?? throw new ArgumentNullException(nameof(userViewModelRepository));
            _signUpUserRepository = signUpUserRepository ?? throw new ArgumentNullException(nameof(signUpUserRepository));
            _userRolesRepository = userRolesRepository ?? throw new ArgumentNullException(nameof(userRolesRepository));
            _userRoleAppFeatureRepository = UserRoleAppFeatureRepository ?? throw new ArgumentNullException(nameof(UserRoleAppFeatureRepository));
            _userStatusRepository = userStatusRepository ?? throw new ArgumentNullException(nameof(userStatusRepository));
            _mailConfigurationRepository = mailConfigurationRepository ?? throw new ArgumentNullException(nameof(mailConfigurationRepository));
            UserId = claimsProvider.UserId;
            _commonService = commonService ?? throw new ArgumentNullException(nameof(commonService)); ;
        }

        /// <inheritdoc cref="Loan.Platform.Business.Pact.IUserManagerService"/>
        public async Task<SecurityContext> Login(Login loginModel)
        {
            SecurityContext securityContext = null;
            var aspNetUser = await userManager.FindByNameAsync(loginModel.Username);
            string rolesString = string.Empty;
            string currentRole = string.Empty;
            List<long> featuresAccess = new List<long>();
            if (aspNetUser != null && await userManager.CheckPasswordAsync(aspNetUser, loginModel.Password))
            {
                var user = (await _userRepository.GetByCondition(u => u.AspNetUserId.Trim() == aspNetUser.Id.Trim() && u.IsActive == true)).FirstOrDefault();
                var roles = (await _userRoleMappingRepository.GetByCondition(r => r.UserId == user.Id)).ToList();
                //var userRoles = await roleManager.get.GetRolesAsync(aspNetUser);

                var authClaims = new List<Claim>
                {
                    new Claim("UserId", user.Id+"|"+user.OrganizationId+"|"+user.TenantId + "|" + user.EmailId + "|" + user.FirstName + user.LastName),
                    //new Claim(ClaimTypes.Role,string.Join(",",userRoles)),
                    new Claim(JwtRegisteredClaimNames.Jti, Guid.NewGuid().ToString()),
                    new Claim(JwtRegisteredClaimNames.Aud,_configuration["JWT:ValidAudience"]),
                     new Claim(JwtRegisteredClaimNames.Iss,_configuration["JWT:ValidIssuer"]),
                };

                foreach (var userRole in roles)
                {
                    var role = (await _userRolesRepository.GetById(userRole.RoleId));
                    var featuresMappedToRole = (await _userRoleAppFeatureRepository.GetByCondition(r => (r.RoleId == userRole.RoleId && r.IsActive == true))).ToList();
                    //roleManager.Roles.Where(r => r.Id == userRole.RoleId).FirstOrDefault()?.Name;
                    if (role != null)
                    {
                        rolesString = string.IsNullOrEmpty(rolesString) ? role.Name + "_" + role.Id : rolesString + "," + role.Name + "_" + role.Id;
                    }
                    if (featuresMappedToRole != null && featuresMappedToRole.Count() > 0)
                    {
                        featuresAccess.AddRange(featuresMappedToRole.Select(f => f.FeatureId).ToList());
                    }
                }

                authClaims.Add(new Claim(ClaimTypes.Role, rolesString));

                if (roles != null && roles.Count > 0)
                {
                    currentRole = rolesString.Split(',').OrderBy(x => x).FirstOrDefault();
                    authClaims.Add(new Claim("CurrentRole", currentRole));
                }

                foreach (var feature in featuresAccess.Distinct())
                {
                    authClaims.Add(new Claim("Features", Convert.ToString(feature)));
                }

                var tokenString = GenerateJwtTokenHandler(authClaims);

                securityContext = new SecurityContext();
                securityContext.Token = tokenString;
                securityContext.RoleName = rolesString;
                securityContext.UserId = user.Id;
                securityContext.TenantId = user.TenantId;
                securityContext.OrganizationId = user.OrganizationId;
                securityContext.EmailId = user.EmailId;
                securityContext.Name = user.FirstName + " " + user.LastName;
                securityContext.CurrentRole = currentRole;
            }
            return securityContext;
        }

        /// <inheritdoc cref="Loan.Platform.Business.Pact.IUserManagerService"/>
        public async Task<Response> ApproveRejectUser(SignUpUserViewModel userToApprove, bool isApprove, string password = "")
        {
            var userDetails = await GetSignUpUserById(userToApprove.Id);
            //var userStatuses = await _userStatusRepository.GetAll();

            if (isApprove)
            {
                if (userDetails != null && !userDetails.IsApproved)
                {
                    ApplicationUser identityUser = new ApplicationUser()
                    {
                        Email = userDetails.EmailId,
                        SecurityStamp = Guid.NewGuid().ToString(),
                        NormalizedUserName = userDetails.FirstName + " " + userDetails.LastName,
                        PhoneNumber = userDetails.ContactNo,
                        UserName = userDetails.EmailId,
                        EmailConfirmed = userDetails.StatusId == Convert.ToInt64(UserStatusEnum.Verified) ? true : false
                    };
                    if (string.IsNullOrEmpty(password))
                    {
                        return new Response
                        {
                            StatusCode = StatusCodes.Status500InternalServerError,
                            Status = "Error",
                            Message = $"User creation failed for user: {identityUser.UserName}! Please check user details and try again."
                        };
                    }
                    var result = await userManager.CreateAsync(identityUser, password);
                    if (!result.Succeeded)
                    {
                        return new Response
                        {
                            StatusCode = StatusCodes.Status500InternalServerError,
                            Status = "Error",
                            Message = $"User creation failed for user: {identityUser.UserName}! Please check user details and try again."
                        };
                    }

                    string role = userToApprove.UserType;

                    if (!await roleManager.RoleExistsAsync(role))
                    {
                        await roleManager.CreateAsync(new IdentityRole(role)).ConfigureAwait(false);
                    }
                    if (await roleManager.RoleExistsAsync(role))
                    {
                        await userManager.AddToRoleAsync(identityUser, role);
                    }

                    var savedIdentityUser = await this.userManager.FindByNameAsync(identityUser.Email);

                    var savedUser = await CreateUser(userToApprove, savedIdentityUser);

                    //Add customer details
                    if (role == UserRoleEnum.Customer.ToString() || role == UserRoleEnum.Both.ToString())
                    {
                        if (!await roleManager.RoleExistsAsync(Convert.ToString(UserRoleEnum.Customer)))
                        {
                            await roleManager.CreateAsync(new IdentityRole(Convert.ToString(UserRoleEnum.Customer)));
                        }

                        //var customerRole = await roleManager.FindByNameAsync(Convert.ToString(UserRoleEnum.Customer));
                        //Add customer user mapping details
                        if (!string.IsNullOrEmpty(identityUser.Id))
                        {
                            var savedresult = await this._userRoleMappingRepository.Create(CreateUserRoleMappingObject(savedUser, Convert.ToInt64(UserRoleEnum.Customer)));
                        }
                    }
                    //Add Vendor details
                    if (role == UserRoleEnum.Vendor.ToString() || role == UserRoleEnum.Both.ToString())
                    {
                        if (!await roleManager.RoleExistsAsync(Convert.ToString(UserRoleEnum.Vendor)))
                        {
                            await roleManager.CreateAsync(new IdentityRole(Convert.ToString(UserRoleEnum.Vendor)));
                        }

                        //var vendorRole = await roleManager.FindByNameAsync(Convert.ToString(UserRoleEnum.Vendor));
                        //Add vendor user mapping details
                        if (!string.IsNullOrEmpty(identityUser.Id))
                        {
                            var savedresult = await this._userRoleMappingRepository.Create(CreateUserRoleMappingObject(savedUser, Convert.ToInt64(UserRoleEnum.Vendor)));
                        }
                    }
                    if (!string.IsNullOrEmpty(identityUser.Id))
                    {
                        //update back to user
                        userDetails.IsApproved = true;
                        userDetails.Remark = "Approved by Admin";
                        userDetails.StatusId = _userStatusRepository.GetByCondition(u => u.Name == UserStatusEnum.Approved.ToString()).Result.FirstOrDefault().Id;
                        userDetails.ApprovedBy = userToApprove.ApprovedBy;
                        userDetails.UserTypeId = userToApprove.UserTypeId;
                        userDetails.Organization = userToApprove.Organization;
                        userDetails.OrganizationId = userToApprove.OrganizationId;
                        //todo after getting logged in context object
                        //userDetails.Result.UpdatedBy = 1;
                        await UpdateSignUpUser(userDetails);
                    }
                }
                return new Response()
                {
                    StatusCode = StatusCodes.Status201Created,
                    Status = "Success",
                    Message = "User created successfully! Admin will get in touch with you for further process."
                };
            }
            else
            {
                if (userDetails != null)
                {
                    //update back to user
                    userDetails.IsApproved = false;
                    userDetails.Remark = "Rejected by Admin";
                    userDetails.StatusId = _userStatusRepository.GetByCondition(u => u.Name == UserStatusEnum.Rejected.ToString()).Result.FirstOrDefault().Id;
                    userDetails.Organization = userToApprove.Organization;
                    userDetails.OrganizationId = userToApprove.OrganizationId;
                    //todo after getting logged in context object
                    //userDetails.Result.UpdatedBy = 1;
                    await this.UpdateSignUpUser(userDetails);
                }
                return new Response()
                {
                    StatusCode = StatusCodes.Status403Forbidden,
                    Status = "Rejected",
                    Message = "User Rejected by Admin"
                };
            }
        }

        /// <inheritdoc cref="Loan.Platform.Business.Pact.IUserManagerService"/>
        public async Task<User> GetUserById(long userId)
        {
            return await _userRepository.GetById(userId);
        }

        /// <inheritdoc cref="Loan.Platform.Business.Pact.IUserManagerService"/>
        public async Task Update(User user)
        {
            await _userRepository.Update(user);
        }

        //service method to get user details. quick search logic implemented here.
        public async Task<UserFilterViewModel> GetUserDetails(UserFilterViewModel userFilterViewModel)
        {
            return await _userViewModelRepository.SearchWithPagination(userFilterViewModel);
        }

        /// <inheritdoc cref="Loan.Platform.Business.Pact.IUserManagerService"/>
        public async Task UpdateUserDetail(User userModel)
        {
            var user = await _userRepository.GetById(userModel.Id);
            user.FirstName = userModel.FirstName;
            user.LastName = userModel.LastName;
            user.CompanyName = userModel.CompanyName;
            user.ContactNo = userModel.ContactNo;
            user.Designation = userModel.Designation;
            user.MobileNo = userModel.MobileNo;
            user.Address = userModel.Address;
            await _userRepository.Update(user);
        }

        public async Task<bool> ApproveRejectUsers(ApproveRejectUserViewModel usersForApproveReject)
        {
            bool isApprove = usersForApproveReject.Action.Equals("approve", StringComparison.OrdinalIgnoreCase) ? true : false;
            foreach (SignUpUserViewModel user in usersForApproveReject.Users)
            {
                using (var scope = new TransactionScope(TransactionScopeAsyncFlowOption.Enabled))
                {
                    try
                    {
                        string password = string.Empty;
                        if (isApprove)
                        {
                            //GeneratePassword from PasswordGenerator
                            password = PasswordGenerator.GeneratePassword();
                        }
                        var response = await ApproveRejectUser(user, isApprove, password);
                        if (response != null && response.StatusCode != StatusCodes.Status500InternalServerError)
                        {
                            if (response.StatusCode == StatusCodes.Status201Created)
                            {
                                //Send Email for approval
                                await _commonService.SendApprovalEmail(user, password);
                            }
                            else if (response.StatusCode == StatusCodes.Status403Forbidden)
                            {
                                //send email for rejection
                                await _commonService.SendRejectionEmail(user);
                            }
                        }
                        else
                        {
                            return false;
                        }
                        scope.Complete();
                    }
                    catch (Exception)
                    {
                        throw;
                    }
                    finally
                    {
                        scope.Dispose();
                    }
                }

            }
            return true;
        }

        public SecurityContext GetRefreshToken(string token)
        {
            SecurityContext securityContext = new SecurityContext();
            if (!string.IsNullOrEmpty(token))
            {
                JwtSecurityTokenHandler handler = new JwtSecurityTokenHandler();
                JwtSecurityToken jwtToken = handler.ReadJwtToken(token);
                var claims = jwtToken.Claims;
                var tokenString = GenerateJwtTokenHandler(claims);
                securityContext.Token = tokenString;
            }

            return securityContext;
        }

        public async Task<bool> CreateAdminUsers(string key, IList<AdminUserModel> users)
        {
            if (UserId != 1)
            {
                return false;
            }
            if (!string.IsNullOrEmpty(key) && users != null && users.Count > 0
                && key.Equals(_configuration["SuperAdminUserKey"], StringComparison.OrdinalIgnoreCase))
            {
                foreach (AdminUserModel user in users)
                {
                    var existingUser = await userManager.FindByNameAsync(user.Email);
                    if (existingUser != null)
                    {
                        return false;
                    }
                    using (var scope = new TransactionScope(TransactionScopeAsyncFlowOption.Enabled))
                    {
                        try
                        {
                            var signUpUser = await CreateSignUpUser(user);
                            string password = PasswordGenerator.GeneratePassword();
                            await CreateAdminUser(user.Email, password);
                            //Send Email for approval
                            SignUpUserViewModel signUpUserViewModel = new SignUpUserViewModel()
                            {
                                EmailId = user.Email,
                                Organization = "Standard Rail"
                            };
                            await _commonService.SendApprovalEmail(signUpUserViewModel, password);
                            scope.Complete();
                        }
                        catch (Exception ex)
                        {
                            return false;
                        }
                        finally
                        {
                            scope.Dispose();
                        }
                    }
                }
            }
            return true;
        }

        public async Task<bool> CreateSuperAdminUser(string key)
        {
            if (!key.Equals(_configuration["SuperAdminUserKey"], StringComparison.OrdinalIgnoreCase))
            {
                return false;
            }

            var user = await userManager.FindByNameAsync(_configuration["SuperAdminUserEmail"]);
            if (user != null)
            {
                return false;
            }
            using (var scope = new TransactionScope(TransactionScopeAsyncFlowOption.Enabled))
            {
                try
                {
                    await CreateAdminUser(_configuration["SuperAdminUserEmail"]);
                    scope.Complete();
                }
                catch (Exception)
                {
                    return false;
                }
                finally
                {
                    scope.Dispose();
                }
            }
            return true;
        }

        private async Task<bool> CreateAdminUser(string email, string password = "", long signupUserId = 0)
        {
            ApplicationUser aspNetAdminUser = new ApplicationUser()
            {
                Email = email,
                SecurityStamp = Guid.NewGuid().ToString(),
                NormalizedUserName = "Super Admin",
                UserName = email
            };
            var result = await userManager.CreateAsync(aspNetAdminUser, string.IsNullOrEmpty(password) ?
                             _configuration["SuperAdminUserPassword"] : password);

            if (!await roleManager.RoleExistsAsync(Convert.ToString(UserRoleEnum.Admin)))
            {
                await roleManager.CreateAsync(new IdentityRole(Convert.ToString(UserRoleEnum.Admin)));
            }
            if (await roleManager.RoleExistsAsync(Convert.ToString(UserRoleEnum.Admin)))
            {
                await userManager.AddToRoleAsync(aspNetAdminUser, Convert.ToString(UserRoleEnum.Admin));
            }

            var savedIdentityUser = await this.userManager.FindByNameAsync(aspNetAdminUser.Email);

            User adminUser = new User();
            adminUser.FirstName = "Admin";
            adminUser.OrganizationName = "Standard Rail";
            adminUser.OrganizationId = 1;
            adminUser.TenantId = 1;
            adminUser.EmailId = savedIdentityUser.Email;
            adminUser.AspNetUserId = savedIdentityUser.Id;
            adminUser.ContactNo = "00000000000";
            adminUser.IsActive = true;
            adminUser.CompanyName = "Standard Rail";
            if (signupUserId > 0)
            {
                adminUser.SignUpUserId = signupUserId;
            }
            var savedUser = await this._userRepository.Create(adminUser);

            //var adminRole = await roleManager.FindByNameAsync(UserRoleEnum.Admin.ToString());

            if (savedUser.Id > 0)
            {
                UserRoleMapping vendorRoleMapping = new UserRoleMapping()
                {
                    UserId = savedUser.Id,
                    RoleId = Convert.ToInt64(UserRoleEnum.SuperAdmin),
                };
                vendorRoleMapping.OrganizationId = 1;
                var savedresult = await this._userRoleMappingRepository.Create(vendorRoleMapping);
            }

            return true;
        }

        public async Task<string> ChangePassword(ChangePasswordRequest changePasswordRequest)
        {
            var account = _signUpUserRepository.GetByCondition(e => e.EmailId == changePasswordRequest.EmailId).Result.SingleOrDefault();
            if (account == null) return "Email Id does not exists.";

            var aspNetUser = userManager.FindByNameAsync(account.EmailId).Result;
            if (aspNetUser == null) return "User does not exists.";

            var validCurrentPassword = userManager.CheckPasswordAsync(aspNetUser, changePasswordRequest.CurrentPassword).Result;
            if (!validCurrentPassword) return "Invalid current password.";

            if (account.IsApproved && aspNetUser.EmailConfirmed)
            {
                // update password and remove reset token
                account.PasswordChanged = DateTime.UtcNow;
                IdentityResult changePasswordResult = userManager.ChangePasswordAsync(aspNetUser, changePasswordRequest.CurrentPassword, changePasswordRequest.ConfirmPassword).Result;
                if (changePasswordResult != null && changePasswordResult.Errors.Any())
                {
                    StringBuilder errorMessage = new();
                    foreach (var err in changePasswordResult.Errors)
                    {
                        errorMessage.Append(err.Description + " ");
                    }
                    return errorMessage.ToString();
                }
                await _signUpUserRepository.Update(account);

                return "success";
            }

            return "User not approved in system.";
        }

        private async Task<SignUpUser> GetSignUpUserById(long signUpUserId)
        {
            return await _signUpUserRepository.GetById(signUpUserId);
        }

        private async Task UpdateSignUpUser(SignUpUser user)
        {
            await _signUpUserRepository.Update(user);
        }

        public async Task<User> CreateUser(SignUpUserViewModel signUpUser, ApplicationUser identityUser)
        {
            User user = new User();
            user.FirstName = signUpUser.FirstName;
            user.LastName = signUpUser.LastName;
            user.OrganizationName = signUpUser.Organization;
            user.OrganizationId = signUpUser.OrganizationId == null ? 1 : signUpUser.OrganizationId.Value;
            user.Designation = signUpUser.Designation;
            user.EmailId = signUpUser.EmailId;
            user.ContactNo = signUpUser.ContactNo;
            user.MobileNo = signUpUser.MobileNo;
            user.StatusId = signUpUser.StatusId;
            user.Remark = signUpUser.Remark;
            user.Address = signUpUser.Address;
            user.SignUpUserId = signUpUser.Id;
            user.AspNetUserId = identityUser.Id;
            user.IsActive = true;
            user.TenantId = 1;
            user.ModifiedBy = UserId.Value;
            user.ModifiedTime = DateTime.Now;
            user.CreatedBy = UserId.Value;
            user.CreatedTime = DateTime.Now;
            user.CompanyName = signUpUser.CompanyName;
            return await this._userRepository.Create(user);
        }

        /// <summary>
        /// Shared code for creating the JWT tokenHandler
        /// </summary>
        /// <param name="userId"></param>
        /// <param name="claims"></param>
        /// <returns></returns>
        private string GenerateJwtTokenHandler(IEnumerable<Claim> claims)
        {
            //var tokenHandler = new JwtSecurityTokenHandler();
            //var key = Encoding.ASCII.GetBytes(_configuration["JWT:Secret"]);
            //var encryptKey = Encoding.ASCII.GetBytes(_configuration["JWT:EncryptSecret"]);

            var key = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(_configuration["JWTSecret"]));
            //var key1 = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(_configuration["JWT:EncryptSecret"]));
            var creds = new SigningCredentials(key, SecurityAlgorithms.HmacSha256);
            //var encryptingCredentials = new EncryptingCredentials(key1, JwtConstants.DirectKeyUseAlg, SecurityAlgorithms.Aes256CbcHmacSha512);

            var jwtSecurityToken = new JwtSecurityTokenHandler().CreateJwtSecurityToken(
                _configuration["JWT:ValidAudience"],
                _configuration["JWT:ValidIssuer"],
                new ClaimsIdentity(claims),
                null,
                expires: DateTime.UtcNow.AddMinutes(Convert.ToInt32(_configuration["JWT:ExpireTimeInMinutes"])),
                null,
                signingCredentials: creds
                //,encryptingCredentials
                );
            var encryptedJWT = new JwtSecurityTokenHandler().WriteToken(jwtSecurityToken);

            return encryptedJWT;
        }     

        private UserRoleMapping CreateUserRoleMappingObject(User savedUser, long roleId)
        {
            UserRoleMapping userRoleTypeMapping = new UserRoleMapping()
            {
                UserId = savedUser.Id,
                RoleId = roleId,
                OrganizationId = savedUser.OrganizationId,
                TenantId = savedUser.TenantId,
                ModifiedBy = savedUser.ModifiedBy,
                CreatedBy = savedUser.CreatedBy,
                CreatedTime = DateTime.UtcNow,
                ModifiedTime = DateTime.UtcNow
            };
            return userRoleTypeMapping;
        }

        public SecurityContext UpdateCurrentRole(string token, string updatedRole)
        {
            SecurityContext securityContext = new SecurityContext();
            if (!string.IsNullOrEmpty(token))
            {
                JwtSecurityTokenHandler handler = new JwtSecurityTokenHandler();
                JwtSecurityToken jwtToken = handler.ReadJwtToken(token);
                var claims = jwtToken.Claims.Where(claim => claim.Type != "CurrentRole").ToList();
                claims.Add(new Claim("CurrentRole", updatedRole));
                var tokenString = GenerateJwtTokenHandler(claims);
                securityContext.Token = tokenString;
            }
            return securityContext;
        }

        private async Task<SignUpUser> CreateSignUpUser(AdminUserModel user)
        {
            var signUpUser = new SignUpUser()
            {
                EmailId = user.Email,
                CompanyName = user.CompanyName,
                Designation = user.Designation,
                FirstName = user.FirstName,
                LastName = user.LastName,
                StatusId = Convert.ToInt64(UserStatusEnum.Approved),
                UserTypeId = 1,
                IsApproved = true,
                OrganizationId = 1,
                IsActive = true,
                Organization = "Standard Rail"
            };
            return await this._signUpUserRepository.Create(signUpUser);
        }
    }
}

