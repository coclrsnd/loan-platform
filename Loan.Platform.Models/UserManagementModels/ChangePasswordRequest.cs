using System.ComponentModel.DataAnnotations;

namespace Loan.Platform.Models.UserManagementModels
{
    /// <summary>
    /// Request for change password.
    /// </summary>
    public class ChangePasswordRequest
    {
        [Required]
        [EmailAddress]
        public string EmailId { get; set; }

        [Required]
        [MinLength(6)]
        public string CurrentPassword { get; set; }

        [Required]
        [MinLength(6)]
        public string NewPassword { get; set; }

        [Required]
        [Compare("NewPassword")]
        public string ConfirmPassword { get; set; }

    }
}
