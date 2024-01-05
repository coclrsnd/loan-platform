using Loan.Platform.Data.SqlServer.Extensions;
using Loan.Platform.Models.ViewModels;
using System.Data;

namespace Loan.Platform.Data.SqlServer.CommandBuilder
{
    public class AuditLogBuilder : BaseCommandBuilder<AuditLogFilterViewModel, long>
    {
        public override IDbCommand GetListById(long Id)
        {
            var command = CreateCommand();
            command.CommandType = CommandType.StoredProcedure;
            command.CommandText = "SP_GetAuditLogsByContractId";
            command.AddParameter("ContractId", Id);
            return command;
        }

        public override IDbCommand Search(AuditLogFilterViewModel auditLogFilterViewModel)
        {
            var command = CreateCommand();
            command.CommandType = CommandType.StoredProcedure;
            command.CommandText = "SP_GetAuditLogsOnFilter";

            if (auditLogFilterViewModel != null)
            {
                command.AddParameter("@contractId", auditLogFilterViewModel.ContractId);
                command.AddParameter("@pageNumber", (auditLogFilterViewModel.Pagination.Index + 1));
                command.AddParameter("@pageSize", auditLogFilterViewModel.Pagination.Size);
                command.AddParameter("@sortByColumn", auditLogFilterViewModel.Sorting.SortByColumnName);
                command.AddParameter("@sortBy", auditLogFilterViewModel.Sorting.SortBy);
            }
            return command;
        }

    }
}
