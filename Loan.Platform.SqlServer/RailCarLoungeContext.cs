using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Identity.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore;
using Loan.Platform.Common.EmailService;
using Loan.Platform.Common.UserContext;
using Loan.Platform.Data.SqlServer.SeedData;
using Loan.Platform.Models.Entities;
using Loan.Platform.Models.UserManagementModels;
using StandardRail.RailCarLounge.Data.SqlServer.SeedData;

namespace Loan.Platform.Data.SqlServer
{
    public class RailCarLoungeContext : IdentityDbContext<ApplicationUser>
    {
        public DbSet<Organization> Organizations { get; set; }
        public DbSet<Loans> Loans { get; set; }
        public DbSet<Applicant> Applicants { get; set; }
        public DbSet<Loan.Platform.Models.Entities.Loan> Loan { get; set; }
        public DbSet<User> Users { get; set; }
        public DbSet<MailConfiguration> MailConfigurations { get; set; }
        public DbSet<MailLog> MailLogs { get; set; }
        public DbSet<AuditLogEvent> AuditLogEvents { get; set; }
        public DbSet<AuditLog> AuditLogs { get; set; }
        public DbSet<SignUpUser> SignUpUsers { get; set; }
        public DbSet<UserRoles> UsersRoles { get; set; }
        public DbSet<UserType> UsersTypes { get; set; }
        public DbSet<UserStatus> UserStatuses { get; set; }
        public DbSet<UserRoleMapping> UserRoleMappings { get; set; }
        public DbSet<AppFeatures> AppFeatures { get; set; }
        public DbSet<UserRoleAppFeatureMapping> UserRoleAppFeatureMappings { get; set; }

        public long? OrganizationId;
        long? TenantId;
        long? UserId;
        private List<string> ExcludedModelsFromEntityBase = new List<string>()
        { 
            "User",
            "ApplicationUser",
            "IdentityRole",
            "IdentityUserRole`1",
            "SignUpUser",
            "Organization",
            "UserRoleMapping",
            "MailLog",
            "ReportLog"
        };

        public RailCarLoungeContext(DbContextOptions<RailCarLoungeContext> options, IUserContext claimsProvider) : base(options)
        {
            OrganizationId = claimsProvider.OrganizationId;
            TenantId = claimsProvider.TenantId;
            UserId = claimsProvider.UserId;
        }

        protected override void OnModelCreating(ModelBuilder builder)
        {
            base.OnModelCreating(builder);

            FluentApiEntityMappings(builder);
            SeedEntityData(builder);
        }

        private void SeedEntityData(ModelBuilder modelBuilder)
        {
            //ContractTypeData.ContractTypeSeedData(modelBuilder);
            //CurrencyData.CurrencySeedData(modelBuilder);
            //StorageFeatureData.StorageFeatureSeedData(modelBuilder);
            //VendorData.VendorSeedData(modelBuilder);
            //SwitchingScheduleData.SwitchingScheduleSeedData(modelBuilder);
            //StorageFacilityData.StorageFacilitySeedData(modelBuilder);
            //StorageFacilityFeatureMappingData.StorageFacilityFeatureMappingSeedData(modelBuilder);
            OrganizationData.OrganizationSeedData(modelBuilder);
            //CustomerData.CustomerSeedData(modelBuilder);
            //ContractData.ContractSeedData(modelBuilder);
            //ContractSFFeatureMappingData.ContractSFFeatureMappingDataSeedData(modelBuilder);
            //RegionData.RegionSeedData(modelBuilder);
            //CountryData.CountrySeedData(modelBuilder);
            //StateData.StateSeedData(modelBuilder);
            //RailCarTypeData.RailCarTypeSeedData(modelBuilder);
            //LEContentData.LEContentSeedData(modelBuilder);
            UserRolesData.UserRolesSeedData(modelBuilder);
            UserStatusData.UserStatusSeedData(modelBuilder);
            UserTypesData.UserTypesSeedData(modelBuilder);
            //AuditLogEventData.AuditLogEventSeedData(modelBuilder);
            //NotificationEventData.NotificationEventSeedData(modelBuilder);
        }
        private void FluentApiEntityMappings(ModelBuilder modelBuilder)
        {           
            FluentApiExtensions.AuditLogEventExtension(modelBuilder);
            FluentApiExtensions.AuditLogExtension(modelBuilder);
            FluentApiExtensions.SignUpUsersExtension(modelBuilder);
            FluentApiExtensions.UsersRolesExtension(modelBuilder);
            FluentApiExtensions.UsersTypeExtension(modelBuilder);
            FluentApiExtensions.UserStatusesExtension(modelBuilder);
            FluentApiExtensions.UserRoleAppFeatureExtension(modelBuilder);
            FluentApiExtensions.LoanExtension(modelBuilder);
            FluentApiExtensions.ApplicantExtension(modelBuilder);
            FluentApiExtensions.LoansExtension(modelBuilder);
        }

        public override Task<int> SaveChangesAsync(CancellationToken cancellationToken = default)
        {
            var entries = ChangeTracker
                .Entries()
                .Where(e =>
                        e.State == EntityState.Added
                        || e.State == EntityState.Modified);

            foreach (var entityEntry in entries)
            {
                if (!ExcludedModelsFromEntityBase.Contains(entityEntry.Entity.GetType()?.Name))
                {
                    //entityEntry.Property("ModifiedTime").CurrentValue = DateTime.UtcNow;
                    entityEntry.Property("OrganizationId").CurrentValue = entityEntry.Property("OrganizationId").CurrentValue != null &&
                                                    Convert.ToInt64(entityEntry.Property("OrganizationId").CurrentValue) > 0 ? entityEntry.Property("OrganizationId").CurrentValue : OrganizationId;
                    entityEntry.Property("TenantId").CurrentValue = TenantId;
                    entityEntry.Property("ModifiedBy").CurrentValue = UserId;
                    entityEntry.Property("ModifiedTime").CurrentValue = DateTime.UtcNow;
                    if (entityEntry.State == EntityState.Added)
                    {
                        entityEntry.Property("CreatedBy").CurrentValue = UserId;
                        entityEntry.Property("CreatedTime").CurrentValue = DateTime.UtcNow;
                    }
                }
            }

            return base.SaveChangesAsync(cancellationToken);
        }
    }
}
