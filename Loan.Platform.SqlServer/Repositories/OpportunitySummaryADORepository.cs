using Microsoft.Data.SqlClient;
using Microsoft.Extensions.Configuration;
using StandardRail.RailCarLounge.Data.SqlServer.CommandBuilder;
using StandardRail.RailCarLounge.Data.SqlServer.Pact;
using StandardRail.RailCarLounge.Models.ViewModels;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace StandardRail.RailCarLounge.Data.SqlServer.Repositories
{
    public class OpportunitySummaryADORepository : BaseADORepository<OpportunitySummaryDTBuilder, OpportunitySummaryDetailsDTViewModel, long>, IRepository<OpportunitySummaryDetailsDTViewModel, long>
    {
        public OpportunitySummaryADORepository(IConfiguration configuration, ICommandBuilder<OpportunitySummaryDetailsDTViewModel, long> commandBuilder)
             : base(configuration["DbConnectionString"], commandBuilder)
        {
        }
        public async override Task<OpportunitySummaryDetailsDTViewModel> GetById(long opportunityId)
        {
            OpportunitySummaryDetailsDTViewModel opportunitySummaryDetailsDTViewModel = new OpportunitySummaryDetailsDTViewModel();
            var result = new DataSet();
            using (var cn = new SqlConnection(ConnectionString))
            {
                result = await GetDbSetOperation(_commandBuilder.GetById(opportunityId)).Execute(cn);
            }
            if (result != null && result.Tables.Count > 0)
            {
                opportunitySummaryDetailsDTViewModel.OpportunitySummaryDT = result.Tables[0];
                opportunitySummaryDetailsDTViewModel.OpportunityReservedSpacesDT = result.Tables[1];
            }
            return opportunitySummaryDetailsDTViewModel;
        }
    }
}
