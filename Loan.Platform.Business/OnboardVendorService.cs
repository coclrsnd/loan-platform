using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Threading.Tasks;
using StandardRail.RailCarLounge.Business.Pact;
using StandardRail.RailCarLounge.Common.Helpers;
using StandardRail.RailCarLounge.Common.UserContext;
using StandardRail.RailCarLounge.Data.SqlServer.Pact;
using StandardRail.RailCarLounge.Models.Entities;
using StandardRail.RailCarLounge.Models.Shared;
using StandardRail.RailCarLounge.Models.ViewModels;

namespace StandardRail.RailCarLounge.Business
{

    /// <summary>
    /// Contains business logic for vendor.
    /// </summary>
    public class OnboardVendorService : IOnboardVendorService
    {
        private readonly IRepository<OnboardVendorModel, long> _repository;
        private readonly IRepository<Vendor, long> _vendorRepository;
        private readonly IRepository<VendorFilterViewModel, long> _vendorADORepository;
        private DataTable vendor = null;
        private DataTable storageFacilities = null;
        private DataTable storageFacilitiesRates = null;
        private DataTable storageFacilitiesFeatures = null;
        private DataTable storageFacilitiesInterchanges = null;
        private DataTable storageFacilitiesInterchangeLocations = null;

        private long? TenantId;
        private long? UserId;

        public OnboardVendorService(IRepository<OnboardVendorModel, long> repository, IRepository<Vendor, long> vendorRepository,
            IRepository<VendorFilterViewModel, long> vendorADORepository, IUserContext claimsProvider)
        {
            _repository = repository ?? throw new ArgumentNullException(nameof(repository));
            _vendorRepository = vendorRepository ?? throw new ArgumentNullException(nameof(vendorRepository));
            _vendorADORepository = vendorADORepository ?? throw new ArgumentNullException(nameof(vendorADORepository));
            TenantId = claimsProvider.TenantId;
            UserId = claimsProvider.UserId;
        }


        /// <inheritdoc cref="StandardRail.RailCarLounge.Business.Pact.IOnboardVendorService"/>
        public async Task<IList<VendorAutoCompleteViewModel>> GetVendorList()
        {
            var vendors = await this._vendorRepository.GetAll();
            return vendors.Select(vendor => new VendorAutoCompleteViewModel
            {
                Id = vendor.Id,
                Name = vendor.Organization
            }).ToList();
        }

        /// <inheritdoc cref="StandardRail.RailCarLounge.Business.Pact.IOnboardVendorService"/>
        public async Task<IList<VendorAutoCompleteViewModel>> GetVendorList(string searchText)
        {
            var vendors = (await this._vendorRepository.GetByCondition(t => t.ContactPersonName.Trim().ToLower().StartsWith(searchText.Trim().ToLower()))).ToList();
            return vendors.Select(vendor => new VendorAutoCompleteViewModel
            {
                Id = vendor.Id,
                Name = vendor.Organization
            }).ToList();
        }

        /// <inheritdoc cref="StandardRail.RailCarLounge.Business.Pact.IOnboardVendorService"/>
        public async Task<VendorViewModel> GetVendorDetails(int vendorId)
        {
            OnboardVendorModel onboardVendorModel = await this._repository.GetById(vendorId);
            VendorViewModel vendor = new VendorViewModel();
            if (onboardVendorModel != null)
            {
                vendor.Id = Convert.ToInt64(onboardVendorModel.Vendor.Rows[0]["Id"]);
                vendor.ContactPersonName = Convert.ToString(onboardVendorModel.Vendor.Rows[0]["ContactPersonName"]);
                vendor.PrimaryContactNo = Convert.ToString(onboardVendorModel.Vendor.Rows[0]["PrimaryContactNo"]);
                vendor.SecondaryContactNo = Convert.ToString(onboardVendorModel.Vendor.Rows[0]["SecondaryContactNo"]);
                vendor.Organization = Convert.ToString(onboardVendorModel.Vendor.Rows[0]["Organization"]);
                vendor.OrganizationId = Convert.ToInt64(onboardVendorModel.Vendor.Rows[0]["OrganizationId"]);
                vendor.Address = Convert.ToString(onboardVendorModel.Vendor.Rows[0]["Address"]);
                vendor.ZipCode = Convert.ToString(onboardVendorModel.Vendor.Rows[0]["ZipCode"]);
                vendor.City = Convert.ToString(onboardVendorModel.Vendor.Rows[0]["City"]);
                vendor.StateId = DBFieldsMappingHelper.GetNullableInt64Value(onboardVendorModel.Vendor.Rows[0], "StateId");
                vendor.CountryId = DBFieldsMappingHelper.GetNullableInt64Value(onboardVendorModel.Vendor.Rows[0], "CountryId");
                //vendor.EffectiveDate = Convert.ToDateTime(onboardVendorModel.Vendor.Rows[0]["EffectiveDate"]);
                //vendor.ExpiryDate = Convert.ToDateTime(onboardVendorModel.Vendor.Rows[0]["ExpiryDate"]);
                vendor.EffectiveDate = (onboardVendorModel.Vendor.Rows[0]["EffectiveDate"]).ToDateTimeFormat();
                vendor.ExpiryDate = (onboardVendorModel.Vendor.Rows[0]["ExpiryDate"]).ToDateTimeFormat();
                vendor.PrimaryContactEmail = Convert.ToString(onboardVendorModel.Vendor.Rows[0]["PrimaryContactEmail"]);
                vendor.SecondaryContactEmail = Convert.ToString(onboardVendorModel.Vendor.Rows[0]["SecondaryContactEmail"]);
                vendor.Website = Convert.ToString(onboardVendorModel.Vendor.Rows[0]["Website"]);
                vendor.Description = Convert.ToString(onboardVendorModel.Vendor.Rows[0]["Description"]);
                vendor.PercentageMargin = Convert.ToDecimal(onboardVendorModel.Vendor.Rows[0]["PercentageMargin"]);
                vendor.RegionId = DBFieldsMappingHelper.GetNullableInt64Value(onboardVendorModel.Vendor.Rows[0], "RegionId");
                MapStorageFacilities(vendor, onboardVendorModel);
            }
            return vendor;
        }

        /// <inheritdoc cref="StandardRail.RailCarLounge.Business.Pact.IOnboardVendorService"/>
        public async Task<VendorViewModel> Save(VendorViewModel vendorViewModel)
        {
            OnboardVendorModel onboardVendorModel = new OnboardVendorModel();
            onboardVendorModel.Vendor = PrepareVendorDt(vendorViewModel);
            onboardVendorModel.StorageFacilities = PrepareStorageFacilityDT(vendorViewModel);
            onboardVendorModel.StorageFacilitiesRates = storageFacilitiesRates ?? null;
            onboardVendorModel.StorageFacilitiesFeatures = storageFacilitiesFeatures ?? null;
            onboardVendorModel.StorageFacilitiesInterchanges = storageFacilitiesInterchanges ?? null;
            onboardVendorModel.StorageFacilitiesInterchangeLocations = storageFacilitiesInterchangeLocations ?? null;
            await this._repository.Create(onboardVendorModel);
            return vendorViewModel;
        }

        #region ViewModel Population

        private void MapStorageFacilities(VendorViewModel vendorViewModel, OnboardVendorModel onboardVendorModel)
        {
            vendorViewModel.StorageFacilities = MapStorageFacilities(onboardVendorModel);

            List<StorageFacilityRateViewModel> storageRates = MapStorageFacilityRates(onboardVendorModel);

            List<StorageFacilityFeatureMapping> storageFeatures = MapStorageFacilityFeatures(onboardVendorModel);

            List<StorageFacilityInterchangeViewModel> storageFacilityInterchanges = MapStorageFacilityInterchanges(onboardVendorModel);

            List<StorageFacilityInterchangeLocationViewModel> storageFacilityInterchangeLocations = MapStorageFacilityInterchangeLocations(onboardVendorModel);

            if (vendorViewModel.StorageFacilities != null && vendorViewModel.StorageFacilities.Count > 0)
            {
                foreach (StorageFacilityViewModel storageFacility in vendorViewModel.StorageFacilities)
                {
                    storageFacility.StorageFacilityRates = storageRates.Where(r => r.StorageFacilityId == storageFacility.Id).ToList();
                    storageFacility.StorageFeatures = storageFeatures.Where(f => f.StorageFacilityId == storageFacility.Id)
                                                        .Select(f => new StorageFeatureViewModel
                                                        {
                                                            Id = f.StorageFeatureId
                                                        }).ToList();
                    storageFacility.StorageFacilityInterchanges = storageFacilityInterchanges.Where(t => t.StorageFacilityId == storageFacility.Id).ToList();
                    if (storageFacility.StorageFacilityInterchanges != null && vendorViewModel.StorageFacilities.Count > 0)
                    {
                        foreach (StorageFacilityInterchangeViewModel sfInterchange in storageFacility.StorageFacilityInterchanges)
                        {
                            sfInterchange.InterchangeLocations = storageFacilityInterchangeLocations.Where(t => t.InterchangeId == sfInterchange.Id).ToList();
                        }
                    }
                }
            }


        }

        private List<StorageFacilityRateViewModel> MapStorageFacilityRates(OnboardVendorModel onboardVendorModel)
        {
            List<StorageFacilityRateViewModel> storageRates = new List<StorageFacilityRateViewModel>();
            foreach (DataRow row in onboardVendorModel.StorageFacilitiesRates.Rows)
            {
                var rate = new StorageFacilityRateViewModel();
                rate.Id = Convert.ToInt64(row["Id"]);
                rate.StorageFacilityId = row["StorageFacilityId"] != DBNull.Value ? Convert.ToInt64(row["StorageFacilityId"]) : default;
                rate.CurrencyId = row["CurrencyId"] != DBNull.Value ? Convert.ToInt16(row["CurrencyId"]) : default;
                //rate.PercentageMargin = row["PercentageMargin"] != DBNull.Value ? Convert.ToDecimal(row["PercentageMargin"]) : default;
                rate.DailyStorageRate = row["DailyStorageRate"] != DBNull.Value ? Convert.ToDecimal(row["DailyStorageRate"]) : default;
                rate.SwitchIn = row["SwitchIn"] != DBNull.Value ? Convert.ToDecimal(row["SwitchIn"]) : default;
                rate.SwitchOut = row["SwitchOut"] != DBNull.Value ? Convert.ToDecimal(row["SwitchOut"]) : default;
                rate.SwitchingRate = row["SwitchingRate"] != DBNull.Value ? Convert.ToDecimal(row["SwitchingRate"]) : default;
                rate.SpecialSwitchingRate = row["SpecialSwitchingRate"] != DBNull.Value ? Convert.ToDecimal(row["SpecialSwitchingRate"]) : default;
                rate.HazmatSwitchOutRate = row["HazmatSwitchOutRate"] != DBNull.Value ? Convert.ToDecimal(row["HazmatSwitchOutRate"]) : default;
                rate.HazmatSwitchInRate = row["HazmatSwitchInRate"] != DBNull.Value ? Convert.ToDecimal(row["HazmatSwitchInRate"]) : default;
                rate.LoadedSwitchInRate = row["LoadedSwitchInRate"] != DBNull.Value ? Convert.ToDecimal(row["LoadedSwitchInRate"]) : default;
                rate.LoadedSwitchOutRate = row["LoadedSwitchOutRate"] != DBNull.Value ? Convert.ToDecimal(row["LoadedSwitchOutRate"]) : default;
                rate.CherryPickingRate = row["CherryPickingRate"] != DBNull.Value ? Convert.ToDecimal(row["CherryPickingRate"]) : default;
                rate.ReservationRate = row["ReservationRate"] != DBNull.Value ? Convert.ToDecimal(row["ReservationRate"]) : default;
                //rate.EffectiveDate = Convert.ToDateTime(row["EffectiveDate"]);
                //rate.ExpiryDate = Convert.ToDateTime(row["ExpiryDate"]);
                rate.EffectiveDate = (row["EffectiveDate"]).ToDateTimeFormat();
                rate.ExpiryDate = (row["ExpiryDate"]).ToDateTimeFormat();
                storageRates.Add(rate);
            }
            return storageRates;
        }

        private List<StorageFacilityFeatureMapping> MapStorageFacilityFeatures(OnboardVendorModel onboardVendorModel)
        {
            List<StorageFacilityFeatureMapping> storageFeatures = new List<StorageFacilityFeatureMapping>();
            foreach (DataRow row in onboardVendorModel.StorageFacilitiesFeatures.Rows)
            {
                var feature = new StorageFacilityFeatureMapping();
                feature.Id = Convert.ToInt64(row["Id"]);
                feature.StorageFeatureId = Convert.ToInt64(row["StorageFeatureId"]);
                feature.StorageFacilityId = Convert.ToInt64(row["StorageFacilityId"]);
                //feature.StorageFeature = new StorageFeature()
                //{
                //    Id = Convert.ToInt64(row["Id"]),
                //    Name = Convert.ToString(row["Name"]),
                //    Description = Convert.ToString(row["Description"]),
                //};
                storageFeatures.Add(feature);
            }
            return storageFeatures;
        }

        private List<StorageFacilityViewModel> MapStorageFacilities(OnboardVendorModel onboardVendorModel)
        {
            var storageFacilities = new List<StorageFacilityViewModel>();
            foreach (DataRow row in onboardVendorModel.StorageFacilities.Rows)
            {
                var storagefacility = new StorageFacilityViewModel();
                storagefacility.Id = Convert.ToInt64(row["Id"]);
                storagefacility.Name = Convert.ToString(row["Name"]);
                storagefacility.Mark = Convert.ToString(row["Mark"]);
                storagefacility.Lat = Convert.ToString(row["Lat"]);
                storagefacility.Long = Convert.ToString(row["Long"]);
                storagefacility.Capacity = DBFieldsMappingHelper.GetNullableIntValue(row, "Capacity");
                storagefacility.AvailableCars = DBFieldsMappingHelper.GetNullableIntValue(row, "AvailableCars");
                storagefacility.Rating = row["Rating"] != DBNull.Value ? Convert.ToDouble(row["Rating"]) : default;
                storagefacility.Address = Convert.ToString(row["Address"]);
                storagefacility.PrimaryContactNumber = Convert.ToString(row["PrimaryContactNumber"]);
                storagefacility.SecondaryContactNumber = Convert.ToString(row["SecondaryContactNumber"]);
                storagefacility.PrimaryEmail = Convert.ToString(row["PrimaryEmail"]);
                storagefacility.SecondaryEmail = Convert.ToString(row["SecondaryEmail"]);
                storagefacility.ZipCode = Convert.ToString(row["ZipCode"]);
                storagefacility.City = Convert.ToString(row["City"]);
                storagefacility.StateId = DBFieldsMappingHelper.GetNullableInt64Value(row, "StateId");
                storagefacility.CountryId = DBFieldsMappingHelper.GetNullableInt64Value(row, "CountryId");
                storagefacility.VendorId = Convert.ToInt64(row["VendorId"]);
                storagefacility.RegionId = DBFieldsMappingHelper.GetNullableInt64Value(row, "RegionId");
                //storagefacility.EffectiveDate = Convert.ToDateTime(row["EffectiveDate"]);
                //storagefacility.ExpiryDate = Convert.ToDateTime(row["ExpiryDate"]);
                storagefacility.EffectiveDate = (row["EffectiveDate"]).ToDateTimeFormat();
                storagefacility.ExpiryDate = (row["ExpiryDate"]).ToDateTimeFormat();
                storagefacility.SPLC = Convert.ToString(row["SPLC"]);
                storagefacility.Priority = DBFieldsMappingHelper.GetNullableIntValue(row, "Priority");
                storagefacility.Description = Convert.ToString(row["Description"]);
                storageFacilities.Add(storagefacility);
            }
            return storageFacilities;
        }

        private List<StorageFacilityInterchangeViewModel> MapStorageFacilityInterchanges(OnboardVendorModel onboardVendorModel)
        {
            var storageFacilitieInterchanges = new List<StorageFacilityInterchangeViewModel>();
            foreach (DataRow row in onboardVendorModel.StorageFacilitiesInterchanges.Rows)
            {
                var storagefacilityInterchanges = new StorageFacilityInterchangeViewModel();
                storagefacilityInterchanges.Id = Convert.ToInt64(row["InterChangeId"]);
                storagefacilityInterchanges.StorageFacilityId = Convert.ToInt64(row["StorageFacilityId"]);
                storagefacilityInterchanges.RailRoadId = Convert.ToInt64(row["RailRoadId"]);
                storagefacilityInterchanges.RailRoadName = Convert.ToString(row["RailRoadName"]);
                storagefacilityInterchanges.GrossRailRoadCapacity = DBFieldsMappingHelper.GetNullableDecimalValue(row, "GrossRailRoadCapacity");
                //storagefacilityInterchanges.R260 = Convert.ToString(row["R260"]);
                //storagefacilityInterchanges.FSAC = Convert.ToString(row["FSAC"]);
                storagefacilityInterchanges.MarkCode = Convert.ToString(row["MarkCode"]);
                storagefacilityInterchanges.UnitId = DBFieldsMappingHelper.GetNullableInt64Value(row, "UnitId");
                storageFacilitieInterchanges.Add(storagefacilityInterchanges);
            }
            return storageFacilitieInterchanges;
        }

        private List<StorageFacilityInterchangeLocationViewModel> MapStorageFacilityInterchangeLocations(OnboardVendorModel onboardVendorModel)
        {
            var storageFacilitieInterchangeLocations = new List<StorageFacilityInterchangeLocationViewModel>();
            foreach (DataRow row in onboardVendorModel.StorageFacilitiesInterchangeLocations.Rows)
            {
                var sfInterchangeLocation = new StorageFacilityInterchangeLocationViewModel();
                sfInterchangeLocation.Id = Convert.ToInt64(row["Id"]);
                sfInterchangeLocation.StorageFacilityId = Convert.ToInt64(row["StorageFacilityId"]);
                sfInterchangeLocation.RailRoadId = Convert.ToInt64(row["RailRoadId"]);
                sfInterchangeLocation.InterchangeId = Convert.ToInt64(row["InterchangeId"]);
                sfInterchangeLocation.CountryId = Convert.ToInt64(row["CountryId"]);
                sfInterchangeLocation.StateId = Convert.ToInt64(row["StateId"]);
                sfInterchangeLocation.City = Convert.ToString(row["City"]);
                sfInterchangeLocation.SPLC = Convert.ToString(row["SPLC"]);
                sfInterchangeLocation.Lat = Convert.ToString(row["Lat"]);
                sfInterchangeLocation.Long = Convert.ToString(row["Long"]);
                sfInterchangeLocation.Description = Convert.ToString(row["Description"]);
                sfInterchangeLocation.R260 = Convert.ToString(row["R260"]);
                sfInterchangeLocation.FSAC = Convert.ToString(row["FSAC"]);
                storageFacilitieInterchangeLocations.Add(sfInterchangeLocation);
            }
            return storageFacilitieInterchangeLocations;
        }
        #endregion

        #region DataTable Population
        private DataTable PrepareStorageFacilityDT(VendorViewModel vendorViewModel)
        {
            if (vendorViewModel.StorageFacilities != null && vendorViewModel.StorageFacilities.Count > 0)
            {
                if (storageFacilities == null)
                {
                    CreateStorageFacilityDT();
                }
                foreach (StorageFacilityViewModel storageFacility in vendorViewModel.StorageFacilities)
                {
                    storageFacilities.Rows.Add(storageFacility.Id, storageFacility.Name, storageFacility.Lat, storageFacility.Long, storageFacility.Capacity, storageFacility.AvailableCars,
                        0, storageFacility.Address, storageFacility.PrimaryContactNumber, storageFacility.SecondaryContactNumber, storageFacility.PrimaryEmail, storageFacility.SecondaryEmail,
                        storageFacility.ZipCode, storageFacility.City, storageFacility.StateId, storageFacility.CountryId, storageFacility.VendorId, storageFacility.RegionId,
                        storageFacility.EffectiveDate, storageFacility.ExpiryDate, storageFacility.SPLC, storageFacility.Mark, storageFacility.Priority, storageFacility.Description,
                        DateTime.Now, UserId, DateTime.Now, UserId, vendorViewModel.OrganizationId, TenantId, storageFacility.IsTrimbleVerified);

                    if (storageFacility.StorageFacilityRates != null && storageFacility.StorageFacilityRates.Count > 0)
                    {
                        PrepareStorageFacilityRateDT(storageFacility, vendorViewModel.OrganizationId);
                    }

                    if (storageFacility.StorageFeatures != null && storageFacility.StorageFeatures.Count > 0)
                    {
                        PrepareStorageFacilityFeaturesDT(storageFacility, vendorViewModel.OrganizationId);
                    }

                    if (storageFacility.StorageFacilityInterchanges != null && storageFacility.StorageFacilityInterchanges.Count > 0)
                    {
                        PrepareStorageFacilityInterchangesDT(storageFacility, vendorViewModel.OrganizationId);
                    }
                }
            }
            return storageFacilities;
        }

        private void PrepareStorageFacilityInterchangesDT(StorageFacilityViewModel storageFacility, long organizationId)
        {
            if (storageFacilitiesInterchanges == null)
            {
                CreateStorageFacilityInterchangeDT();
            }
            foreach (StorageFacilityInterchangeViewModel interchange in storageFacility.StorageFacilityInterchanges)
            {

                try
                {
                    storageFacilitiesInterchanges.Rows.Add(interchange.StorageFacilityId, storageFacility.Name, interchange.Id, interchange.RailRoadId, interchange.RailRoadName,
                               interchange.MarkCode, interchange.GrossRailRoadCapacity, interchange.UnitId, DateTime.Now, UserId, DateTime.Now, UserId, organizationId, TenantId, interchange.IsActive);

                    if (interchange.InterchangeLocations != null && interchange.InterchangeLocations.Count > 0)
                    {
                        PrepareStorageFacilityInterchangeLocationDT(interchange, storageFacility.Name, organizationId);
                    }
                }
                catch (Exception)
                {

                    throw;
                }
            }
        }

        private void PrepareStorageFacilityInterchangeLocationDT(StorageFacilityInterchangeViewModel interchange,
            string storageFacilityName, long organizationId)
        {
            if (storageFacilitiesInterchangeLocations == null)
            {
                CreateStorageFacilityInterchangeLocationDT();
            }
            foreach (StorageFacilityInterchangeLocationViewModel location in interchange.InterchangeLocations)
            {
                storageFacilitiesInterchangeLocations.Rows.Add(interchange.StorageFacilityId, storageFacilityName, interchange.Id, interchange.RailRoadId, location.Id,
                    location.CountryId, location.StateId, location.City, location.SPLC, location.R260, location.FSAC, location.Lat, location.Long, location.Description, DateTime.Now, UserId, DateTime.Now, UserId, organizationId, TenantId, location.IsActive);
            }
        }

        private void PrepareStorageFacilityRateDT(StorageFacilityViewModel storageFacility, long organizationId)
        {
            if (storageFacilitiesRates == null)
            {
                CreateStorageFacilityRatesDT();
            }
            foreach (StorageFacilityRateViewModel storageFacilityRate in storageFacility.StorageFacilityRates)
            {
                storageFacilitiesRates.Rows.Add(storageFacilityRate.Id, storageFacilityRate.StorageFacilityId, storageFacility.Name, storageFacilityRate.CurrencyId,
                    storageFacilityRate.DailyStorageRate, storageFacilityRate.SwitchIn, storageFacilityRate.SwitchOut, storageFacilityRate.SwitchingRate,
                    storageFacilityRate.SpecialSwitchingRate, storageFacilityRate.HazmatSwitchInRate, storageFacilityRate.HazmatSwitchOutRate, storageFacilityRate.LoadedSwitchInRate,
                    storageFacilityRate.LoadedSwitchOutRate, storageFacilityRate.CherryPickingRate,
                    storageFacilityRate.ReservationRate, storageFacilityRate.EffectiveDate, storageFacilityRate.ExpiryDate, DateTime.Now, UserId, DateTime.Now, UserId, organizationId, TenantId, storageFacilityRate.IsActive);
            }
        }

        private void PrepareStorageFacilityFeaturesDT(StorageFacilityViewModel storageFacility, long organizationId)
        {
            if (storageFacilitiesFeatures == null)
            {
                CreateStorageFacilityFeaturesDT();
            }
            foreach (StorageFeatureViewModel storageFeature in storageFacility.StorageFeatures)
            {
                storageFacilitiesFeatures.Rows.Add(storageFacility.Id, storageFacility.Name, storageFeature.Id, DateTime.Now, UserId, DateTime.Now, UserId, organizationId, TenantId, storageFeature.IsActive);
            }
        }

        private DataTable PrepareVendorDt(VendorViewModel vendorViewModel)
        {
            if (vendor == null)
            {
                CreateVendorDT();
            }
            vendor.Rows.Add(vendorViewModel.Id, vendorViewModel.ContactPersonName, vendorViewModel.PrimaryContactNo, vendorViewModel.SecondaryContactNo,
                vendorViewModel.Organization, vendorViewModel.Address, vendorViewModel.ZipCode, vendorViewModel.City, vendorViewModel.StateId,
                vendorViewModel.CountryId, vendorViewModel.RegionId, vendorViewModel.PercentageMargin, vendorViewModel.EffectiveDate, vendorViewModel.ExpiryDate, vendorViewModel.PrimaryContactEmail, vendorViewModel.SecondaryContactEmail,
                vendorViewModel.Website, vendorViewModel.Description, DateTime.Now, UserId, DateTime.Now, UserId, vendorViewModel.OrganizationId, TenantId);
            return vendor;
        }
        #endregion

        #region DataTable Creation
        private void CreateVendorDT()
        {
            vendor = new DataTable();
            vendor.Columns.Add("Id", typeof(long));
            vendor.Columns.Add("ContactPersonName", typeof(string));
            vendor.Columns.Add("PrimaryContactNo", typeof(string));
            vendor.Columns.Add("SecondaryContactNo", typeof(string));
            vendor.Columns.Add("Organization", typeof(string));
            vendor.Columns.Add("Address", typeof(string));
            vendor.Columns.Add("ZipCode", typeof(string));
            vendor.Columns.Add("City", typeof(string));
            vendor.Columns.Add("StateId", typeof(long));
            vendor.Columns.Add("CountryId", typeof(long));
            vendor.Columns.Add("RegionId", typeof(long));
            vendor.Columns.Add("PercentageMargin", typeof(decimal));
            vendor.Columns.Add("EffectiveDate", typeof(DateTime));
            vendor.Columns.Add("ExpiryDate", typeof(DateTime));
            vendor.Columns.Add("PrimaryContactEmail", typeof(string));
            vendor.Columns.Add("SecondaryContactEmail", typeof(string));
            vendor.Columns.Add("Website", typeof(string));
            vendor.Columns.Add("Description", typeof(string));
            vendor.Columns.Add("CreatedTime", typeof(DateTime));
            vendor.Columns.Add("CreatedBy", typeof(long));
            vendor.Columns.Add("ModifiedTime", typeof(DateTime));
            vendor.Columns.Add("ModifiedBy", typeof(long));
            vendor.Columns.Add("OrganizationId", typeof(string));
            vendor.Columns.Add("TenantId", typeof(long));
        }

        private void CreateStorageFacilityDT()
        {
            storageFacilities = new DataTable();
            storageFacilities.Columns.Add("Id", typeof(long));
            storageFacilities.Columns.Add("Name", typeof(string));
            storageFacilities.Columns.Add("Lat", typeof(string));
            storageFacilities.Columns.Add("Long", typeof(string));
            storageFacilities.Columns.Add("Capacity", typeof(int));
            storageFacilities.Columns.Add("AvailableCars", typeof(int));
            storageFacilities.Columns.Add("Rating", typeof(float));
            storageFacilities.Columns.Add("Address", typeof(string));
            storageFacilities.Columns.Add("PrimaryContactNumber", typeof(string));
            storageFacilities.Columns.Add("SecondaryContactNumber", typeof(string));
            storageFacilities.Columns.Add("PrimaryEmail", typeof(string));
            storageFacilities.Columns.Add("SecondaryEmail", typeof(string));
            storageFacilities.Columns.Add("ZipCode", typeof(string));
            storageFacilities.Columns.Add("City", typeof(string));
            storageFacilities.Columns.Add("StateId", typeof(long));
            storageFacilities.Columns.Add("CountryId", typeof(long));
            storageFacilities.Columns.Add("VendorId", typeof(long));
            storageFacilities.Columns.Add("RegionId", typeof(long));
            storageFacilities.Columns.Add("EffectiveDate", typeof(DateTime));
            storageFacilities.Columns.Add("ExpiryDate", typeof(DateTime));
            storageFacilities.Columns.Add("SPLC", typeof(string));
            storageFacilities.Columns.Add("Mark", typeof(string));
            storageFacilities.Columns.Add("Priority", typeof(int));
            storageFacilities.Columns.Add("Description", typeof(string));
            storageFacilities.Columns.Add("CreatedTime", typeof(DateTime));
            storageFacilities.Columns.Add("CreatedBy", typeof(long));
            storageFacilities.Columns.Add("ModifiedTime", typeof(DateTime));
            storageFacilities.Columns.Add("ModifiedBy", typeof(long));
            storageFacilities.Columns.Add("OrganizationId", typeof(string));
            storageFacilities.Columns.Add("TenantId", typeof(long));
            storageFacilities.Columns.Add("IsTrimbleVerified", typeof(bool));
        }

        private void CreateStorageFacilityRatesDT()
        {
            storageFacilitiesRates = new DataTable();
            storageFacilitiesRates.Columns.Add("Id", typeof(long));
            storageFacilitiesRates.Columns.Add("StorageFacilityId", typeof(long));
            storageFacilitiesRates.Columns.Add("StorageFacilityName", typeof(string));
            storageFacilitiesRates.Columns.Add("CurrencyId", typeof(short));
            storageFacilitiesRates.Columns.Add("DailyStorageRate", typeof(decimal));
            storageFacilitiesRates.Columns.Add("SwitchIn", typeof(decimal));
            storageFacilitiesRates.Columns.Add("SwitchOut", typeof(string));
            storageFacilitiesRates.Columns.Add("SwitchingRate", typeof(string));
            storageFacilitiesRates.Columns.Add("SpecialSwitchingRate", typeof(string));
            storageFacilitiesRates.Columns.Add("HazmatSwitchInRate", typeof(string));
            storageFacilitiesRates.Columns.Add("HazmatSwitchOutRate", typeof(long));
            storageFacilitiesRates.Columns.Add("LoadedSwitchInRate", typeof(string));
            storageFacilitiesRates.Columns.Add("LoadedSwitchOutRate", typeof(long));
            storageFacilitiesRates.Columns.Add("CherryPickingRate", typeof(long));
            storageFacilitiesRates.Columns.Add("ReservationRate", typeof(string));
            storageFacilitiesRates.Columns.Add("EffectiveDate", typeof(DateTime));
            storageFacilitiesRates.Columns.Add("ExpiryDate", typeof(DateTime));
            storageFacilitiesRates.Columns.Add("CreatedTime", typeof(DateTime));
            storageFacilitiesRates.Columns.Add("CreatedBy", typeof(long));
            storageFacilitiesRates.Columns.Add("ModifiedTime", typeof(DateTime));
            storageFacilitiesRates.Columns.Add("ModifiedBy", typeof(long));
            storageFacilitiesRates.Columns.Add("OrganizationId", typeof(string));
            storageFacilitiesRates.Columns.Add("TenantId", typeof(long));
            storageFacilitiesRates.Columns.Add("IsActive", typeof(bool));
        }

        private void CreateStorageFacilityFeaturesDT()
        {
            storageFacilitiesFeatures = new DataTable();
            storageFacilitiesFeatures.Columns.Add("StorageFacilityId", typeof(long));
            storageFacilitiesFeatures.Columns.Add("StorageFacilityName", typeof(string));
            storageFacilitiesFeatures.Columns.Add("StorageFeatureId", typeof(long));
            storageFacilitiesFeatures.Columns.Add("CreatedTime", typeof(DateTime));
            storageFacilitiesFeatures.Columns.Add("CreatedBy", typeof(long));
            storageFacilitiesFeatures.Columns.Add("ModifiedTime", typeof(DateTime));
            storageFacilitiesFeatures.Columns.Add("ModifiedBy", typeof(long));
            storageFacilitiesFeatures.Columns.Add("OrganizationId", typeof(string));
            storageFacilitiesFeatures.Columns.Add("TenantId", typeof(long));
            storageFacilitiesFeatures.Columns.Add("IsActive", typeof(bool));
        }

        private void CreateStorageFacilityInterchangeDT()
        {
            storageFacilitiesInterchanges = new DataTable();
            storageFacilitiesInterchanges.Columns.Add("StorageFacilityId", typeof(long));
            storageFacilitiesInterchanges.Columns.Add("StorageFacilityName", typeof(string));
            storageFacilitiesInterchanges.Columns.Add("Id", typeof(long));
            storageFacilitiesInterchanges.Columns.Add("RailRoadId", typeof(long));
            storageFacilitiesInterchanges.Columns.Add("RailRoadName", typeof(string));
            storageFacilitiesInterchanges.Columns.Add("MarkCode", typeof(string));
            storageFacilitiesInterchanges.Columns.Add("GrossRailRoadLimitCapacity", typeof(long));
            //storageFacilitiesInterchanges.Columns.Add("R260", typeof(string));
            //storageFacilitiesInterchanges.Columns.Add("FSAC", typeof(string));
            storageFacilitiesInterchanges.Columns.Add("UnitId", typeof(long));
            storageFacilitiesInterchanges.Columns.Add("CreatedTime", typeof(DateTime));
            storageFacilitiesInterchanges.Columns.Add("CreatedBy", typeof(long));
            storageFacilitiesInterchanges.Columns.Add("ModifiedTime", typeof(DateTime));
            storageFacilitiesInterchanges.Columns.Add("ModifiedBy", typeof(long));
            storageFacilitiesInterchanges.Columns.Add("OrganizationId", typeof(string));
            storageFacilitiesInterchanges.Columns.Add("TenantId", typeof(long));
            storageFacilitiesInterchanges.Columns.Add("IsActive", typeof(bool));
        }

        private void CreateStorageFacilityInterchangeLocationDT()
        {
            storageFacilitiesInterchangeLocations = new DataTable();
            storageFacilitiesInterchangeLocations.Columns.Add("StorageFacilityId", typeof(long));
            storageFacilitiesInterchangeLocations.Columns.Add("StorageFacilityName", typeof(string));
            storageFacilitiesInterchangeLocations.Columns.Add("InterchangeId", typeof(long));
            storageFacilitiesInterchangeLocations.Columns.Add("RailRoadId", typeof(long));
            storageFacilitiesInterchangeLocations.Columns.Add("Id", typeof(long));
            storageFacilitiesInterchangeLocations.Columns.Add("CountryId", typeof(long));
            storageFacilitiesInterchangeLocations.Columns.Add("StateId", typeof(long));
            storageFacilitiesInterchangeLocations.Columns.Add("City", typeof(string));
            storageFacilitiesInterchangeLocations.Columns.Add("SPLC", typeof(string));
            storageFacilitiesInterchangeLocations.Columns.Add("R260", typeof(string));
            storageFacilitiesInterchangeLocations.Columns.Add("FSAC", typeof(string));
            storageFacilitiesInterchangeLocations.Columns.Add("Lat", typeof(string));
            storageFacilitiesInterchangeLocations.Columns.Add("Long", typeof(string));
            storageFacilitiesInterchangeLocations.Columns.Add("Description", typeof(string));
            storageFacilitiesInterchangeLocations.Columns.Add("CreatedTime", typeof(DateTime));
            storageFacilitiesInterchangeLocations.Columns.Add("CreatedBy", typeof(long));
            storageFacilitiesInterchangeLocations.Columns.Add("ModifiedTime", typeof(DateTime));
            storageFacilitiesInterchangeLocations.Columns.Add("ModifiedBy", typeof(long));
            storageFacilitiesInterchangeLocations.Columns.Add("OrganizationId", typeof(string));
            storageFacilitiesInterchangeLocations.Columns.Add("TenantId", typeof(long));
            storageFacilitiesInterchangeLocations.Columns.Add("IsActive", typeof(bool));
        }
        #endregion

        #region Search Grid
        /// <inheritdoc cref="StandardRail.RailCarLounge.Business.Pact.IOnboardVendorService"/>
        public async Task<VendorFilterViewModel> GetVendorsOnFilter(VendorFilterViewModel vendorFilterViewModel)
        {
            return await this._vendorADORepository.SearchWithPagination(vendorFilterViewModel);
        }
        #endregion
    }
}
