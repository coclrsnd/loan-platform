using System.Collections.Generic;
using System.Threading.Tasks;
using StandardRail.RailCarLounge.Models.Entities;
using StandardRail.RailCarLounge.Models.ViewModels;

namespace StandardRail.RailCarLounge.Business.Pact
{
    /// <summary>
    /// Defines interface for Customer onboard CRUD and search operations.
    /// </summary>
    public interface ICustomerService
    {
        /// <summary>
        /// Get all active Customers.
        /// </summary>
        /// <returns>List of Customers</returns>
        Task<IList<Customer>> GetCustomerList();

        /// <summary>
        /// Save New Customer detail.
        /// </summary>
        /// <param name="customerModel">CustomerViewModel</param>
        /// <returns>List of Customers</returns>
        Task<Customer> OnBoardNewCustomers(CustomerViewModel customerModel);

        /// <summary>
        /// Get all active Customers list with Filter parameter.
        /// </summary>
        /// <param name="customerFilterModel">CustomerFilterViewModel</param>
        /// <returns>List of customers with pagination detail</returns>
        Task<CustomerFilterViewModel> GetCustomersOnFilter(CustomerFilterViewModel customerFilterModel);

        /// <summary>
        /// Get Customer by customer ID
        /// </summary>
        /// <param name="id">long</param>
        /// <returns>Get customer detail of given ID</returns>
        Task<Customer> GetCustomerById(long id);

        /// <summary>
        /// Update Customer detail
        /// </summary>
        /// <param name="customerViewModel">CustomerViewModel</param>
        /// <returns></returns>
        Task UpdateCustomerDetail(CustomerViewModel customerViewModel);

        /// <summary>
        /// get customer list for autocomplete
        /// </summary>
        /// <param name="searchText"></param>
        /// <returns>List of customers</returns>
        Task<IList<CustomerAutoCompleteViewModel>> GetCustomers(string searchText);

        /// <summary>
        /// get customer for user
        /// </summary>
        /// <param name="userId"></param>
        /// <returns>Customer auto complete model</returns>
        Task<CustomerAutoCompleteViewModel> GetCustomerForUser(long userId);

        /// <summary>
        /// Check whether user has access of customer details requested
        /// </summary>
        /// <param name="customerId"></param>
        /// <param name="vendorId"></param>
        /// <returns></returns>
        Task<bool> CheckCustomerDetailsAccess(long customerId, long vendorId);

        /// <summary>
        /// Get percentage margin for customer
        /// </summary>
        /// <param name="userId"></param>
        /// <returns></returns>
        Task<decimal?> GetPercentageMarginForCustomer(long storageOrderId, long customerId);

    }
}