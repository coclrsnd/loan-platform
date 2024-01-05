using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Loan.Platform.Models.ViewModels
{
    public class VendorFilterViewModel
    {
        public long OrganizationId { get; set; }

        public string Organization { get; set; }

        public long StorageFacilityId { get; set; }

        public long InterchangeId { get; set; }

        public long CountryId { get; set; }

        public long StateId { get; set; }

        public List<string> City { get; set; }

       // public PaginationModel Pagination { get; set; }

        public List<VendorSearchGridViewModel> VendorGridData { get; set; }

       // public SortingModel Sorting { get; set; }
       public VendorRibbon VendorRibbon { get; set; }
}
}
