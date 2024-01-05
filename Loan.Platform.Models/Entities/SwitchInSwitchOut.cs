using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace StandardRail.RailCarLounge.Models.Entities
{
    public class SwitchInSwitchOut
    {
        public List<RangeMaster> SwitchIn { get; set; }

        public List<RangeMaster> SwitchOut { get; set; }
    }
}
