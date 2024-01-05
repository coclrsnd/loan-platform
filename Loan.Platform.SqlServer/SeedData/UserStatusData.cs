using Microsoft.EntityFrameworkCore;
using Loan.Platform.Models.Entities;

namespace Loan.Platform.Data.SqlServer.SeedData
{
    public static class UserStatusData
    {
        public static void UserStatusSeedData(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<UserStatus>().HasData(new UserStatus
            {
                Id = 1,
                Name = "Pending",
                Description = "Email verification pending by user.",
                IsActive = true,
            });

            modelBuilder.Entity<UserStatus>().HasData(new UserStatus
            {
                Id = 2,
                Name = "Verified",
                Description = "Email verified by user.",
                IsActive = true,
            });

            modelBuilder.Entity<UserStatus>().HasData(new UserStatus
            {
                Id = 3,
                Name = "Rejected",
                Description = "Signup rejected.",
                IsActive = true,
            });

            modelBuilder.Entity<UserStatus>().HasData(new UserStatus
            {
                Id = 4,
                Name = "Approved",
                Description = "Signup approved.",
                IsActive = true,
            });
        }
    }
}
