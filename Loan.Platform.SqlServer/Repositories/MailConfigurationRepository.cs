using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using System.Threading.Tasks;
using Loan.Platform.Data.SqlServer.Pact;
using Loan.Platform.Models.Entities;

namespace Loan.Platform.Data.SqlServer.Repositories
{
    public class MailConfigurationRepository : BaseRepository<MailConfiguration, long>, IRepository<MailConfiguration, long>  
    {
        private readonly RailCarLoungeContext _railCarLoungeContext;
        public MailConfigurationRepository(RailCarLoungeContext railCarLoungeContext)
        {
            _railCarLoungeContext = railCarLoungeContext ?? throw new ArgumentNullException(nameof(railCarLoungeContext));
        }
        public override async Task<IList<MailConfiguration>> GetAll()
        {
            return await Task.Run(
                () => { return _railCarLoungeContext.MailConfigurations.Where(s => s.IsActive.Value).ToList(); });
        }

        public override async Task<IQueryable<MailConfiguration>> GetByCondition(Expression<Func<MailConfiguration, bool>> expression)
        {
            return await Task.Run(
                () => { return this._railCarLoungeContext.MailConfigurations.Where(expression); });
        }
    }
}
