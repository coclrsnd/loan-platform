using System;

namespace StandardRail.RailCarLounge.Models.Entities
{
    public class StorageFacility : EntityBase
    {
        public long Id { get; set; }

        public string Name { get; set; }

        public string Lat { get; set; }

        public string Long { get; set; }

        public int? Capacity { get; set; }

        public int? AvailableCars { get; set; }

        public double? Rating { get; set; }

        public string Address { get; set; }

        public string PrimaryContactNumber { get; set; }

        public string SecondaryContactNumber { get; set; }

        public string PrimaryEmail { get; set; }

        public string SecondaryEmail { get; set; }

        public string ZipCode { get; set; }

        public string City { get; set; }

        public long? StateId { get; set; }

        public long? CountryId { get; set; }

        public long VendorId { get; set; }

        public long? RegionId { get; set; }

        public DateTime EffectiveDate { get; set; }

        public DateTime ExpiryDate { get; set; }

        public string SPLC { get; set; }

        public int? Priority { get; set; }

        public string Description { get; set; }

        //Navigation Properties
        public virtual State State { get; set; }

        public virtual Country Country { get; set; }

        public virtual Vendor Vendor { get; set; }

        public virtual Region Region { get; set; }

        public string Mark { get; set; }

        public bool IsTrimbleVerified { get; set; }
    }
}
