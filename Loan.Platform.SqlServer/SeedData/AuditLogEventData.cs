using Microsoft.EntityFrameworkCore;
using Loan.Platform.Models.Entities;

namespace Loan.Platform.Data.SqlServer.SeedData
{
    public static class AuditLogEventData
    {
        public static void AuditLogEventSeedData(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<AuditLogEvent>().HasData(
            new AuditLogEvent
            {
                Id = 1,
                Name = "Storage Order Created",
                Description = "Storage Order Created"
            });

            modelBuilder.Entity<AuditLogEvent>().HasData(
            new AuditLogEvent
            {
                Id = 2,
                Name = "Storage Order Updated",
                Description = "Storage Order Updated"
            });

            modelBuilder.Entity<AuditLogEvent>().HasData(
            new AuditLogEvent
            {
                Id = 3,
                Name = "Storage Order Expired",
                Description = "Storage Order Expired"
            });

            modelBuilder.Entity<AuditLogEvent>().HasData(
            new AuditLogEvent
            {
                Id = 4,
                Name = "Rail Car Added",
                Description = "Rail Car Added"
            });

            modelBuilder.Entity<AuditLogEvent>().HasData(
            new AuditLogEvent
            {
                Id = 5,
                Name = "Rail Car Arrived",
                Description = "Rail Car Arrived"
            });

            modelBuilder.Entity<AuditLogEvent>().HasData(
            new AuditLogEvent
            {
                Id = 6,
                Name = "Rail Car Departed",
                Description = "Rail Car Departed"
            });

            modelBuilder.Entity<AuditLogEvent>().HasData(
            new AuditLogEvent
            {
                Id = 7,
                Name = "Notes Added",
                Description = "Notes Added"
            });

            modelBuilder.Entity<AuditLogEvent>().HasData(
            new AuditLogEvent
            {
                Id = 8,
                Name = "Attachment Added",
                Description = "Attachment Added"
            });

            modelBuilder.Entity<AuditLogEvent>().HasData(
          new AuditLogEvent
          {
              Id = 9,
              Name = "Rail Car Updated",
              Description = "Rail Car Updated"
          });
        }
    }
}
