using System;
using Microsoft.EntityFrameworkCore;
using StandardRail.RailCarLounge.Models.Entities;

namespace StandardRail.RailCarLounge.Data.SqlServer.SeedData
{
    public static class CurrencyData
    {
        public static void CurrencySeedData(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Currency>().HasData(new Currency
            {
                Id = 1,
                Name = "US Dollars",
                Code = "USD",
                IsActive = true,
                CreatedTime = DateTime.Now,
                CreatedBy = 1,
                ModifiedBy = 1,
                ModifiedTime = DateTime.Now,
                OrganizationId = 0,
                TenantId = 1,
            });

            modelBuilder.Entity<Currency>().HasData(new Currency
            {
                Id = 2,
                Name = "Canadian Dollars",
                Code = "CDN",
                IsActive = true,
                CreatedTime = DateTime.Now,
                CreatedBy = 1,
                ModifiedBy = 0,
                ModifiedTime = DateTime.Now,
                OrganizationId = 0,
                TenantId = 1,
            });

            modelBuilder.Entity<Currency>().HasData(new Currency
            {
                Id = 3,
                Name = "Pesos",
                Code = "MXN",
                IsActive = true,
                CreatedTime = DateTime.Now,
                CreatedBy = 1,
                ModifiedBy = 0,
                ModifiedTime = DateTime.Now,
                OrganizationId = 0,
                TenantId = 1,
            });
        }
    }
}
