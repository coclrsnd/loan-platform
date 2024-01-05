using System;
using System.Linq;
using System.Linq.Expressions;
using System.Threading.Tasks;
using Loan.Platform.Data.SqlServer.Pact;
using Loan.Platform.Models.Entities;

namespace Loan.Platform.Data.SqlServer.Repositories
{
    public class SignUpUserRepository : BaseRepository<SignUpUser, long>, IRepository<SignUpUser, long>
    {
        private readonly RailCarLoungeContext _railCarLoungeContext;

        public SignUpUserRepository(RailCarLoungeContext railCarLoungeContext)
        {
            _railCarLoungeContext = railCarLoungeContext ?? throw new ArgumentNullException(nameof(railCarLoungeContext));
        }

        public async override Task<SignUpUser> GetById(long userId)
        {
            return await _railCarLoungeContext.SignUpUsers.FindAsync(Convert.ToInt32(userId));
        }

        public async override Task Update(SignUpUser user)
        {
            _railCarLoungeContext.SignUpUsers.Update(user);
            await _railCarLoungeContext.SaveChangesAsync();
        }

        public async override Task<SignUpUser> Create(SignUpUser user)
        {
            var savedUser = await _railCarLoungeContext.SignUpUsers.AddAsync(user);
            await _railCarLoungeContext.SaveChangesAsync();
            return savedUser.Entity;
        }

        public override async Task<IQueryable<SignUpUser>> GetByCondition(Expression<Func<SignUpUser, bool>> expression)
        {
            return await Task.Run(
                () => { return this._railCarLoungeContext.SignUpUsers.Where(expression); });
        }
    }
}
