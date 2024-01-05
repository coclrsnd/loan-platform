using StandardRail.RailCarLounge.Data.SqlServer.Extensions;
using StandardRail.RailCarLounge.Models.ViewModels;
using System.Data;

namespace StandardRail.RailCarLounge.Data.SqlServer.CommandBuilder
{
    public class ContractNoteBuilder : BaseCommandBuilder<NoteViewModel, long>
    {
        public override IDbCommand GetListById(long Id)
        {
            var command = CreateCommand();
            command.CommandType = CommandType.StoredProcedure;
            command.CommandText = "SP_GetNotesByContractId";
            command.AddParameter("ContractId", Id);
            return command;
        }

    }
}
