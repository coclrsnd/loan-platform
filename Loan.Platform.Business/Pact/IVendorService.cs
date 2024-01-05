using System.Collections.Generic;
using System.Threading.Tasks;
using StandardRail.RailCarLounge.Models.Entities;

namespace StandardRail.RailCarLounge.Business.Pact
{
    /// <summary>
    /// Defines interface for vendor onboard CRUD and search operations.
    /// </summary>
    public interface IVendorService
    {
        /// <summary>
        /// Get vendor list based on searchText.
        /// </summary>
        /// <param name="searchText"></param>
        /// <returns>List of vendor</returns>
        Task<IList<Vendor>> GetVendorList(string searchText);

        /// <summary>
        /// Get vendor for user based on userId.
        /// </summary>
        /// <param name="userId"></param>
        /// <returns>Vendor object</returns>
        Task<Vendor> GetVendorForUser(long userId);

        /// <summary>
        /// Check vendor details access.
        /// </summary>
        /// <param name="vendorId"></param>
        /// <param name="customerId"></param>
        /// <returns>boolean value</returns>
        Task<bool> CheckVendorDetailsAccess(long vendorId, long customerId);

        /// <summary>
        /// Get percentage margin for vendor.
        /// </summary>
        /// <param name="storageOrderId"></param>
        /// <param name="vendorId"></param>
        /// <returns>decimal value</returns>
        Task<decimal?> GetPercentageMarginForVendor(long storageOrderId, long vendorId);
    }
}
