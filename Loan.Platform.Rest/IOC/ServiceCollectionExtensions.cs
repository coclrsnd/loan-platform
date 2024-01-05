using System.Text;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.DependencyInjection.Extensions;
using Microsoft.IdentityModel.Tokens;
using Loan.Platform.Business;
using Loan.Platform.Business.Pact;
using Loan.Platform.Common.EmailService;
using Loan.Platform.Common.StorageAccountHelper.BlobHelper;
using Loan.Platform.Common.UserContext;
using Loan.Platform.Data.SqlServer;
using Loan.Platform.Data.SqlServer.CommandBuilder;
using Loan.Platform.Data.SqlServer.Pact;
using Loan.Platform.Data.SqlServer.Repositories;
using Loan.Platform.Models.Entities;
using Loan.Platform.Models.ReportModels;
using Loan.Platform.Models.Shared;
using Loan.Platform.Models.UserManagementModels;
using Loan.Platform.Models.ViewModels;
using Loan.Platform.Rest.Services;

namespace Loan.Platform.Rest.IOC
{
    public static class ServiceCollectionExtensions
    {
        public static void RegisterIdentityServices(this IServiceCollection services, IConfiguration configuration)
        {
            // For Entity Framework  
            services.AddDbContext<RailCarLoungeContext>(options => options.UseSqlServer(configuration["DbConnectionString"], b => b.MigrationsAssembly("Loan.Platform.Rest")));
            //services.AddDbContext<RailCarLoungeContext>(options => options.UseSqlServer(configuration["DbConnectionString"], b => b.MigrationsAssembly("Loan.Platform.Rest")), ServiceLifetime.Transient);

            // For Identity  
            services.AddIdentity<ApplicationUser, IdentityRole>(options =>
            {
                options.Password.RequiredLength = 8;
                options.Password.RequiredUniqueChars = 3;
            })
                .AddEntityFrameworkStores<RailCarLoungeContext>()
                .AddDefaultTokenProviders();

            // Adding Authentication  
            services.AddAuthentication(options =>
            {
                options.DefaultAuthenticateScheme = JwtBearerDefaults.AuthenticationScheme;
                options.DefaultChallengeScheme = JwtBearerDefaults.AuthenticationScheme;
                options.DefaultScheme = JwtBearerDefaults.AuthenticationScheme;
            })

            // Adding Jwt Bearer  
            .AddJwtBearer(options =>
            {
                options.SaveToken = true;
                options.RequireHttpsMetadata = false;
                options.TokenValidationParameters = new TokenValidationParameters()
                {
                    ValidateIssuer = false,
                    ValidateAudience = true,
                    ValidateLifetime = true,
                    ValidateIssuerSigningKey = true,

                    ValidAudience = configuration["JWT:ValidAudience"],
                    ValidIssuer = configuration["JWT:ValidIssuer"],
                    IssuerSigningKey = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(configuration["JWTSecret"]))
                };
            });
        }

        public static void RegisterServices(this IServiceCollection services, IConfiguration configuration)
        {

            services.TryAddTransient<IAccountService, AccountService>();
            services.TryAddTransient<IRepository<MailConfiguration, long>, MailConfigurationRepository>();

            services.TryAddTransient<IEmailService, EmailService>();
            services.TryAddTransient<IUserManagerService, UserManagerService>();
            services.TryAddTransient<IRepository<User, long>, UserRepository>();
           
            services.TryAddTransient<IRepository<Organization, long>, OrganizationRepository>();
           
            services.TryAddTransient<IRepository<UserFilterViewModel, long>, UserADORepository>();
            services.TryAddTransient<ICommandBuilder<UserFilterViewModel, long>, UserBuilder>();

           
            services.TryAddTransient<IAzureBlobService, AzureBlobService>();

            services.TryAddTransient<IRepository<AuditLog, long>, AuditLogRepository>();
            services.TryAddTransient<IRepository<SignUpUser, long>, SignUpUserRepository>();
            services.TryAddTransient<IRepository<UserRoles, long>, UserRolesRepository>();
            services.TryAddTransient<IRepository<UserType, long>, UserTypeRepository>();
            services.TryAddTransient<IRepository<UserStatus, long>, UserStatusRepository>();
            services.TryAddTransient<IRepository<UserRoleMapping, long>, UserRoleMappingRepository>();
            services.TryAddScoped<IUserContext, UserContext>();
            services.TryAddTransient<IRepository<UserRoleAppFeatureMapping, long>, UserRoleAppFeatureRepository>();

            services.TryAddTransient<ICommandBuilder<AuditLogFilterViewModel, long>, AuditLogBuilder>();
            services.TryAddTransient<IRepository<AuditLogFilterViewModel, long>, AuditLogADORepository>();
            services.TryAddTransient<ICommonService, CommonService>();
            services.TryAddTransient<IRepository<MailLog, long>, MailLogRepository>();
            services.TryAddTransient<IUtilityService, UtilityService>();

            
        }
    }
}
