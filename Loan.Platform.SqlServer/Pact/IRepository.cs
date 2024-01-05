using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Linq.Expressions;
using System.Threading.Tasks;
using Loan.Platform.Data.SqlServer.CommandMethods;

namespace Loan.Platform.Data.SqlServer.Pact
{
    /// <summary>
    /// Inferface for performing all types of database operations.
    /// </summary>
    /// <typeparam name="TEntity"></typeparam>
    /// <typeparam name="Key"></typeparam>
    public interface IRepository<TEntity, Key>
    {
        Task<TEntity> Create(TEntity _object);

        Task<IList<TEntity>> SaveEntities(IList<TEntity> entities);

        Task Update(TEntity _object);

        Task<IList<TEntity>> GetAll();

        Task<IList<TEntity>> Search(TEntity _object);

        Task<TEntity> SearchWithPagination(TEntity _object);

        int GetCount(TEntity _object);

        Task<TEntity> GetById(Key Id);

        Task Delete(Key key);

        Task<IList<TEntity>> GetListById(Key Id);

        ScalerBatchOperation<ResultType> GetScalerOperation<ResultType>(IDbCommand command);

        DbSetBatchOperation GetDbSetOperation(IDbCommand command);

        NonQueryBatchOperation GeNonQueryBatchOperation(IDbCommand command);

        Task<IQueryable<TEntity>> GetByCondition(Expression<Func<TEntity, bool>> expression);
    }
}
