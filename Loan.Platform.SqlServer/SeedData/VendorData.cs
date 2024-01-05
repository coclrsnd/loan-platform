using Microsoft.EntityFrameworkCore;
using StandardRail.RailCarLounge.Models.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace StandardRail.RailCarLounge.Data.SqlServer.SeedData
{
    public class VendorData
    {
        public static void VendorSeedData(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Vendor>().HasData(new Vendor
            {
                Id = 1,
                ContactPersonName = "Vendor A",
                PrimaryContactNo = "1234567",
                SecondaryContactNo = "22220",
                Organization = "Test Org",
                Address = "Test Addr",
                ZipCode = "111",
                City = "test city",
                StateId = null,
                CountryId = null,
                EffectiveDate = DateTime.Now,
                ExpiryDate = DateTime.Now.AddDays(3000),
                PrimaryContactEmail = "test@gmail.com",
                SecondaryContactEmail = "testc@gmail.com",
                Website = "testwebsite",
                Description = "test desc",
                IsActive = true,
                CreatedTime = DateTime.Now,
                CreatedBy = 1,
                ModifiedBy = 0,
                ModifiedTime = DateTime.Now,
                OrganizationId = 0,
                TenantId = 0
            });

            modelBuilder.Entity<Vendor>().HasData(new Vendor
            {
                Id = 2,
                ContactPersonName = "Vendor B",
                PrimaryContactNo = "1234567",
                SecondaryContactNo = "22220",
                Organization = "Test Org",
                Address = "Test Addr",
                ZipCode = "111",
                City = "test city",
                StateId = null,
                CountryId = null,
                EffectiveDate = DateTime.Now,
                ExpiryDate = DateTime.Now.AddDays(3000),
                PrimaryContactEmail = "test1@gmail.com",
                SecondaryContactEmail = "testc1@gmail.com",
                Website = "testwebsite",
                Description = "test desc",
                IsActive = true,
                CreatedTime = DateTime.Now,
                CreatedBy = 1,
                ModifiedBy = 0,
                ModifiedTime = DateTime.Now,
                OrganizationId = 0,
                TenantId = 0
            });

            modelBuilder.Entity<Vendor>().HasData(new Vendor
            {
                Id = 3,
                ContactPersonName = "Matt Vendor",
                PrimaryContactNo = "1234567",
                SecondaryContactNo = "22220",
                Organization = "Test Org",
                Address = "Test Addr",
                ZipCode = "111",
                City = "test city",
                StateId = null,
                CountryId = null,
                EffectiveDate = DateTime.Now,
                ExpiryDate = DateTime.Now.AddDays(3000),
                PrimaryContactEmail = "test1@gmail.com",
                SecondaryContactEmail = "testc1@gmail.com",
                Website = "testwebsite",
                Description = "test desc",
                IsActive = true,
                CreatedTime = DateTime.Now,
                CreatedBy = 1,
                ModifiedBy = 0,
                ModifiedTime = DateTime.Now,
                OrganizationId = 0,
                TenantId = 0
            });

            modelBuilder.Entity<Vendor>().HasData(new Vendor
            {
                Id = 4,
                ContactPersonName = "Steve Vendor",
                PrimaryContactNo = "1234567",
                SecondaryContactNo = "22220",
                Organization = "Test Org",
                Address = "Test Addr",
                ZipCode = "111",
                City = "test city",
                StateId = null,
                CountryId = null,
                EffectiveDate = DateTime.Now,
                ExpiryDate = DateTime.Now.AddDays(3000),
                PrimaryContactEmail = "test1@gmail.com",
                SecondaryContactEmail = "testc1@gmail.com",
                Website = "testwebsite",
                Description = "test desc",
                IsActive = true,
                CreatedTime = DateTime.Now,
                CreatedBy = 1,
                ModifiedBy = 0,
                ModifiedTime = DateTime.Now,
                OrganizationId = 0,
                TenantId = 0
            });
        }
    }
}


