using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.Data.SqlClient;
using Microsoft.Extensions.Configuration;
using Loan.Platform.Data.SqlServer.CommandBuilder;
using Loan.Platform.Models.ViewModels;

namespace Loan.Platform.Data.SqlServer.Repositories
{

    public class UserADORepository : BaseADORepository<UserBuilder, UserFilterViewModel, long>
    {
        public UserADORepository(IConfiguration configuration, ICommandBuilder<UserFilterViewModel, long> commandBuilder)
            : base(configuration["DbConnectionString"], commandBuilder)
        {
        }


        public override async Task<UserFilterViewModel> SearchWithPagination(UserFilterViewModel userViewModel)
        {
            var userList = new List<SignUpUserViewModel>();
            using (var cn = new SqlConnection(ConnectionString))
            {
                var result = await GetDbSetOperation(_commandBuilder.Search(userViewModel)).Execute(cn);
                if (result.Tables[0].Rows.Count > 0)
                {
                    userViewModel.PaginationModel = new PaginationModel()
                    {
                        TotalRecords = Convert.ToInt32(result.Tables[0].Rows[0]["TotalRecords"]),
                    };
                    userList = (from DataRow dr in result.Tables[0].Rows
                                select new SignUpUserViewModel()
                                {
                                    Id = Convert.ToInt32(dr["id"]),
                                    FirstName = dr["FirstName"].ToString(),
                                    LastName = dr["LastName"].ToString(),
                                    CompanyName = dr["CompanyName"].ToString(),
                                    Designation = dr["Designation"].ToString(),
                                    EmailId = dr["EmailId"].ToString(),
                                    ContactNo = dr["ContactNo"].ToString(),
                                    IsApproved = Convert.ToBoolean(dr["IsApproved"]),
                                    UserType = dr["UserType"].ToString(),
                                    Status = dr["Status"].ToString(),
                                    StatusId = string.IsNullOrEmpty(dr["StatusId"].ToString()) ? 1 : Convert.ToInt64(dr["StatusId"]),
                                    UserTypeId = string.IsNullOrEmpty(dr["UserTypeId"].ToString()) ? null : Convert.ToInt64(dr["UserTypeId"]),
                                    Organization = dr["Organization"].ToString(),
                                    OrganizationId = string.IsNullOrEmpty(dr["OrganizationId"].ToString()) ? null : Convert.ToInt64(dr["OrganizationId"]),
                                }).ToList();
                }
                userViewModel.UserList= userList;
            }
            return userViewModel;
        }

    }
}
