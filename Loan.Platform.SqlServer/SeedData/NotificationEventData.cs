using System.Collections.Generic;
using System.Text.Json;
using Microsoft.EntityFrameworkCore;
using StandardRail.RailCarLounge.Models.Entities;

namespace StandardRail.RailCarLounge.Data.SqlServer.SeedData
{
    public static class NotificationEventData
    {
        public static void NotificationEventSeedData(ModelBuilder modelBuilder)
        {
            var jsonNotificationEventList = Resource.NotificationEvents;
            var regions = JsonSerializer.Deserialize<List<NotificationEvent>>(jsonNotificationEventList);
            modelBuilder.Entity<NotificationEvent>().HasData(regions);
        }
    }
}
