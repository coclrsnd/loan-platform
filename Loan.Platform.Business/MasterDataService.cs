using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using AutoMapper;
using Loan.Platform.Business.Pact;
using Loan.Platform.Data.SqlServer.Pact;
using Loan.Platform.Models.Entities;
using Loan.Platform.Models.UserManagementModels;
using Loan.Platform.Models.ViewModels;

namespace Loan.Platform.Business
{
    /// <summary>
    /// Contains Business logic for master data.
    /// </summary>
    public class MasterDataService : IMasterDataService
    {
        private readonly IRepository<Country, long> _countryRepository;

        private readonly IRepository<State, long> _stateRepository;

        private readonly IRepository<Customer, long> _customerRepository;

        private readonly IRepository<Vendor, long> _vendorRepository;
        private readonly IRepository<Organization, long> _organizationRepository;

        private readonly IRepository<StorageFacilityInterchange, long> _sfInterchangeRepository;

        private readonly IRepository<RailRoad, long> _railRoadRepository;

        private readonly IRepository<UserType, long> _userTypeRepository;

        private readonly IRepository<UserStatus, long> _userStatusRepository;

        private readonly IMapper _mapper;

        private readonly IRepository<Region, long> _regionRepository;

        private readonly IRepository<RateType, long> _rateTypeRepository;

        private readonly IRepository<RangeMaster, long> _rangeMasterRepository;

        public MasterDataService(IRepository<Country, long> countryRepository, IRepository<State, long> stateRepository,
            IRepository<Customer, long> customerRepository, IRepository<Organization, long> organizationRepository,
            IMapper mapper, IRepository<Region, long> regionRepository,
            IRepository<StorageFacilityInterchange, long> sfInterchangeRepository,
            IRepository<Vendor, long> vendorRepository,
            IRepository<RailRoad, long> railRoadRepository,
            IRepository<UserType, long> userTypeRepository,
            IRepository<UserStatus, long> userStatusRepository,
            IRepository<RateType, long> rateTypeRepository,
            IRepository<RangeMaster, long> rangeMasterRepository)
        {
            _rangeMasterRepository = rangeMasterRepository ?? throw new ArgumentNullException(nameof(rangeMasterRepository));
            _countryRepository = countryRepository ?? throw new ArgumentNullException(nameof(countryRepository));
            _stateRepository = stateRepository ?? throw new ArgumentNullException(nameof(stateRepository));
            _customerRepository = customerRepository ?? throw new ArgumentNullException(nameof(customerRepository));
            _organizationRepository = organizationRepository ?? throw new ArgumentNullException(nameof(organizationRepository));
            _mapper = mapper ?? throw new ArgumentNullException(nameof(mapper));
            _regionRepository = regionRepository ?? throw new ArgumentNullException(nameof(regionRepository));
            _sfInterchangeRepository = sfInterchangeRepository ?? throw new ArgumentNullException(nameof(sfInterchangeRepository));
            _vendorRepository = vendorRepository ?? throw new ArgumentNullException(nameof(vendorRepository));
            _railRoadRepository = railRoadRepository ?? throw new ArgumentNullException(nameof(railRoadRepository));
            _userTypeRepository = userTypeRepository ?? throw new ArgumentNullException(nameof(userTypeRepository));
            _userStatusRepository = userStatusRepository ?? throw new ArgumentNullException(nameof(userStatusRepository));
            _rateTypeRepository = rateTypeRepository ?? throw new ArgumentNullException(nameof(rateTypeRepository));
        }

        /// <inheritdoc cref="Loan.Platform.Business.Pact.IMasterDataService"/>
        public async Task<IList<Country>> GetAllCountries()
        {
            return await _countryRepository.GetAll();
        }

        /// <inheritdoc cref="Loan.Platform.Business.Pact.IMasterDataService"/>
        public async Task<IList<State>> GetStateListByCountryID(long countryID)
        {
            if (countryID > 0)
            {
                return await _stateRepository.GetListById(countryID);
            }
            return await _stateRepository.GetAll();
        }

        /// <inheritdoc cref="Loan.Platform.Business.Pact.IMasterDataService"/>
        public async Task<IList<string>> GetCityList(string reqFor)
        {
            if (reqFor.Trim().ToLower() == "cust")
            {
                var customersList =await _customerRepository.GetByCondition(t => t.IsActive.HasValue && t.IsActive.Value && !string.IsNullOrEmpty(t.City));
                if (customersList != null && customersList.Count() > 0)
                {
                    return customersList.Select(t => t.City).Distinct().ToList();
                }
            }
            else
            {
                var vendorData =await _vendorRepository.GetByCondition(t => t.IsActive.HasValue && t.IsActive.Value && !string.IsNullOrEmpty(t.City));
                if (vendorData != null && vendorData.Count() > 0)
                {
                    return vendorData.Select(t => t.City).Distinct().ToList();
                }
            }
            return null;
        }

        public IList<string> GetCustomerCityList()
        {
            var customersList = _customerRepository.GetByCondition(t => !string.IsNullOrEmpty(t.City)).Result;
            if (customersList != null && customersList.Count() > 0)
            {
                return customersList.Select(t => t.City).Distinct().ToList();
            }
            return null;

        }

        /// <inheritdoc cref="Loan.Platform.Business.Pact.IMasterDataService"/>
        public async Task<IList<Organization>> GetAllOrganizations(string searchText)
        {
            return (await _organizationRepository.GetByCondition(t => t.Name.Trim().ToLower().StartsWith(searchText.Trim().ToLower()))).Take(50).ToList();

        }

        /// <inheritdoc cref="Loan.Platform.Business.Pact.IMasterDataService"/>
        public async Task<Organization> SaveAndGetOrganization(OrganizationViewModel organizationModel)
        {
            organizationModel.Name = organizationModel.Name.Trim();
            organizationModel.Description = organizationModel.Description.Trim();
            var organizationEntity = _mapper.Map<Organization>(organizationModel);
            var organizationWithSameName = await _organizationRepository.GetByCondition(t => t.Name.Trim().ToLower() == organizationModel.Name.Trim().ToLower() && t.IsActive == true);
            if (organizationWithSameName != null && organizationWithSameName.Count() > 0)
            {
                return organizationWithSameName.FirstOrDefault();
            }

            var savedOrganizationData = _organizationRepository.Create(organizationEntity).Result;
            if (savedOrganizationData.Id > 0)
            {
                return savedOrganizationData;
            }

            return organizationEntity;
        }

        /// <inheritdoc cref="Loan.Platform.Business.Pact.IMasterDataService"/>
        public async Task<IList<Region>> GetRegions()
        {
            return (await _regionRepository.GetAll());
        }

        /// <inheritdoc cref="Loan.Platform.Business.Pact.IMasterDataService"/>
        public async Task<IList<StorageFacilityInterchangeViewModel>> GetInterchangesList(long organizationID, long storageFacilityID)
        {
            if (organizationID > 0 && storageFacilityID > 0)
            {
                return (
                     await
                    _sfInterchangeRepository.GetByCondition(t => t.IsActive.HasValue && t.IsActive.Value
                    && t.OrganizationId == organizationID &&
                    t.StorageFacilityId == storageFacilityID))
                    .Select(t => new StorageFacilityInterchangeViewModel()
                    {
                        MarkCode = t.MarkCode,
                        RailRoadId = t.RailRoadId,
                        RailRoadName = t.RailRoadName
                    }).Distinct()
                    .Take(50).ToList();
                //await
                //this._railRoadRepository.GetByCondition(t => t.OrganizationId == organizationID &&
                //t.StorageFacilityId == storageFacilityID)).Take(50).ToList();
            }
            else if (organizationID > 0)
            {
                return (
                    await
                    _sfInterchangeRepository.GetByCondition(t => t.IsActive.HasValue && t.IsActive.Value
                    && t.OrganizationId == organizationID))
                    .Select(t => new StorageFacilityInterchangeViewModel()
                    {
                        MarkCode = t.MarkCode,
                        RailRoadId = t.RailRoadId,
                        RailRoadName = t.RailRoadName
                    }).Distinct()
                    .Take(50).ToList();

            }
            else if (storageFacilityID > 0)
            {
                return (
                    await
                  _sfInterchangeRepository.GetByCondition(t => t.IsActive.HasValue && t.IsActive.Value
                  && t.StorageFacilityId == storageFacilityID))
                  .Select(t => new StorageFacilityInterchangeViewModel()
                  {
                      MarkCode = t.MarkCode,
                      RailRoadId = t.RailRoadId,
                      RailRoadName = t.RailRoadName
                  }).Distinct()
                  .Take(50).ToList();
                //await
                //this._railRoadRepository.GetByCondition(t => t.StorageFacilityId == storageFacilityID))
                //.Take(50).ToList();
            }
            else
            {
                return (
                  await
                  _sfInterchangeRepository.GetByCondition(t => t.IsActive.HasValue && t.IsActive.Value))
                  .Select(t => new StorageFacilityInterchangeViewModel()
                  {
                      MarkCode = t.MarkCode,
                      RailRoadId = t.RailRoadId,
                      RailRoadName = t.RailRoadName
                  }).Distinct()
                  .Take(50).ToList();
            }
        }

        /// <inheritdoc cref="Loan.Platform.Business.Pact.IMasterDataService"/>
        public async Task<IList<RailRoad>> GetAllRailRoads()
        {
            return (await _railRoadRepository.GetAll());
        }

        /// <inheritdoc cref="Loan.Platform.Business.Pact.IMasterDataService"/>
        public async Task<IList<Region>> GetRegionByCountryID(long countryID)
        {
            return (await _regionRepository.GetListById(countryID));
        }


        public Task<IList<Organization>> GetOrganizations()
        {
            return _organizationRepository.GetAll();
        }

        public Task<IList<UserType>> GetUserTypes()
        {
            return _userTypeRepository.GetAll();
        }

        public Task<IList<UserStatus>> GetUserStatuses()
        {
            return _userStatusRepository.GetAll();
        }

        public Task<IList<RateType>> GetContractRateTypes()
        {
            return _rateTypeRepository.GetAll();
        }

        public async Task<SwitchInSwitchOut> GetSwitchInSwitchOutList()
        {
            var switchInSwitchOutLimit = await _rangeMasterRepository.GetAll();
            return new SwitchInSwitchOut
            {
                SwitchIn = switchInSwitchOutLimit.Where(x => x.Category == "SwitchIn").ToList(),
                SwitchOut = switchInSwitchOutLimit.Where(x => x.Category == "SwitchOut").ToList()
            };
        }
    }
}