using System;

namespace Loan.Platform.Models.Entities
{
    public class BaseUserDetails : EntityBase
    {
        public long Id { get; set; }

        public Guid CustomerUserId { get; set; }

        public string Name { get; set; }

        public string PrimaryContactNo { get; set; }

        public string SecondaryContactNo { get; set; }

        public string Subsidary { get; set; }

        public string Address { get; set; }

        public string ZipCode { get; set; }

        public string City { get; set; }

        public long? StateId { get; set; }

        public long? CountryId { get; set; }

        public DateTime EffectiveDate { get; set; }

        public DateTime? ExpiryDate { get; set; }

        public string PrimaryContactEmail { get; set; }

        public string SecondaryContactEmail { get; set; }
        public string Website { get; set; }
        public string Description { get; set; }
        public virtual Organization Organization { get; set; }
    }
}
