using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Loan.Platform.Models.ViewModels
{
    public class ContractDTViewModel
    {
        public DataTable Contract { get; set; }

        public DataTable ContractRates { get; set; }

        public DataTable ContractSFFeatureMapping { get; set; }
    }
}
