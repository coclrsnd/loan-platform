using System.Data;
using StandardRail.RailCarLounge.Common.UserContext;
using StandardRail.RailCarLounge.Data.SqlServer.Extensions;
using StandardRail.RailCarLounge.Models.ViewModels;

namespace StandardRail.RailCarLounge.Data.SqlServer.CommandBuilder
{
    public class ContractBuilder : BaseCommandBuilder<ContractViewModel, long>
    {
        private long? OrganizationId;
        private string CurrentRole;

        public ContractBuilder(IUserContext userContext)
        {
            OrganizationId = userContext.OrganizationId;
            CurrentRole = userContext.CurrentRole;
        }

        public override IDbCommand Search(ContractViewModel contractViewModel)
        {
            var command = CreateCommand();
            command.CommandType = CommandType.StoredProcedure;
            command.CommandText = "SP_GetStorageOrderDetails";

            string role = !string.IsNullOrEmpty(CurrentRole) ? CurrentRole.Split('_')[0] : string.Empty;
            contractViewModel.CustomerId = !string.IsNullOrEmpty(contractViewModel.CustomerName) && contractViewModel.CustomerId ==0 ? -1 : contractViewModel.CustomerId;
            contractViewModel.VendorId = !string.IsNullOrEmpty(contractViewModel.VendorName) && contractViewModel.VendorId == 0 ? -1 : contractViewModel.VendorId;
            command.AddParameter("CustomerId", contractViewModel.CustomerId);
            command.AddParameter("VendorId", contractViewModel.VendorId);
            command.AddParameter("StorageFacilityId", contractViewModel.StorageFacilityId);
            command.AddParameter("Rider", contractViewModel.Rider);
            command.AddParameter("EffectiveDate", contractViewModel.EffectiveDate);
            command.AddParameter("ExpiryDate", contractViewModel.ExpiryDate);
            command.AddParameter("CurrencyId", contractViewModel.CurrencyId);
            command.AddParameter("SwitchInMin", contractViewModel.SwitchInMin);
            command.AddParameter("SwitchInMax", contractViewModel.SwitchInMax);
            command.AddParameter("SwitchOutMin", contractViewModel.SwitchOutMin);
            command.AddParameter("SwitchOutMax", contractViewModel.SwitchOutMax);
            string featureIds = null;
            if (contractViewModel.StorageFeatureIds != null && contractViewModel.StorageFeatureIds.Count > 0)
            {
                 featureIds = string.Join(",", contractViewModel.StorageFeatureIds);
            }
            command.AddParameter("StorageFeatureIds", featureIds);
            command.AddParameter("@currentRole", role);
            command.AddParameter("@organizationId", OrganizationId);
            return command;
        }

        public override IDbCommand GetById(long Id)
        {
            var command = CreateCommand();
            command.CommandType = CommandType.StoredProcedure;
            string role = !string.IsNullOrEmpty(CurrentRole) ? CurrentRole.Split('_')[0] : string.Empty;
            command.CommandText = "SP_GetStorageOrderDetailsById";
            command.AddParameter("Id", Id);
            command.AddParameter("CurrentRole", role);
            return command;
        }

        public override IDbCommand GetCount(ContractViewModel contractViewModel)
        {
            var command = CreateCommand();
            command.CommandType = CommandType.StoredProcedure;
            command.CommandText = "SP_GetSOCountByVendorCustomerEffectiveDate";
            command.AddParameter("VendorId", contractViewModel.VendorId);
            command.AddParameter("CustomerId", contractViewModel.CustomerId);
            command.AddParameter("EffectiveDate", contractViewModel.EffectiveDate);
            return command;
        }
    }
}
