using Microsoft.EntityFrameworkCore;
using StandardRail.RailCarLounge.Models.Entities;

namespace StandardRail.RailCarLounge.Data.SqlServer.SeedData
{
    public static class RailRoadData
    {
        public static void RailRoadSeedData(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<RailRoad>().HasData(new RailRoad
            {
                Id = 1,
                Name = "ABC",
                MarkCode = "ABC Number"
            });

            modelBuilder.Entity<RailRoad>().HasData(new RailRoad
            {
                Id = 2,
                Name = "XYZ",
                MarkCode = "XYZ Number"
            });
        }
    }
}
