using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using StandardRail.RailCarLounge.Business.Pact;
using StandardRail.RailCarLounge.Common.UserContext;
using StandardRail.RailCarLounge.Data.SqlServer.Pact;
using StandardRail.RailCarLounge.Models.Entities;
using StandardRail.RailCarLounge.Models.ViewModels;

namespace StandardRail.RailCarLounge.Business
{
    /// <summary>
    /// Contains Business Logic for Vendor.
    /// </summary>
    public class VendorService : IVendorService
    {
        private readonly IRepository<Vendor, long> _repository;
        private readonly IRepository<User, long> _userRepository;
        private readonly IContractService _contractService;
        private readonly IRepository<ContractViewModel, long> _contractRepository;

        private readonly long? OrganizationId;
        private readonly string CurrentRole;
        public VendorService(IRepository<Vendor, long> repository,
            IRepository<User, long> userRepository, IUserContext claimsProvider, IContractService contractService, IRepository<ContractViewModel, long> contractRepository)
        {
            _repository = repository ?? throw new ArgumentNullException(nameof(repository));
            _userRepository = userRepository ?? throw new ArgumentNullException(nameof(userRepository));
            _contractService = contractService ?? throw new ArgumentNullException(nameof(contractService));
            _contractRepository = contractRepository ?? throw new ArgumentNullException(nameof(contractRepository));
            OrganizationId = claimsProvider.OrganizationId;
            CurrentRole = claimsProvider.CurrentRole;
        }

        /// <inheritdoc cref="StandardRail.RailCarLounge.Business.Pact.IVendorService"/>
        public async Task<Vendor> GetVendorForUser(long userId)
        {
            var vendor = new Vendor();
            var user = await _userRepository.GetById(userId);
            if (user != null)
            {
                vendor = (await this._repository.GetByCondition(t => t.OrganizationId == user.OrganizationId)).FirstOrDefault();
            }
            return vendor;
        }

        /// <inheritdoc cref="StandardRail.RailCarLounge.Business.Pact.IVendorService"/>
        public async Task<IList<Vendor>> GetVendorList(string searchText)
        {
            return (await this._repository.GetByCondition(t => t.IsActive.HasValue && t.IsActive.Value && t.Organization.Trim().ToLower().StartsWith(searchText.Trim().ToLower()))).Take(50).ToList().Select(x => { x.PercentageMargin=0; return x; }).ToList();
        }

        /// <inheritdoc cref="StandardRail.RailCarLounge.Business.Pact.IVendorService"/>
        public async Task<bool> CheckVendorDetailsAccess(long vendorId, long customerId)
        {
            if (customerId == 0)
            {
                if (CurrentRole.Contains("Admin", StringComparison.OrdinalIgnoreCase))
                {
                    return true;
                }
                var vendor = (await this._repository.GetByCondition(t => t.Id == vendorId)).FirstOrDefault();
                if (vendor != null && vendor.OrganizationId == OrganizationId)
                {
                    return true;
                }
                return false;
            }
            else
            {
                return await _contractService.ValidateCustomerVendorWithSO(vendorId, customerId);
            }
        }

        /// <inheritdoc cref="StandardRail.RailCarLounge.Business.Pact.IVendorService"/>
        public async Task<decimal?> GetPercentageMarginForVendor(long storageOrderId, long vendorId)
        {
            var storageOrder = await _contractRepository.GetById(storageOrderId);
            string role = !string.IsNullOrEmpty(CurrentRole) ? CurrentRole.Split('_')[0] : string.Empty;
            if (storageOrder.Id == 0 || storageOrder.PercentageRate.BookingFee == null)
                return (await this._repository.GetByCondition(t => t.Id == vendorId)).ToList()
                    .Select(c => new Vendor()
                    {
                        PercentageMargin = (role == "Customer") ? 0 : c.PercentageMargin
                    }).FirstOrDefault().PercentageMargin;
            else
                return storageOrder.PercentageRate.ListingFee;
        }
    }
}
