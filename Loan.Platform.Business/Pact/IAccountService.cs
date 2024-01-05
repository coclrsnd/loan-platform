using System.Threading.Tasks;
using Loan.Platform.Models.Accounts;

namespace Loan.Platform.Business.Pact
{
    public interface IAccountService
    {
        Task Register(RegisterRequest registerRequest, string origin);
        Task<bool> VerifyEmail(string token);
        Task ForgotPassword(ForgotPasswordRequest model, string origin);
        void ValidateResetToken(ValidateResetTokenRequest model);
        Task<bool> ResetPassword(ResetPasswordRequest model);
    }
}
