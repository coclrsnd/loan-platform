namespace StandardRail.RailCarLounge.Models.Entities
{
    public class StorageFacilityFeatureMapping : EntityBase
    {
        public long Id { get; set; }

        public long StorageFacilityId { get; set; }

        public long StorageFeatureId { get; set; }

        //Navigation Properties

        public virtual StorageFacility StorageFacility { get; set; }

        public virtual StorageFeature StorageFeature { get; set; }
    }
}
