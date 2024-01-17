using System;
using System.Linq;
using System.Linq.Expressions;
using System.Threading.Tasks;
using Loan.Platform.Data.SqlServer.Pact;
using Loan.Platform.Models.Entities;

namespace Loan.Platform.Data.SqlServer.Repositories
{
    public class LoansRepository : BaseRepository<Loans, long>, IRepository<Loans, long>

    {
        private readonly RailCarLoungeContext _railCarLoungeContext;

        public string ConnectionString { get; private set; }

        public LoansRepository(RailCarLoungeContext railCarLoungeContext)
        {
            _railCarLoungeContext = railCarLoungeContext ?? throw new ArgumentNullException(nameof(railCarLoungeContext));
        }
       
        public override async Task<IQueryable<Loans>> GetByCondition(Expression<Func<Loans, bool>> expression)
        {
            return await Task.Run(
                () => { return this._railCarLoungeContext.Loans.Where(expression); });
        }
    }
}
