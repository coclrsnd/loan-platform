using System;
using Microsoft.EntityFrameworkCore;
using Loan.Platform.Models.Entities;
using Loan.Platform.Models.UserManagementModels;

namespace Loan.Platform.Data.SqlServer
{
    public static class FluentApiExtensions
    {
        public static void SignUpUsersExtension(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<SignUpUser>(entity =>
            {
                entity.Property(c => c.IsActive).HasDefaultValue(true).IsRequired();
                entity.Property(c => c.Id).IsRequired().UseIdentityColumn(1, 1);
                entity.Property(c => c.FirstName).IsRequired().HasMaxLength(100);
                entity.Property(c => c.EmailId).IsRequired().HasMaxLength(200);
                entity.Property(c => c.ContactNo).HasMaxLength(20);
                entity.Property(c => c.MobileNo).HasMaxLength(20);
                entity.Property(c => c.LastName).HasMaxLength(100);
                entity.Property(c => c.CompanyName).HasMaxLength(100);
                entity.Property(c => c.Designation).HasMaxLength(100);
                entity.ToTable("SignUpUser", t => t.IsTemporal(true));
            });
        }

        public static void UsersRolesExtension(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<UserRoles>(entity =>
            {
                entity.Property(c => c.IsActive).HasDefaultValue(true);
                entity.Property(c => c.Id).IsRequired().UseIdentityColumn(1, 1);
                entity.Property(c => c.Name).IsRequired().HasMaxLength(100);
                entity.ToTable("UserRoles");
            });
        }

        public static void UsersTypeExtension(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<UserType>(entity =>
            {
                entity.Property(c => c.IsActive).HasDefaultValue(true);
                entity.Property(c => c.Id).IsRequired().UseIdentityColumn(1, 1);
                entity.Property(c => c.Name).IsRequired().HasMaxLength(100);
                entity.ToTable("UserType");
            });
        }

        public static void UserStatusesExtension(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<UserStatus>(entity =>
            {
                entity.Property(c => c.IsActive).HasDefaultValue(true);
                entity.Property(c => c.Id).IsRequired().UseIdentityColumn(1, 1);
                entity.Property(c => c.Name).IsRequired().HasMaxLength(100);
                entity.ToTable("UserStatus");
            });
        }

        public static void AuditLogEventExtension(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<AuditLogEvent>(entity =>
            {
                entity.Property(c => c.IsActive).HasDefaultValue(true).IsRequired();
                entity.Property(c => c.Id).IsRequired().UseIdentityColumn(1, 1);
                entity.Property(c => c.Name).IsRequired();
                entity.ToTable("AuditLogEvent");
            });
        }

        public static void AuditLogExtension(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<AuditLog>(entity =>
            {
                entity.Property(c => c.IsActive).HasDefaultValue(true).IsRequired();
                entity.Property(c => c.Id).IsRequired().UseIdentityColumn(1, 1);
                entity.Property(c => c.EntityId).IsRequired();
                entity.Property(c => c.EventId).IsRequired();
                entity.ToTable("AuditLogs");
            });
        }

        public static void UserRoleAppFeatureExtension(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<UserRoleAppFeatureMapping>(entity =>
            {
                entity.Property(c => c.IsActive).HasDefaultValue(true).IsRequired();
                entity.Property(c => c.Id).IsRequired().UseIdentityColumn(1, 1);
                entity.Property(c => c.RoleId).IsRequired();
                entity.Property(c => c.FeatureId).IsRequired();
                entity.ToTable("UserRoleAppFeatureMapping");
            });
        }

        public static void LoanExtension(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity< Loan.Platform.Models.Entities.Loan> (entity =>
            {
                // Primary key
                entity.HasKey(e => e.Id);

                // Amount property configuration
                entity.Property(e => e.Amount)
                    .HasColumnType("decimal(18,2)") // Example: decimal with precision 18 and scale 2
                    .IsRequired();

                // Status property configuration
                // Assuming Status is an enum in your application
                entity.Property(e => e.Status)
                    .IsRequired();

                // ApplicantId foreign key
                entity.Property(e => e.ApplicantId)
                    .IsRequired();

                // Relationship with Applicant entity
                entity.HasOne(e => e.Applicant)
                    .WithMany()
                    .HasForeignKey(e => e.ApplicantId)
                    .IsRequired()
                    .OnDelete(DeleteBehavior.Restrict); // Define the delete behavior according to your requirement

                entity.ToTable("Loan");
            });            
        }


        public static void ApplicantExtension(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Applicant>(entity =>
            {
                // Primary key
                entity.HasKey(e => e.Id);

                // Name property configuration
                entity.Property(e => e.Name)
                     .IsRequired()
                    .HasMaxLength(100); // Adjust the length as needed

                // AdharNumber property configuration
                entity.Property(e => e.AdharNumber)
                     .IsRequired()
                    .HasMaxLength(12); // Adjust the length as needed

                entity.HasMany(o => o.ApplicantOrganizationMappings)
                     .WithOne(aom => aom.Applicant)
                     .HasForeignKey(aom => aom.ApplicantId)
                     .OnDelete(DeleteBehavior.Restrict);

                entity.ToTable("Applicant");
            });

        }


        public static void OrganizationExtension(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Organization>(entity =>
            {
                // Primary key
                entity.HasKey(e => e.Id);

                // Name property configuration
                entity.Property(e => e.Name)
                    .IsRequired()
                    .HasMaxLength(100); // Adjust the length as needed

                // Description property configuration
                entity.Property(e => e.Description)
                    .HasMaxLength(500); // Adjust the length as needed

                // IsActive property configuration
                entity.Property(e => e.IsActive)
                    .IsRequired();

                // CreatedTime property configuration
                entity.Property(e => e.CreatedTime)
                    .IsRequired();

                // CreatedBy property configuration
                entity.Property(e => e.CreatedBy)
                    .IsRequired();

                // ModifiedTime property configuration
                entity.Property(e => e.ModifiedTime)
                    .IsRequired();

                // ModifiedBy property configuration
                entity.Property(e => e.ModifiedBy)
                    .IsRequired();

                entity.HasMany(o => o.ApplicantOrganizationMappings)
                     .WithOne(aom => aom.Organization)
                     .HasForeignKey(aom => aom.OrganizationId)
                     .OnDelete(DeleteBehavior.Restrict);

            });
        }

        public static void ApplicantOrganizationMappingExtension(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<ApplicantOrganizationMapping>(entity =>
            {
                entity.HasKey(e => e.Id);

                entity.HasKey(e => new { e.ApplicantId, e.OrganizationId });

                entity.HasOne(aom => aom.Applicant)
                    .WithMany(a => a.ApplicantOrganizationMappings)
                    .HasForeignKey(aom => aom.ApplicantId)
                    .OnDelete(DeleteBehavior.Restrict);

                entity.HasOne(aom => aom.Organization)
                    .WithMany(o => o.ApplicantOrganizationMappings)
                    .HasForeignKey(aom => aom.OrganizationId)
                    .OnDelete(DeleteBehavior.Restrict);
            });
        }
    }
}
