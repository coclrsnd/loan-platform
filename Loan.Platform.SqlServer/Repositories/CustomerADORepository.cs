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
    /// Performs ADO database operations for Customer.
    /// </summary>
    public class CustomerADORepository : BaseADORepository<CustomerBuilder, CustomerFilterViewModel, long>
    {
        public CustomerADORepository(IConfiguration configuration, ICommandBuilder<CustomerFilterViewModel, long> commandBuilder)
        : base(configuration["DbConnectionString"], commandBuilder)
        {
        }

        public override async Task<CustomerFilterViewModel> SearchWithPagination(CustomerFilterViewModel filterModel)
        {
            CustomerFilterViewModel customerFilterViewModel = new CustomerFilterViewModel();
            customerFilterViewModel.CustomerRibbon = new CustomerRibbon();
            var customersList = new List<CustomerViewModel>();

            using (var cn = new SqlConnection(ConnectionString))
            {
                var result = await GetDbSetOperation(_commandBuilder.Search(filterModel)).Execute(cn);
                if (result?.Tables[0]?.Rows.Count > 0)
                {
                    customerFilterViewModel.Pagination = new PaginationModel()
                    {
                        Index = filterModel.Pagination.Index,
                        Size = filterModel.Pagination.Size,
                        TotalRecords = Convert.ToInt32(result.Tables[0].Rows[0]["TotalRecords"]),
                    };

                    customersList = (from DataRow dr in result.Tables[0].Rows
                                     select new CustomerViewModel()
                                     {
                                         Id = Convert.ToInt32(dr["Id"]),
                                         Name = dr["Organization"].ToString(),
                                         PrimaryContactNo = dr["PrimaryContact"].ToString(),
                                         PrimaryContactEmail = dr["PrimaryEmail"].ToString(),
                                         Location = dr["Location"].ToString()
                                     }).ToList();
                    customerFilterViewModel.CustomerModel = customersList;
                    customerFilterViewModel.CustomerRibbon.TotalCustomers = Convert.ToInt32(result.Tables[0].Rows[0]["TotalRecords"]);

                    if (result?.Tables[1]?.Rows.Count > 0)
                    {
                        customerFilterViewModel.CustomerRibbon.TotalCarsStored = Convert.ToInt32(result.Tables[1].Rows[0]["TotalCarsStored"]);
                        customerFilterViewModel.CustomerRibbon.TotalContractedSpaces = Convert.ToInt32(result.Tables[1].Rows[0]["TotalContractedSpaces"]);
                        customerFilterViewModel.CustomerRibbon.TotalStorageOrders = Convert.ToInt32(result.Tables[1].Rows[0]["TotalStorageOrders"]);
                    }

                }
            }

            return customerFilterViewModel;
        }
    }
}