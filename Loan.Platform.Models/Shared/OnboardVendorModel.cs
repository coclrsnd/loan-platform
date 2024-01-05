using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Loan.Platform.Models.Shared
{
    /// <summary>
    /// Hold Vendor Information to be saved in DB.
    /// </summary>
    public class OnboardVendorModel
    {
        public DataTable Vendor { get; set; }

        public DataTable StorageFacilities { get; set; }

        public DataTable StorageFacilitiesRates { get; set; }

        public DataTable StorageFacilitiesFeatures { get; set; }

        public DataTable StorageFacilitiesInterchanges { get; set; }

        public DataTable StorageFacilitiesInterchangeLocations { get; set; }
    }
}
