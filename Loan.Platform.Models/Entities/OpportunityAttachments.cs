using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace StandardRail.RailCarLounge.Models.Entities
{
    public class OpportunityAttachments : EntityBase
    {
        public long Id { get; set; }

        public long OpportunityId { get; set; }

        public string Name { get; set; }

        public string Path { get; set; }

    }
}
