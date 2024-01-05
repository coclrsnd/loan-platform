using System.ComponentModel.DataAnnotations;
namespace Loan.Platform.Models.Accounts
{
    public class ForgotPasswordRequest
    {
        [Required]
        [EmailAddress]
        public string Email { get; set; }
    }
}