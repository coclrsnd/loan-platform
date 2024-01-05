using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Loan.Platform.Models.LoanModels
{
    public class LoanViewModel
    {
        public long LoanId { get; set; }
        public decimal Amount { get; set; }
        public long ApplicantId { get; set; }
    }
}
