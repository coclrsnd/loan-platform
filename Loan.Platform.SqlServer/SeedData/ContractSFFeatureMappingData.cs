using Microsoft.EntityFrameworkCore;
using StandardRail.RailCarLounge.Models.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace StandardRail.RailCarLounge.Data.SqlServer.SeedData
{
    public class ContractSFFeatureMappingData
    {
        public static void ContractSFFeatureMappingDataSeedData(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<ContractSFFeatureMapping>().HasData(new ContractSFFeatureMapping
            {
                Id = 1,
                StorageFacilityid = 1,
                StorageFeatureId = 1,
                ContractId = 1,
                IsActive = true,
                CreatedTime = DateTime.Now,
                CreatedBy = 1,
                ModifiedBy = 0,
                ModifiedTime = DateTime.Now,
                OrganizationId = 0,
                TenantId = 0,
            });

            modelBuilder.Entity<ContractSFFeatureMapping>().HasData(new ContractSFFeatureMapping
            {
                Id = 2,
                StorageFacilityid = 1,
                StorageFeatureId = 2,
                ContractId = 1,
                IsActive = true,
                CreatedTime = DateTime.Now,
                CreatedBy = 1,
                ModifiedBy = 0,
                ModifiedTime = DateTime.Now,
                OrganizationId = 0,
                TenantId = 0,
            });

            modelBuilder.Entity<ContractSFFeatureMapping>().HasData(new ContractSFFeatureMapping
            {
                Id = 3,
                StorageFacilityid = 2,
                StorageFeatureId = 5,
                ContractId = 2,
                IsActive = true,
                CreatedTime = DateTime.Now,
                CreatedBy = 1,
                ModifiedBy = 0,
                ModifiedTime = DateTime.Now,
                OrganizationId = 0,
                TenantId = 0,
            });

            modelBuilder.Entity<ContractSFFeatureMapping>().HasData(new ContractSFFeatureMapping
            {
                Id = 4,
                StorageFacilityid = 2,
                StorageFeatureId = 6,
                ContractId = 2,
                IsActive = true,
                CreatedTime = DateTime.Now,
                CreatedBy = 1,
                ModifiedBy = 0,
                ModifiedTime = DateTime.Now,
                OrganizationId = 0,
                TenantId = 0,
            });
        }



    }
}
