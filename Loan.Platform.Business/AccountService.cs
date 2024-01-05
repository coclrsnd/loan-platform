using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Threading.Tasks;
using System.Web;
using Microsoft.AspNetCore.Identity;
using Microsoft.Extensions.Configuration;
using Loan.Platform.Business.Helpers;
using Loan.Platform.Business.Pact;
using Loan.Platform.Common.EmailService;
using Loan.Platform.Data.SqlServer.Pact;
using Loan.Platform.Models.Accounts;
using Loan.Platform.Models.Entities;
using Loan.Platform.Models.Enums;
using Loan.Platform.Models.UserManagementModels;

namespace Loan.Platform.Business
{
    public class AccountService : IAccountService
    {
        private readonly UserManager<ApplicationUser> _userManager;
        private readonly IRepository<User, long> _userRepository;
        private readonly IRepository<SignUpUser, long> _signUpUserRepository;
        private readonly IRepository<UserStatus, long> _userStatusRepository;
        private readonly IRepository<MailConfiguration, long> _mailConfigurationRepository;
        private readonly IEmailService _emailService;
        private readonly ICommonService _commonService;

        public AccountService(UserManager<ApplicationUser> userManager, IRepository<SignUpUser, long> signUpUserRepository,
            IRepository<UserStatus, long> userStatusRepository, IRepository<User, long> userRepository,
            IRepository<MailConfiguration, long> mailConfigurationRepository, IEmailService emailService, ICommonService commonService)
        {
            _userManager = userManager ?? throw new ArgumentNullException(nameof(userManager));
            _signUpUserRepository = signUpUserRepository ?? throw new ArgumentNullException(nameof(signUpUserRepository));
            _userRepository = userRepository ?? throw new ArgumentNullException(nameof(userRepository));
            _userStatusRepository = userStatusRepository ?? throw new ArgumentNullException(nameof(userStatusRepository));
            _mailConfigurationRepository = mailConfigurationRepository ?? throw new ArgumentNullException(nameof(mailConfigurationRepository));
            _emailService = emailService ?? throw new ArgumentNullException(nameof(emailService));
            _commonService = commonService ?? throw new ArgumentNullException(nameof(commonService));
        }

        public async Task ForgotPassword(ForgotPasswordRequest model, string origin)
        {
            var account = this._signUpUserRepository.GetByCondition(e => e.EmailId == model.Email).Result.FirstOrDefault();

            // always return ok response to prevent email enumeration
            if (account == null) return;

            var aspNetUser = _userManager.FindByNameAsync(account.EmailId).Result;
            if (account.IsApproved && aspNetUser != null && aspNetUser.EmailConfirmed)
            {
                // create reset token that expires after 1 day
                account.ResetToken = _userManager.GeneratePasswordResetTokenAsync(aspNetUser).Result;
                //generateResetToken
                var resetToken = _commonService.GenerateResetToken();
                account.ResetTokenExpires = DateTime.UtcNow.AddDays(1);
                _signUpUserRepository.Update(account).GetAwaiter().GetResult();
            }
            else
            {
                // always return ok response to prevent email enumeration
                return;
            }

            // send email
            await _commonService.SendPasswordResetEmail(account, origin);
        }

        public async Task Register(RegisterRequest registerRequest, string origin)
        {
            if (this._signUpUserRepository.GetByCondition(e => e.EmailId == registerRequest.EmailId).Result.Any())
            {
                // send already registered error in email to prevent account enumeration
                await _commonService.SendAlreadyRegisteredEmail(registerRequest, origin);
                return;
            }
            var signUpUser = new SignUpUser()
            {
                EmailId = registerRequest.EmailId,
                CompanyName = registerRequest.CompanyName,
                Designation = registerRequest.Designation,
                FirstName = registerRequest.FirstName,
                LastName = registerRequest.LastName,
                ContactNo = registerRequest.ContactNo.ToString(),
                StatusId = Convert.ToInt64(UserStatusEnum.Pending)
            };
            signUpUser.VerificationToken = _commonService.GenerateVerificationToken();
            var savedUser = await this._signUpUserRepository.Create(signUpUser);

            // send email
            await _commonService.SendVerificationEmailAsync(savedUser, origin);
        }

        public async Task<bool> ResetPassword(ResetPasswordRequest model)
        {
            var account = _signUpUserRepository.GetByCondition(e => e.ResetToken == model.Token && e.ResetTokenExpires > DateTime.UtcNow).Result.SingleOrDefault();
            if (account == null) throw new AppException("Invalid password reset token");

            var aspNetUser = _userManager.FindByNameAsync(account.EmailId).Result;
            if (aspNetUser == null) throw new AppException("Invalid user");

            if (account.IsApproved && aspNetUser.EmailConfirmed)
            {
                // update password and remove reset token
                account.PasswordReset = DateTime.UtcNow;
                account.ResetToken = null;
                account.ResetTokenExpires = null;
                IdentityResult resetPasswordResult = _userManager.ResetPasswordAsync(aspNetUser, model.Token, model.ConfirmPassword).Result;
                if (resetPasswordResult != null && resetPasswordResult.Errors.Any())
                {
                    StringBuilder errorMessage = new();
                    foreach (var err in resetPasswordResult.Errors)
                    {
                        errorMessage.Append(err.Description + " ");
                    }
                    throw new AppException(errorMessage.ToString());
                }
                await _signUpUserRepository.Update(account);

                return true;
            }

            return false;
        }

        public void ValidateResetToken(ValidateResetTokenRequest model)
        {
            var account = _signUpUserRepository.GetByCondition(e => e.ResetToken == model.Token && e.ResetTokenExpires > DateTime.UtcNow).Result.FirstOrDefault();
            if (account == null) throw new AppException("Invalid password reset token");
        }

        public async Task<bool> VerifyEmail(string token)
        {
            var signedUser = _signUpUserRepository.GetByCondition(x => x.VerificationToken == token && x.StatusId == Convert.ToInt64(UserStatusEnum.Pending)).Result.SingleOrDefault();
            bool status = false;
            if (signedUser == null)
                return false;

            var verifiedUserStatus = _userStatusRepository.GetByCondition(e => e.Name == UserStatusEnum.Verified.ToString()).Result.SingleOrDefault();
            if (verifiedUserStatus == null)
                return status;

            signedUser.StatusId = verifiedUserStatus.Id;
            signedUser.VerifiedOn = DateTime.UtcNow;
            signedUser.VerificationToken = null;

            await _signUpUserRepository.Update(signedUser);
            await _commonService.SendUserApprovalRequestEmail(signedUser);

            return true;
        }       

    }
}