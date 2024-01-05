using System.Collections.Generic;
using System.Text.Json;
using Microsoft.EntityFrameworkCore;
using StandardRail.RailCarLounge.Models.Entities;

namespace StandardRail.RailCarLounge.Data.SqlServer.SeedData
{
    public static class RailCarTypeData
    {
        public static void RailCarTypeSeedData(ModelBuilder modelBuilder)
        {
            var jsonRailcarTypeList = Resource.RailcarTypes;
            var railCarTypes = JsonSerializer.Deserialize<List<RailCarType>>(jsonRailcarTypeList);
            modelBuilder.Entity<RailCarType>().HasData(railCarTypes);
        }
    }
}
