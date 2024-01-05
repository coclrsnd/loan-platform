using System.Collections.Generic;

namespace Loan.Platform.Models.ViewModels
{
    public class VendorSearchGridViewModel
    {
        public long Id { get; set; }

        public string Vendor { get; set; }

        public long StorageFacilityId { get; set; }

        public string Facility { get; set; }

        public string Location { get; set; }

        public string Interchanges { get; set; }

        public long ContractedSpace { get; set; }

        public long CarsStored { get; set; }

        public double TotalAmount { get; set; }

        public double AVGMonthlyCost { get; set; }

        public double AVGCarCost { get; set; }

        public List<VendorSearchGridViewModel> VendorChildData { get; set; }
    }
}
