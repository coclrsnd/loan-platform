using System;
using Microsoft.EntityFrameworkCore;
using StandardRail.RailCarLounge.Models.Entities;

namespace StandardRail.RailCarLounge.Data.SqlServer.SeedData
{
    public static class ContractData
    {
        public static void ContractSeedData(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Contract>().HasData(new Contract
            {
                Id = 1,
                VendorId = 1,
                CustomerId = 1,
                Rider = "Rider1234",
                StorageFacilityId = 1,
                ContractTypeId = 1,
                EffectiveDate = DateTime.Now,
                ExpiryDate = DateTime.Now.AddDays(500),
                //AcceptHazmatCars = true,
                //AcceptLoadedCars = true,
                //Notes = "test",
                //SwitchIn = 4,
                //SwitchOut = 6,
                TotalCars = 100,
                CurrencyId = 1,
                Location = "testcity",
                //PercentageMargin = 23,
                //DailyStorageRate = 45
            });

            modelBuilder.Entity<Contract>().HasData(new Contract
            {
                Id = 2,
                VendorId = 2,
                CustomerId = 2,
                Rider = "Rider4567",
                ContractTypeId = 2,
                StorageFacilityId = 2,
                EffectiveDate = DateTime.Now,
                ExpiryDate = DateTime.Now.AddDays(300),
                //AcceptHazmatCars = false,
                //AcceptLoadedCars = true,
                //Notes = "test",
                //SwitchIn = 7,
                //SwitchOut = 8,
                TotalCars = 50,
                CurrencyId = 2,
                Location = "testcity 1",
                //PercentageMargin = 23,
                //DailyStorageRate = 45
            });
        }
    }
}
