using System;
using Microsoft.EntityFrameworkCore;
using StandardRail.RailCarLounge.Models.Entities;

namespace StandardRail.RailCarLounge.Data.SqlServer.SeedData
{
    public static class ContractTypeData
    {
        public static void ContractTypeSeedData(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<ContractType>().HasData(new ContractType
            {
                Id = 1,
                Name = "Take or Pay",
                IsActive = true,
                CreatedTime = DateTime.Now,
                CreatedBy = 1,
                ModifiedBy = 1,
                ModifiedTime = DateTime.Now,
                OrganizationId = 0,
                TenantId = 1,
            });

            modelBuilder.Entity<ContractType>().HasData(new ContractType
            {
                Id = 2,
                Name = "Reserve",
                IsActive = true,
                CreatedTime = DateTime.Now,
                CreatedBy = 1,
                ModifiedBy = 1,
                ModifiedTime = DateTime.Now,
                OrganizationId = 0,
                TenantId = 1,
            });

            modelBuilder.Entity<ContractType>().HasData(new ContractType
            {
                Id = 3,
                Name = "Open",
                IsActive = true,
                CreatedTime = DateTime.Now,
                CreatedBy = 1,
                ModifiedBy = 1,
                ModifiedTime = DateTime.Now,
                OrganizationId = 0,
                TenantId = 1,
            });

        }
    }
}