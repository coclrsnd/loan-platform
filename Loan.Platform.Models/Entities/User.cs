using System;

namespace Loan.Platform.Models.Entities
{
    public class User : EntityBase
    {
        public long Id { get; set; }

        public string FirstName { get; set; }

        public string LastName { get; set; }

        public string OrganizationName { get; set; }

        public string Designation { get; set; }

        public string EmailId { get; set; }

        public string ContactNo { get; set; }

        public string MobileNo { get; set; }

        public long? ApprovedBy { get; set; }

        public long? StatusId { get; set; }

        public string Remark { get; set; }

        public string Address { get; set; }

        public long? SignUpUserId { get; set; }

        public string AspNetUserId { get; set; }

        public string VerificationToken { get; set; }

        public DateTime? VerifiedOn { get; set; }

        public string CompanyName { get; set; }
    }
}
