using System.Data;
using System.Threading.Tasks;
using Microsoft.Data.SqlClient;
using Microsoft.Extensions.Configuration;
using StandardRail.RailCarLounge.Data.SqlServer.CommandBuilder;
using StandardRail.RailCarLounge.Data.SqlServer.Pact;
using StandardRail.RailCarLounge.Models.ViewModels;

namespace StandardRail.RailCarLounge.Data.SqlServer.Repositories
{
    public class ContractDTRepository : BaseADORepository<ContractDTBuilder, ContractDTViewModel, long>, IRepository<ContractDTViewModel, long>
    {
        public ContractDTRepository(IConfiguration configuration, ICommandBuilder<ContractDTViewModel, long> commandBuilder)
              : base(configuration["DbConnectionString"], commandBuilder)
        {
        }

        public async override Task<ContractDTViewModel> Create(ContractDTViewModel contractViewModel)
        {
            using (var cn = new SqlConnection(ConnectionString))
            {
                var ContractId = await GetScalerOperation<long>(_commandBuilder.Create(contractViewModel))
                              .Execute(cn);

                foreach (DataRow dr in contractViewModel.Contract.Rows)
                {
                    dr["Id"] = ContractId;
                }
            }
            return contractViewModel;
        }

    }
}
