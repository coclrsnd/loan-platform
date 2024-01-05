using System;
using Microsoft.EntityFrameworkCore;
using StandardRail.RailCarLounge.Models.Entities;

namespace StandardRail.RailCarLounge.Data.SqlServer.SeedData
{
    public static class StorageFeatureData
    {
        public static void StorageFeatureSeedData(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<StorageFeature>().HasData(new StorageFeature
            {
                Id = 1,
                Name = "Hazmat Cars",
                Description = "Hazmat Cars",
                IsActive = true,
                CreatedTime = DateTime.Now,
                CreatedBy = 1,
                ModifiedBy = 1,
                ModifiedTime = DateTime.Now,
                OrganizationId = 0,
                TenantId = 0,
            });
            modelBuilder.Entity<StorageFeature>().HasData(new StorageFeature
            {
                Id = 2,
                Name = "Loaded Cars",
                Description = "Loaded Cars",
                IsActive = true,
                CreatedTime = DateTime.Now,
                CreatedBy = 1,
                ModifiedBy = 1,
                ModifiedTime = DateTime.Now,
                OrganizationId = 0,
                TenantId = 0,
            });
            modelBuilder.Entity<StorageFeature>().HasData(new StorageFeature
            {
                Id = 3,
                Name = "Cherrypicking",
                Description = "Cherrypicking",
                IsActive = true,
                CreatedTime = DateTime.Now,
                CreatedBy = 1,
                ModifiedBy = 1,
                ModifiedTime = DateTime.Now,
                OrganizationId = 0,
                TenantId = 0,
            });
            modelBuilder.Entity<StorageFeature>().HasData(new StorageFeature
            {
                Id = 4,
                Name = "Secured Facility",
                Description = "Secured Facility",
                IsActive = true,
                CreatedTime = DateTime.Now,
                CreatedBy = 1,
                ModifiedBy = 1,
                ModifiedTime = DateTime.Now,
                OrganizationId = 0,
                TenantId = 0,
            });

            modelBuilder.Entity<StorageFeature>().HasData(new StorageFeature
            {
                Id = 5,
                Name = "Scrapping",
                Description = "Scrapping",
                IsActive = true,
                CreatedTime = DateTime.Now,
                CreatedBy = 1,
                ModifiedBy = 1,
                ModifiedTime = DateTime.Now,
                OrganizationId = 0,
                TenantId = 0,
            });

            modelBuilder.Entity<StorageFeature>().HasData(new StorageFeature
            {
                Id = 6,
                Name = "Repair",
                Description = "Repair",
                IsActive = true,
                CreatedTime = DateTime.Now,
                CreatedBy = 1,
                ModifiedBy = 1,
                ModifiedTime = DateTime.Now,
                OrganizationId = 0,
                TenantId = 0,
            });

            modelBuilder.Entity<StorageFeature>().HasData(new StorageFeature
            {
                Id = 7,
                Name = "Mechanical",
                Description = "Mechanical",
                IsActive = true,
                CreatedTime = DateTime.Now,
                CreatedBy = 1,
                ModifiedBy = 1,
                ModifiedTime = DateTime.Now,
                OrganizationId = 0,
                TenantId = 0,
            });

            modelBuilder.Entity<StorageFeature>().HasData(new StorageFeature
            {
                Id = 8,
                Name = "Cleaning",
                Description = "Cleaning",
                IsActive = true,
                CreatedTime = DateTime.Now,
                CreatedBy = 1,
                ModifiedBy = 1,
                ModifiedTime = DateTime.Now,
                OrganizationId = 0,
                TenantId = 0,
            });

            modelBuilder.Entity<StorageFeature>().HasData(new StorageFeature
            {
                Id = 9,
                Name = "Recertification",
                Description = "Recertification",
                IsActive = true,
                CreatedTime = DateTime.Now,
                CreatedBy = 1,
                ModifiedBy = 1,
                ModifiedTime = DateTime.Now,
                OrganizationId = 0,
                TenantId = 0,
            });

            modelBuilder.Entity<StorageFeature>().HasData(new StorageFeature
            {
                Id = 10,
                Name = "Stripe Aligning",
                Description = "Stripe Aligning",
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
