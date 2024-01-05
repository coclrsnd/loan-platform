using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Linq.Expressions;
using System.Threading.Tasks;
using Loan.Platform.Data.SqlServer.CommandBuilder;
using Loan.Platform.Data.SqlServer.CommandMethods;
using Loan.Platform.Data.SqlServer.Pact;

namespace Loan.Platform.Data.SqlServer.Repositories
{
    public class BaseADORepository<CommandBuilder, T, K> : IRepository<T, K> where CommandBuilder : ICommandBuilder<T, K>
    {
        public readonly ICommandBuilder<T, K> _commandBuilder;

        public string ConnectionString { get; set; }
        public BaseADORepository(string connectionString,ICommandBuilder<T,K> commandBuilder)
        {
            ConnectionString= connectionString;
            _commandBuilder = commandBuilder ?? throw new ArgumentNullException(nameof(commandBuilder));
        }
        public virtual Task<T> Create(T _object)
        {
            throw new NotImplementedException();
        }

        public virtual Task Delete(K key)
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

        public virtual Task Update(T _object)
        {
            throw new NotImplementedException();
        }

        public ScalerBatchOperation<ResultType> GetScalerOperation<ResultType>(IDbCommand command)
        {
            return new ScalerBatchOperation<ResultType>(command);
        }

        public DbSetBatchOperation GetDbSetOperation(IDbCommand command)
        {
            return new DbSetBatchOperation(command);
        }

        public NonQueryBatchOperation GetNonQueryBatchOperation(IDbCommand command)
        {
            return new NonQueryBatchOperation(command);
        }

        public NonQueryBatchOperation GeNonQueryBatchOperation(IDbCommand command)
        {
            return new NonQueryBatchOperation(command);
        }

        public virtual Task<IList<T>> Search(T _object)
        {
            throw new NotImplementedException();
        }

        public virtual Task<IList<T>> GetListById(K Id)
        {
            throw new NotImplementedException();
        }

        public virtual int GetCount(T _object)
        {
            throw new NotImplementedException();
        }

        public virtual Task<IQueryable<T>> GetByCondition(Expression<Func<T, bool>> expression)
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
