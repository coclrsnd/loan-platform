using System.Data;
using System.Threading.Tasks;
using Microsoft.Data.SqlClient;
using Microsoft.Extensions.Configuration;
using StandardRail.RailCarLounge.Data.SqlServer.CommandBuilder;
using StandardRail.RailCarLounge.Data.SqlServer.Pact;
using StandardRail.RailCarLounge.Models.ViewModels;

namespace StandardRail.RailCarLounge.Data.SqlServer.Repositories
{
    public class OpportunityDTRepository : BaseADORepository<OpportunityDTBuilder, OpportunityDTViewModel, long>, IRepository<OpportunityDTViewModel, long>
    {

        public OpportunityDTRepository(IConfiguration configuration, ICommandBuilder<OpportunityDTViewModel, long> commandBuilder)
            : base(configuration["DbConnectionString"], commandBuilder)
        {
        }

        public async override Task<OpportunityDTViewModel> Create(OpportunityDTViewModel opportunityDTViewModel)
        {
            var result = new DataSet();
            using (var cn = new SqlConnection(ConnectionString))
            {
                var opportunityId = await GetScalerOperation<long>(_commandBuilder.Create(opportunityDTViewModel))
                          .Execute(cn);
                foreach (DataRow dr in opportunityDTViewModel.Opportunity.Rows)
                {
                    dr["Id"] = opportunityId;
                }
            }
            return opportunityDTViewModel;
        }

        public async override Task<OpportunityDTViewModel> GetById(long opportunityId)
        {
            OpportunityDTViewModel opportunityDTViewModel = new OpportunityDTViewModel();
            var result = new DataSet();
            using (var cn = new SqlConnection(ConnectionString))
            {
                result = await GetDbSetOperation(_commandBuilder.GetById(opportunityId))
                           .Execute(cn);
            }
            if (result != null && result.Tables.Count > 0)
            {
                opportunityDTViewModel.Opportunity = result.Tables[0];
                opportunityDTViewModel.OpportunityRailcarDetails = result.Tables[1];
                opportunityDTViewModel.OpportunityAttachments = result.Tables[2];
            }
            return opportunityDTViewModel;
        }

    }
}
