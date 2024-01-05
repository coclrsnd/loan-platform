using System;
using System.Linq;
using System.Linq.Expressions;
using System.Threading.Tasks;
using Loan.Platform.Data.SqlServer.Pact;
using Loan.Platform.Models.UserManagementModels;

namespace Loan.Platform.Data.SqlServer.Repositories
{
    public class UserRoleMappingRepository : BaseRepository<UserRoleMapping, long>, IRepository<UserRoleMapping, long>
    {
        private readonly RailCarLoungeContext _railCarLoungeContext;
        public UserRoleMappingRepository(RailCarLoungeContext railCarLoungeContext)
        {
            _railCarLoungeContext = railCarLoungeContext ?? throw new ArgumentNullException(nameof(railCarLoungeContext));
        }
        public async override Task<UserRoleMapping> Create(UserRoleMapping userRoleTypeMapping)
        {
            try
            {
                var result = await _railCarLoungeContext.UserRoleMappings.AddAsync(userRoleTypeMapping);
                var res = await _railCarLoungeContext.SaveChangesAsync();
                return result.Entity;
            }
            catch (Exception)
            {
                throw;
            }
        }

        public override async Task<IQueryable<UserRoleMapping>> GetByCondition(Expression<Func<UserRoleMapping, bool>> expression)
        {
            return await Task.Run(
                () => { return this._railCarLoungeContext.UserRoleMappings.Where(expression); });
        }
    }
}
