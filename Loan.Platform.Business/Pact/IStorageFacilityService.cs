using System.Collections.Generic;
using System.Threading.Tasks;
using StandardRail.RailCarLounge.Models.Entities;
using StandardRail.RailCarLounge.Models.ViewModels;

namespace StandardRail.RailCarLounge.Business.Pact
{
    /// <summary>
    /// Defines interface to get Storage Facility data.
    /// </summary>
    public interface IStorageFacilityService
    {
        /// <summary>
        /// Save Storage Facility Detail.
        /// </summary>
        /// <param name="storageFacilityViewModel">StorageFacilityViewModel</param>
        /// <returns>Saved Storage Facility data</returns>
        Task<StorageFacility> Save(StorageFacilityViewModel storageFacilityViewModel);

        /// <summary>
        /// Get Storage Features.
        /// </summary>
        /// <returns></returns>
        Task<List<StorageFacilityViewModel>> GetStorageFeatures();

        /// <summary>
        /// Get Storage Facility By Id.
        /// </summary>
        /// <param name="id">int</param>
        /// <returns>Storage Facility detail for requested ID</returns>
        Task<StorageFacilityViewModel> GetStorageFacilityById(int id);

        /// <summary>
        /// Get Storage Facilities by Vendor Id.
        /// </summary>
        /// <param name="vendorId">long</param>
        /// <returns>List of Storage facilities</returns>
        Task<IList<StorageFacility>> GetStorageFacilitiesByVendorId(long vendorId);

        /// <summary>
        /// Get Storage Facility on search for Autocomplete.
        /// </summary>
        /// <param name="organizationID">long</param>
        /// <returns>List of Storage Facility start with input param value</returns>
        Task<IList<StorageFacility>> GetStorageFacilities(long organizationID);

        /// <summary>
        /// To Search and Get Storage facilities
        /// </summary>
        /// <param name="facilityMapSearchRequest">FacilityMapSearchRequestModel</param>
        /// <returns>List of FacilityMapSearchResultViewModel</returns>
        Task<FacilityMapSearchResultViewModel> SearchStorageFacilities(FacilityMapSearchRequestModel facilityMapSearchRequest);

        /// <summary>
        /// Book a Storage Facility from facility search map.
        /// </summary>
        /// <param name="storageFacilityBookNowRequestViewModel"></param>
        /// <returns></returns>
        Task<bool> BookStorageFacility(StorageFacilityBookNowRequestViewModel storageFacilityBookNowRequestViewModel);
    }
}
