using System.Collections.Generic;
using System.Threading.Tasks;
using StandardRail.RailCarLounge.Models.ViewModels;

namespace StandardRail.RailCarLounge.Business.Pact
{
    /// <summary>
    /// Contains methods for Onboard Vendor.
    /// </summary>
    public interface IOnboardVendorService
    {
        /// <summary>
        /// Saves Vendor Information.
        /// </summary>
        /// <param name="vendorViewModel"></param>
        /// <returns>Vendor Object</returns>
        Task<VendorViewModel> Save(VendorViewModel vendorViewModel);

        /// <summary>
        /// Get Vendor List from Db.
        /// </summary>
        /// <returns>List of Vendors</returns>
        Task<IList<VendorAutoCompleteViewModel>> GetVendorList(string searchText);

        /// <summary>
        /// Get vendor details from Db.
        /// </summary>
        /// <returns>Vendor Details</returns>
        Task<VendorViewModel> GetVendorDetails(int vendorId);

        /// <summary>
        /// Get Vendors list on filter.
        /// </summary>
        /// <param name="vendorFilterViewModel">VendorFilterViewModel</param>
        /// <returns>List of vendors</returns>
        Task<VendorFilterViewModel> GetVendorsOnFilter(VendorFilterViewModel vendorFilterViewModel);

        /// <summary>
        /// Get Vendor List from Db.
        /// </summary>
        /// <returns>List of Vendors</returns>
        Task<IList<VendorAutoCompleteViewModel>> GetVendorList();
    }
}
