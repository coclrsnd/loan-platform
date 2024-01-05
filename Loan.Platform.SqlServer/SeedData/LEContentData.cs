using System;
using Microsoft.EntityFrameworkCore;
using StandardRail.RailCarLounge.Models.Entities;

namespace StandardRail.RailCarLounge.Data.SqlServer.SeedData
{
    public static class LEContentData
    {
        public static void LEContentSeedData(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<LEContent>().HasData(new LEContent
            {
                Id = 1,
                Name = "Loaded",
                Description = "",
                IsActive = true,
                CreatedTime = DateTime.Now,
                CreatedBy = 1,
                ModifiedBy = 1,
                ModifiedTime = DateTime.Now,
                OrganizationId = 0,
                TenantId = 0,
            });

            modelBuilder.Entity<LEContent>().HasData(new LEContent
            {
                Id = 2,
                Name = "Empty",
                Description = "",
                IsActive = true,
                CreatedTime = DateTime.Now,
                CreatedBy = 1,
                ModifiedBy = 1,
                ModifiedTime = DateTime.Now,
                OrganizationId = 0,
                TenantId = 0,
            });

            modelBuilder.Entity<LEContent>().HasData(new LEContent
            {
                Id = 3,
                Name = "Empty Residue",
                Description = "",
                IsActive = true,
                CreatedTime = DateTime.Now,
                CreatedBy = 1,
                ModifiedBy = 1,
                ModifiedTime = DateTime.Now,
                OrganizationId = 0,
                TenantId = 0,
            });

        }
    }
}
