using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace StandardRail.RailCarLounge.Data.SqlServer.CommandBuilder
{
    public class StorageFeatureBuilder<TEnitity, Key> :BaseCommandBuilder<TEnitity, Key>
    {
        //public override IDbCommand Create(TEnitity entity)
        //{
        //    var command = CreateCommand();
        //    command.CommandType = CommandType.StoredProcedure;
        //    command.CommandText = "CreateStorageFeature";
        //}
    }
}
