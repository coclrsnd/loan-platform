using System;

namespace StandardRail.RailCarLounge.Models.Entities
{
    public class SavedSearch : EntityBase
    {
        public long Id { get; set; }

        public string Name { get; set; }

        public string ScreenName { get; set; }

        public DateTime? LastRun { get; set; }

        public DateTime? EffectiveDate { get; set; }

        public DateTime? ExpiryDate { get; set; }

        public long SavedBy { get; set; }

        public string SearchCriteria { get; set; }

        public string NavigateUrl { get; set; }
    }
}
