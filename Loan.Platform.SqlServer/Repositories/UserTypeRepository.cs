using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Loan.Platform.Data.SqlServer.Pact;
using Loan.Platform.Models.UserManagementModels;

namespace Loan.Platform.Data.SqlServer.Repositories
{
    public class UserTypeRepository: BaseRepository<UserType, long>, IRepository<UserType, long>
    {
        private readonly RailCarLoungeContext _railCarLoungeContext;

        public UserTypeRepository(RailCarLoungeContext railCarLoungeContext)
        {
            this._railCarLoungeContext = railCarLoungeContext ?? throw new ArgumentNullException(nameof(railCarLoungeContext));
        }

        public override async Task<IList<UserType>> GetAll()
        {
            return await Task.Run(
                () => { return this._railCarLoungeContext.UsersTypes.Where(s => s.IsActive.Value).ToList(); });
        }
    }
}
