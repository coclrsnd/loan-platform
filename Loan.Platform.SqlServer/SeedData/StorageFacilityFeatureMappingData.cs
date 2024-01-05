using Microsoft.EntityFrameworkCore;
using StandardRail.RailCarLounge.Models.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace StandardRail.RailCarLounge.Data.SqlServer.SeedData
{
    public class StorageFacilityFeatureMappingData
    {
        public static void StorageFacilityFeatureMappingSeedData(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<StorageFacilityFeatureMapping>().HasData(new StorageFacilityFeatureMapping
            {
                Id = 1,
                StorageFacilityId = 1,
                StorageFeatureId = 1,
                IsActive = true,
                CreatedTime = DateTime.Now,
                CreatedBy = 1,
                ModifiedBy = 0,
                ModifiedTime = DateTime.Now,
                OrganizationId = 0,
                TenantId = 0,
            });

            modelBuilder.Entity<StorageFacilityFeatureMapping>().HasData(new StorageFacilityFeatureMapping
            {
                Id = 2,
                StorageFacilityId = 1,
                StorageFeatureId = 2,
                IsActive = true,
                CreatedTime = DateTime.Now,
                CreatedBy = 1,
                ModifiedBy = 0,
                ModifiedTime = DateTime.Now,
                OrganizationId = 0,
                TenantId = 0,
            });

            modelBuilder.Entity<StorageFacilityFeatureMapping>().HasData(new StorageFacilityFeatureMapping
            {
                Id = 3,
                StorageFacilityId = 1,
                StorageFeatureId = 3,
                IsActive = true,
                CreatedTime = DateTime.Now,
                CreatedBy = 1,
                ModifiedBy = 0,
                ModifiedTime = DateTime.Now,
                OrganizationId = 0,
                TenantId = 0,
            });

            modelBuilder.Entity<StorageFacilityFeatureMapping>().HasData(new StorageFacilityFeatureMapping
            {
                Id = 4,
                StorageFacilityId = 1,
                StorageFeatureId = 4,
                IsActive = true,
                CreatedTime = DateTime.Now,
                CreatedBy = 1,
                ModifiedBy = 0,
                ModifiedTime = DateTime.Now,
                OrganizationId = 0,
                TenantId = 0,
            });

            modelBuilder.Entity<StorageFacilityFeatureMapping>().HasData(new StorageFacilityFeatureMapping
            {
                Id = 5,
                StorageFacilityId = 2,
                StorageFeatureId = 5,
                IsActive = true,
                CreatedTime = DateTime.Now,
                CreatedBy = 1,
                ModifiedBy = 0,
                ModifiedTime = DateTime.Now,
                OrganizationId = 0,
                TenantId = 0,
            });

            modelBuilder.Entity<StorageFacilityFeatureMapping>().HasData(new StorageFacilityFeatureMapping
            {
                Id = 6,
                StorageFacilityId = 2,
                StorageFeatureId = 6,
                IsActive = true,
                CreatedTime = DateTime.Now,
                CreatedBy = 1,
                ModifiedBy = 0,
                ModifiedTime = DateTime.Now,
                OrganizationId = 0,
                TenantId = 0,
            });

            modelBuilder.Entity<StorageFacilityFeatureMapping>().HasData(new StorageFacilityFeatureMapping
            {
                Id = 7,
                StorageFacilityId = 2,
                StorageFeatureId = 7,
                IsActive = true,
                CreatedTime = DateTime.Now,
                CreatedBy = 1,
                ModifiedBy = 0,
                ModifiedTime = DateTime.Now,
                OrganizationId = 0,
                TenantId = 0,
            });

            modelBuilder.Entity<StorageFacilityFeatureMapping>().HasData(new StorageFacilityFeatureMapping
            {
                Id = 8,
                StorageFacilityId = 3,
                StorageFeatureId = 8,
                IsActive = true,
                CreatedTime = DateTime.Now,
                CreatedBy = 1,
                ModifiedBy = 0,
                ModifiedTime = DateTime.Now,
                OrganizationId = 0,
                TenantId = 0,
            });

            modelBuilder.Entity<StorageFacilityFeatureMapping>().HasData(new StorageFacilityFeatureMapping
            {
                Id = 9,
                StorageFacilityId = 3,
                StorageFeatureId = 9,
                IsActive = true,
                CreatedTime = DateTime.Now,
                CreatedBy = 1,
                ModifiedBy = 0,
                ModifiedTime = DateTime.Now,
                OrganizationId = 0,
                TenantId = 0,
            });

            modelBuilder.Entity<StorageFacilityFeatureMapping>().HasData(new StorageFacilityFeatureMapping
            {
                Id = 10,
                StorageFacilityId = 3,
                StorageFeatureId = 10,
                IsActive = true,
                CreatedTime = DateTime.Now,
                CreatedBy = 1,
                ModifiedBy = 0,
                ModifiedTime = DateTime.Now,
                OrganizationId = 0,
                TenantId = 0,
            });

            modelBuilder.Entity<StorageFacilityFeatureMapping>().HasData(new StorageFacilityFeatureMapping
            {
                Id = 11,
                StorageFacilityId = 4,
                StorageFeatureId = 1,
                IsActive = true,
                CreatedTime = DateTime.Now,
                CreatedBy = 1,
                ModifiedBy = 0,
                ModifiedTime = DateTime.Now,
                OrganizationId = 0,
                TenantId = 0,
            });

            modelBuilder.Entity<StorageFacilityFeatureMapping>().HasData(new StorageFacilityFeatureMapping
            {
                Id = 12,
                StorageFacilityId = 4,
                StorageFeatureId = 2,
                IsActive = true,
                CreatedTime = DateTime.Now,
                CreatedBy = 1,
                ModifiedBy = 0,
                ModifiedTime = DateTime.Now,
                OrganizationId = 0,
                TenantId = 0,
            });

            modelBuilder.Entity<StorageFacilityFeatureMapping>().HasData(new StorageFacilityFeatureMapping
            {
                Id = 13,
                StorageFacilityId = 5,
                StorageFeatureId = 3,
                IsActive = true,
                CreatedTime = DateTime.Now,
                CreatedBy = 1,
                ModifiedBy = 0,
                ModifiedTime = DateTime.Now,
                OrganizationId = 0,
                TenantId = 0,
            });

            modelBuilder.Entity<StorageFacilityFeatureMapping>().HasData(new StorageFacilityFeatureMapping
            {
                Id = 14,
                StorageFacilityId = 5,
                StorageFeatureId = 4,
                IsActive = true,
                CreatedTime = DateTime.Now,
                CreatedBy = 1,
                ModifiedBy = 0,
                ModifiedTime = DateTime.Now,
                OrganizationId = 0,
                TenantId = 0,
            });

            modelBuilder.Entity<StorageFacilityFeatureMapping>().HasData(new StorageFacilityFeatureMapping
            {
                Id = 15,
                StorageFacilityId = 6,
                StorageFeatureId = 6,
                IsActive = true,
                CreatedTime = DateTime.Now,
                CreatedBy = 1,
                ModifiedBy = 0,
                ModifiedTime = DateTime.Now,
                OrganizationId = 0,
                TenantId = 0,
            });

            modelBuilder.Entity<StorageFacilityFeatureMapping>().HasData(new StorageFacilityFeatureMapping
            {
                Id = 16,
                StorageFacilityId = 6,
                StorageFeatureId = 7,
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
