using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using AutoMapper;
using StandardRail.RailCarLounge.Business.Pact;
using StandardRail.RailCarLounge.Common.UserContext;
using StandardRail.RailCarLounge.Data.SqlServer.Pact;
using StandardRail.RailCarLounge.Models.Entities;
using StandardRail.RailCarLounge.Models.ViewModels;

namespace StandardRail.RailCarLounge.Business
{
    /// <summary>
    /// Contains Business Logic for Customer.
    /// </summary>
    public class CustomerService : ICustomerService
    {
        private readonly IRepository<CustomerFilterViewModel, long> _customerADORepository;
        private readonly IRepository<Customer, long> _customerRepository;
        private readonly IRepository<User, long> _userRepository;
        private readonly IContractService _contractService;
        private readonly IRepository<ContractViewModel, long> _contractRepository;
        private readonly IMapper _mapper;
        private long? OrganizationId;
        private readonly string CurrentRole;

        public CustomerService(IRepository<Customer, long> customerRepository, IMapper mapper,
            IRepository<CustomerFilterViewModel, long> customerADORepository,
            IRepository<User, long> userRepository, IUserContext claimsProvider,
            IContractService contractService, IRepository<ContractViewModel, long> contractRepository)
        {
            _customerRepository = customerRepository ?? throw new ArgumentNullException(nameof(customerRepository));
            _mapper = mapper ?? throw new ArgumentNullException(nameof(mapper));
            _customerADORepository = customerADORepository ?? throw new ArgumentNullException(nameof(customerADORepository));
            _userRepository = userRepository ?? throw new ArgumentNullException(nameof(userRepository));
            _contractService = contractService ?? throw new ArgumentNullException(nameof(contractService));
            _contractRepository = contractRepository ?? throw new ArgumentNullException(nameof(contractRepository));
            OrganizationId = claimsProvider.OrganizationId;
            CurrentRole = claimsProvider.CurrentRole;
        }

        /// <inheritdoc cref="StandardRail.RailCarLounge.Business.Pact.ICustomerService"/>
        public Task<IList<Customer>> GetCustomerList()
        {
            return _customerRepository.GetAll();
        }

        /// <inheritdoc cref="StandardRail.RailCarLounge.Business.Pact.ICustomerService"/>
        public Task<Customer> OnBoardNewCustomers(CustomerViewModel customerModel)
        {
            var customerEntity = this._mapper.Map<Customer>(customerModel);
            // save customer detail
            var savedEntity = _customerRepository.Create(customerEntity);
            return savedEntity;
        }

        /// <inheritdoc cref="StandardRail.RailCarLounge.Business.Pact.ICustomerService"/>
        public async Task<CustomerFilterViewModel> GetCustomersOnFilter(CustomerFilterViewModel customerFilterModel)
        {
            return await _customerADORepository.SearchWithPagination(customerFilterModel);
        }

        /// <inheritdoc cref="StandardRail.RailCarLounge.Business.Pact.ICustomerService"/>
        public Task<Customer> GetCustomerById(long id)
        {
            var customerDetail = _customerRepository.GetById(id);
            return customerDetail;
        }

        /// <inheritdoc cref="StandardRail.RailCarLounge.Business.Pact.ICustomerService"/>
        public async Task UpdateCustomerDetail(CustomerViewModel customerViewModel)
        {
            var customerEntity = _mapper.Map<Customer>(customerViewModel);
            await _customerRepository.Update(customerEntity);
        }

        /// <inheritdoc cref="StandardRail.RailCarLounge.Business.Pact.ICustomerService"/>
        public async Task<IList<CustomerAutoCompleteViewModel>> GetCustomers(string searchText)
        {
           
            return (await _customerRepository.GetByCondition(t => t.Organization.Name.Trim().ToLower().StartsWith(searchText.Trim().ToLower()))).Take(50)
                .Select(c => new CustomerAutoCompleteViewModel()
                {
                    Name = c.Organization.Name,
                    Id = c.Id
                }).ToList();
        }

        /// <inheritdoc cref="StandardRail.RailCarLounge.Business.Pact.ICustomerService"/>
        public async Task<CustomerAutoCompleteViewModel> GetCustomerForUser(long userId)
        {
            var customer = new CustomerAutoCompleteViewModel();
            var user = await _userRepository.GetById(userId);
            if (user != null)
            {
                customer = (await _customerRepository.GetByCondition(t => t.OrganizationId == user.OrganizationId)).ToList()
                            .Select(c => new CustomerAutoCompleteViewModel()
                            {
                                Name = c.Organization.Name,
                                Id = c.Id
                            }).FirstOrDefault();
            }
            return customer;
        }

        /// <inheritdoc cref="StandardRail.RailCarLounge.Business.Pact.ICustomerService"/>
        public async Task<bool> CheckCustomerDetailsAccess(long customerId, long vendorId)
        {
            if (vendorId == 0)
            {
                if (CurrentRole.Contains("Admin", StringComparison.OrdinalIgnoreCase))
                {
                    return true;
                }
                var customer = (await this._customerRepository.GetByCondition(t => t.Id == customerId)).FirstOrDefault();
                if (customer != null && customer.OrganizationId == OrganizationId)
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

        /// <inheritdoc cref="StandardRail.RailCarLounge.Business.Pact.ICustomerService"/>
        public async Task<decimal?> GetPercentageMarginForCustomer(long storageOrderId,long customerId)
        {
            var storageOrder = await _contractRepository.GetById(storageOrderId);
            string role = !string.IsNullOrEmpty(CurrentRole) ? CurrentRole.Split('_')[0] : string.Empty;
            if (storageOrder.Id== 0 || storageOrder.PercentageRate.BookingFee == null )
                return (await _customerRepository.GetByCondition(t => t.Id == customerId)).ToList()
                                 .Select(c => new Customer()
                                 {
                                     PercentageMargin = (role == "Vendor") ? 0 : c.PercentageMargin
                                 }).FirstOrDefault().PercentageMargin;
            else
                return storageOrder.PercentageRate.BookingFee;

        }
    }
}