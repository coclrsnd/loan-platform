using Microsoft.Data.SqlClient;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Loan.Platform.Data.SqlServer.CommandMethods
{
    public class ScalerBatchOperation<ResultType> : BatchOperation<ResultType>, IBatchOperation<ResultType>
    {
        private readonly IDbCommand _command;

        public ScalerBatchOperation(IDbCommand command)
        {
            this._command = command;
        }
        public override async Task<ResultType> Execute(IDbConnection cn, IDbTransaction tran = null)
        {
            try
            {
                if (cn.State == ConnectionState.Closed)
                {
                    cn.Open();
                }

                _command.Connection = cn;
                if (tran != null)
                {
                    _command.Transaction = tran;
                }

                var result = (ResultType)Convert.ChangeType(await ((SqlCommand)_command).ExecuteScalarAsync(), typeof(ResultType));
                return result;
            }
            catch (Exception)
            {
                if (tran != null)
                {
                    tran.Rollback();
                }
                throw;
            }
        }
    }
}
