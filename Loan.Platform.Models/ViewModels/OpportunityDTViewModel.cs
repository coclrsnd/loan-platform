using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Loan.Platform.Models.ViewModels
{
    public class OpportunityDTViewModel
    {
        public DataTable Opportunity { get; set; }

        public DataTable OpportunityRailcarDetails { get; set; }

        public DataTable OpportunityAttachments { get; set; }
    }
}
