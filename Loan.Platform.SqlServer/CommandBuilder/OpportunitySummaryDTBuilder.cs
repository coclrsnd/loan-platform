using StandardRail.RailCarLounge.Data.SqlServer.Extensions;
using StandardRail.RailCarLounge.Models.Entities;
using StandardRail.RailCarLounge.Models.ViewModels;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace StandardRail.RailCarLounge.Data.SqlServer.CommandBuilder
{
    public class OpportunitySummaryDTBuilder : BaseCommandBuilder<OpportunitySummaryDetailsDTViewModel, long>
    {
        public OpportunitySummaryDTBuilder()
        {
        }

        public override IDbCommand GetById(long opportunityId)
        {
            var command = CreateCommand();
            command.CommandType = CommandType.StoredProcedure;
            command.CommandText = "SP_GetOpportunityOrderSummaryDetails";
            command.AddParameter("OpportunityId", opportunityId);
            return command;
        }
    }
}
