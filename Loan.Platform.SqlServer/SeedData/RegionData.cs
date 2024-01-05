using System.Collections.Generic;
using System.Text.Json;
using Microsoft.EntityFrameworkCore;
using StandardRail.RailCarLounge.Models.Entities;

namespace StandardRail.RailCarLounge.Data.SqlServer.SeedData
{
    public static class RegionData
    {
        public static void RegionSeedData(ModelBuilder modelBuilder)
        {
            var jsonRegionList = Resource.Region;
            var regions = JsonSerializer.Deserialize<List<Region>>(jsonRegionList);
            modelBuilder.Entity<Region>().HasData(regions);
        }
    }
}
