using System.ComponentModel.DataAnnotations;

namespace Loan.Platform.Models.ViewModels
{
    public class EmailUtilityViewModel
    {
        [Required]
        public string EmailId { get; set; }

        public string Origin { get; set; }
    }
}
