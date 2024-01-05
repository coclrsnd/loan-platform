using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.Data.SqlClient;
using Microsoft.Extensions.Configuration;
using Loan.Platform.Common.Helpers;
using Loan.Platform.Data.SqlServer.CommandBuilder;
using Loan.Platform.Models.ViewModels;


namespace Loan.Platform.Data.SqlServer.Repositories
{
    public class AuditLogADORepository : BaseADORepository<AuditLogBuilder, AuditLogFilterViewModel, long>
    {
        private readonly IConfiguration _configuration;
        public AuditLogADORepository(IConfiguration configuration, ICommandBuilder<AuditLogFilterViewModel, long> commandBuilder)
            : base(configuration["DbConnectionString"], commandBuilder)
        {
            _configuration = configuration;
        }

        public override async Task<AuditLogFilterViewModel> GetById(long Id)
        {
            var auditLogs = new List<AuditLogViewModel>();
            var auditLogFilterViewModel = new AuditLogFilterViewModel();
            using (var cn = new SqlConnection(ConnectionString))
            {
                var result = await GetDbSetOperation(_commandBuilder.GetListById(Id)).Execute(cn);
                if (result.Tables[0].Rows.Count > 0)
                {
                    auditLogs = (from DataRow dr in result.Tables[0].Rows
                                 select new AuditLogViewModel()
                                 {
                                     Id = Convert.ToInt32(dr["Id"]),
                                     Description = string.IsNullOrEmpty(dr["Description"].ToString()) ? null : dr["Description"].ToString(),
                                     Action = string.IsNullOrEmpty(dr["Action"].ToString()) ? null : dr["Action"].ToString(),
                                     CreatedTime = Convert.ToDateTime(dr["CreatedTime"].ToString()).ToDefaultTimeZone(_configuration["DefaultTimeZone"]),
                                     User = string.IsNullOrEmpty(dr["CreatedBy"].ToString()) ? null : dr["CreatedBy"].ToString(),
                                 }).ToList();
                }
                auditLogFilterViewModel.AuditLogModel = auditLogs.OrderByDescending(e => e.CreatedTime).ToList();
            }
            return auditLogFilterViewModel;
        }

        public override async Task<AuditLogFilterViewModel> SearchWithPagination(AuditLogFilterViewModel filterModel)
        {
            AuditLogFilterViewModel auditLogFilterViewModel = new AuditLogFilterViewModel();
            var auditLogViewModel = new List<AuditLogViewModel>();

            using (var cn = new SqlConnection(ConnectionString))
            {
                var result = await GetDbSetOperation(_commandBuilder.Search(filterModel)).Execute(cn);
                if (result?.Tables[0]?.Rows.Count > 0)
                {
                    auditLogFilterViewModel.Pagination = new PaginationModel()
                    {
                        Index = filterModel.Pagination.Index,
                        Size = filterModel.Pagination.Size,
                        TotalRecords = Convert.ToInt32(result.Tables[0].Rows[0]["TotalRecords"]),
                    };

                    auditLogViewModel = (from DataRow dr in result.Tables[0].Rows
                                         select new AuditLogViewModel()
                                         {
                                             Id = Convert.ToInt32(dr["Id"]),
                                             Description = string.IsNullOrEmpty(dr["Description"].ToString()) ? null : dr["Description"].ToString(),
                                             Action = string.IsNullOrEmpty(dr["Action"].ToString()) ? null : dr["Action"].ToString(),
                                             CreatedTime = Convert.ToDateTime(dr["CreatedTime"].ToString()).ToDefaultTimeZone(_configuration["DefaultTimeZone"]),
                                             User = string.IsNullOrEmpty(dr["CreatedBy"].ToString()) ? null : dr["CreatedBy"].ToString(),
                                         }).ToList();
                    auditLogFilterViewModel.AuditLogModel = auditLogViewModel;

                }
            }
            return auditLogFilterViewModel;
        }
    }
}
