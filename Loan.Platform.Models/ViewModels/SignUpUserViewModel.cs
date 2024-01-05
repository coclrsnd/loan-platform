using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Loan.Platform.Models.ViewModels
{
    /// <summary>
    /// Hold information for the Users.
    /// </summary>
    public class SignUpUserViewModel
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

        public string Status { get; set; }

        public string UserType { get; set; }

        public long? UserTypeId { get; set; }

        public long StatusId { get; set; }

        public string Remark { get; set; }

        public int ApprovedBy { get; set; }

        public string Address { get; set; }

        public string Organization { get; set; }

        public long? OrganizationId { get; set; }

        public PaginationModel PaginationModel { get; set; }

        public PaginationModel SortingModel { get; set; }
    }
}
