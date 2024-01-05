using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using System.Threading.Tasks;
using Loan.Platform.Data.SqlServer.Pact;
using Loan.Platform.Models.Entities;

namespace Loan.Platform.Data.SqlServer.Repositories
{
    public class UserStatusRepository : BaseRepository<UserStatus, long>, IRepository<UserStatus, long>
    {
        private readonly RailCarLoungeContext _railCarLoungeContext;

        public UserStatusRepository(RailCarLoungeContext railCarLoungeContext)
        {
            this._railCarLoungeContext = railCarLoungeContext ?? throw new ArgumentNullException(nameof(railCarLoungeContext));
        }

        public override async Task<IList<UserStatus>> GetAll()
        {
            return await Task.Run(
                () => { return this._railCarLoungeContext.UserStatuses.Where(s => s.IsActive.Value).ToList(); });
        }

        public override async Task<IQueryable<UserStatus>> GetByCondition(Expression<Func<UserStatus, bool>> expression)
        {
            return await Task.Run(
                () => { return this._railCarLoungeContext.UserStatuses.Where(expression); });
        }
    }
}
