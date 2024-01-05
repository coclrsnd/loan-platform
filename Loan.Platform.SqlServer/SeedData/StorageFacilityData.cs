using System;
using Microsoft.EntityFrameworkCore;
using StandardRail.RailCarLounge.Models.Entities;

namespace StandardRail.RailCarLounge.Data.SqlServer.SeedData
{
    public static class StorageFacilityData
    {
        public static void StorageFacilitySeedData(ModelBuilder modelBuilder)
        {

            modelBuilder.Entity<StorageFacility>()
        .HasData(
            new StorageFacility
            {
                Id = 1,
                Name = "ABC Storage",
                Lat = "46.719366",
                Long = "-92.112475",
                Capacity = 123,
                AvailableCars = 5000,
                Rating = 2,
                Address = "Test Addr",
                PrimaryContactNumber = "1234567",
                SecondaryContactNumber = "22220",
                PrimaryEmail = "Testf@gmail.com",
                SecondaryEmail = "TestSecondary@gmail.com",
                ZipCode = "111",
                City = "test city",
                StateId = null,
                CountryId = null,
                RegionId = 1,
                SPLC = "SPLC",
                Priority = 3,
                EffectiveDate = DateTime.Now,
                ExpiryDate = DateTime.Now.AddDays(3000),
                Description = "test desc",
                IsActive = true,
                CreatedTime = DateTime.Now,
                CreatedBy = 1,
                ModifiedBy = 0,
                ModifiedTime = DateTime.Now,
                OrganizationId = 0,
                TenantId = 0,
                VendorId = 1,
            }
        );

            modelBuilder.Entity<StorageFacility>()
      .HasData(
          new StorageFacility
          {
              Id = 2,
              Name = "Storage XYZ",
              Lat = "52.858819",
              Long = "-104.609663",
              Capacity = 123,
              AvailableCars = 5000,
              Rating = 2,
              Address = "Test Addr2",
              PrimaryContactNumber = "1234567",
              SecondaryContactNumber = "22220",
              PrimaryEmail = "Testf2@gmail.com",
              SecondaryEmail = "TestSecondary@gmail.com",
              ZipCode = "111",
              City = "test city1",
              StateId = null,
              CountryId = null,
              RegionId = 1,
              SPLC = "SPLC",
              Priority = 3,
              EffectiveDate = DateTime.Now,
              ExpiryDate = DateTime.Now.AddDays(3000),
              Description = "test desc",
              IsActive = true,
              CreatedTime = DateTime.Now,
              CreatedBy = 1,
              ModifiedBy = 0,
              ModifiedTime = DateTime.Now,
              OrganizationId = 0,
              TenantId = 0,
              VendorId = 2,
          }
      );

            modelBuilder.Entity<StorageFacility>()
     .HasData(
         new StorageFacility
         {
             Id = 3,
             Name = "Spring Valleys",
             Lat = "50.151404",
             Long = "-121.579882",
             Capacity = 123,
             AvailableCars = 5000,
             Rating = 2,
             Address = "Test Addr2",
             PrimaryContactNumber = "1234567",
             SecondaryContactNumber = "22220",
             PrimaryEmail = "Testf2@gmail.com",
             SecondaryEmail = "TestSecondary@gmail.com",
             ZipCode = "111",
             City = "test city2",
             StateId = null,
             CountryId = null,
             RegionId = 2,
             SPLC = "SPLC",
             Priority = 3,
             EffectiveDate = DateTime.Now,
             ExpiryDate = DateTime.Now.AddDays(3000),
             Description = "test desc",
             IsActive = true,
             CreatedTime = DateTime.Now,
             CreatedBy = 1,
             ModifiedBy = 0,
             ModifiedTime = DateTime.Now,
             OrganizationId = 0,
             TenantId = 0,
             VendorId = 3,
         }
     );

            modelBuilder.Entity<StorageFacility>()
     .HasData(
         new StorageFacility
         {
             Id = 4,
             Name = "Matt Storage",
             Lat = "49.771159",
             Long = "-94.494456",
             Capacity = 123,
             AvailableCars = 5000,
             Rating = 2,
             Address = "Test Addr2",
             PrimaryContactNumber = "1234567",
             SecondaryContactNumber = "22220",
             PrimaryEmail = "Testf2@gmail.com",
             SecondaryEmail = "TestSecondary@gmail.com",
             ZipCode = "111",
             City = "test city3",
             StateId = null,
             CountryId = null,
             RegionId = 2,
             SPLC = "SPLC",
             Priority = 3,
             EffectiveDate = DateTime.Now,
             ExpiryDate = DateTime.Now.AddDays(3000),
             Description = "test desc",
             IsActive = true,
             CreatedTime = DateTime.Now,
             CreatedBy = 1,
             ModifiedBy = 0,
             ModifiedTime = DateTime.Now,
             OrganizationId = 0,
             TenantId = 0,
             VendorId = 4,
         }
     );

            modelBuilder.Entity<StorageFacility>()
     .HasData(
         new StorageFacility
         {
             Id = 5,
             Name = "Hexagonal",
             Lat = "48.673901",
             Long = "-88.648724",
             Capacity = 123,
             AvailableCars = 5000,
             Rating = 2,
             Address = "Test Addr2",
             PrimaryContactNumber = "1234567",
             SecondaryContactNumber = "22220",
             PrimaryEmail = "Testf2@gmail.com",
             SecondaryEmail = "TestSecondary@gmail.com",
             ZipCode = "111",
             City = "test city4",
             StateId = null,
             CountryId = null,
             RegionId = 3,
             SPLC = "SPLC",
             Priority = 3,
             EffectiveDate = DateTime.Now,
             ExpiryDate = DateTime.Now.AddDays(3000),
             Description = "test desc",
             IsActive = true,
             CreatedTime = DateTime.Now,
             CreatedBy = 1,
             ModifiedBy = 0,
             ModifiedTime = DateTime.Now,
             OrganizationId = 0,
             TenantId = 0,
             VendorId = 1,
         }
     );

            modelBuilder.Entity<StorageFacility>()
     .HasData(
         new StorageFacility
         {
             Id = 6,
             Name = "Best Str",
             Lat = "44.714709",
             Long = "-79.603807",
             Capacity = 123,
             AvailableCars = 5000,
             Rating = 2,
             Address = "Test Addr2",
             PrimaryContactNumber = "1234567",
             SecondaryContactNumber = "22220",
             PrimaryEmail = "Testf2@gmail.com",
             SecondaryEmail = "TestSecondary@gmail.com",
             ZipCode = "111",
             City = "test city5",
             StateId = null,
             CountryId = null,
             RegionId = 4,
             SPLC = "SPLC",
             Priority = 3,
             EffectiveDate = DateTime.Now,
             ExpiryDate = DateTime.Now.AddDays(3000),
             Description = "test desc",
             IsActive = true,
             CreatedTime = DateTime.Now,
             CreatedBy = 1,
             ModifiedBy = 0,
             ModifiedTime = DateTime.Now,
             OrganizationId = 0,
             TenantId = 0,
             VendorId = 2,
         }
     );
        }
    }
}
