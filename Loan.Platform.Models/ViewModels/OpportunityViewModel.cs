using System.Collections.Generic;

namespace Loan.Platform.Models.ViewModels
{
    public class OpportunityViewModel
    {
        public long Id { get; set; }

        public string Name { get; set; }

        public string StartDate { get; set; }

        public string EndDate { get; set; }

        public long BookingStatus { get; set; }

        public string AgreementPath { get; set; }

        public long VendorId { get; set; }

        public long OrganizationId { get; set; }

        public long FacilityId { get; set; }

        public long? TotalNoApproxSpaces { get; set; }

        public long? TotalNoReservedSpaces { get; set; }

        public string BookingDate { get; set; }

        public long? CustomerId { get; set; }

        public List<OpportunityRailcarDetailsViewModel> OpportunityRailCars { get; set; }

        public List<OpportunityAttachmentViewModel> OpportunityAttachments { get; set; }
    }
}
