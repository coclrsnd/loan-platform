using System.Data;
using StandardRail.RailCarLounge.Common.UserContext;
using StandardRail.RailCarLounge.Data.SqlServer.Extensions;
using StandardRail.RailCarLounge.Models.ViewModels;

namespace StandardRail.RailCarLounge.Data.SqlServer.CommandBuilder
{
    public class CustomerBuilder : BaseCommandBuilder<CustomerFilterViewModel, long>
    {
        private long? OrganizationId;
        private string CurrentRole;

        public CustomerBuilder(IUserContext userContext)
        {
            OrganizationId = userContext.OrganizationId;
            CurrentRole = userContext.CurrentRole;
        }

        public override IDbCommand Search(CustomerFilterViewModel customerfilterModel)
        {
            var command = CreateCommand();
            command.CommandType = CommandType.StoredProcedure;
            command.CommandText = "SP_GetCustomersOnFilter";
            string role = !string.IsNullOrEmpty(CurrentRole) ? CurrentRole.Split('_')[0] : string.Empty;
            if (customerfilterModel != null)
            {                
                command.AddParameter("@countryId", customerfilterModel.CountryId);
                command.AddParameter("@stateId", customerfilterModel.StateId);
                command.AddParameter("@city", string.Join(",", customerfilterModel.CityName ));
                command.AddParameter("@orgName", customerfilterModel.Organization);
                command.AddParameter("@pageNumber", (customerfilterModel.Pagination.Index+1));
                command.AddParameter("@pageSize", customerfilterModel.Pagination.Size);
                command.AddParameter("@sortByColumn", customerfilterModel.Sorting.SortByColumnName);
                command.AddParameter("@sortBy", customerfilterModel.Sorting.SortBy);
                command.AddParameter("@currentRole", role);
                command.AddParameter("@organizationId", OrganizationId);
            }        
            return command;
        }       
    }
}
