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
    public class ContractNoteMappingADORepository : BaseADORepository<ContractNoteBuilder, NoteViewModel, long>
    {
        private readonly IConfiguration _configuration;


        public ContractNoteMappingADORepository(IConfiguration configuration, ICommandBuilder<NoteViewModel, long> commandBuilder)
            : base(configuration["DbConnectionString"], commandBuilder)
        {
            _configuration = configuration;
        }

        public override async Task<IList<NoteViewModel>> GetListById(long Id)
        {
            var noteList = new List<NoteViewModel>();
            using (var cn = new SqlConnection(ConnectionString))
            {
                var result = await GetDbSetOperation(_commandBuilder.GetListById(Id)).Execute(cn);
                if (result.Tables[0].Rows.Count > 0)
                {
                    noteList = (from DataRow dr in result.Tables[0].Rows
                                      select new NoteViewModel()
                                      {
                                          Id = Convert.ToInt32(dr["Id"]),
                                          Description = string.IsNullOrEmpty(dr["Description"].ToString()) ? null : dr["Description"].ToString(),
                                          ContractId = Convert.ToInt32(dr["ContractId"]),
                                          CreatedTime = Convert.ToDateTime(dr["CreatedTime"].ToString()).ToDefaultTimeZone(_configuration["DefaultTimeZone"]),
                                          User = string.IsNullOrEmpty(dr["CreatedBy"].ToString()) ? null : dr["CreatedBy"].ToString(),
                                      }).ToList();
                }
            }
            return noteList;
        }
    }
}
