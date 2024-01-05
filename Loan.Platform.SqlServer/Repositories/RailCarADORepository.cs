using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.Data.SqlClient;
using Microsoft.Extensions.Configuration;
using StandardRail.RailCarLounge.Common.Helpers;
using StandardRail.RailCarLounge.Data.SqlServer.CommandBuilder;
using StandardRail.RailCarLounge.Models.ViewModels;

namespace StandardRail.RailCarLounge.Data.SqlServer.Repositories
{
    public class RailCarADORepository : BaseADORepository<RailCarBuilder, RailCarViewModel, long>
    {
        public RailCarADORepository(IConfiguration configuration, ICommandBuilder<RailCarViewModel, long> commandBuilder)
            : base(configuration["DbConnectionString"], commandBuilder)
        {
        }

        public override async Task<RailCarViewModel> SearchWithPagination(RailCarViewModel railCarViewModel)
        {
            RailCarRibbon railCarRibbon = new RailCarRibbon();
            RailCarViewModel railCarFilterViewModel = new RailCarViewModel();
            railCarFilterViewModel.RailCarList = new List<RailCarViewModel>();
            List<ContractRailCarChargeViewModel> contractChargeList = null;
            using (var cn = new SqlConnection(ConnectionString))
            {
                var result = await GetDbSetOperation(_commandBuilder.Search(railCarViewModel)).Execute(cn);
                if (result.Tables[0].Rows.Count > 0)
                {
                    foreach(DataRow dr in result.Tables[0].Rows)
                    {
                        if (!railCarFilterViewModel.RailCarList.Any(t => t.ContractRailCarMappingId == Convert.ToInt32(dr["ContractRailCarMappingId"])))
                        {
                            var railCarModel = new RailCarViewModel();
                            railCarModel.Id = Convert.ToInt32(dr["id"]);
                            railCarModel.CarInitial = dr["CarInitial"].ToString();
                            railCarModel.CarNumber = dr["CarNumber"].ToString();
                            railCarModel.CarId = dr["CarInitial"].ToString() + dr["CarNumber"].ToString();
                            railCarModel.LEName = string.IsNullOrEmpty(dr["LEName"].ToString()) ? null : dr["LEName"].ToString();
                            railCarModel.LEContents = string.IsNullOrEmpty(dr["LEContents"].ToString()) ? null : dr["LEContents"].ToString();
                            railCarModel.CarTypeName = string.IsNullOrEmpty(dr["CarTypeName"].ToString()) ? null : dr["CarTypeName"].ToString();
                            railCarModel.BolDate = string.IsNullOrEmpty(dr["BolDate"].ToString()) ? null : (dr["BolDate"]).ToDateTimeFormat();
                            railCarModel.ArrivalDate = string.IsNullOrEmpty(dr["ArrivalDate"].ToString()) ? null : (dr["ArrivalDate"]).ToDateTimeFormat();
                            railCarModel.DepartureDate = string.IsNullOrEmpty(dr["DepartureDate"].ToString()) ? null : (dr["DepartureDate"]).ToDateTimeFormat();
                            railCarModel.Fleet = string.IsNullOrEmpty(dr["Fleet"].ToString()) ? null : dr["Fleet"].ToString();
                            railCarModel.Notes = string.IsNullOrEmpty(dr["Notes"].ToString()) ? null : dr["Notes"].ToString();
                            railCarModel.LEId = string.IsNullOrEmpty(dr["LEId"].ToString()) ? null : Convert.ToInt32(dr["LEId"]);
                            railCarModel.RailCarTypeId = string.IsNullOrEmpty(dr["RailCarTypeId"].ToString()) ? null : Convert.ToInt32(dr["RailCarTypeId"]);
                            railCarModel.ContractId = Convert.ToInt32(dr["ContractId"]);
                            railCarModel.ContractRailCarMappingId = Convert.ToInt32(dr["ContractRailCarMappingId"]);
                            railCarModel.CreatedTime = Convert.ToDateTime(dr["CreatedTime"].ToString());
                            railCarModel.CarsStored = string.IsNullOrEmpty(dr["CarsStored"].ToString()) ? null : Convert.ToInt32(dr["CarsStored"]);
                            railCarModel.IsUnderStorage = Convert.ToBoolean(dr["IsUnderStorage"].ToString());
                            railCarModel.StorageOrder = dr["StorageOrder"].ToString();
                            railCarModel.CustomerId = Convert.ToInt32(dr["CustomerId"]);
                            railCarModel.IsHazmatCar = Convert.ToBoolean(dr["IsHazmatCar"]);

                            contractChargeList = new List<ContractRailCarChargeViewModel>();
                            foreach (DataRow drCharge in result.Tables[0].Select("Id = " + Convert.ToInt32(dr["id"]) + " AND ChargeId IS NOT NULL"))
                            {
                                var chargeModel = new ContractRailCarChargeViewModel();
                                chargeModel.Id = Convert.ToInt32(drCharge["ChargeId"]);
                                chargeModel.ContractRailCarMappingId = railCarModel.ContractRailCarMappingId;
                                chargeModel.Amount = !string.IsNullOrEmpty(drCharge["Amount"].ToString()) ? Convert.ToDecimal(drCharge["Amount"].ToString()) : null;
                                chargeModel.Title = drCharge["Title"].ToString();
                                chargeModel.Date = drCharge["Date"].ToDateTimeFormat();
                                chargeModel.IsActive = true;
                                contractChargeList.Add(chargeModel);
                            }
                            railCarModel.ContractRailCarCharge = contractChargeList;
                            railCarFilterViewModel.RailCarList.Add(railCarModel);
                        }
                    }

                    if (result.Tables[1].Rows.Count > 0)
                    {

                        railCarRibbon.TotalCarsStored = Convert.ToInt32(result.Tables[1].Rows[0]["CarsStored"]);
                        railCarRibbon.TotalCarTypes = Convert.ToInt32(result.Tables[1].Rows[0]["RailCarTypes"]);
                        railCarRibbon.TotalContents = Convert.ToInt32(result.Tables[1].Rows[0]["Contents"]);
                        railCarRibbon.TotalEmptyCars = Convert.ToInt32(result.Tables[1].Rows[0]["EmptyCars"]);
                        railCarRibbon.TotalFleets = Convert.ToInt32(result.Tables[1].Rows[0]["Fleets"]);
                        railCarRibbon.TotalLoadedCars = Convert.ToInt32(result.Tables[1].Rows[0]["LoadedCars"]);

                    }
                }
                railCarFilterViewModel.RailCarRibbon = railCarRibbon;
            }
            return railCarFilterViewModel;
        }

        public override async Task<IList<RailCarViewModel>> GetListById(long Id)
        {
            var railCarList = new List<RailCarViewModel>();
            List<ContractRailCarChargeViewModel> contractChargeList = null;
            using (var cn = new SqlConnection(ConnectionString))
            {
                var result = await GetDbSetOperation(_commandBuilder.GetListById(Id)).Execute(cn);
                if (result.Tables[0].Rows.Count > 0)
                {
                    foreach (DataRow dr in result.Tables[0].Rows)
                    {
                        if (!railCarList.Any(t => t.ContractRailCarMappingId == Convert.ToInt32(dr["ContractRailCarMappingId"])))
                        {
                            var railCarModel = new RailCarViewModel();
                            railCarModel.Id = Convert.ToInt32(dr["id"]);
                            railCarModel.CarInitial = dr["CarInitial"].ToString();
                            railCarModel.CarNumber = dr["CarNumber"].ToString();
                            railCarModel.CarId = dr["CarInitial"].ToString() + dr["CarNumber"].ToString();
                            railCarModel.LEName = string.IsNullOrEmpty(dr["LEName"].ToString()) ? null : dr["LEName"].ToString();
                            railCarModel.LEContents = string.IsNullOrEmpty(dr["LEContents"].ToString()) ? null : dr["LEContents"].ToString();
                            railCarModel.CarTypeName = string.IsNullOrEmpty(dr["CarTypeName"].ToString()) ? null : dr["CarTypeName"].ToString();
                            railCarModel.BolDate = string.IsNullOrEmpty(dr["BolDate"].ToString()) ? null : (dr["BolDate"]).ToDateTimeFormat();
                            railCarModel.ArrivalDate = string.IsNullOrEmpty(dr["ArrivalDate"].ToString()) ? null : (dr["ArrivalDate"]).ToDateTimeFormat();
                            railCarModel.DepartureDate = string.IsNullOrEmpty(dr["DepartureDate"].ToString()) ? null : (dr["DepartureDate"]).ToDateTimeFormat();
                            railCarModel.Fleet = string.IsNullOrEmpty(dr["Fleet"].ToString()) ? null : dr["Fleet"].ToString();
                            railCarModel.Notes = string.IsNullOrEmpty(dr["Notes"].ToString()) ? null : dr["Notes"].ToString();
                            railCarModel.LEId = string.IsNullOrEmpty(dr["LEId"].ToString()) ? null : Convert.ToInt32(dr["LEId"]);
                            railCarModel.RailCarTypeId = string.IsNullOrEmpty(dr["RailCarTypeId"].ToString()) ? null : Convert.ToInt32(dr["RailCarTypeId"]);
                            railCarModel.ContractId = Convert.ToInt32(dr["ContractId"]);
                            railCarModel.ContractRailCarMappingId = Convert.ToInt32(dr["ContractRailCarMappingId"]);
                            railCarModel.CreatedTime = Convert.ToDateTime(dr["CreatedTime"].ToString());
                            railCarModel.CarsStored = string.IsNullOrEmpty(dr["CarsStored"].ToString()) ? null : Convert.ToInt32(dr["CarsStored"]);
                            railCarModel.IsUnderStorage = Convert.ToBoolean(dr["IsUnderStorage"].ToString());
                            railCarModel.CustomerId = Convert.ToInt32(dr["CustomerId"]);
                            railCarModel.IsHazmatCar = Convert.ToBoolean(dr["IsHazmatCar"]);

                            contractChargeList = new List<ContractRailCarChargeViewModel>();
                            foreach (DataRow drCharge in result.Tables[0].Select("ContractRailCarMappingId = " + Convert.ToInt32(dr["ContractRailCarMappingId"]) + " AND ChargeId IS NOT NULL"))
                            {
                                var chargeModel = new ContractRailCarChargeViewModel();
                                chargeModel.Id = Convert.ToInt32(drCharge["ChargeId"]);
                                chargeModel.ContractRailCarMappingId = railCarModel.ContractRailCarMappingId;
                                chargeModel.Amount = !string.IsNullOrEmpty(drCharge["Amount"].ToString()) ? Convert.ToDecimal(drCharge["Amount"].ToString()) : null;
                                chargeModel.Title = drCharge["Title"].ToString();
                                chargeModel.Date = drCharge["Date"].ToDateTimeFormat();
                                chargeModel.IsActive = true;
                                contractChargeList.Add(chargeModel);
                            }
                            railCarModel.ContractRailCarCharge = contractChargeList;
                            railCarList.Add(railCarModel);
                        }
                    }
                }
            }
            return railCarList;
        }
    }
}
