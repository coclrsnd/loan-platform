using StandardRail.RailCarLounge.Common.UserContext;
using StandardRail.RailCarLounge.Data.SqlServer.Extensions;
using StandardRail.RailCarLounge.Models.ViewModels;
using System.Data;

namespace StandardRail.RailCarLounge.Data.SqlServer.CommandBuilder
{
    public class RailCarBuilder : BaseCommandBuilder<RailCarViewModel, long>
    {
        private long? OrganizationId;
        private string CurrentRole;

        public RailCarBuilder(IUserContext userContext)
        {
            OrganizationId = userContext.OrganizationId;
            CurrentRole = userContext.CurrentRole;
        }

        public override IDbCommand GetListById(long Id)
        {
            var command = CreateCommand();
            command.CommandType = CommandType.StoredProcedure;
            command.CommandText = "SP_GetRailCarDetailsByContractId";
            command.AddParameter("ContractId", Id);
            return command;
        }

        public override IDbCommand Search(RailCarViewModel railCarViewModel)
        {
            var command = CreateCommand();
            command.CommandType = CommandType.StoredProcedure;
            command.CommandText = "SP_GetRailCarDetails";

            string role = !string.IsNullOrEmpty(CurrentRole) ? CurrentRole.Split('_')[0] : string.Empty;

            command.AddParameter("ContractId", railCarViewModel.StorageOrderId);
            command.AddParameter("CarInitial", railCarViewModel.CarInitial);
            command.AddParameter("CarNumber", railCarViewModel.CarNumber);
            command.AddParameter("CarType", railCarViewModel.RailCarTypeId);
            command.AddParameter("LandE", railCarViewModel.LEId);
            command.AddParameter("ArrivalDate", railCarViewModel.ArrivalDate);
            command.AddParameter("DepartureDate", railCarViewModel.DepartureDate);
            command.AddParameter("BolDate", railCarViewModel.BolDate);
            command.AddParameter("LEContents", string.IsNullOrEmpty(railCarViewModel.LEContents) ? null : railCarViewModel.LEContents);
            command.AddParameter("Fleet", string.IsNullOrEmpty(railCarViewModel.Fleet) ? null : railCarViewModel.Fleet);
            command.AddParameter("CurrentRole", role);
            command.AddParameter("OrganizationId", OrganizationId);
            return command;
        }
    }
}
