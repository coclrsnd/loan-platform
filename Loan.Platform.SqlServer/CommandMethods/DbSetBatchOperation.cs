using Microsoft.Data.SqlClient;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Loan.Platform.Data.SqlServer.CommandMethods
{
    public class DbSetBatchOperation : BatchOperation<DataSet>, IBatchOperation<DataSet>
    {
        private readonly IDbCommand _command;

        public DbSetBatchOperation(IDbCommand command)
        {
            this._command = command;
        }
        public override async Task<DataSet> Execute(IDbConnection cn, IDbTransaction tran = null)
        {
            DataSet result = new DataSet();
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

                using (SqlDataAdapter dataAdapter = new SqlDataAdapter((SqlCommand)_command))
                {
                    await Task.Run(() => dataAdapter.Fill(result));
                }
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
