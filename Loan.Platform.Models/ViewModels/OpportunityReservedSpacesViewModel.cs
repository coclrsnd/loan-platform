using System;

namespace Loan.Platform.Models.ViewModels
{
    public class OpportunityReservedSpacesViewModel
    {
        public long Id { get; set; }

        public long OpportunityId { get; set; }

        public long ReservedSpaces { get; set; }

        public DateTime EffectiveDate { get; set; }

        public DateTime ExpirationDate { get; set; }

        public bool IsActive { get; set; } = true;
    }
}
