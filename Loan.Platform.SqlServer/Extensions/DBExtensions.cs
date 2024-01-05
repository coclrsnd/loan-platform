using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Loan.Platform.Data.SqlServer.Extensions
{
    public static class DBExtensions
    {
        public static void AddParameter(this IDbCommand command, string paramName, object value)
        {
            var param = command.CreateParameter();
            param.ParameterName = paramName;
            param.Value = value;
            command.Parameters.Add(param);
        }

    }
}
