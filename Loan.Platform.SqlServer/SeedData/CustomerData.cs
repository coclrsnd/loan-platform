using Microsoft.EntityFrameworkCore;
using StandardRail.RailCarLounge.Models.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace StandardRail.RailCarLounge.Data.SqlServer.SeedData
{
    public static class CustomerData
    {
        public static void CustomerSeedData(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Customer>().HasData(new Customer
            {
                Id = 1,
                CustomerUserId = Guid.NewGuid(),
                Name = "James",
                PrimaryContactNo = "1234567",
                SecondaryContactNo = "22220",
                //Organization = "Test Org",
                Subsidary = "Test Subs",
                Address = "Test Addr",
                ZipCode = "111",
                City = "test city",
                StateId = null,
                CountryId = null,
                EffectiveDate = DateTime.Now,
                ExpiryDate = DateTime.Now.AddDays(3000),
                PrimaryContactEmail = "testcust1@gmail.com",
                SecondaryContactEmail = "testc1@gmail.com",
                Website = "testwebsite",
                Description = "test desc",
                IsActive = true,
                CreatedTime = DateTime.Now,
                CreatedBy = 1,
                ModifiedBy = 0,
                ModifiedTime = DateTime.Now,
                OrganizationId = 1,
                TenantId = 0,
            });

            modelBuilder.Entity<Customer>().HasData(new Customer
            {
                Id = 2,
                CustomerUserId = Guid.NewGuid(),
                Name = "Austin",
                PrimaryContactNo = "1234567",
                SecondaryContactNo = "22220",
                //Organization = "Test Org",
                Subsidary = "Test Subs",
                Address = "Test Addr",
                ZipCode = "111",
                City = "test city",
                StateId = null,
                CountryId = null,
                EffectiveDate = DateTime.Now,
                ExpiryDate = DateTime.Now.AddDays(3000),
                PrimaryContactEmail = "testcust2@gmail.com",
                SecondaryContactEmail = "testc2@gmail.com",
                Website = "testwebsite",
                Description = "test desc",
                IsActive = true,
                CreatedTime = DateTime.Now,
                CreatedBy = 1,
                ModifiedBy = 0,
                ModifiedTime = DateTime.Now,
                OrganizationId = 1,
                TenantId = 0,
            });

            modelBuilder.Entity<Customer>().HasData(new Customer
            {
                Id = 3,
                CustomerUserId = Guid.NewGuid(),
                Name = "Steve",
                PrimaryContactNo = "1234567",
                SecondaryContactNo = "22220",
                //Organization = "Test Org",
                Subsidary = "Test Subs",
                Address = "Test Addr",
                ZipCode = "111",
                City = "test city",
                StateId = null,
                CountryId = null,
                EffectiveDate = DateTime.Now,
                ExpiryDate = DateTime.Now.AddDays(3000),
                PrimaryContactEmail = "testcust2@gmail.com",
                SecondaryContactEmail = "testc2@gmail.com",
                Website = "testwebsite",
                Description = "test desc",
                IsActive = true,
                CreatedTime = DateTime.Now,
                CreatedBy = 1,
                ModifiedBy = 0,
                ModifiedTime = DateTime.Now,
                OrganizationId = 1,
                TenantId = 0,
            });

            modelBuilder.Entity<Customer>().HasData(new Customer
            {
                Id = 4,
                CustomerUserId = Guid.NewGuid(),
                Name = "Martin",
                PrimaryContactNo = "1234567",
                SecondaryContactNo = "22220",
                //Organization = "Test Org",
                Subsidary = "Test Subs",
                Address = "Test Addr",
                ZipCode = "111",
                City = "test city",
                StateId = null,
                CountryId = null,
                EffectiveDate = DateTime.Now,
                ExpiryDate = DateTime.Now.AddDays(3000),
                PrimaryContactEmail = "testcust2@gmail.com",
                SecondaryContactEmail = "testc2@gmail.com",
                Website = "testwebsite",
                Description = "test desc",
                IsActive = true,
                CreatedTime = DateTime.Now,
                CreatedBy = 1,
                ModifiedBy = 0,
                ModifiedTime = DateTime.Now,
                OrganizationId = 1,
                TenantId = 0,
            });
        }
    }
}
