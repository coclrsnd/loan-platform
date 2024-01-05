using System;
using Microsoft.AspNetCore.Hosting;
using Microsoft.Azure.KeyVault;
using Microsoft.Azure.Services.AppAuthentication;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.Configuration.AzureKeyVault;
using Microsoft.Extensions.Hosting;
using Serilog;

namespace Loan.Platform.Rest
{
    public static class Program
    {
        public static int Main(string[] args)
        {
            IConfiguration configuration = new ConfigurationBuilder().AddJsonFile("appsettings.json").Build();

            // The initial "bootstrap" logger is able to log errors during start-up. It's completely replaced by the
            // logger configured in `UseSerilog()` below, once configuration and dependency-injection have both been
            // set up successfully.
            Log.Logger = CreateSerilogLogger(configuration);

            Log.Information("Application Starting Up");

            try
            {
                CreateHostBuilder(args).Build().Run();

                Log.Information("Application Stopped Up");
                return 0;
            }
            catch (Exception ex)
            {
                Log.Fatal(ex, "The application failed to start correctly, An unhandled exception occured during bootstrapping");
                return 1;
            }
            finally
            {
                Log.CloseAndFlush();
            }
        }

        public static IHostBuilder CreateHostBuilder(string[] args) =>
            Host.CreateDefaultBuilder(args)
                .ConfigureAppConfiguration((context, config) =>
                {
                    var settings = config.Build();

                    if (!context.HostingEnvironment.IsDevelopment())
                    {
                        var keyVaultEndpoint = settings["KeyVaultUrl"];

                        if (!string.IsNullOrEmpty(keyVaultEndpoint))
                        {
                            var azureServiceTokenProvider = new AzureServiceTokenProvider();
                            var keyVaultClient = new KeyVaultClient(new KeyVaultClient.AuthenticationCallback(azureServiceTokenProvider.KeyVaultTokenCallback));
                            config.AddAzureKeyVault(keyVaultEndpoint, keyVaultClient, new DefaultKeyVaultSecretManager());
                        }
                    }
                })
                .UseSerilog((context, services, configuration) =>
                configuration
                .ReadFrom.Configuration(context.Configuration)
                .ReadFrom.Services(services)
                .Enrich.FromLogContext())
                .ConfigureWebHostDefaults(webBuilder =>
                {
                    webBuilder.UseStartup<Startup>();
                });

        private static Serilog.ILogger CreateSerilogLogger(IConfiguration configuration)
        {
            return new LoggerConfiguration()
               .ReadFrom.Configuration(configuration)
                .CreateBootstrapLogger();
        }
    }
}
