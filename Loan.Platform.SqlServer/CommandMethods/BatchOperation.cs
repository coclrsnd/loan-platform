using System;
using System.Data;
using System.Threading.Tasks;

namespace Loan.Platform.Data.SqlServer.CommandMethods
{
    public class BatchOperation<ResultType> : IBatchOperation<ResultType>
    {
        public virtual async Task<ResultType> Execute(IDbConnection cn, IDbTransaction tran = null)
        {
            throw new NotImplementedException();
        }

        async Task<object> IBatchOperation.Execute(IDbConnection cn, IDbTransaction tran = null)
        {
            return await Execute(cn, tran);
        }
    }
}
