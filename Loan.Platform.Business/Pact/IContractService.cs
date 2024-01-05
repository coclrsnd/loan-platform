using System.Collections.Generic;
using System.Threading.Tasks;
using StandardRail.RailCarLounge.Models.Entities;
using StandardRail.RailCarLounge.Models.ViewModels;

namespace StandardRail.RailCarLounge.Business.Pact
{
    public interface IContractService
    {
        Task<ContractViewModel> GetStorageOrderDetails(ContractViewModel contractViewModel);

        Task<ContractViewModel> SaveStorageOrder(ContractViewModel contractViewModel);

        Task<ContractViewModel> SaveContractDetail(ContractViewModel contractViewModel);

        Task UpdateStorageOrder(ContractViewModel contractViewModel);

        Task UpdateStorageOrderForCarsStored(long contractId, long carsStored);

        Task<ContractViewModel> GetStorageOrderDetailsById(long Id);

        Task<IList<Contract>> GetStorageOrderList(string searchText);

        Task<bool> ValidateAndExpire(long Id);

        Task<bool> ValidateCustomerVendorWithSO(long vendorId, long customerId);

        Task<List<StorageOrderModel>> GetStorageOrderbyCustomer(long customerId);

        Task<bool> CheckStorageOrderDetailsAccess(long customerId, long vendorId);

    }
}
