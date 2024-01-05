using System;
using System.Linq;
using System.Linq.Expressions;
using System.Threading.Tasks;
using Loan.Platform.Data.SqlServer.Pact;
using Loan.Platform.Models.UserManagementModels;

namespace Loan.Platform.Data.SqlServer.Repositories
{
    public class UserRoleAppFeatureRepository : BaseRepository<UserRoleAppFeatureMapping, long>, IRepository<UserRoleAppFeatureMapping, long>
    {
        private readonly RailCarLoungeContext _railCarLoungeContext;
        public UserRoleAppFeatureRepository(RailCarLoungeContext railCarLoungeContext)
        {
            _railCarLoungeContext = railCarLoungeContext ?? throw new ArgumentNullException(nameof(railCarLoungeContext));
        }

        public override async Task<IQueryable<UserRoleAppFeatureMapping>> GetByCondition(Expression<Func<UserRoleAppFeatureMapping, bool>> expression)
        {
            return await Task.Run(
                () => { return _railCarLoungeContext.UserRoleAppFeatureMappings.Where(expression); });
        }
    }
}
