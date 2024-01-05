using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Linq.Expressions;
using System.Threading.Tasks;
using Loan.Platform.Data.SqlServer.CommandMethods;
using Loan.Platform.Data.SqlServer.Pact;

namespace Loan.Platform.Data.SqlServer.Repositories
{
    public class BaseRepository<T, K> : IRepository<T, K>
    {
        public virtual Task<T> Create(T _object)
        {
            throw new NotImplementedException();
        }

        public virtual Task Delete(K key)
        {
            throw new NotImplementedException();
        }

        public virtual Task Update(T _object)
        {
            throw new NotImplementedException();
        }

        public virtual Task<IList<T>> GetAll()
        {
            throw new NotImplementedException();
        }

        public virtual Task<T> GetById(K Id)
        {
            throw new NotImplementedException();
        }

        public DbSetBatchOperation GetDbSetOperation(IDbCommand command)
        {
            throw new NotImplementedException();
        }

        public ScalerBatchOperation<ResultType> GetScalerOperation<ResultType>(IDbCommand command)
        {
            throw new NotImplementedException();
        }
        public NonQueryBatchOperation GeNonQueryBatchOperation(IDbCommand command)
        {
            throw new NotImplementedException();
        }

        public Task<IList<T>> Search(T _object)
        {
            throw new NotImplementedException();
        }

        public virtual Task<IList<T>> GetListById(K Id)
        {
            throw new NotImplementedException();
        }

        public virtual Task<IQueryable<T>> GetByCondition(Expression<Func<T, bool>> expression)
        {
            throw new NotImplementedException();
        }

        public virtual int GetCount(T _object)
        {
            throw new NotImplementedException();
        }

        public virtual Task<T> SearchWithPagination(T _object)
        {
            throw new NotImplementedException();
        }

        public virtual Task<IList<T>> SaveEntities(IList<T> entities)
        {
            throw new NotImplementedException();
        }
    }
}
