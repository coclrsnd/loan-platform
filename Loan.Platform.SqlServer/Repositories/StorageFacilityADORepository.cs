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
    public class StorageFacilityADORepository : BaseADORepository<StorageFacilityBuilder, FacilityMapSearchViewModel, long>
    {
        public StorageFacilityADORepository(IConfiguration configuration, ICommandBuilder<FacilityMapSearchViewModel, long> commandBuilder)
            : base(configuration["DbConnectionString"], commandBuilder)
        {
        }

        public override async Task<IList<FacilityMapSearchViewModel>> Search(FacilityMapSearchViewModel facilityMapSearchViewModel)
        {
            var facilityMapSearchViewModels = new List<FacilityMapSearchViewModel>();
            using (var cn = new SqlConnection(ConnectionString))
            {
                var result = await GetDbSetOperation(_commandBuilder.Search(facilityMapSearchViewModel)).Execute(cn);
                if (result != null && result.Tables[0].Rows.Count > 0)
                {
                    facilityMapSearchViewModel.FacilityMapSearchResultViewModel = new FacilityMapSearchResultViewModel();
                    facilityMapSearchViewModel.FacilityMapSearchResultViewModel.StorageFacilityViewModels = (from DataRow dr in result.Tables[0].Rows
                                                                                                             select new StorageFacilityResultViewModel()
                                                                                                             {
                                                                                                                 Id = Convert.ToInt32(dr["id"]),
                                                                                                                 Name = dr["Name"].ToString(),
                                                                                                                 Interchanges = !string.IsNullOrEmpty(dr["Interchanges"].ToString()) ? dr["Interchanges"].ToString() : "N/A",
                                                                                                                 Description = dr["Description"].ToString(),
                                                                                                                 Lat = dr["Lat"].ToString(),
                                                                                                                 Long = dr["Long"].ToString(),
                                                                                                                 AvailableCars = Convert.ToInt32(dr["AvailableCars"]),
                                                                                                                 Capacity = Convert.ToInt32(dr["Capacity"]),
                                                                                                                 City = dr["City"].ToString(),
                                                                                                                 StateCode = dr["StateCode"].ToString(),
                                                                                                                 Rating = Convert.ToDouble(dr["Rating"]),
                                                                                                                 DailyStorageRate = dr["DailyRate"] != DBNull.Value ? Convert.ToDecimal(dr["DailyRate"]) : null,
                                                                                                                 StorageFeatures = dr["FeatureList"] != DBNull.Value ? dr["FeatureList"].ToString().Split(',').Select((e, i) => new StorageFeatureViewModel() { Name = e.ToString(), Id = i + 1 }).ToList() : null,
                                                                                                                 VendorId = DBFieldsMappingHelper.GetNullableInt64Value(dr, "VendorId"),
                                                                                                                 CurrencyCode = Convert.ToString(dr["CurrencyCode"])
                                                                                                             }).ToList();

                    facilityMapSearchViewModels.Add(facilityMapSearchViewModel);
                }
            }
            return facilityMapSearchViewModels;
        }
    }
}
