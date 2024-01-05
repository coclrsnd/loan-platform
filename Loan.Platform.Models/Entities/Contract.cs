using System;
using Microsoft.EntityFrameworkCore;

namespace StandardRail.RailCarLounge.Models.Entities
{
    public class Contract : EntityBase
    {
        public long Id { get; set; }

        public long VendorId { get; set; }

        public long CustomerId { get; set; }

        public string Rider { get; set; }

        public long StorageFacilityId { get; set; }

        public DateTime EffectiveDate { get; set; }

        public DateTime? ExpiryDate { get; set; }

        public long? ContractTypeId { get; set; }

        public int? TotalCars { get; set; }

        public short? CurrencyId { get; set; }

        public string Description { get; set; }

        public string Location { get; set; }

        public long CarsStored { get; set; }

        public bool IsFlatRateContract { get; set; }

        //Navigation properties
        public ContractType ContractType { get; set; }

        public Currency Currency { get; set; }


        public StorageFacility StorageFacility { get; set; }

        public int? ReservedSpaces { get; set; }
    }
}
