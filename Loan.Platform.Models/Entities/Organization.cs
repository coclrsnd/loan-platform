using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace Loan.Platform.Models.Entities
{
    public class Organization
    {
        public long Id { get; set; }
        public string Name { get; set; }
        public string Code { get; set; }
        public string Description { get; set; }
        public string LogoPath { get; set; }
        public bool? IsActive { get; set; }
        public DateTime CreatedTime { get; set; }

        [Required(AllowEmptyStrings = false)]
        public long CreatedBy { get; set; }

        public DateTime ModifiedTime { get; set; }

        [Required(AllowEmptyStrings = false)]
        public long ModifiedBy { get; set; }
        public ICollection<ApplicantOrganizationMapping> ApplicantOrganizationMappings { get; set; }
    }
}
