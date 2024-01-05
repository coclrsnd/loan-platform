using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.Data.SqlClient;
using Microsoft.Extensions.Configuration;
using StandardRail.RailCarLounge.Data.SqlServer.CommandBuilder;
using StandardRail.RailCarLounge.Models.ReportModels;

namespace StandardRail.RailCarLounge.Data.SqlServer.Repositories
{
    public class StorageFacilityActivityReportADORepository : BaseADORepository<StorageFacilityActivityReportBuilder, StorageFacilityActivityReportViewModel, long>
    {
        public StorageFacilityActivityReportADORepository(IConfiguration configuration, ICommandBuilder<StorageFacilityActivityReportViewModel, long> commandBuilder)
            : base(configuration["DbConnectionString"], commandBuilder)
        {
        }

        public override async Task<IList<StorageFacilityActivityReportViewModel>> Search(StorageFacilityActivityReportViewModel storageFacilityActivityReportViewModel)
        {
            var storageFacilityActivityReportViewModels = new List<StorageFacilityActivityReportViewModel>();
            var activityReportDetails = new StorageFacilityActivityReport();
            using (var cn = new SqlConnection(ConnectionString))
            {
                var result = await GetDbSetOperation(_commandBuilder.Search(storageFacilityActivityReportViewModel)).Execute(cn);
                if (result != null && result.Tables.Count > 0)
                {
                    if (result.Tables[0].Rows.Count > 0)
                    {
                        activityReportDetails.OrganizationName = Convert.ToString(result.Tables[0].Rows[0]["OrganizationName"]);
                        activityReportDetails.OrganizationAddress = Convert.ToString(result.Tables[0].Rows[0]["OrgAddress"]);
                        activityReportDetails.ReportFromDate = Convert.ToDateTime(result.Tables[0].Rows[0]["ReportFromDate"]).ToString("MMM dd, yyyy");
                        activityReportDetails.ReportToDate = Convert.ToDateTime(result.Tables[0].Rows[0]["ReportToDate"]).ToString("MMM dd, yyyy");
                        activityReportDetails.Order = Convert.ToString(result.Tables[0].Rows[0]["Order"]);
                        activityReportDetails.FacilityName = Convert.ToString(result.Tables[0].Rows[0]["FacilityName"]);
                        activityReportDetails.FacilityLocation = Convert.ToString(result.Tables[0].Rows[0]["FacilityAddress"]);
                        activityReportDetails.ReportDate = Convert.ToDateTime(result.Tables[0].Rows[0]["ReportDate"]).ToString("MMM dd, yyyy");
                        activityReportDetails.DaysInPeriod = Convert.ToDateTime(result.Tables[0].Rows[0]["ReportToDate"]).Date.Subtract(Convert.ToDateTime(result.Tables[0].Rows[0]["ReportFromDate"]).Date).Duration().Days + 1;
                        activityReportDetails.ContractType = Convert.ToString(result.Tables[0].Rows[0]["ContractType"]);
                        activityReportDetails.ContractedSpace = Convert.ToInt32(result.Tables[0].Rows[0]["ContractedSpace"]);
                        activityReportDetails.Currency = Convert.ToString(result.Tables[0].Rows[0]["Currency"]);
                        activityReportDetails.IsAdvancedSwitchingRatesEnabled = Convert.ToBoolean(result.Tables[0].Rows[0]["IsAdvancedSwitchingRatesEnabled"]);
                        activityReportDetails.DailyRate = !string.IsNullOrEmpty(result.Tables[0].Rows[0]["DailyStorageRate"].ToString()) ? Convert.ToDecimal(result.Tables[0].Rows[0]["DailyStorageRate"]) : 0;

                        if (!activityReportDetails.IsAdvancedSwitchingRatesEnabled)
                        {
                            activityReportDetails.SwitchIn = !string.IsNullOrEmpty(result.Tables[0].Rows[0]["SwitchIn"].ToString()) ? Convert.ToDecimal(result.Tables[0].Rows[0]["SwitchIn"]) : null;
                            activityReportDetails.SwitchOut = !string.IsNullOrEmpty(result.Tables[0].Rows[0]["SwitchOut"].ToString()) ? Convert.ToDecimal(result.Tables[0].Rows[0]["SwitchOut"]) : null;
                        }
                        else
                        {
                            activityReportDetails.StandardSwitchIn = !string.IsNullOrEmpty(result.Tables[0].Rows[0]["SwitchIn"].ToString()) ? Convert.ToDecimal(result.Tables[0].Rows[0]["SwitchIn"]) : null;
                            activityReportDetails.StandardSwitchOut = !string.IsNullOrEmpty(result.Tables[0].Rows[0]["SwitchOut"].ToString()) ? Convert.ToDecimal(result.Tables[0].Rows[0]["SwitchOut"]) : null;
                        }

                        activityReportDetails.LoadedSwitchIn = !string.IsNullOrEmpty(result.Tables[0].Rows[0]["LoadedSwitchIn"].ToString()) ? Convert.ToDecimal(result.Tables[0].Rows[0]["LoadedSwitchIn"]) : null;
                        activityReportDetails.LoadedSwitchOut = !string.IsNullOrEmpty(result.Tables[0].Rows[0]["LoadedSwitchOut"].ToString()) ? Convert.ToDecimal(result.Tables[0].Rows[0]["LoadedSwitchOut"]) : null;
                        activityReportDetails.HazmatSwitchIn = !string.IsNullOrEmpty(result.Tables[0].Rows[0]["HazmatSwitchIn"].ToString()) ? Convert.ToDecimal(result.Tables[0].Rows[0]["HazmatSwitchIn"]) : null;
                        activityReportDetails.HazmatSwitchOut = !string.IsNullOrEmpty(result.Tables[0].Rows[0]["HazmatSwitchOut"].ToString()) ? Convert.ToDecimal(result.Tables[0].Rows[0]["HazmatSwitchOut"]) : null;
                        activityReportDetails.HazmatSurcharge = !string.IsNullOrEmpty(result.Tables[0].Rows[0]["HazmatSurcharge"].ToString()) ? Convert.ToDecimal(result.Tables[0].Rows[0]["HazmatSurcharge"]) : null;
                        activityReportDetails.LoadedSurcharge = !string.IsNullOrEmpty(result.Tables[0].Rows[0]["LoadedSurcharge"].ToString()) ? Convert.ToDecimal(result.Tables[0].Rows[0]["LoadedSurcharge"]) : null;

                        storageFacilityActivityReportViewModel.StorageFacilityActivityReport = activityReportDetails;
                    }

                    if (result.Tables.Count > 1 && result.Tables[1] != null && result.Tables[1].Rows.Count > 0)
                    {
                        var carActivities = new List<CarActivity>();
                        int index = 1;
                        foreach (DataRow carDetails in result.Tables[1].Rows)
                        {
                            var activity = new CarActivity();
                            activity.Index = index++;
                            activity.CarInitial = Convert.ToString(carDetails["CarInitial"]);
                            activity.CarNumber = Convert.ToString(carDetails["CarNumber"]);
                            activity.IsHazard = Convert.ToBoolean(carDetails["IsHazmatCar"]) ? "Y" : "N";
                            activity.IsLoadedEmpty = Convert.ToString(carDetails["LE"]);
                            activity.Commodity = Convert.ToString(carDetails["LEContents"]);
                            activity.ArrivalDate = !string.IsNullOrEmpty(carDetails["ArrivalDate"].ToString()) ? Convert.ToDateTime(carDetails["ArrivalDate"].ToString()).ToString("MMM dd, yyyy") : "-";
                            activity.DepartureDate = !string.IsNullOrEmpty(carDetails["DepartureDate"].ToString()) ? Convert.ToDateTime(carDetails["DepartureDate"].ToString()).ToString("MMM dd, yyyy") : "-";
                            activity.Days = !string.IsNullOrEmpty(carDetails["NoOfDays"].ToString()) ? Convert.ToInt32(carDetails["NoOfDays"]) : 0;

                            if (storageFacilityActivityReportViewModel.StorageFacilityActivityReportRequest.ContractTypeId == 1)
                            {
                                activity.DailyStorageRate = !string.IsNullOrEmpty(carDetails["TotalDailyRate"].ToString()) ? Convert.ToDecimal(carDetails["TotalDailyRate"]) : 0;
                                activity.TotalDailyAmount = !string.IsNullOrEmpty(carDetails["TotalDailyAmount"].ToString()) ? Convert.ToDecimal(carDetails["TotalDailyAmount"]) : 0;
                            }
                            activity.SwitchIn = !string.IsNullOrEmpty(carDetails["SwitchIn"].ToString()) ? Convert.ToDecimal(carDetails["SwitchIn"]) : 0;
                            activity.SwitchOut = !string.IsNullOrEmpty(carDetails["SwitchOut"].ToString()) ? Convert.ToDecimal(carDetails["SwitchOut"]) : 0;
                            activity.SpecialSwitchingAmount = !string.IsNullOrEmpty(carDetails["SpecialSwitchingAmount"].ToString()) ? Convert.ToDecimal(carDetails["SpecialSwitchingAmount"]) : 0;
                            activity.TotalSwitchingAmount = !string.IsNullOrEmpty(carDetails["TotalSwitchingAmount"].ToString()) ? Convert.ToDecimal(carDetails["TotalSwitchingAmount"]) : 0;
                            activity.Total = activity.TotalDailyAmount + activity.TotalSwitchingAmount;

                            if (storageFacilityActivityReportViewModel.StorageFacilityActivityReportRequest.ContractTypeId == 2 ||
                            storageFacilityActivityReportViewModel.StorageFacilityActivityReportRequest.ContractTypeId == 3)
                            {
                                activityReportDetails.TakeOrPayDays = !string.IsNullOrEmpty(carDetails["TermDays"].ToString()) ? Convert.ToInt32(carDetails["TermDays"]) : 0;
                            }

                            carActivities.Add(activity);
                        }

                        if (storageFacilityActivityReportViewModel.StorageFacilityActivityReportRequest.ContractTypeId == 2 ||
                           storageFacilityActivityReportViewModel.StorageFacilityActivityReportRequest.ContractTypeId == 3)
                        {
                            activityReportDetails.SumTotalSwitchAmount = carActivities.Sum(e => e.TotalSwitchingAmount);
                            activityReportDetails.TotalTakeOrPayAmount = (activityReportDetails.TakeOrPayDays * activityReportDetails.ContractedSpace) * activityReportDetails.DailyRate;
                            activityReportDetails.TotalAmount = activityReportDetails.SumTotalSwitchAmount + activityReportDetails.TotalTakeOrPayAmount;
                        }

                        storageFacilityActivityReportViewModel.StorageFacilityActivityReport.CarActivities = carActivities;
                    }
                    if (result.Tables.Count > 2 && result.Tables[2] != null && result.Tables[2].Rows.Count > 0)
                    {
                        activityReportDetails.CarsAtFacility = !string.IsNullOrEmpty(result.Tables[2].Rows[0]["CarsStored"].ToString()) ? Convert.ToInt32(result.Tables[2].Rows[0]["CarsStored"].ToString()) : 0;
                        activityReportDetails.DaysOfStorage = !string.IsNullOrEmpty(result.Tables[2].Rows[0]["TotalDaysOfStorage"].ToString()) ? Convert.ToInt32(result.Tables[2].Rows[0]["TotalDaysOfStorage"].ToString()) : 0;
                        activityReportDetails.CarsReleased = !string.IsNullOrEmpty(result.Tables[2].Rows[0]["ReleasedStorage"].ToString()) ? Convert.ToInt32(result.Tables[2].Rows[0]["ReleasedStorage"].ToString()) : 0;
                        activityReportDetails.CarsReceived = !string.IsNullOrEmpty(result.Tables[2].Rows[0]["ReceivedStorage"].ToString()) ? Convert.ToInt32(result.Tables[2].Rows[0]["ReceivedStorage"].ToString()) : 0;
                        activityReportDetails.Commodities = !string.IsNullOrEmpty(result.Tables[3].Rows[0]["Commodities"].ToString()) ? Convert.ToString(result.Tables[3].Rows[0]["Commodities"]) : "Not Available";
                    }
                }
            }
            storageFacilityActivityReportViewModels.Add(storageFacilityActivityReportViewModel);
            return storageFacilityActivityReportViewModels;
        }
    }
}
