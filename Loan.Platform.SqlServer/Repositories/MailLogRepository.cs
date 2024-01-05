using System;
using System.Threading.Tasks;
using Loan.Platform.Data.SqlServer.Pact;
using Loan.Platform.Models.Entities;

namespace Loan.Platform.Data.SqlServer.Repositories
{
    public class MailLogRepository : BaseRepository<MailLog, long>, IRepository<MailLog, long>
    {
        private readonly RailCarLoungeContext _railCarLoungeContext;

        public MailLogRepository(RailCarLoungeContext railCarLoungeContext)
        {
            this._railCarLoungeContext = railCarLoungeContext ?? throw new ArgumentNullException(nameof(railCarLoungeContext));
        }

        public async override Task<MailLog> Create(MailLog _maiLog)
        {
            var savedLog = await _railCarLoungeContext.MailLogs.AddAsync(_maiLog);
            var res = await _railCarLoungeContext.SaveChangesAsync();
            return savedLog.Entity;
        }

    }
}
