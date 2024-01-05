using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Loan.Platform.Data.SqlServer.Pact;
using Loan.Platform.Models.UserManagementModels;

namespace Loan.Platform.Data.SqlServer.Repositories
{
    public class UserRolesRepository: BaseRepository<UserRoles, long>, IRepository<UserRoles, long>
    {
        private readonly RailCarLoungeContext _railCarLoungeContext;

        public UserRolesRepository(RailCarLoungeContext railCarLoungeContext)
        {
            this._railCarLoungeContext = railCarLoungeContext ?? throw new ArgumentNullException(nameof(railCarLoungeContext));
        }

        public override async Task<IList<UserRoles>> GetAll()
        {
            return await Task.Run(
                () => { return this._railCarLoungeContext.UsersRoles.Where(s => s.IsActive.Value).ToList(); });
        }

        public async override Task<UserRoles> GetById(long roleId)
        {
            return await Task.Run(
                () => { return _railCarLoungeContext.UsersRoles.Where(s => s.Id == roleId).FirstOrDefault(); });            
        }
    }
}
