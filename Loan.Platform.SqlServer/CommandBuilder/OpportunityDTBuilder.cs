using System.Data;
using StandardRail.RailCarLounge.Data.SqlServer.Extensions;
using StandardRail.RailCarLounge.Models.ViewModels;

namespace StandardRail.RailCarLounge.Data.SqlServer.CommandBuilder
{
    public class OpportunityDTBuilder : BaseCommandBuilder<OpportunityDTViewModel, long>
    {
        public OpportunityDTBuilder()
        {
        }

        public override IDbCommand Create(OpportunityDTViewModel opportunityDTViewModel)
        {
            var command = CreateCommand();
            command.CommandType = CommandType.StoredProcedure;
            command.CommandText = "usp_CreateOrUpdateOpportunity";
            command.AddParameter("Opportunity", opportunityDTViewModel.Opportunity);
            command.AddParameter("OpportunityRailcarDetails", opportunityDTViewModel.OpportunityRailcarDetails);
            command.AddParameter("OpportunityAttachments", opportunityDTViewModel.OpportunityAttachments);
            return command;
        }

        public override IDbCommand GetById(long opportunityId)
        {
            var command = CreateCommand();
            command.CommandType = CommandType.StoredProcedure;
            command.CommandText = "SP_GetOpportunityDetailsById";
            command.AddParameter("OpportunityId", opportunityId);
            return command;
        }
    }
}
