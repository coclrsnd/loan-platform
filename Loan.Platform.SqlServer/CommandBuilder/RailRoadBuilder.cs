using StandardRail.RailCarLounge.Data.SqlServer.Extensions;
using StandardRail.RailCarLounge.Models.Entities;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace StandardRail.RailCarLounge.Data.SqlServer.CommandBuilder
{
    public class RailRoadBuilder:BaseCommandBuilder<RailRoad, long>
    {
        public override IDbCommand Create(RailRoad railRoad)
        {
            var command =CreateCommand();
            command.CommandType = CommandType.StoredProcedure;
            command.CommandText = "CreateOrUpdateRailRoad";

            command.AddParameter("Name",railRoad.Name);
            command.AddParameter("RailRoadNumber", railRoad.MarkCode);
            command.AddParameter("IsActive", true);
            command.AddParameter("CreatedTime",DateTime.Now);
            command.AddParameter("CreatedBy",1);
            command.AddParameter("ModifiedTime",DateTime.Now);
            command.AddParameter("ModifiedBy",1);
            command.AddParameter("OrganizationId", 1);
            command.AddParameter("TenantId", 1);
            return command;
        }

        public override IDbCommand All()
        {
            var command = CreateCommand();
            command.CommandType = CommandType.StoredProcedure;
            command.CommandText = "GetRailRoads";
           
            return command;
        }
    }
}
