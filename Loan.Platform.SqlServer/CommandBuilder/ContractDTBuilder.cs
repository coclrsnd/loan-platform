using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using StandardRail.RailCarLounge.Common.UserContext;
using StandardRail.RailCarLounge.Data.SqlServer.Extensions;
using StandardRail.RailCarLounge.Models.Shared;
using StandardRail.RailCarLounge.Models.ViewModels;

namespace StandardRail.RailCarLounge.Data.SqlServer.CommandBuilder
{
    public  class ContractDTBuilder : BaseCommandBuilder<ContractDTViewModel, long>
    {
        private string CurrentRole;
        public ContractDTBuilder(IUserContext userContext)
        {
            CurrentRole = userContext.CurrentRole;
        }
        /// <summary>
        /// Creates command for Contract save.
        /// </summary>
        /// <param name="contractDTViewModel"></param>
        /// <returns></returns>
        public override IDbCommand Create(ContractDTViewModel contractDTViewModel)
        {
            var command = CreateCommand();
            command.CommandType = CommandType.StoredProcedure;
            command.CommandText = "usp_CreateOrUpdateContract";
            string role = !string.IsNullOrEmpty(CurrentRole) ? CurrentRole.Split('_')[0] : string.Empty;
            command.AddParameter("Contract", contractDTViewModel.Contract);
            command.AddParameter("ContractRate", contractDTViewModel.ContractRates);
            command.AddParameter("ContractSFFeatureMapping", contractDTViewModel.ContractSFFeatureMapping);
            command.AddParameter("CurrentRole", role);
            return command;
        }
    }
}
