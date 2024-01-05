
namespace StandardRail.RailCarLounge.Models.Entities
{
    public class OpportunityFeatures : EntityBase
    {
        public long Id { get; set; }

        public long OpportunityId { get; set; }

        public long FeatureId { get; set; }

        public string Comments { get; set; }

    }
}
