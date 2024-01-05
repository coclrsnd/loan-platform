using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Loan.Platform.Models.ViewModels
{
    public class ApproveRejectUserViewModel
    {
        public List<SignUpUserViewModel> Users { get; set; }

        public string Action { get; set; }
    }
}
