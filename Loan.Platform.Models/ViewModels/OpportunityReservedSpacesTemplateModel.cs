using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Loan.Platform.Models.ViewModels
{
    public class OpportunityReservedSpacesTemplateModel
    {
        public long Id { get; set; }

        public long OpportunityId { get; set; }

        public long ReservedSpaces { get; set; }

        public string EffectiveDate { get; set; }

        public string ExpirationDate { get; set; }

        public bool IsActive { get; set; } = true;
    }
}
