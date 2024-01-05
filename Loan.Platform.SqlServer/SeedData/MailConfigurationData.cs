using Microsoft.EntityFrameworkCore;
using StandardRail.RailCarLounge.Models.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.Json;
using System.Threading.Tasks;

namespace StandardRail.RailCarLounge.Data.SqlServer.SeedData
{
    public static class MailConfigurationData
    {

        public static void NotificationEventSeedData(ModelBuilder modelBuilder)
        {
            var jsonMailConfigurationList = Resource.NotificationEvents;
            var mailConfigurations = JsonSerializer.Deserialize<List<MailConfiguration>>(jsonMailConfigurationList);
            modelBuilder.Entity<MailConfiguration>().HasData(mailConfigurations);
        }
    }
}
