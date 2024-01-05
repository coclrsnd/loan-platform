using System;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;

namespace Loan.Platform.Models.Entities
{
    public class EntityBase
    {
        [DefaultValue(true)]
        public bool? IsActive { get; set; }

        public DateTime CreatedTime { get; set; }

        [Required(AllowEmptyStrings = false)]
        public long CreatedBy { get; set; }

        public DateTime ModifiedTime { get; set; }

        [Required(AllowEmptyStrings = false)]
        public long ModifiedBy { get; set; }

        [DefaultValue(0)]
        public long OrganizationId { get; set; }

        [DefaultValue(0)]
        public long TenantId { get; set; }
    }
}
