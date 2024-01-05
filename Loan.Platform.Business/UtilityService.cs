using System;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Identity;
using Microsoft.Extensions.Configuration;
using Loan.Platform.Business.Helpers;
using Loan.Platform.Business.Pact;
using Loan.Platform.Common.Helpers;
using Loan.Platform.Data.SqlServer.Pact;
using Loan.Platform.Models.Entities;
using Loan.Platform.Models.Enums;
using Loan.Platform.Models.UserManagementModels;
using Loan.Platform.Models.ViewModels;

namespace Loan.Platform.Business
{
    /// <summary>
    /// Contains utility logic to handle different functionalities
    /// </summary>
    public class UtilityService : IUtilityService
    {
        private readonly IRepository<SignUpUser, long> _signUpUserRepository;
        private readonly ICommonService _commonService;
        private readonly UserManager<ApplicationUser> _userManager;
        private readonly IConfiguration _configuration;

        private const string ErrorMessagePrefix = "User with EmailId \"{0}\" {1}";
        private const string NotExist = "does not exist";
        private const string Not = "is not ";
        private const string InvalidSuperAdminKey = "Invalid SuperAdminUserKey";


        public UtilityService(IRepository<SignUpUser, long> signUpUserRepository, ICommonService commonService, UserManager<ApplicationUser> userManager, IConfiguration configuration)
        {
            _signUpUserRepository = signUpUserRepository ?? throw new ArgumentNullException(nameof(signUpUserRepository));
            _commonService = commonService ?? throw new ArgumentNullException(nameof(commonService));
            _userManager = userManager ?? throw new ArgumentNullException(nameof(userManager));
            _configuration = configuration ?? throw new ArgumentNullException(nameof(configuration));
        }

        /// <inheritdoc cref="Loan.Platform.Business.Pact.IUtilityService"/>
        public async Task<string> UserPasswordResetEmail(EmailUtilityViewModel emailUtilityViewModel, string key)
        {
            var account = await BaseValidations(emailUtilityViewModel, key, UserStatusEnum.Approved);

            var aspNetUser = await _userManager.FindByNameAsync(account.EmailId);
            if (aspNetUser != null && aspNetUser.EmailConfirmed)
            {
                // create reset token that expires after 1 day
                account.ResetToken = await _userManager.GeneratePasswordResetTokenAsync(aspNetUser);
                account.ResetTokenExpires = DateTime.UtcNow.AddDays(1);

                await _signUpUserRepository.Update(account);
                await _commonService.SendPasswordResetEmail(account, emailUtilityViewModel.Origin);

                return _commonService.GenerateLinkWithToken("reset-password", account.ResetToken, emailUtilityViewModel.Origin); ;
            }
            throw new AppException(string.Format(ErrorMessagePrefix, emailUtilityViewModel.EmailId, NotExist));
        }

        /// <inheritdoc cref="Loan.Platform.Business.Pact.IUtilityService"/>
        public async Task<string> UserApprovalEmail(EmailUtilityViewModel emailUtilityViewModel, string key)
        {
            var account = await BaseValidations(emailUtilityViewModel, key, UserStatusEnum.Approved);

            var identityUser = await _userManager.FindByNameAsync(emailUtilityViewModel.EmailId);

            if (identityUser != null && identityUser.UserName.Equals(emailUtilityViewModel.EmailId, StringComparison.OrdinalIgnoreCase))
            {
                string newPassword = PasswordGenerator.GeneratePassword();
                identityUser.PasswordHash = _userManager.PasswordHasher.HashPassword(identityUser, newPassword);

                await _userManager.UpdateAsync(identityUser);

                var singUpUserModel = new SignUpUserViewModel()
                {
                    FirstName = account.FirstName,
                    LastName = account.LastName,
                    EmailId = account.EmailId,
                    Organization = account.Organization
                };

                await _commonService.SendApprovalEmail(singUpUserModel, newPassword);

                return newPassword;
            }
            throw new AppException(string.Format(ErrorMessagePrefix, emailUtilityViewModel.EmailId, NotExist));
        }

        /// <inheritdoc cref="Loan.Platform.Business.Pact.IUtilityService"/>
        public async Task<string> UserVerifyEmail(EmailUtilityViewModel emailUtilityViewModel, string key)
        {
            var account = await BaseValidations(emailUtilityViewModel, key, UserStatusEnum.Pending);
            account.VerificationToken = _commonService.GenerateVerificationToken();

            await _signUpUserRepository.Update(account);
            await _commonService.SendVerificationEmailAsync(account, emailUtilityViewModel.Origin);

            return _commonService.GenerateLinkWithToken("verify-email", account.VerificationToken, emailUtilityViewModel.Origin);
        }

        /// <summary>
        /// Validates the user request.
        /// </summary>
        /// <returns>Return SingnUpUser object if validations are passed/ throws error if the validations failed</returns>
        private async Task<SignUpUser> BaseValidations(EmailUtilityViewModel emailUtilityViewModel, string key, UserStatusEnum userStatusEnum = UserStatusEnum.Approved)
        {
            if (!key.Equals(_configuration["SuperAdminUserKey"], StringComparison.OrdinalIgnoreCase))
            {
                throw new AppException(InvalidSuperAdminKey);
            }

            var account = (await _signUpUserRepository.GetByCondition(e => e.EmailId == emailUtilityViewModel.EmailId)).SingleOrDefault();

            if (account == null)
                throw new AppException(string.Format(ErrorMessagePrefix, emailUtilityViewModel.EmailId, NotExist));
            if (userStatusEnum == UserStatusEnum.Approved && !account.IsApproved)
                throw new AppException(string.Format(ErrorMessagePrefix, account.EmailId, Not + UserStatusEnum.Approved.ToString()));
            if (userStatusEnum == UserStatusEnum.Pending && account.StatusId != (int)userStatusEnum)
                throw new AppException(string.Format(ErrorMessagePrefix, account.EmailId, Not + userStatusEnum.ToString()));

            return account;
        }
    }
}
