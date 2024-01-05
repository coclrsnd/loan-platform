using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Loan.Platform.Models.ViewModels
{
    public class OpportunityRailcarDetailsViewModel 
    {
        public long Id { get; set; }

        public long? ExpectedNumberOfCars { get; set; }

        public long OpportunityID { get; set; }

        public long LEId { get; set; }

        public string LandE { get; set; }

        public string Commodity { get; set; }

        public bool IsHazmat { get; set; }

        public string Hazmat { get; set; }        

        public long CarType { get; set; }

        public string CarTypeName { get; set; }

        public string RailCarIds { get; set; }

        public bool IsActive { get; set; }
    }
}
