using System.Collections.Generic;
using System.Threading.Tasks;
using StandardRail.RailCarLounge.Models.Entities;
using StandardRail.RailCarLounge.Models.UserManagementModels;
using StandardRail.RailCarLounge.Models.ViewModels;

namespace StandardRail.RailCarLounge.Business.Pact
{
    /// <summary>
    /// Defines interface to get Master data.
    /// </summary>
    public interface IMasterDataService
    {
        /// <summary>
        /// Get all country list.
        /// </summary>
        /// <returns>List of Country</returns>
        Task<IList<Country>> GetAllCountries();

        /// <summary>
        /// Get State list by country ID.
        /// </summary>
        /// <param name="countryID">long</param>
        /// <returns>List of State</returns>
        Task<IList<State>> GetStateListByCountryID(long countryID);

        /// <summary>
        /// Get Customers city list.
        /// </summary>
        /// <param name="reqFor">string</param>
        /// <returns>List of string value</returns>
        Task<IList<string>> GetCityList(string reqFor);

        /// <summary>
        /// Get All Organizations List based on input string.
        /// </summary>
        /// <param name="searchText">string</param>
        /// <returns>List of Organizations</returns>
        Task<IList<Organization>> GetAllOrganizations(string searchText);

        /// <summary>
        /// To Get (if organization is exist) And Save (if organization is not exist).
        /// </summary>
        /// <param name="organizationModel">OrganizationViewModel</param>
        /// <returns>List of Organization</returns>
        Task<Organization> SaveAndGetOrganization(OrganizationViewModel organizationModel);

        /// <summary>
        /// Get all regions
        /// </summary>
        /// <returns>List of regions</returns>
        Task<IList<Region>> GetRegions();

        /// <summary>
        /// Get StorageFacilityInterchanges list based on Vendor/Organization or/and StorageFacility
        /// </summary>
        /// <param name="organizationID">long</param>
        /// <param name="storageFacilityID">long</param>
        /// <returns>List of StorageFacilityInterchange</returns>
        Task<IList<StorageFacilityInterchangeViewModel>> GetInterchangesList(long organizationID, long storageFacilityID);
        
        /// <summary>
        /// Get RailRoads list
        /// </summary>
        /// <returns>List of Rail Roads</returns>
        Task<IList<RailRoad>> GetAllRailRoads();

        /// <summary>
        /// Get Regions List for requested countryID
        /// </summary>
        /// <param name="countryID">long</param>
        /// <returns></returns>
        Task<IList<Region>> GetRegionByCountryID(long countryID);

        /// <summary>
        /// Get All Organizations List.
        /// </summary>
        /// <param name="searchText">string</param>
        /// <returns>List of Organizations</returns>
        Task<IList<Organization>> GetOrganizations();

        /// <summary>
        /// Get All User Types List.
        /// </summary>
        /// <param name="searchText">string</param>
        /// <returns>List of User Types</returns>
        Task<IList<UserType>> GetUserTypes();

        /// <summary>
        /// Get All User Status List.
        /// </summary>
        /// <returns>List of User Statuses</returns>
        Task<IList<UserStatus>> GetUserStatuses();

        /// <summary>
        /// Get All Rate Types
        /// </summary>
        /// <returns>List of contract rate types</returns>
        Task<IList<RateType>> GetContractRateTypes();

        /// <summary>
        /// Get All SwitchIn SwitchOut List.
        /// </summary>
        /// <returns>List of SwitchInSwitchOut</returns>
        Task<SwitchInSwitchOut> GetSwitchInSwitchOutList();
    }
}
