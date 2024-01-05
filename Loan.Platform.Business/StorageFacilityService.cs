using System;
using System.Collections.Generic;
using System.Data;
using System.Globalization;
using System.Linq;
using System.Net;
using System.Text.Json;
using System.Threading.Tasks;
using AutoMapper;
using GeoJSON.Text.Feature;
using GeoJSON.Text.Geometry;
using StandardRail.RailCarLounge.Business.Pact;
using StandardRail.RailCarLounge.Data.SqlServer.Pact;
using StandardRail.RailCarLounge.Models.Entities;
using StandardRail.RailCarLounge.Models.FreightRailModels;
using StandardRail.RailCarLounge.Models.ViewModels;

namespace StandardRail.RailCarLounge.Business
{
    /// <summary>
    /// Contains Business Logic for Storage Facility.
    /// </summary>
    public class StorageFacilityService : IStorageFacilityService
    {
        private readonly IRepository<FacilityMapSearchViewModel, long> _adoRepository;
        private readonly IRepository<StorageFacility, long> _storageRepository;
        private readonly IRepository<StorageOpportunity, long> _storageOpportunityRepository;
        private readonly IFreightRailService _freightRailService;
        private readonly IUserManagerService _userManagerService;
        private readonly ICommonService _commonService;
        private readonly IMapper _mapper;

        public StorageFacilityService(IRepository<FacilityMapSearchViewModel, long> adoRepository, IRepository<StorageFacility, long> storageRepository,
            IRepository<StorageOpportunity, long> storageOpportunityRepository, IMapper mapper, IFreightRailService freightRailService, IUserManagerService userManagerService, ICommonService commonService)
        {
            _storageRepository = storageRepository ?? throw new ArgumentNullException(nameof(storageRepository));
            _mapper = mapper ?? throw new ArgumentNullException(nameof(mapper));
            _adoRepository = adoRepository ?? throw new ArgumentNullException(nameof(adoRepository));
            _freightRailService = freightRailService ?? throw new ArgumentNullException(nameof(freightRailService));
            _userManagerService = userManagerService ?? throw new ArgumentNullException(nameof(userManagerService));
            _storageOpportunityRepository = storageOpportunityRepository ?? throw new ArgumentNullException(nameof(storageOpportunityRepository));
            _commonService = commonService ?? throw new ArgumentNullException(nameof(commonService));
        }

        public async Task<bool> BookStorageFacility(StorageFacilityBookNowRequestViewModel storageFacilityBookNowRequestViewModel)
        {
            bool bookingStatus = false;
            if (storageFacilityBookNowRequestViewModel == null)
                return bookingStatus;

            if (storageFacilityBookNowRequestViewModel.UserId > 0)
            {
                User user = default;
                StorageFacilityViewModel storageFacilityViewModel = default;
                user = await _userManagerService.GetUserById(storageFacilityBookNowRequestViewModel.UserId);
                if (user == null)
                {
                    return bookingStatus;
                }

                if (user.IsActive.Value && !string.IsNullOrEmpty(user.EmailId))
                {
                    storageFacilityViewModel = GetStorageFacilityById(storageFacilityBookNowRequestViewModel.StorageFacilityId).Result;
                    if (storageFacilityViewModel != null)
                    {
                        var storageOpportunity = new StorageOpportunity()
                        {
                            BookingId = $"{user.OrganizationName}-{storageFacilityViewModel.Name}-{storageFacilityBookNowRequestViewModel.BookingDate.ToShortDateString()}",
                            BookingDate = storageFacilityBookNowRequestViewModel.BookingDate,
                            CustomerId = user.OrganizationId,
                            StorageId = storageFacilityViewModel.Id,
                            StorageName = storageFacilityViewModel.Name,
                            Email = user.EmailId,
                            DailyStorageRate = storageFacilityBookNowRequestViewModel.DailyStorageRate,
                            VendorId = storageFacilityViewModel.VendorId.HasValue ? storageFacilityViewModel.VendorId.Value : 0,
                            UserId = user.Id,
                        };
                        // save storage opportunity details
                        var savedEntity = _storageOpportunityRepository.Create(storageOpportunity).Result;
                        if (savedEntity != null)
                        {
                            //Send email of booking to customer.
                            bool isBookingEmailSent = await _commonService.SendBookingConfirmationEmailAsync(storageOpportunity);
                            //Send email of booking confirmation to Internal sales team and railcarstorage email address.
                           // bool isStorageOpportunityEmailSent = await _commonService.SendStorageOpportunityEmailAsync(storageOpportunity, user.OrganizationName);
                            if (isBookingEmailSent)// && isStorageOpportunityEmailSent)
                                bookingStatus = true;
                        }
                    }
                }
            }
            return bookingStatus;
        }      

        public async Task<FacilityMapSearchResultViewModel> SearchStorageFacilities(FacilityMapSearchRequestModel facilityMapSearchRequest)
        {
            var facilityMapSearchViewModel = new FacilityMapSearchViewModel();

            if (facilityMapSearchRequest != null)
            {
                facilityMapSearchViewModel.FacilityMapSearchRequest = facilityMapSearchRequest;
            }

            FacilityMapSearchResultViewModel facilityMapSearchResultViewModel = new FacilityMapSearchResultViewModel();
            facilityMapSearchResultViewModel.Status = HttpStatusCode.OK;
            var storageFacilitiesFeatureCollection = new FeatureCollection();
            if (facilityMapSearchViewModel.FacilityMapSearchRequest != null && facilityMapSearchViewModel.FacilityMapSearchRequest.isMulticityEnable)
            {
                //Get route path
                (HttpStatusCode, string) routePathResult = await _freightRailService.GetRoutePath(facilityMapSearchViewModel.FacilityMapSearchRequest);
                if (!routePathResult.Item1.Equals(HttpStatusCode.OK))
                {
                    facilityMapSearchResultViewModel.Status = routePathResult.Item1;
                    facilityMapSearchResultViewModel.ResponseMessage = routePathResult.Item2.ToString();
                    return facilityMapSearchResultViewModel;
                }
                facilityMapSearchResultViewModel.OriginDestinationRoutePath = routePathResult.Item2.ToString();
                //AddOrigin
                var originPoint = new Point(new Position(facilityMapSearchViewModel.FacilityMapSearchRequest.Origin.Latitude / 1000000, facilityMapSearchViewModel.FacilityMapSearchRequest.Origin.Longitude / 1000000));
                IDictionary<string, object> originProperties = new Dictionary<string, object>
                        {
                            {"Type", "O"},
                            {"Name", "Origin" },
                            {"StorageId", -1 }
                        };
                var originFeature = new Feature(originPoint, originProperties);
                storageFacilitiesFeatureCollection.Features.Add(originFeature);

                //AddDestination
                var destinationPoint = new Point(new Position(facilityMapSearchViewModel.FacilityMapSearchRequest.Destination.Latitude / 1000000, facilityMapSearchViewModel.FacilityMapSearchRequest.Destination.Longitude / 1000000));
                IDictionary<string, object> destProperties = new Dictionary<string, object>
                        {
                            {"Type", "D"},
                            {"Name", "Destination" },
                            {"StorageId", -1 }
                        };
                var destFeature = new Feature(destinationPoint, destProperties);
                storageFacilitiesFeatureCollection.Features.Add(destFeature);


                //Get GeocodeRoute report
                var railReport = await _freightRailService.GetDetailedGeocodeRouteReportForSPLC(facilityMapSearchViewModel.FacilityMapSearchRequest);
                if (railReport != null && railReport.Report != null && railReport.Report.Lines != null)
                {
                    var stationsAlongRoute = railReport.Report.Lines.Where((e) => !string.IsNullOrEmpty(e.SPLC)).Select(e => e.SPLC).ToList();
                    //string listOfSPLC = string.Join(",", stationsAlongRoute);
                    var mileToSPLCMapping = this.SPLCMappingDataTable(railReport.Report);
                    facilityMapSearchViewModel.FacilityMapSearchRequest.SPLCMilesMap = mileToSPLCMapping;
                    //facilityMapSearchViewModel.FacilityMapSearchRequest.SPLCs = listOfSPLC;
                }
            }

            var storageFacilityViewModels = await _adoRepository.Search(facilityMapSearchViewModel);
            if (storageFacilityViewModels != null && storageFacilityViewModels.Count > 0)
            {
                var storageFacilityViewModel = storageFacilityViewModels.FirstOrDefault();
                if ((storageFacilityViewModel != default(FacilityMapSearchViewModel) && storageFacilityViewModel.FacilityMapSearchResultViewModel != null) &&
                    storageFacilityViewModel.FacilityMapSearchResultViewModel.StorageFacilityViewModels != null)
                {
                    List<StorageFacilityResultViewModel> storageFacilityResultViewModels = new List<StorageFacilityResultViewModel>();
                    foreach (var storageFacility in storageFacilityViewModels[0].FacilityMapSearchResultViewModel.StorageFacilityViewModels)
                    {
                        var validLat = double.TryParse(storageFacility.Lat, NumberStyles.Float, CultureInfo.InvariantCulture, out double latitude);
                        var validLong = double.TryParse(storageFacility.Long, NumberStyles.Float, CultureInfo.InvariantCulture, out double longitude);
                        if (validLat && latitude > -90 && latitude < 90 && validLong && longitude > -180 && longitude < 180)
                        {
                            var point = new Point(new Position(storageFacility.Lat, storageFacility.Long));
                            IDictionary<string, object> properties = new Dictionary<string, object>
                            {
                                {"Type", "A"},
                                {"Name", storageFacility.Name },
                                {"StorageId", storageFacility.Id }
                            };
                            var pointFeature = new Feature(point, properties);
                            storageFacilitiesFeatureCollection.Features.Add(pointFeature);
                            storageFacilityResultViewModels.Add(storageFacility);
                        }
                    }

                    facilityMapSearchResultViewModel.StorageFacilityViewModels = storageFacilityResultViewModels;
                }
            }
            if (storageFacilitiesFeatureCollection != null)
            {
                facilityMapSearchResultViewModel.StorageFacilityMapPoints = JsonSerializer.Serialize(storageFacilitiesFeatureCollection);
            }

            return facilityMapSearchResultViewModel;
        }

        #region DataTable Creation
        private DataTable SPLCMappingDataTable(Report railReport)
        {
            DataTable mileToSPLCDataTable = new DataTable();
            if (railReport != null && railReport.Lines != null)
            {
                var stationsAlongRoute = railReport.Lines.Where((e) => !string.IsNullOrEmpty(e.SPLC)).DistinctBy(e => e.SPLC).ToDictionary(e => e.SPLC.ToString(), e => e.TotalDist.ToString(), StringComparer.OrdinalIgnoreCase);
                mileToSPLCDataTable.Columns.Clear();
                mileToSPLCDataTable.Columns.Add("SPLC", typeof(string));
                mileToSPLCDataTable.Columns.Add("Miles", typeof(string));

                foreach (var station in stationsAlongRoute)
                {
                    mileToSPLCDataTable.Rows.Add(station.Key, station.Value);
                }
            }

            return mileToSPLCDataTable;
        }
        #endregion

        /// <inheritdoc cref="StandardRail.RailCarLounge.Business.Pact.IStorageFacilityService"/>
        public Task<IList<StorageFacility>> GetStorageFacilitiesByVendorId(long vendorId)
        {
            var storageFacilities = this._storageRepository.GetListById(vendorId);
            return storageFacilities;
        }

        /// <inheritdoc cref="StandardRail.RailCarLounge.Business.Pact.IStorageFacilityService"/>
        public async Task<StorageFacilityViewModel> GetStorageFacilityById(int id)
        {
            StorageFacility storageFacility = await _storageRepository.GetById(id);
            return _mapper.Map<StorageFacilityViewModel>(storageFacility);
        }

        /// <inheritdoc cref="StandardRail.RailCarLounge.Business.Pact.IStorageFacilityService"/>
        public Task<List<StorageFacilityViewModel>> GetStorageFeatures()
        {
            throw new NotImplementedException();
        }

        /// <inheritdoc cref="StandardRail.RailCarLounge.Business.Pact.IStorageFacilityService"/>
        public Task<StorageFacility> Save(StorageFacilityViewModel storageFacilityViewModel)
        {
            StorageFacility storageFacility = _mapper.Map<StorageFacilityViewModel, StorageFacility>(storageFacilityViewModel);
            return _storageRepository.Create(storageFacility);
        }

        /// <inheritdoc cref="StandardRail.RailCarLounge.Business.Pact.IStorageFacilityService"/>
        public async Task<IList<StorageFacility>> GetStorageFacilities(long organizationID)
        {
            if (organizationID > 0)
            {
                return (
                  await
                  this._storageRepository.GetByCondition(t =>
                  t.OrganizationId == organizationID)).Take(200).ToList();
            }
            else
            {
                return (
                    await
                    this._storageRepository.GetByCondition(t => t.IsActive.HasValue && t.IsActive.Value))
                    .Take(50).ToList();

            }
        }
    }
}