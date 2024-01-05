using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.Data.SqlClient;
using Microsoft.Extensions.Configuration;
using StandardRail.RailCarLounge.Data.SqlServer.CommandBuilder;
using StandardRail.RailCarLounge.Models.ViewModels;

namespace StandardRail.RailCarLounge.Data.SqlServer.Repositories
{
    /// <summary>
    /// Performs ADO database operations for Vendor.
    /// </summary>
    public class VendorADORepository : BaseADORepository<VendorBuilder, VendorFilterViewModel, long>
    {
        public VendorADORepository(IConfiguration configuration, ICommandBuilder<VendorFilterViewModel, long> commandBuilder)
       : base(configuration["DbConnectionString"], commandBuilder)
        {
        }

        public override async Task<VendorFilterViewModel> SearchWithPagination(VendorFilterViewModel filterModel)
        {
            VendorFilterViewModel vendorFilterViewModel = new VendorFilterViewModel();

            var vendorsList = new List<VendorSearchGridViewModel>();

            vendorFilterViewModel.VendorRibbon = new VendorRibbon();
            using (var cn = new SqlConnection(ConnectionString))
            {
                var result = await GetDbSetOperation(_commandBuilder.Search(filterModel)).Execute(cn);
                if (result.Tables[0].Rows.Count > 0 && result.Tables[1].Rows.Count > 0)
                {
                    //vendorFilterViewModel.Pagination = new PaginationModel()
                    //{
                    //    Index = filterModel.Pagination.Index,
                    //    Size = filterModel.Pagination.Size,
                    //    TotalRecords = Convert.ToInt32(result.Tables[0].Rows[0]["TotalRecords"]),
                    //};
                    vendorFilterViewModel.VendorGridData = new List<VendorSearchGridViewModel>();

                    foreach (DataRow dr in result.Tables[1].Rows)
                    {
                        VendorSearchGridViewModel searchGridViewModel = new VendorSearchGridViewModel();
                        searchGridViewModel.Vendor = dr["Vendor"].ToString();
                        searchGridViewModel.Id = Convert.ToInt64(dr["VendorId"].ToString());
                        //searchGridViewModel.StorageFacilityId = Convert.ToInt64(dr["StorageFacilityId"].ToString());

                        if (!vendorFilterViewModel.VendorGridData.Any(t => t.Id == searchGridViewModel.Id))
                        {
                            if (result.Tables.Count > 1 && result.Tables[1] != null && result.Tables[1].Rows != null && result.Tables[1].Rows.Count > 0)
                            {
                                // Bind data to Child Grid
                              
                                    vendorsList = (from vendor in result.Tables[0].AsEnumerable()
                                                   group vendor by
                                                   new
                                                   {
                                                       Id = vendor.Field<long>("VendorId"),
                                                       StorageFacilityId = vendor.Field<long>("StorageFacilityId"),
                                                       StorageFacilityName = vendor.Field<string>("StorageFacilityName"),
                                                       Interchanges = vendor.Field<string>("Interchanges"),
                                                       Location = vendor.Field<string>("Locations"),
                                                   }
                                                   into vendorList
                                                   select new VendorSearchGridViewModel()
                                                   {
                                                       Id = vendorList.Key.Id,
                                                       StorageFacilityId = vendorList.Key.StorageFacilityId,
                                                       ContractedSpace = vendorList.Sum(x => x.Field<int>("TotalCars")),
                                                       CarsStored = vendorList.Sum(x => x.Field<int>("AvailableCars")),
                                                       TotalAmount = (double)vendorList.Sum(x => x.Field<decimal>("TotalAmount")),
                                                       AVGMonthlyCost = (double)vendorList.Sum(x => x.Field<decimal>("AVGMonthly")),
                                                       AVGCarCost = vendorList.Sum(x => x.Field<int>("AvailableCars")) != 0 ? Math.Round((double)vendorList.Sum(x => x.Field<decimal>("AVGMonthly")) / vendorList.Sum(x => x.Field<int>("AvailableCars")), 2) : 0,
                                                       Facility = vendorList.Key.StorageFacilityName,
                                                       Location = vendorList.Key.Location,
                                                       Interchanges = vendorList.Key.Interchanges,
                                                   }).Where(x => x.Id == searchGridViewModel.Id).ToList();
                            }

                            // Bind data to main Grid
                            searchGridViewModel.VendorChildData = vendorsList;
                            searchGridViewModel.Facility = vendorsList.Count.ToString() + " Facilities";
                            searchGridViewModel.Location = vendorsList.Select(t => t.Location.Split(",")).Select(g => new { TotalRecords = g.Count() }).Sum(t => t.TotalRecords).ToString();
                            searchGridViewModel.Interchanges = vendorsList.Select(t => t.Interchanges.Split(", ").Distinct()).Select(g => new { TotalRecords = g.Count() }).Sum(t => t.TotalRecords).ToString();
                            searchGridViewModel.ContractedSpace = vendorsList.Sum(t => t.ContractedSpace);
                            searchGridViewModel.CarsStored = vendorsList.Sum(t => t.CarsStored);
                            searchGridViewModel.TotalAmount = vendorsList.Sum(t => t.TotalAmount);
                            searchGridViewModel.AVGMonthlyCost = vendorsList.Sum(t => t.AVGMonthlyCost);
                            searchGridViewModel.AVGCarCost = vendorsList.Sum(t => t.AVGCarCost);
                            vendorFilterViewModel.VendorRibbon.TotalFacilities += vendorsList.Count;
                            vendorFilterViewModel.VendorGridData.Add(searchGridViewModel);
                            vendorFilterViewModel.VendorRibbon.TotalCarsStored += vendorsList.Sum(t => t.CarsStored);
                            vendorFilterViewModel.VendorRibbon.TotalContractedSpaces += vendorsList.Sum(t => t.ContractedSpace);
                        }
                    }
                    vendorFilterViewModel.VendorRibbon.TotalLoadedCars = result.Tables[0].AsEnumerable().Sum(x => x.Field<int>("LoadedCars"));
                    vendorFilterViewModel.VendorRibbon.TotalEmptyCars = result.Tables[0].AsEnumerable().Sum(x => x.Field<int>("EmptyCars"));
                    vendorFilterViewModel.VendorRibbon.TotalVendors = vendorFilterViewModel.VendorGridData.Count;
                    vendorFilterViewModel.VendorRibbon.TotalSpacesAvailable = vendorFilterViewModel.VendorRibbon.TotalContractedSpaces - vendorFilterViewModel.VendorRibbon.TotalCarsStored;
                }
            }

            return vendorFilterViewModel;
        }
    }
}
