using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Loan.Platform.Models.ViewModels
{
    public class OpportunitySummaryViewModel
    {
        public string StorageFacilityName { get; set; }

        public string DailyStorageRate { get; set; }

        public string InterchangeRR { get; set; }

        public string ApproxSpaces { get; set; }

        public string StartDate { get; set; }

        public string EndDate { get; set; } 

        public string TotalCars { get; set; }
    }
}
