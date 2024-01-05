using System.Data;
using StandardRail.RailCarLounge.Common.UserContext;
using StandardRail.RailCarLounge.Data.SqlServer.Extensions;
using StandardRail.RailCarLounge.Models.ViewModels;

namespace StandardRail.RailCarLounge.Data.SqlServer.CommandBuilder
{
    public class VendorBuilder : BaseCommandBuilder<VendorFilterViewModel, long>
    {
        private long? OrganizationId;
        private string CurrentRole;

        public VendorBuilder(IUserContext userContext)
        {
            OrganizationId = userContext.OrganizationId;
            CurrentRole = userContext.CurrentRole;
        }
        /// <summary>
        /// Creates command for Get Vendors on Search.
        /// </summary>
        /// <param name="vendorFilter">VendorFilterViewModel</param>
        /// <returns></returns>
        public override IDbCommand Search(VendorFilterViewModel vendorFilter)
        {
            var command = CreateCommand();
            command.CommandType = CommandType.StoredProcedure;
            command.CommandText = "SP_GetVendorsOnFilter";
            string role = !string.IsNullOrEmpty(CurrentRole) ? CurrentRole.Split('_')[0] : string.Empty;
            if (vendorFilter != null)
            {
                command.AddParameter("@orgName", vendorFilter.Organization);
                command.AddParameter("@storagefacilityId", vendorFilter.StorageFacilityId);
                command.AddParameter("@interchangeId", vendorFilter.InterchangeId);
                command.AddParameter("@city", string.Join(",", vendorFilter.City));
                command.AddParameter("@countryId", vendorFilter.CountryId);
                command.AddParameter("@stateId", vendorFilter.StateId);
                command.AddParameter("@currentRole", role);
                command.AddParameter("@organizationId", OrganizationId);
                //command.AddParameter("pageNumber", (vendorFilter.Pagination.Index + 1));
                //command.AddParameter("pageSize", vendorFilter.Pagination.Size);
                //command.AddParameter("sortByColumn", vendorFilter.Sorting.SortByColumnName);
                //command.AddParameter("sortBy", vendorFilter.Sorting.SortBy);
            }
            return command;
        }
    }
}
