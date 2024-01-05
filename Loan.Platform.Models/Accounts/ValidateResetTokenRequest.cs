using System.ComponentModel.DataAnnotations;

namespace Loan.Platform.Models.Accounts
{
    public class ValidateResetTokenRequest
    {
        [Required]
        public string Token { get; set; }
    }
}
