using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Loan.Platform.Models.ViewModels
{
    public class ContractFilterViewModel
    {
        public int CustomerId { get; set; }

        public int VendorId { get; set; }

        public List<int> StorageFeatureIds { get; set; }

        public string Rider { get; set; }

        public string EffectiveDate { get; set; }

        public string ExpiryDate { get; set; }

        public decimal? SwitchInMin { get; set; }

        public decimal? SwitchInMax { get; set; }

        public decimal? SwitchOutMin { get; set; }

        public decimal? SwitchOutMax { get; set; }

        public int? CurrencyId { get; set; }

    }
}
