using System.Data;
using System.Threading.Tasks;

namespace Loan.Platform.Data.SqlServer.CommandMethods
{
    public interface IBatchOperation
    {
        Task<object> Execute(IDbConnection cn, IDbTransaction tran = null);
    }

    public interface IBatchOperation<ResultType> : IBatchOperation
    {
    }


}
