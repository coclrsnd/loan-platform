using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Loan.Platform.Models.Entities
{
    public class ApplicantOrganizationMapping:EntityBase
    {
        public long Id { get; set; }
        public long ApplicantId { get; set; }
        public Applicant Applicant { get; set; }

        public long OrganizationId { get; set; }
        public Organization Organization { get; set; }
    }
}
