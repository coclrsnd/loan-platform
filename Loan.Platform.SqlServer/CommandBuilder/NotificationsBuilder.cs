using System;
using System.Data;
using StandardRail.RailCarLounge.Data.SqlServer.Extensions;
using StandardRail.RailCarLounge.Models.Entities;

namespace StandardRail.RailCarLounge.Data.SqlServer.CommandBuilder
{
    public class NotificationsBuilder:BaseCommandBuilder<MailLog, long>
    {
        public override IDbCommand Create(MailLog mailLog)
        {
            var command =CreateCommand();
            command.CommandType = CommandType.StoredProcedure;
            command.CommandText = "spInsertMail";

            command.AddParameter("action", "Sign-Up Action");
            command.AddParameter("userName","Suyash Khokale");
            command.AddParameter("userEmail", "suyash.khokale@gmail.com");
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
