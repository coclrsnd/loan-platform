using System;
using System.Collections.Generic;

namespace Loan.Platform.Models.ViewModels
{
    /// <summary>
    /// Vendor View Model.
    /// </summary>
    public class VendorViewModel
    {
        public long Id { get; set; }

        public string ContactPersonName { get; set; }

        public string PrimaryContactNo { get; set; }

        public string SecondaryContactNo { get; set; }

        public string Organization { get; set; }

        public long OrganizationId { get; set; }

        public string Address { get; set; }

        public string ZipCode { get; set; }

        public string City { get; set; }

        public long? StateId { get; set; }

        public long? CountryId { get; set; }

        public long? RegionId { get; set; }

        public decimal PercentageMargin { get; set; }

        public string EffectiveDate { get; set; }

        public string ExpiryDate { get; set; }

        public string PrimaryContactEmail { get; set; }

        public string SecondaryContactEmail { get; set; }

        public string Website { get; set; }

        public string Description { get; set; }

       public List<StorageFacilityViewModel> StorageFacilities { get; set; }
    }
}
