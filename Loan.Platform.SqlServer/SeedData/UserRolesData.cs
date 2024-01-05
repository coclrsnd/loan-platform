using Microsoft.EntityFrameworkCore;
using Loan.Platform.Models.UserManagementModels;

namespace Loan.Platform.Data.SqlServer.SeedData
{
    public class UserRolesData
    {
        public static void UserRolesSeedData(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<UserRoles>().HasData(new UserRoles
            {
                Id = 1,
                Name = "SuperAdmin",
                Description = "SuperAdmin",
                IsActive = true,
            });

            modelBuilder.Entity<UserRoles>().HasData(new UserRoles
            {
                Id = 2,
                Name = "Admin",
                Description = "Admin",
                IsActive = true,
            });

            modelBuilder.Entity<UserRoles>().HasData(new UserRoles
            {
                Id = 3,
                Name = "Customer",
                Description = "Customer",
                IsActive = true,
            });

            modelBuilder.Entity<UserRoles>().HasData(new UserRoles
            {
                Id = 4,
                Name = "Vendor",
                Description = "Vendor",
                IsActive = true,
            });
        }
    }
}
