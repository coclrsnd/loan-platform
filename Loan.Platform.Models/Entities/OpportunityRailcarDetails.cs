using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace StandardRail.RailCarLounge.Models.Entities
{
    public class OpportunityRailcarDetails : EntityBase
    {
        public long Id { get; set; }

        public long OpportunityID { get; set; }

        public long? ExpectedNumberOfCars { get; set; }

        public long LEId { get; set; }

        public string Commodity { get; set; }

        public bool IsHazmat { get; set; }

        public long CarType { get; set; }

        public string RailcarIds { get; set; }        
    }
}
