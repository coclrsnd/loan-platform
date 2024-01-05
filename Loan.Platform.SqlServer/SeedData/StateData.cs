using Microsoft.EntityFrameworkCore;
using StandardRail.RailCarLounge.Models.Entities;
using System.Collections.Generic;
using System.Text.Json;

namespace StandardRail.RailCarLounge.Data.SqlServer.SeedData
{
    public static class StateData
    {
        public static void StateSeedData(ModelBuilder modelBuilder)
        {
            var jsonStateList = Resource.States;
            var states = JsonSerializer.Deserialize<List<State>>(jsonStateList);
            modelBuilder.Entity<State>().HasData(states);
        }
    }
}
