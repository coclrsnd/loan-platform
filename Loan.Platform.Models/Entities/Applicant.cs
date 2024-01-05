using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Loan.Platform.Models.Entities
{
    public class Applicant
    {
        public long Id { get; set; }
        public string Name { get; set; }
        public string AdharNumber { get; set; }
        public ICollection<ApplicantOrganizationMapping> ApplicantOrganizationMappings { get; set; }

    }
}
