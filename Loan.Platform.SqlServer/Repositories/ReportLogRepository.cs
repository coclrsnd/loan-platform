using System;
using System.Threading.Tasks;
using StandardRail.RailCarLounge.Data.SqlServer.Pact;
using StandardRail.RailCarLounge.Models.Entities;

namespace StandardRail.RailCarLounge.Data.SqlServer.Repositories
{
    public class ReportLogRepository : BaseRepository<ReportLog, long>, IRepository<ReportLog, long>
    {
        private readonly RailCarLoungeContext _railCarLoungeContext;

        public ReportLogRepository(RailCarLoungeContext railCarLoungeContext)
        {
            this._railCarLoungeContext = railCarLoungeContext ?? throw new ArgumentNullException(nameof(railCarLoungeContext));
        }

        public async override Task<ReportLog> Create(ReportLog _reportLog)
        {
            var savedLog = await _railCarLoungeContext.ReportLog.AddAsync(_reportLog);
            var res = await _railCarLoungeContext.SaveChangesAsync();
            return savedLog.Entity;
        }
    }
}
