using Microsoft.Data.SqlClient;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Loan.Platform.Data.SqlServer.CommandMethods
{
    public class ReaderBatchOperation<ResultType>:BatchOperation<List<ResultType>>,IBatchOperation<List<ResultType>>
    {
        private readonly IDbCommand _command;

        public ReaderBatchOperation(IDbCommand command)
        {
            this._command = command;
        }
        public override async Task<List<ResultType>> Execute(IDbConnection cn, IDbTransaction tran = null)
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
                //this will not work as we need to mapping here
                // added just for support
                var result = (List<ResultType>)Convert.ChangeType(await ((SqlCommand)_command).ExecuteReaderAsync(), typeof(ResultType));
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
