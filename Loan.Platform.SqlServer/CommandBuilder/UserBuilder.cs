using Loan.Platform.Data.SqlServer.Extensions;
using Loan.Platform.Models.Entities;
using Loan.Platform.Models.ViewModels;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Loan.Platform.Data.SqlServer.CommandBuilder
{
    public class UserBuilder : BaseCommandBuilder<UserFilterViewModel, long>
    {
        public override IDbCommand All()
        {
            var command = CreateCommand();
            command.CommandType = CommandType.StoredProcedure;
            command.CommandText = "SP_GetUserDetails";
            return command;
        }

        public override IDbCommand Search(UserFilterViewModel userViewModel)
        {
            var command = CreateCommand();
            command.CommandType = CommandType.StoredProcedure;
            command.CommandText = "SP_GetUserDetails";
            command.AddParameter("FirstName", userViewModel.FirstName);
            command.AddParameter("CompanyName", userViewModel.CompanyName);
            command.AddParameter("StatusId", userViewModel.StatusId);
            if (userViewModel.PaginationModel != null)
            {
                command.AddParameter("pageNumber", userViewModel.PaginationModel.Index);
                command.AddParameter("pageSize", userViewModel.PaginationModel.Size);
            }
            if (userViewModel.SortingModel != null)
            {
                command.AddParameter("sortByColumn", userViewModel.SortingModel.SortByColumnName);
                command.AddParameter("sortBy", userViewModel.SortingModel.SortBy);
            }
            return command;
        }

    }
}
