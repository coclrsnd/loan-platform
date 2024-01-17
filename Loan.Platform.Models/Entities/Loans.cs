using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Loan.Platform.Models.Entities
{
    public class Loans : EntityBase
    {
        public int Id { get; set; }
        public decimal Amount { get; set; }
        public int Status { get; set; }
        public string Organization { get; set; }
        public string AdharNumber { get; set; }
        public DateTime LoanDate { get; set; }
        public string LoanBorrower { get; set; }
        public string LoanType { get; set; }
    }
}
