using System.Threading.Tasks;
using Loan.Platform.Models.ViewModels;

namespace Loan.Platform.Business.Pact
{
    public interface IUtilityService
    {
        /// <summary>
        /// Sends the verification email to user.
        /// </summary>
        /// <returns>Verification Email link</returns>
        Task<string> UserVerifyEmail(EmailUtilityViewModel emailUtilityViewModel,string key);

        /// <summary>
        /// Sends the Password reset email to user.
        /// </summary>
        /// <returns>Password reset Email link</returns>
        Task<string> UserPasswordResetEmail(EmailUtilityViewModel emailUtilityViewModel,string key);

        /// <summary>
        /// Sends the Approval email to user.
        /// </summary>
        /// <returns>Newly updated Password</returns>
        Task<string> UserApprovalEmail(EmailUtilityViewModel emailUtilityViewModel, string key);
    }
}
