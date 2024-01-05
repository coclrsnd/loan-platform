using Loan.Platform.Models.ViewModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Loan.Platform.Models.OpportunityOrderSummary
{
    public class OSModel
    {
        public string OrderNo { get; set; }
        public string BookingDate { get; set; }
        public string Company { get; set; }
        public string Name { get; set; }
        public string Address { get; set; }
        public string ContactNo { get; set; }
        public string Email { get; set; }
        public string StorageFacilityName { get; set; }
        public string InterchangeRR { get; set; }
        public string Vendor { get; set; }
        public string StartDate { get; set; }
        public string EndDate { get; set; }
        public string ApproxSpaces { get; set; }
        public List<OpportunityRailcarDetailsViewModel> OpportunityRailCars { get; set; }
        public List<OpportunityReservedSpacesTemplateModel> ReservedSpaceDetails { get; set; }

    }
}
