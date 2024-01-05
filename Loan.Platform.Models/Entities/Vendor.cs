using System;
using Microsoft.EntityFrameworkCore;

namespace StandardRail.RailCarLounge.Models.Entities
{
    /// <summary>
    /// Holds properties of Vendor Entity.
    /// </summary>
    public class Vendor : EntityBase //: BaseUserDetails
    {
        public long Id { get; set; }

        public string ContactPersonName { get; set; }

        public string PrimaryContactNo { get; set; }

        public string SecondaryContactNo { get; set; }

        public string Organization { get; set; }

        public string Address { get; set; }

        public string ZipCode { get; set; }

        public string City { get; set; }

        public long? StateId { get; set; }

        public long? CountryId { get; set; }

        public long? RegionId { get; set; }

        public DateTime EffectiveDate { get; set; }

        public DateTime? ExpiryDate { get; set; }

        public string PrimaryContactEmail { get; set; }

        public string SecondaryContactEmail { get; set; }

        public string Website { get; set; }

        public string Description { get; set; }

        [Precision(18, 2)]
        public decimal? PercentageMargin { get; set; }

        //Navigation Properties
        public virtual State State { get; set; }

        public virtual Country Country { get; set; }

        public virtual Region Region { get; set; }
    }
}
