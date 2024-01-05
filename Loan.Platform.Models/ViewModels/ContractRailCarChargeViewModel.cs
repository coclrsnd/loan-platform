using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Loan.Platform.Models.ViewModels
{
    public class ContractRailCarChargeViewModel
    {
        public long Id { get; set; }

        public long ContractRailCarMappingId { get; set; }

        public decimal? Amount { get; set; }

        public string Title { get; set; }

        public string Date { get; set; }

        public bool IsActive { get; set; }
    }
}
