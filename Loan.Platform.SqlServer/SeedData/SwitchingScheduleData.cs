using Microsoft.EntityFrameworkCore;
using StandardRail.RailCarLounge.Models.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace StandardRail.RailCarLounge.Data.SqlServer.SeedData
{
    public static class SwitchingScheduleData
    {
        public static void SwitchingScheduleSeedData(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<SwitchingSchedule>().HasData(new SwitchingSchedule
            {
                Id = 1,
                OnFriday = true,
                OnMonday = false,
                OnTuesday = true,
                OnWednesday = true,
                OnThursday = false,
                OnSaturday = true,
                OnSunday = false,
                StorageFacilityId =1,
                RailRoadId =1
            });

            modelBuilder.Entity<SwitchingSchedule>().HasData(new SwitchingSchedule
            {
                Id = 2,
                OnFriday = true,
                OnMonday = false,
                OnTuesday = true,
                OnWednesday = true,
                OnThursday = false,
                OnSaturday = true,
                OnSunday = false,
                StorageFacilityId = 2,
                RailRoadId=2
            });
        }
    }
}
