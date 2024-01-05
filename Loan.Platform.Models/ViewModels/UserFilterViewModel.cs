using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Loan.Platform.Models.ViewModels
{
    public class UserFilterViewModel
    {
        public string CompanyName { get; set; }

        public string FirstName { get; set; }

        public long StatusId { get; set; }

        public List<SignUpUserViewModel> UserList { get; set; }

        public PaginationModel PaginationModel { get; set; }

        public SortingModel SortingModel { get; set; }
    }
}