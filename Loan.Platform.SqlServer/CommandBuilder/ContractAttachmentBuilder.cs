using StandardRail.RailCarLounge.Data.SqlServer.Extensions;
using StandardRail.RailCarLounge.Models.ViewModels;
using System.Data;

namespace StandardRail.RailCarLounge.Data.SqlServer.CommandBuilder
{
    public class ContractAttachmentBuilder : BaseCommandBuilder<AttachmentViewModel, long>
    {
        public override IDbCommand GetListById(long Id)
        {
            var command = CreateCommand();
            command.CommandType = CommandType.StoredProcedure;
            command.CommandText = "SP_GetAttachmentsByContractId";
            command.AddParameter("ContractId", Id);
            return command;
        }

    }
}
