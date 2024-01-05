using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Loan.Platform.Data.SqlServer.CommandBuilder
{
    public interface ICommandBuilder<T, K>
    {
        IDbCommand CreateCommand();
        IDbCommand All();
        IDbCommand GetById(K key);
        IDbCommand Create(T entity);
        IDbCommand Update(T entity);
        IDbCommand Delete(K key);
        IDbCommand Search(T entity);
        IDbCommand GetCount(T entity);
        IDbCommand GetListById(K key);
    }
}
