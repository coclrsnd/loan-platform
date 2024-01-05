using System;
using Loan.Platform.Models.UserManagementModels;

namespace Loan.Platform.Models.Entities
{
    public class SignUpUser
    {
        public int Id { get; set; }

        public string FirstName { get; set; }

        public string LastName { get; set; }

        public string CompanyName { get; set; }

        public string Designation { get; set; }

        public string EmailId { get; set; }

        public string ContactNo { get; set; }

        public string MobileNo { get; set; }

        public bool IsApproved { get; set; }

        public long StatusId { get; set; }

        public string Remark { get; set; }

        public string Address { get; set; }

        public string VerificationToken { get; set; }

        public DateTime? VerifiedOn { get; set; }

        public string ResetToken { get; set; }

        public DateTime? ResetTokenExpires { get; set; }

        public DateTime? PasswordReset { get; set; }

        public DateTime? PasswordChanged { get; set; }

        public long? ApprovedBy { get; set; }

        public long UpdatedBy { get; set; }

        public long? OrganizationId { get; set; }

        public string Organization { get; set; }

        public long? UserTypeId { get; set; }
        
        public bool? IsActive { get; set; }

        //Navigation Properties
        public UserType UserType { get; set; }
    }
}
