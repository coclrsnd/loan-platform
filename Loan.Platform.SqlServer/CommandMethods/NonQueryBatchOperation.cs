using System;
using System.Data;
using System.Threading.Tasks;
using Microsoft.Data.SqlClient;

namespace Loan.Platform.Data.SqlServer.CommandMethods
{
    public class NonQueryBatchOperation : BatchOperation<int>, IBatchOperation<int>
    {
        private readonly IDbCommand _command;

        public NonQueryBatchOperation(IDbCommand command)
        {
            this._command = command;
        }
        public override async Task<int> Execute(IDbConnection cn, IDbTransaction tran = null)
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
                int result = 0;

                result =await  ((SqlCommand)_command).ExecuteNonQueryAsync(new System.Threading.CancellationToken());
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
