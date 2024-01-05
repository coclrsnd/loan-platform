using System;
using System.Data;
using Microsoft.Data.SqlClient;

namespace Loan.Platform.Data.SqlServer.CommandBuilder
{
    public class BaseCommandBuilder<T, K> : ICommandBuilder<T, K>
    {
        public virtual IDbCommand All()
        {
            throw new NotImplementedException();
        }

        public virtual IDbCommand Create(T entity)
        {
            throw new NotImplementedException();
        }

        public virtual IDbCommand Search(T entity)
        {
            throw new NotImplementedException();
        }

        public virtual IDbCommand CreateCommand()
        {
            return new SqlCommand();
        }

        public virtual IDbCommand Delete(K key)
        {
            throw new NotImplementedException();
        }

        public virtual IDbCommand GetById(K key)
        {
            throw new NotImplementedException();
        }

        public virtual IDbCommand GetListById(K key)
        {
            throw new NotImplementedException();
        }

        public virtual IDbCommand Update(T entity)
        {
            throw new NotImplementedException();
        }

        public virtual IDbCommand GetCount(T entity)
        {
            throw new NotImplementedException();
        }

        //public virtual IDbCommand GetListById(long id)
        //{
        //    throw new NotImplementedException();
        //}
    }
}
