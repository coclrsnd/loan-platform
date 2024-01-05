using System;
using System.ComponentModel.DataAnnotations;

namespace Loan.Platform.Models.Accounts
{
    public class RegisterRequest
    {
        [Required]
        public string FirstName { get; set; }

        [Required]
        public string LastName { get; set; }

        [Required]
        public string CompanyName { get; set; }

        [Required]
        [EmailAddress]
        public string EmailId { get; set; }
        
        public string Designation { get; set; }

        public string ContactNo { get; set; }

        [Range(typeof(bool), "true", "true")]
        public bool AgreeTermsAndConditions { get; set; }
    }
}
