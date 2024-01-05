using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.Data.SqlClient;
using Microsoft.Extensions.Configuration;
using StandardRail.RailCarLounge.Data.SqlServer.CommandBuilder;
using StandardRail.RailCarLounge.Data.SqlServer.Pact;
using StandardRail.RailCarLounge.Models.Entities;

namespace StandardRail.RailCarLounge.Data.SqlServer.Repositories
{
    /// <summary>
    /// Performs ADO database operations for RailRoad.
    /// </summary>
    public class RailRoadADORepository : BaseADORepository<RailRoadBuilder, RailRoad, long>, IRepository<RailRoad, long>  
    {
        


        public RailRoadADORepository(IConfiguration configuration, ICommandBuilder<RailRoad,long> commandBuilder) 
            :base(configuration["DbConnectionString"], commandBuilder) 
        {
        }

        public override async Task<RailRoad> Create(RailRoad railRoad)
        {
            var result = 0L;
            using (var cn = new SqlConnection(ConnectionString))
            {
                result =await  GetScalerOperation<long>(_commandBuilder.Create(railRoad))
                           .Execute(cn);
            }
            railRoad.Id = result;
            return railRoad;
        }

        public override async Task<IList<RailRoad>> GetAll() 
        {
            var result1= new List<RailRoad>();
            using (var cn = new SqlConnection(ConnectionString))
            {
                var result = await GetDbSetOperation(_commandBuilder.All()).Execute(cn);
            }
            return result1.ToList();
        }
    }
}
