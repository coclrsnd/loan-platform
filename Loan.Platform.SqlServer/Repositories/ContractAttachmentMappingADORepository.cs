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
    public class ContractAttachmentMappingADORepository : BaseADORepository<ContractAttachmentBuilder, AttachmentViewModel, long>
    {

        private readonly IConfiguration _configuration;

        public ContractAttachmentMappingADORepository(IConfiguration configuration, ICommandBuilder<AttachmentViewModel, long> commandBuilder)
            : base(configuration["DbConnectionString"], commandBuilder)
        {
            _configuration = configuration;
        }

        public override async Task<IList<AttachmentViewModel>> GetListById(long Id)
        {
            var attachmentList = new List<AttachmentViewModel>();
            using (var cn = new SqlConnection(ConnectionString))
            {
                var result = await GetDbSetOperation(_commandBuilder.GetListById(Id)).Execute(cn);
                if (result.Tables[0].Rows.Count > 0)
                {
                    attachmentList = (from DataRow dr in result.Tables[0].Rows
                                      select new AttachmentViewModel()
                                      {
                                          Id = Convert.ToInt32(dr["Id"]),
                                          Path = string.IsNullOrEmpty(dr["Path"].ToString()) ? null : dr["Path"].ToString(),
                                          FileName = string.IsNullOrEmpty(dr["Name"].ToString()) ? null : dr["Name"].ToString(),
                                          ContractId = Convert.ToInt32(dr["ContractId"]),
                                          CreatedTime = (Convert.ToDateTime(dr["CreatedTime"].ToString())).ToDefaultTimeZone(_configuration["DefaultTimeZone"]),
                                          User = string.IsNullOrEmpty(dr["CreatedBy"].ToString())?null: dr["CreatedBy"].ToString(),
                                      }).ToList();
                }
            }
            return attachmentList;
        }
    }
}
