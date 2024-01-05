namespace Loan.Platform.Models.ViewModels
{
    public class OpportunityFeaturesViewModel
    {
        public long Id { get; set; }

        public long OpportunityId { get; set; }

        public long FeatureId { get; set; }

        public bool IsActive { get; set; }

        public string Comments { get; set; }
    }
}
