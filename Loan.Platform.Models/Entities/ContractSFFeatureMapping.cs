namespace StandardRail.RailCarLounge.Models.Entities
{
    public class ContractSFFeatureMapping : EntityBase
    {
        public long Id { get; set; }

        public long ContractId { get; set; }
        public long StorageFacilityid { get; set; }

        public long StorageFeatureId { get; set; }

        //Navigation Properties

        //public virtual StorageFacility StorageFacility { get; set; }

        public virtual StorageFeature StorageFeature { get; set; }

        public virtual Contract Contract { get; set; }
    }
}
