using System.ComponentModel.DataAnnotations;

namespace Loan.Platform.Models.Accounts
{
    public class VerifyEmailRequest
    {
        [Required]
        public string Token { get; set; }
    }
}
