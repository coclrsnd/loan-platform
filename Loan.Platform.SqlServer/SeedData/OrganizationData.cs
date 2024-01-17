using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Loan.Platform.Models.Entities;
using Microsoft.EntityFrameworkCore;

namespace StandardRail.RailCarLounge.Data.SqlServer.SeedData
{
    public static class OrganizationData
    {
        public static void OrganizationSeedData(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Organization>().HasData(new Organization
            {
                Id=1,
                Name="Standard Rail",
                Description= "Standard Rail Description",
                Code ="STDR",
                LogoPath = ""
            },
            new Organization{
                Id = 2,
                Name = "Co _ Operative bank",
                Description = "Co _operative Bank Sindhanur",
                Code = "COPSIND",
                LogoPath = "../../../assets/images/train-bg-one.jpg"
            });

        }
    }
}
