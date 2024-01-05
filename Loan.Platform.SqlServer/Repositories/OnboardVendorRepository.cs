using System;
using System.Data;
using System.Threading.Tasks;
using Microsoft.Data.SqlClient;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.Options;
using StandardRail.RailCarLounge.Data.SqlServer.CommandBuilder;
using StandardRail.RailCarLounge.Data.SqlServer.Pact;
using StandardRail.RailCarLounge.Models.Configurations;
using StandardRail.RailCarLounge.Models.Shared;

namespace StandardRail.RailCarLounge.Data.SqlServer.Repositories
{
    public class OnboardVendorRepository : BaseADORepository<OnboardVendorBuilder, OnboardVendorModel, long>, IRepository<OnboardVendorModel, long>
    {

        public OnboardVendorRepository(IConfiguration configuration, ICommandBuilder<OnboardVendorModel, long> commandBuilder)
            : base(configuration["DbConnectionString"], commandBuilder)
        {
        }

        /// <inheritdoc/>
        public async override Task<OnboardVendorModel> Create(OnboardVendorModel onBoardVendor)
        {
            using (var cn = new SqlConnection(ConnectionString))
            {
                await GetNonQueryBatchOperation(_commandBuilder.Create(onBoardVendor))
                           .Execute(cn);
            }
            return onBoardVendor;
        }

        /// <inheritdoc/>
        public async override Task<OnboardVendorModel> GetById(long vendorId)
        {
            OnboardVendorModel onboardVendorModel = new OnboardVendorModel();
            var result = new DataSet();
            using (var cn = new SqlConnection(ConnectionString))
            {
                result = await GetDbSetOperation(_commandBuilder.GetById(vendorId))
                           .Execute(cn);
            }
            if (result != null && result.Tables.Count > 0)
            {
                onboardVendorModel.Vendor = result.Tables[0];
                onboardVendorModel.StorageFacilities = result.Tables[1];
                onboardVendorModel.StorageFacilitiesFeatures = result.Tables[3];
                onboardVendorModel.StorageFacilitiesRates = result.Tables[2];
                onboardVendorModel.StorageFacilitiesInterchanges = result.Tables[4];
                onboardVendorModel.StorageFacilitiesInterchangeLocations = result.Tables[5];
            }
            return onboardVendorModel;
        }
    }
}
