using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Threading.Tasks;
using AutoMapper;
using StandardRail.RailCarLounge.Business.Pact;
using StandardRail.RailCarLounge.Common.UserContext;
using StandardRail.RailCarLounge.Data.SqlServer;
using StandardRail.RailCarLounge.Data.SqlServer.Pact;
using StandardRail.RailCarLounge.Models.Entities;
using StandardRail.RailCarLounge.Models.Enums;
using StandardRail.RailCarLounge.Models.ViewModels;

namespace StandardRail.RailCarLounge.Business
{
    /// <summary>
    /// Contains Business Logic for Contract.
    /// </summary>
    public class ContractService : IContractService
    {
        private readonly IRepository<ContractViewModel, long> _adoRepository;
        private readonly IRepository<Contract, long> _repository;
        private readonly IRepository<ContractDTViewModel, long> _contractDTRepository;
        private readonly IRepository<Customer, long> _customerRepository;
        private readonly IRepository<Vendor, long> _vendorRepository;
        private readonly IRepository<User, long> _userRepository;
        private readonly IMapper _mapper;
        private readonly RailCarLoungeContext _railCarLoungeContext;
        private readonly IAuditLogService _auditLogService;
        private readonly ICommonService _commonService;
        private readonly string CurrentRole;
        private DataTable dtContract = null;
        private DataTable dtContractRate = null;
        private DataTable dtContractSFFeatureMapping = null;
        private long? UserId;
        private long? TenantId;
        private long? OrganizationId;

        public ContractService(IRepository<ContractViewModel, long> adoRepository, IMapper mapper, IRepository<Contract, long> repository,
            RailCarLoungeContext railCarLoungeContext, IAuditLogService auditLogService, IUserContext userContext,
            ICommonService commonService, IRepository<ContractDTViewModel, long> contractDTRepository, IRepository<User, long> userRepository, 
            IRepository<Customer, long> customerRepository, IRepository<Vendor, long> vendorRepository)
        {
            _adoRepository = adoRepository ?? throw new ArgumentNullException(nameof(adoRepository));
            _mapper = mapper ?? throw new ArgumentNullException(nameof(mapper));
            _repository = repository ?? throw new ArgumentNullException(nameof(repository));
            _railCarLoungeContext = railCarLoungeContext ?? throw new ArgumentNullException(nameof(railCarLoungeContext));
            _auditLogService = auditLogService ?? throw new ArgumentNullException(nameof(auditLogService));
            _commonService = commonService ?? throw new ArgumentNullException(nameof(commonService));
            _contractDTRepository = contractDTRepository ?? throw new ArgumentNullException(nameof(contractDTRepository));
            _userRepository = userRepository ?? throw new ArgumentNullException(nameof(userRepository));
            _customerRepository = customerRepository ?? throw new ArgumentNullException(nameof(customerRepository));
            _vendorRepository = vendorRepository ?? throw new ArgumentNullException(nameof(vendorRepository));
            CurrentRole = userContext.CurrentRole;
            UserId = userContext.UserId;
            TenantId = userContext.TenantId;
            OrganizationId = userContext.OrganizationId;
        }

        /// <inheritdoc cref="StandardRail.RailCarLounge.Business.Pact.IContractService"/>
        public async Task<ContractViewModel> GetStorageOrderDetails(ContractViewModel contractViewModel)
        {
            return await _adoRepository.SearchWithPagination(contractViewModel);
        }

        /// <inheritdoc cref="StandardRail.RailCarLounge.Business.Pact.IContractService"/>
        public async Task<ContractViewModel> GetStorageOrderDetailsById(long Id)
        {
            return await _adoRepository.GetById(Id);
        }

        /// <inheritdoc cref="StandardRail.RailCarLounge.Business.Pact.IContractService"/>
        public async Task<ContractViewModel> SaveStorageOrder(ContractViewModel contractViewModel)
        {
            string year = DateTime.Parse(contractViewModel.EffectiveDate.ToString()).Year.ToString();
            int storageOrderCount = _adoRepository.GetCount(contractViewModel);
            storageOrderCount++;
            string storageOrderName = contractViewModel.VendorName + " - " + contractViewModel.CustomerName + " - " + year + " - " + storageOrderCount;
            var contract = this._mapper.Map<Contract>(contractViewModel);
            if (contractViewModel.StorageFeatureIds != null && contractViewModel.StorageFeatureIds.Count >= 1)
            {
                //if (riderViewModel.StorageFeatureIds.Contains(Convert.ToInt32(FacilityFeature.HazmatCars)))
                //{
                //    contract.AcceptHazmatCars = true;
                //}
                //if (riderViewModel.StorageFeatureIds.Contains(Convert.ToInt32(FacilityFeature.LoadedCars)))
                //{
                //    contract.AcceptLoadedCars = true;
                //}
            }
            contract.Rider = storageOrderName;

            contractViewModel.Rider = storageOrderName;
            ContractDTViewModel contractViewModelDataTable = new ContractDTViewModel();
            contractViewModelDataTable.Contract = PrepareContractDt(contractViewModel);
            contractViewModelDataTable.ContractRates = PrepareContractRateDt(contractViewModel);
            contractViewModelDataTable.ContractSFFeatureMapping = PrepareContractSFFeatureMappingDT(contractViewModel);

            var savedContract = await _repository.Create(contract);

            if (savedContract.Id > 0)
            {
                await _auditLogService.LogStorageOrderEvents(savedContract.Id, AuditLogEvents.StorageOrderCreated, "Storage Order Created.");
            }

            var mappedRiderViewModel = this._mapper.Map<ContractViewModel>(savedContract);
            return mappedRiderViewModel;
        }

        /// <inheritdoc cref="StandardRail.RailCarLounge.Business.Pact.IContractService"/>
        public async Task<ContractViewModel> SaveContractDetail(ContractViewModel contractViewModel)
        {
            if (contractViewModel != null)
            {
                string storageOrderName = string.Empty;
                if (contractViewModel?.Id == 0)
                {
                    string year = DateTime.Parse(contractViewModel.EffectiveDate.ToString()).Year.ToString();
                    int storageOrderCount = _adoRepository.GetCount(contractViewModel);
                    storageOrderCount++;
                    storageOrderName = contractViewModel.VendorName + " - " + contractViewModel.CustomerName + " - " + year + " - " + storageOrderCount;
                }
                else
                {
                    storageOrderName = contractViewModel.Rider;
                }

                if (contractViewModel.StorageFeatureIds != null && contractViewModel.StorageFeatureIds.Count >= 1)
                {
                    //if (riderViewModel.StorageFeatureIds.Contains(Convert.ToInt32(FacilityFeature.HazmatCars)))
                    //{
                    //    contract.AcceptHazmatCars = true;
                    //}
                    //if (riderViewModel.StorageFeatureIds.Contains(Convert.ToInt32(FacilityFeature.LoadedCars)))
                    //{
                    //    contract.AcceptLoadedCars = true;
                    //}
                }
                //contract.Rider = storageOrderName;

                contractViewModel.Rider = storageOrderName;
                ContractDTViewModel contractViewModelDataTable = new ContractDTViewModel();
                contractViewModelDataTable.Contract = PrepareContractDt(contractViewModel);
                contractViewModelDataTable.ContractRates = PrepareContractRateDt(contractViewModel);
                contractViewModelDataTable.ContractSFFeatureMapping = PrepareContractSFFeatureMappingDT(contractViewModel);
                var auditlog = contractViewModel.Id == 0 ? "Storage Order Created." : "Storage Order updated.";
                var action = contractViewModel.Id == 0 ? AuditLogEvents.StorageOrderCreated : AuditLogEvents.StorageOrderUpdated;
                await _contractDTRepository.Create(contractViewModelDataTable);
                contractViewModel.Id = contractViewModelDataTable.Contract.AsEnumerable()
                   .Select(r => r.Field<long>("Id")).FirstOrDefault();
                await _auditLogService.LogStorageOrderEvents(contractViewModel.Id, action, auditlog);
            }
            return contractViewModel;
        }

        /// <inheritdoc cref="StandardRail.RailCarLounge.Business.Pact.IContractService"/>
        public async Task UpdateStorageOrder(ContractViewModel contractViewModel)
        {
            var contract = this._mapper.Map<Contract>(contractViewModel);
            //if (riderViewModel.StorageFeatureIds != null && riderViewModel.StorageFeatureIds.Count >= 1)
            //{
            //    if (riderViewModel.StorageFeatureIds.Contains(Convert.ToInt32(FacilityFeature.HazmatCars)))
            //    {
            //        contract.AcceptHazmatCars = true;
            //    }
            //    if (riderViewModel.StorageFeatureIds.Contains(Convert.ToInt32(FacilityFeature.LoadedCars)))
            //    {
            //        contract.AcceptLoadedCars = true;
            //    }
            //}
            //else
            //{
            //    contract.AcceptHazmatCars = false;
            //    contract.AcceptLoadedCars = false;
            //}
            contract.IsActive = true;
            await _repository.Update(contract);
            await _auditLogService.LogStorageOrderEvents(contract.Id, AuditLogEvents.StorageOrderUpdated, "Storage Order updated.");
        }

        /// <inheritdoc cref="StandardRail.RailCarLounge.Business.Pact.IContractService"/>
        public async Task UpdateStorageOrderForCarsStored(long contractId, long carsStored)
        {
            var contract = this._railCarLoungeContext.Contracts.Where(s => s.Id == contractId).FirstOrDefault();
            contract.CarsStored = carsStored + contract.CarsStored;
            await _repository.Update(contract);
        }

        /// <inheritdoc cref="StandardRail.RailCarLounge.Business.Pact.IContractService"/>
        public async Task<IList<Contract>> GetStorageOrderList(string searchText)
        {
            if (CurrentRole.StartsWith("Vendor", StringComparison.OrdinalIgnoreCase))
            {
                var vendor = await _commonService.GetVendorForLoggedInUser();
                return (await this._repository.GetByCondition(t => t.VendorId == vendor.Id && t.Rider.Trim().ToLower().StartsWith(searchText.Trim().ToLower()))).Take(50).ToList();
            }
            else if (CurrentRole.StartsWith("Customer", StringComparison.OrdinalIgnoreCase))
            {
                var customer = await _commonService.GetCustomerForLoggedInUser();
                return (await this._repository.GetByCondition(t => t.CustomerId == customer.Id && t.Rider.Trim().ToLower().StartsWith(searchText.Trim().ToLower()))).Take(50).ToList();
            }
            else
            {
                return (await this._repository.GetByCondition(t => t.Rider.Trim().ToLower().StartsWith(searchText.Trim().ToLower()))).Take(50).ToList();
            }
        }

        /// <inheritdoc cref="StandardRail.RailCarLounge.Business.Pact.IContractService"/>
        public async Task<bool> ValidateAndExpire(long Id)
        {
            var isExpired = false;
            var underStorageRailCarMappings = this._railCarLoungeContext.ContractRailCarMappings.Where(s => s.ContractId == Id && s.IsActive == true && s.IsUnderStorage).FirstOrDefault();
            if (underStorageRailCarMappings != null && underStorageRailCarMappings.ContractId > 0)
            {
                isExpired = false;
            }
            else
            {
                var contract = this._railCarLoungeContext.Contracts.Where(s => s.Id == Id).FirstOrDefault();
                contract.ExpiryDate = DateTime.Now;
                await _repository.Update(contract);
                isExpired = true;
                await _auditLogService.LogStorageOrderEvents(Id, AuditLogEvents.StorageOrderExpired, "Storage Order Expired.");
            }
            return isExpired;
        }

        /// <inheritdoc cref="StandardRail.RailCarLounge.Business.Pact.IContractService"/>
        public async Task<bool> ValidateCustomerVendorWithSO(long vendorId, long customerId)
        {
            var storageOrders = await this._repository.GetByCondition(c => c.CustomerId == customerId && c.VendorId == vendorId);
            if (storageOrders != null && storageOrders.Count() > 0)
            {
                return true;
            }
            return false;
        }

        /// <inheritdoc cref="StandardRail.RailCarLounge.Business.Pact.IContractService"/>
        public async Task<bool> CheckStorageOrderDetailsAccess(long customerId, long vendorId)
        {
            if (CurrentRole.Contains("Admin", StringComparison.OrdinalIgnoreCase))
            {
                return true;
            }
            var user = await _userRepository.GetById(UserId.Value);
            if (CurrentRole.StartsWith("Customer", StringComparison.OrdinalIgnoreCase) && user != null)
            {
                var customer = (await _customerRepository.GetByCondition(t => t.OrganizationId == user.OrganizationId)).FirstOrDefault();
                if (customer != null && customer.Id == customerId)
                {
                    return true;
                }
            }
            else if (CurrentRole.StartsWith("Vendor", StringComparison.OrdinalIgnoreCase) && user != null)
            {
                var vendor = (await this._vendorRepository.GetByCondition(t => t.OrganizationId == user.OrganizationId)).FirstOrDefault();
                if (vendor != null && vendor.Id == vendorId)
                {
                    return true;
                }
            }
            return false;
        }

        private DataTable PrepareContractDt(ContractViewModel contractViewModel)
        {
            if (dtContract == null)
            {
                CreateContractDT();
            }
            dtContract.Rows.Add(contractViewModel.Id, contractViewModel.VendorId, contractViewModel.CustomerId, contractViewModel.Rider,
                contractViewModel.StorageFacilityId, contractViewModel.EffectiveDate, contractViewModel.ExpiryDate, contractViewModel.ContractTypeId,
                contractViewModel.TotalCars, contractViewModel.CurrencyId, contractViewModel.Description, contractViewModel.Location,
                contractViewModel.CarsStored, contractViewModel.ReservedSpaces, contractViewModel.IsFlatRateContract, contractViewModel.IsAdvancedSwitchingRatesEnabled, true, DateTime.UtcNow, UserId,
                DateTime.UtcNow, UserId, OrganizationId, TenantId);
            return dtContract;
        }

        private DataTable PrepareContractRateDt(ContractViewModel contractViewModel)
        {
            if (dtContractRate == null)
            {
                CreateContractRateDT();
            }
            ContractRatesViewModel ratesViewModel;
            if (contractViewModel.IsFlatRateContract)
            {
                if (contractViewModel.CustomerRate != null && contractViewModel.CustomerRate.DailyStorageRate > 0)
                {
                    ratesViewModel = contractViewModel.CustomerRate;
                    dtContractRate.Rows.Add(ratesViewModel.Id,
                        contractViewModel.Id,
                        ratesViewModel.RateTypeId,
                        contractViewModel.IsAdvancedSwitchingRatesEnabled ? ratesViewModel.StandardSwitchIn : ratesViewModel.SwitchIn,
                        contractViewModel.IsAdvancedSwitchingRatesEnabled ? ratesViewModel.StandardSwitchOut : ratesViewModel.SwitchOut,
                        ratesViewModel.SpecialSwitchingRate,
                        ratesViewModel.DailyStorageRate,
                        ratesViewModel.SwitchingRate,
                        ratesViewModel.HazmatSurcharge,
                        ratesViewModel.LoadedSurcharge,
                        ratesViewModel.ReservationRate,
                        ratesViewModel.CherryPickingRate,
                        ratesViewModel.BookingFee,
                        ratesViewModel.ListingFee,
                        true,
                        DateTime.UtcNow,
                        UserId,
                        DateTime.UtcNow,
                        UserId,
                        OrganizationId,
                        TenantId,
                        ratesViewModel.IsAdvancedHazmatSwitchingEnabled,
                        ratesViewModel.IsAdvancedLoadedSwitchingEnabled,
                        ratesViewModel.HazmatSwitchIn,
                        ratesViewModel.HazmatSwitchOut,
                        ratesViewModel.LoadedSwitchIn,
                        ratesViewModel.LoadedSwitchOut);
                }
                if (contractViewModel.VendorCost != null && contractViewModel.VendorCost.DailyStorageRate > 0)
                {
                    ratesViewModel = contractViewModel.VendorCost;
                    dtContractRate.Rows.Add(ratesViewModel.Id,
                        contractViewModel.Id,
                        ratesViewModel.RateTypeId,
                        contractViewModel.IsAdvancedSwitchingRatesEnabled ? ratesViewModel.StandardSwitchIn : ratesViewModel.SwitchIn,
                        contractViewModel.IsAdvancedSwitchingRatesEnabled ? ratesViewModel.StandardSwitchOut : ratesViewModel.SwitchOut,
                        ratesViewModel.SpecialSwitchingRate,
                        ratesViewModel.DailyStorageRate,
                        ratesViewModel.SwitchingRate,
                        ratesViewModel.HazmatSurcharge,
                        ratesViewModel.LoadedSurcharge,
                        ratesViewModel.ReservationRate,
                        ratesViewModel.CherryPickingRate,
                        ratesViewModel.BookingFee,
                        ratesViewModel.ListingFee,
                        true,
                        DateTime.UtcNow,
                        UserId,
                        DateTime.UtcNow,
                        UserId,
                        OrganizationId,
                        TenantId,
                        ratesViewModel.IsAdvancedHazmatSwitchingEnabled,
                        ratesViewModel.IsAdvancedLoadedSwitchingEnabled,
                        ratesViewModel.HazmatSwitchIn,
                        ratesViewModel.HazmatSwitchOut,
                        ratesViewModel.LoadedSwitchIn,
                        ratesViewModel.LoadedSwitchOut);
                }
            }
            else
            {
                if (contractViewModel.PercentageRate != null && contractViewModel.PercentageRate.DailyStorageRate > 0)
                {
                    ratesViewModel = contractViewModel.PercentageRate;
                    dtContractRate.Rows.Add(ratesViewModel.Id,
                        contractViewModel.Id,
                        ratesViewModel.RateTypeId,
                        contractViewModel.IsAdvancedSwitchingRatesEnabled ? ratesViewModel.StandardSwitchIn : ratesViewModel.SwitchIn,
                        contractViewModel.IsAdvancedSwitchingRatesEnabled ? ratesViewModel.StandardSwitchOut : ratesViewModel.SwitchOut,
                        ratesViewModel.SpecialSwitchingRate,
                        ratesViewModel.DailyStorageRate,
                        ratesViewModel.SwitchingRate,
                        ratesViewModel.HazmatSurcharge,
                        ratesViewModel.LoadedSurcharge,
                        ratesViewModel.ReservationRate,
                        ratesViewModel.CherryPickingRate,
                        ratesViewModel.BookingFee,
                        ratesViewModel.ListingFee,
                        true,
                        DateTime.UtcNow,
                        UserId,
                        DateTime.UtcNow,
                        UserId,
                        OrganizationId,
                        TenantId,
                        ratesViewModel.IsAdvancedHazmatSwitchingEnabled,
                        ratesViewModel.IsAdvancedLoadedSwitchingEnabled,
                        ratesViewModel.HazmatSwitchIn,
                        ratesViewModel.HazmatSwitchOut,
                        ratesViewModel.LoadedSwitchIn,
                        ratesViewModel.LoadedSwitchOut);
                }
            }
            return dtContractRate;
        }

        private DataTable PrepareContractSFFeatureMappingDT(ContractViewModel contractViewModel)
        {
            if (dtContractSFFeatureMapping == null)
            {
                CreateContractSFFeatureMappingDT();
            }
            if (contractViewModel.storageFeatureViewModels != null && contractViewModel.storageFeatureViewModels.Count > 0)
            {
                foreach (var storageFeatureViewModel in contractViewModel.storageFeatureViewModels)
                {
                    dtContractSFFeatureMapping.Rows.Add(contractViewModel.Id, storageFeatureViewModel.Id, storageFeatureViewModel.IsActive, DateTime.UtcNow, UserId,
                        DateTime.UtcNow, UserId, OrganizationId, TenantId);
                }
            }
            return dtContractSFFeatureMapping;
        }

        private void CreateContractDT()
        {
            dtContract = new DataTable();
            dtContract.Columns.Add("Id", typeof(long));
            dtContract.Columns.Add("VendorId", typeof(long));
            dtContract.Columns.Add("CustomerId", typeof(long));
            dtContract.Columns.Add("Rider", typeof(string));
            dtContract.Columns.Add("StorageFacilityId", typeof(long));
            dtContract.Columns.Add("EffectiveDate", typeof(DateTime));
            dtContract.Columns.Add("ExpiryDate", typeof(DateTime));
            dtContract.Columns.Add("ContractTypeId", typeof(long));
            dtContract.Columns.Add("TotalCars", typeof(long));
            dtContract.Columns.Add("CurrencyId", typeof(long));
            dtContract.Columns.Add("Description", typeof(string));
            dtContract.Columns.Add("Location", typeof(string));
            dtContract.Columns.Add("CarsStored", typeof(long));
            dtContract.Columns.Add("ReservedSpaces", typeof(long));
            dtContract.Columns.Add("IsFlatRateContract", typeof(bool));
            dtContract.Columns.Add("IsAdvancedSwitchingRatesEnabled", typeof(bool));
            dtContract.Columns.Add("IsActive", typeof(bool));
            dtContract.Columns.Add("CreatedTime", typeof(DateTime));
            dtContract.Columns.Add("CreatedBy", typeof(long));
            dtContract.Columns.Add("ModifiedTime", typeof(DateTime));
            dtContract.Columns.Add("ModifiedBy", typeof(long));
            dtContract.Columns.Add("OrganizationId", typeof(long));
            dtContract.Columns.Add("TenantId", typeof(long));
        }

        private void CreateContractRateDT()
        {
            dtContractRate = new DataTable();
            dtContractRate.Columns.Add("Id", typeof(long));
            dtContractRate.Columns.Add("ContractId", typeof(long));
            dtContractRate.Columns.Add("RateTypeId", typeof(long));
            dtContractRate.Columns.Add("SwitchIn", typeof(decimal));
            dtContractRate.Columns.Add("SwitchOut", typeof(decimal));
            dtContractRate.Columns.Add("SpecialSwitchingRate", typeof(decimal));
            dtContractRate.Columns.Add("DailyStorageRate", typeof(decimal));
            dtContractRate.Columns.Add("SwitchingRate", typeof(decimal));
            dtContractRate.Columns.Add("HazmatSurcharge", typeof(decimal));
            dtContractRate.Columns.Add("LoadedSurcharge", typeof(decimal));
            dtContractRate.Columns.Add("ReservationRate", typeof(decimal));
            dtContractRate.Columns.Add("CherryPickingRate", typeof(decimal));
            dtContractRate.Columns.Add("BookingFee", typeof(decimal));
            dtContractRate.Columns.Add("ListingFee", typeof(decimal));
            dtContractRate.Columns.Add("IsActive", typeof(bool));
            dtContractRate.Columns.Add("CreatedTime", typeof(DateTime));
            dtContractRate.Columns.Add("CreatedBy", typeof(long));
            dtContractRate.Columns.Add("ModifiedTime", typeof(DateTime));
            dtContractRate.Columns.Add("ModifiedBy", typeof(long));
            dtContractRate.Columns.Add("OrganizationId", typeof(long));
            dtContractRate.Columns.Add("TenantId", typeof(long));
            dtContractRate.Columns.Add("IsAdvancedHazmatSwitchingEnabled", typeof(bool));
            dtContractRate.Columns.Add("IsAdvancedLoadedSwitchingEnabled", typeof(bool));
            dtContractRate.Columns.Add("HazmatSwitchIn", typeof(decimal));
            dtContractRate.Columns.Add("HazmatSwitchOut", typeof(decimal));
            dtContractRate.Columns.Add("LoadedSwitchIn", typeof(decimal));
            dtContractRate.Columns.Add("LoadedSwitchOut", typeof(decimal));
        }

        public async Task<List<StorageOrderModel>> GetStorageOrderbyCustomer(long customerId)
        {
            var storageOrderModels = this._repository.GetByCondition(t => t.CustomerId == customerId).Result.Select(t => new StorageOrderModel()
            {
                Id = t.Id,
                Name = t.Rider,
                ContractTypeId = (long)t.ContractTypeId,
                ContractType = t.ContractType.Name
            }).ToList();
            return storageOrderModels.ToList();
        }

        private void CreateContractSFFeatureMappingDT()
        {
            dtContractSFFeatureMapping = new DataTable();
            dtContractSFFeatureMapping.Columns.Add("ContractId", typeof(long));
            dtContractSFFeatureMapping.Columns.Add("StorageFeatureId", typeof(long));
            dtContractSFFeatureMapping.Columns.Add("IsActive", typeof(bool));
            dtContractSFFeatureMapping.Columns.Add("CreatedTime", typeof(DateTime));
            dtContractSFFeatureMapping.Columns.Add("CreatedBy", typeof(long));
            dtContractSFFeatureMapping.Columns.Add("ModifiedTime", typeof(DateTime));
            dtContractSFFeatureMapping.Columns.Add("ModifiedBy", typeof(long));
            dtContractSFFeatureMapping.Columns.Add("OrganizationId", typeof(long));
            dtContractSFFeatureMapping.Columns.Add("TenantId", typeof(long));
        }
    }
}
