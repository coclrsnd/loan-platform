using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace StandardRail.RailCarLounge.Models.Entities
{
    public class Opportunity : EntityBase
    {
        public long Id { get; set; }

        public string Name { get; set; }

        public DateTime StartDate { get; set; }

        public DateTime EndDate { get; set; }

        public long BookingStatus { get; set; }

        public string AgreementPath { get; set; }

        public long VendorId { get; set; }

        public long CustomerId { get; set; }

        public long FacilityId { get; set; }

    }
}
