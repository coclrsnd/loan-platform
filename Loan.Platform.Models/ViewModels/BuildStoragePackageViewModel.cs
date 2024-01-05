using System.Collections.Generic;

namespace Loan.Platform.Models.ViewModels
{
    public class BuildStoragePackageViewModel
    {
        public List<OpportunityReservedSpacesViewModel> OpportunityReservedSpaces { get; set; }

        public IList<OpportunityFeaturesViewModel> OpportunityFeaturesModels { get; set; }
    }
}
