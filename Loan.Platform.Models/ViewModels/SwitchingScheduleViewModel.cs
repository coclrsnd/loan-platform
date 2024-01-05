using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Loan.Platform.Models.ViewModels
{
    public class SwitchingScheduleViewModel
    {
        public long Id { get; set; }

        public long StorageFacilityId { get; set; }

        public long RailRoadId { get; set; }

        public bool? OnMonday { get; set; }

        public bool? OnTuesday { get; set; }

        public bool? OnWednesday { get; set; }

        public bool? OnThursday { get; set; }

        public bool? OnFriday { get; set; }

        public bool? OnSaturday { get; set; }

        public bool? OnSunday { get; set; }
    }
}
