using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Loan.Platform.Models.Entities
{
    public class Loan : EntityBase
    {
        public int Id { get; set; }
        public decimal Amount { get; set; }
        public int Status { get; set; }
        public long ApplicantId { get; set; }
        public Applicant Applicant { get; set; }
    }
}
