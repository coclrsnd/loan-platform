using System;
using System.Linq;
using System.Linq.Expressions;
using System.Threading.Tasks;
using Loan.Platform.Data.SqlServer.Pact;
using Loan.Platform.Models.Entities;

namespace Loan.Platform.Data.SqlServer.Repositories
{
    public class UserRepository : BaseRepository<User, long>, IRepository<User, long>

    {
        private readonly RailCarLoungeContext _railCarLoungeContext;

        public string ConnectionString { get; private set; }

        public UserRepository(RailCarLoungeContext railCarLoungeContext)
        {
            _railCarLoungeContext = railCarLoungeContext ?? throw new ArgumentNullException(nameof(railCarLoungeContext));
        }
        public async override Task<User> Create(User user)
        {
            try
            {
                var savedUser = await _railCarLoungeContext.Users.AddAsync(user);
                var res = await _railCarLoungeContext.SaveChangesAsync();
                return savedUser.Entity;
            }
            catch (Exception)
            {
                throw;
            }
        }

        public async override Task<User> GetById(long userId)
        {
            var user = await _railCarLoungeContext.Users.FindAsync(userId);
            return user;

        }

        public async override Task Update(User user)
        {
            try
            {
                var savedUser = _railCarLoungeContext.Users.Update(user);
                var res = await _railCarLoungeContext.SaveChangesAsync();
            }
            catch (Exception)
            {
                throw;
            }
        }

        public override async Task<IQueryable<User>> GetByCondition(Expression<Func<User, bool>> expression)
        {
            return await Task.Run(
                () => { return this._railCarLoungeContext.Users.Where(expression); });
        }
    }
}
