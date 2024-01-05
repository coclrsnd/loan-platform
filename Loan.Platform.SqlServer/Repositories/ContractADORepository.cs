using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.Data.SqlClient;
using Microsoft.Extensions.Options;
using StandardRail.RailCarLounge.Common.Helpers;
using Microsoft.Extensions.Configuration;
using StandardRail.RailCarLounge.Data.SqlServer.CommandBuilder;
using StandardRail.RailCarLounge.Models.ViewModels;
using StandardRail.RailCarLounge.Common.UserContext;

namespace StandardRail.RailCarLounge.Data.SqlServer.Repositories
{
    /// <summary>
    /// Performs ADO database operations for Contract.
    /// </summary>
    public class ContractADORepository : BaseADORepository<ContractBuilder, ContractViewModel, long>
    {
        private readonly string CurrentRole;
        public ContractADORepository(IConfiguration configuration, ICommandBuilder<ContractViewModel, long> commandBuilder, IUserContext claimsProvider)
            : base(configuration["DbConnectionString"], commandBuilder)
        {
            CurrentRole = claimsProvider.CurrentRole;
        }

        public override async Task<ContractViewModel> GetById(long Id)
        {
            var contractModel = new ContractViewModel();
            using (var cn = new SqlConnection(ConnectionString))
            {
                var result = await GetDbSetOperation(_commandBuilder.GetById(Id)).Execute(cn);
                if (result.Tables[0].Rows.Count > 0)
                {
                    DataRow dr = result.Tables[0].Rows[0];
                    if (Convert.ToInt32(dr["id"]) > 0)
                    {
                        contractModel.Id = Convert.ToInt32(dr["id"]);
                        contractModel.Rider = dr["Rider"].ToString();
                        contractModel.VendorId = Convert.ToInt32(dr["VendorId"]);
                        contractModel.VendorName = dr["VendorName"].ToString();
                        contractModel.StorageFacilityId = Convert.ToInt32(dr["StorgeFacilityId"]);
                        contractModel.StorageFacilityName = dr["StorgeFacilityName"].ToString();
                        contractModel.CustomerId = Convert.ToInt32(dr["CustomerId"]);
                        contractModel.CustomerName = dr["CustomerName"].ToString();
                        contractModel.ContractTypeId = Convert.ToInt32(dr["ContractTypeId"]);
                        contractModel.ContractTypeName = dr["ContractTypeName"].ToString();
                        contractModel.Location = dr["Location"].ToString();
                        contractModel.TotalCars = Convert.ToInt32(dr["TotalCars"]);
                        contractModel.CarsStored = DBFieldsMappingHelper.GetNullableIntValue(dr,"CarsStored");
                        contractModel.EffectiveDate = (dr["EffectiveDate"]).ToDateTimeFormat();
                        contractModel.ExpiryDate = (dr["ExpiryDate"]).ToDateTimeFormat();
                        contractModel.CurrencyId = Convert.ToInt32(dr["CurrencyId"]);
                        contractModel.CurrencyName = dr["CurrencyName"].ToString();
                        contractModel.IsFlatRateContract = Convert.ToBoolean(dr["IsFlatRateContract"]);
                        contractModel.ReservedSpaces = DBFieldsMappingHelper.GetNullableIntValue(dr,"ReservedSpaces");
                        contractModel.Description = Convert.ToString(dr["Description"]);
                        contractModel.IsAdvancedSwitchingRatesEnabled = Convert.ToBoolean(dr["IsAdvancedSwitchingRatesEnabled"]);

                        //if (riderModel.IsFlatRateContract)
                        //{
                        //    riderModel.
                        //}
                        //riderModel.PercentageMargin = Convert.ToDecimal(dr["PercentageMargin"]);
                        //riderModel.DailyStorageRate = Convert.ToDecimal(dr["DailyStorageRate"]);
                        // riderModel.SwitchIn = string.IsNullOrEmpty(dr["SwitchIn"].ToString()) ? null : Convert.ToDecimal(dr["SwitchIn"]);
                        // riderModel.SwitchOut = string.IsNullOrEmpty(dr["SwitchOut"].ToString()) ? null : Convert.ToDecimal(dr["SwitchOut"]);
                        // riderModel.SwitchingRate = string.IsNullOrEmpty(dr["SwitchingRate"].ToString()) ? null : Convert.ToDecimal(dr["SwitchingRate"]);
                        // riderModel.SpecialSwitchingRate = string.IsNullOrEmpty(dr["SpecialSwitchingRate"].ToString()) ? null : Convert.ToDecimal(dr["SpecialSwitchingRate"]);
                        //riderModel.HazmatSurcharge = string.IsNullOrEmpty(dr["HazmatSurcharge"].ToString()) ? null : Convert.ToDecimal(dr["HazmatSurcharge"]);
                        //riderModel.LoadedSurcharge = string.IsNullOrEmpty(dr["LoadedSurcharge"].ToString()) ? null : Convert.ToDecimal(dr["LoadedSurcharge"]);
                        //riderModel.CherryPickingRate = string.IsNullOrEmpty(dr["CherryPickingRate"].ToString()) ? null : Convert.ToDecimal(dr["CherryPickingRate"]);
                        //riderModel.ReservationRate = string.IsNullOrEmpty(dr["ReservationRate"].ToString()) ? null : Convert.ToDecimal(dr["ReservationRate"]);
                        contractModel.CreatedTime = Convert.ToDateTime(dr["CreatedTime"].ToString());
                    }
                }
                if (result.Tables[1].Rows.Count > 0)
                {
                    if (contractModel.IsFlatRateContract)
                    {
                        foreach(DataRow drRate in result.Tables[1].Rows)
                        {
                            if (Convert.ToString(drRate["RateType"]).Trim().ToLower().Contains("vendor"))
                            {
                                // for vendor
                                contractModel.VendorCost = new ContractRatesViewModel()
                                {
                                    Id= Convert.ToInt32(drRate["Id"]),
                                    ContractId = Convert.ToInt32(drRate["ContractId"]),
                                    RateTypeId = Convert.ToInt32(drRate["RateTypeId"]),
                                    SwitchIn = contractModel.IsAdvancedSwitchingRatesEnabled ? null : DBFieldsMappingHelper.GetNullableDecimalValue(drRate, "SwitchIn"),
                                    SwitchOut = contractModel.IsAdvancedSwitchingRatesEnabled ? null : DBFieldsMappingHelper.GetNullableDecimalValue(drRate, "SwitchOut"),
                                    SpecialSwitchingRate = DBFieldsMappingHelper.GetNullableDecimalValue(drRate, "SpecialSwitchingRate"),
                                    DailyStorageRate =  Convert.ToDecimal(drRate["DailyStorageRate"]),
                                    SwitchingRate = DBFieldsMappingHelper.GetNullableDecimalValue(drRate, "SwitchingRate"),
                                    HazmatSurcharge = DBFieldsMappingHelper.GetNullableDecimalValue(drRate, "HazmatSurcharge"),
                                    LoadedSurcharge = DBFieldsMappingHelper.GetNullableDecimalValue(drRate, "LoadedSurcharge"),
                                    ReservationRate = DBFieldsMappingHelper.GetNullableDecimalValue(drRate, "ReservationRate"),
                                    CherryPickingRate = DBFieldsMappingHelper.GetNullableDecimalValue(drRate, "CherryPickingRate"),
                                    IsAdvancedHazmatSwitchingEnabled = Convert.ToBoolean(drRate["IsAdvancedHazmatSwitchingEnabled"]),
                                    IsAdvancedLoadedSwitchingEnabled = Convert.ToBoolean(drRate["IsAdvancedLoadedSwitchingEnabled"]),                                   
                                    HazmatSwitchIn = DBFieldsMappingHelper.GetNullableDecimalValue(drRate, "HazmatSwitchIn"),
                                    HazmatSwitchOut = DBFieldsMappingHelper.GetNullableDecimalValue(drRate, "HazmatSwitchOut"),
                                    LoadedSwitchIn = DBFieldsMappingHelper.GetNullableDecimalValue(drRate, "LoadedSwitchIn"),
                                    LoadedSwitchOut = DBFieldsMappingHelper.GetNullableDecimalValue(drRate, "LoadedSwitchOut"),
                                    StandardSwitchIn = !contractModel.IsAdvancedSwitchingRatesEnabled ? null : DBFieldsMappingHelper.GetNullableDecimalValue(drRate, "SwitchIn"),
                                    StandardSwitchOut = !contractModel.IsAdvancedSwitchingRatesEnabled ? null : DBFieldsMappingHelper.GetNullableDecimalValue(drRate, "SwitchOut"),
                                };
                            }
                            else
                            {
                                // for Customer
                                contractModel.CustomerRate = new ContractRatesViewModel()
                                {
                                    Id = Convert.ToInt32(drRate["Id"]),
                                    ContractId = Convert.ToInt32(drRate["ContractId"]),
                                    RateTypeId = Convert.ToInt32(drRate["RateTypeId"]),
                                    SwitchIn = contractModel.IsAdvancedSwitchingRatesEnabled ? null : DBFieldsMappingHelper.GetNullableDecimalValue(drRate, "SwitchIn"),
                                    SwitchOut = contractModel.IsAdvancedSwitchingRatesEnabled ? null : DBFieldsMappingHelper.GetNullableDecimalValue(drRate, "SwitchOut"),
                                    SpecialSwitchingRate = DBFieldsMappingHelper.GetNullableDecimalValue(drRate, "SpecialSwitchingRate"),
                                    DailyStorageRate = Convert.ToDecimal(drRate["DailyStorageRate"]),
                                    SwitchingRate = DBFieldsMappingHelper.GetNullableDecimalValue(drRate, "SwitchingRate"),
                                    HazmatSurcharge = DBFieldsMappingHelper.GetNullableDecimalValue(drRate, "HazmatSurcharge"),
                                    LoadedSurcharge = DBFieldsMappingHelper.GetNullableDecimalValue(drRate, "LoadedSurcharge"),
                                    ReservationRate = DBFieldsMappingHelper.GetNullableDecimalValue(drRate, "ReservationRate"),
                                    CherryPickingRate = DBFieldsMappingHelper.GetNullableDecimalValue(drRate, "CherryPickingRate"),
                                    IsAdvancedHazmatSwitchingEnabled = Convert.ToBoolean(drRate["IsAdvancedHazmatSwitchingEnabled"]),
                                    IsAdvancedLoadedSwitchingEnabled = Convert.ToBoolean(drRate["IsAdvancedLoadedSwitchingEnabled"]),
                                    HazmatSwitchIn = DBFieldsMappingHelper.GetNullableDecimalValue(drRate, "HazmatSwitchIn"),
                                    HazmatSwitchOut = DBFieldsMappingHelper.GetNullableDecimalValue(drRate, "HazmatSwitchOut"),
                                    LoadedSwitchIn = DBFieldsMappingHelper.GetNullableDecimalValue(drRate, "LoadedSwitchIn"),
                                    LoadedSwitchOut = DBFieldsMappingHelper.GetNullableDecimalValue(drRate, "LoadedSwitchOut"),
                                    StandardSwitchIn = !contractModel.IsAdvancedSwitchingRatesEnabled ? null : DBFieldsMappingHelper.GetNullableDecimalValue(drRate, "SwitchIn"),
                                    StandardSwitchOut = !contractModel.IsAdvancedSwitchingRatesEnabled ? null : DBFieldsMappingHelper.GetNullableDecimalValue(drRate, "SwitchOut"),
                                };
                            }
                        }
                    }
                    else
                    {
                        foreach (DataRow drRate in result.Tables[1].Rows)
                        {
                            // for Percentage rate
                            contractModel.PercentageRate = new ContractRatesViewModel()
                            {
                                Id = Convert.ToInt32(drRate["Id"]),
                                ContractId = Convert.ToInt32(drRate["ContractId"]),
                                RateTypeId = Convert.ToInt32(drRate["RateTypeId"]),
                                SwitchIn = contractModel.IsAdvancedSwitchingRatesEnabled ? null : DBFieldsMappingHelper.GetNullableDecimalValue(drRate, "SwitchIn"),
                                SwitchOut = contractModel.IsAdvancedSwitchingRatesEnabled ? null : DBFieldsMappingHelper.GetNullableDecimalValue(drRate, "SwitchOut"),
                                SpecialSwitchingRate = DBFieldsMappingHelper.GetNullableDecimalValue(drRate, "SpecialSwitchingRate"),
                                DailyStorageRate = Convert.ToDecimal(drRate["DailyStorageRate"]),
                                SwitchingRate = DBFieldsMappingHelper.GetNullableDecimalValue(drRate, "SwitchingRate"),
                                HazmatSurcharge = DBFieldsMappingHelper.GetNullableDecimalValue(drRate, "HazmatSurcharge"),
                                LoadedSurcharge = DBFieldsMappingHelper.GetNullableDecimalValue(drRate, "LoadedSurcharge"),
                                ReservationRate = DBFieldsMappingHelper.GetNullableDecimalValue(drRate, "ReservationRate"),
                                CherryPickingRate = DBFieldsMappingHelper.GetNullableDecimalValue(drRate, "CherryPickingRate"),
                                BookingFee = !CurrentRole.StartsWith("Vendor", StringComparison.OrdinalIgnoreCase) ? Convert.ToDecimal(drRate["BookingFee"]) : 0,
                                ListingFee = !CurrentRole.StartsWith("Customer", StringComparison.OrdinalIgnoreCase) ? Convert.ToDecimal(drRate["ListingFee"]) : 0,
                                IsAdvancedHazmatSwitchingEnabled = Convert.ToBoolean(drRate["IsAdvancedHazmatSwitchingEnabled"]),
                                IsAdvancedLoadedSwitchingEnabled = Convert.ToBoolean(drRate["IsAdvancedLoadedSwitchingEnabled"]),
                                HazmatSwitchIn = DBFieldsMappingHelper.GetNullableDecimalValue(drRate, "HazmatSwitchIn"),
                                HazmatSwitchOut = DBFieldsMappingHelper.GetNullableDecimalValue(drRate, "HazmatSwitchOut"),
                                LoadedSwitchIn = DBFieldsMappingHelper.GetNullableDecimalValue(drRate, "LoadedSwitchIn"),
                                LoadedSwitchOut = DBFieldsMappingHelper.GetNullableDecimalValue(drRate, "LoadedSwitchOut"),
                                StandardSwitchIn = !contractModel.IsAdvancedSwitchingRatesEnabled ? null : DBFieldsMappingHelper.GetNullableDecimalValue(drRate, "SwitchIn"),
                                StandardSwitchOut = !contractModel.IsAdvancedSwitchingRatesEnabled ? null : DBFieldsMappingHelper.GetNullableDecimalValue(drRate, "SwitchOut"),
                            };
                        }
                    }
                }

                if (result.Tables[2].Rows.Count > 0)
                {
                    contractModel.storageFeatureViewModels = (from DataRow drow in result.Tables[2].Rows
                                                              select new StorageFeatureViewModel()
                                                              {
                                                                  Id = Convert.ToInt32(drow["StorageFeatureId"]),
                                                                  Name = drow["StorageFeatureName"].ToString()
                                                              }).ToList();
                }
            }
            return contractModel;
        }

        public override async Task<ContractViewModel> SearchWithPagination(ContractViewModel riderViewModel)
        {
            var riderList = new ContractViewModel();
            StorageOrderRibbon storageOrderRibbon = new StorageOrderRibbon();
            using (var cn = new SqlConnection(ConnectionString))
            {
                var result = await GetDbSetOperation(_commandBuilder.Search(riderViewModel)).Execute(cn);
                if (result.Tables[0].Rows.Count > 0)
                {
                    riderList.RiderModel = (from DataRow dr in result.Tables[0].Rows
                                            select new ContractViewModel()
                                            {
                                                Id = Convert.ToInt32(dr["id"]),
                                                VendorName = dr["VendorName"].ToString(),
                                                StorageFacilityName = dr["StorgeFacilityName"].ToString(),
                                                Rider = dr["Rider"].ToString(),
                                                EffectiveDate = (dr["EffectiveDate"]).ToDateTimeFormat(),
                                                ExpiryDate = (dr["ExpiryDate"]).ToDateTimeFormat(),
                                                TotalCars = string.IsNullOrEmpty(dr["TotalCars"].ToString()) ? null : Convert.ToInt32(dr["TotalCars"]),
                                                SwitchIn = DBFieldsMappingHelper.GetNullableDecimalValue(dr, "SwitchIn"),
                                                SwitchOut = DBFieldsMappingHelper.GetNullableDecimalValue(dr, "SwitchOut"),
                                                Hazmat = dr["Hazmat"].ToString(),
                                            }).ToList();
                    if (result.Tables[1].Rows.Count > 0)
                    {
                        storageOrderRibbon.TotalCarsStored = Convert.ToInt32(result.Tables[1].Rows[0]["CarsStored"]);
                        storageOrderRibbon.TotalContractedSpaces = Convert.ToInt32(result.Tables[1].Rows[0]["TotalCars"]);
                        storageOrderRibbon.TotalRiders = riderList.RiderModel.Count;
                        storageOrderRibbon.TotalOrdersAmount = DBFieldsMappingHelper.GetNullableDecimalValue(result.Tables[1].Rows[0], "TotalAmount");
                        storageOrderRibbon.TotalActiveOrders = Convert.ToInt32(result.Tables[1].Rows[0]["Active"]);
                        storageOrderRibbon.TotalExpiredOrders = Convert.ToInt32(result.Tables[1].Rows[0]["ExpiredOrders"]);
                        storageOrderRibbon.AverageMonthlyAmount = DBFieldsMappingHelper.GetNullableDecimalValue(result.Tables[1].Rows[0], "AVGMonthly");

                    }
                }
                riderList.StorageOrderRibbon = storageOrderRibbon;
            }
            return riderList;
        }

        public override int GetCount(ContractViewModel riderViewModel)
        {
            int storageOrderCount = 0;
            using (var cn = new SqlConnection(ConnectionString))
            {
                var result =  GetDbSetOperation(_commandBuilder.GetCount(riderViewModel)).Execute(cn);
                if (result.Result.Tables[0].Rows.Count > 0)
                {
                    DataRow dr = result.Result.Tables[0].Rows[0];
                    storageOrderCount = Convert.ToInt32(dr["StorageOrderCount"]);
                }
            }
            return storageOrderCount;
        }
    }
}
