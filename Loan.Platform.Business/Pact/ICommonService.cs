using System.Threading.Tasks;
using Loan.Platform.Common.EmailService;
using Loan.Platform.Models.Accounts;
using Loan.Platform.Models.Entities;
using Loan.Platform.Models.ViewModels;

namespace Loan.Platform.Business.Pact
{
    public interface ICommonService
    {

        /// <summary>
        /// Send Verification Email to users.
        /// </summary>
        /// <returns>True / False</returns>
        Task<bool> SendVerificationEmailAsync(SignUpUser user, string origin);

        /// <summary>
        /// Send Password Reset email to users.
        /// </summary>
        /// <returns>True / False</returns>
        Task<bool> SendPasswordResetEmail(SignUpUser user, string origin);

        /// <summary>
        /// Send Approval Request email to admin.
        /// </summary>
        /// <returns>True / False</returns>
        Task<bool> SendUserApprovalRequestEmail(SignUpUser user);

        /// <summary>
        /// Send Already Registered email to users.
        /// </summary>
        /// <returns>True / False</returns>
        Task<bool> SendAlreadyRegisteredEmail(RegisterRequest user, string origin);

        /// <summary>
        /// Send Approval email  to users.
        /// </summary>
        /// <returns>True / False</returns>
        Task<bool> SendApprovalEmail(SignUpUserViewModel user, string password);

        /// <summary>
        /// Send Rejection Email  to users.
        /// </summary>
        /// <returns>True / False</returns>
        Task<bool> SendRejectionEmail(SignUpUserViewModel user);

        /// <summary>
        /// Send Storage Opportunity Email.
        /// </summary>
        /// <returns>True / False</returns>
        Task<bool> SendStorageOpportunityEmailAsync(User user, OpportunityViewModel opportunity, byte[] opportunitySummary);
        
        /// <summary>
        /// Generates link with tokens.
        /// </summary>
        /// <returns>Generated link with token</returns>
        string GenerateLinkWithToken(string url, string token, string origin = null);

        /// <summary>
        /// Generates unique verification token.
        /// </summary>
        /// <returns>unique verification token</returns>
        string GenerateVerificationToken();

        /// <summary>
        /// Generates unique reset token.
        /// </summary>
        /// <returns>unique reset token</returns>
        string GenerateResetToken();

        /// <summary>
        /// Logs the mail responce into Db.
        /// </summary>
        /// <returns>Void</returns>
        Task LogMailResponse(EmailResponse emailRespnce);

        
    }
}
