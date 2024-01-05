using Microsoft.EntityFrameworkCore;
using Loan.Platform.Models.UserManagementModels;

namespace Loan.Platform.Data.SqlServer.SeedData
{
    public static class UserTypesData
    {
        public static void UserTypesSeedData(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<UserType>().HasData(new UserType
            {
                Id = 1,
                Name = "Vendor",
                Description = "Vendor access application user.",
                IsActive = true,
            });

            modelBuilder.Entity<UserType>().HasData(new UserType
            {
                Id = 2,
                Name = "Customer",
                Description = "Customer access application user.",
                IsActive = true,
            });

            modelBuilder.Entity<UserType>().HasData(new UserType
            {
                Id = 3,
                Name = "Both",
                Description = "Vendor and Customer access application user.",
                IsActive = true,
            });
        }
    }
}
