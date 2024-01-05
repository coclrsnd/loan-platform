using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using Loan.Platform.Data.SqlServer.Pact;
using Loan.Platform.Models.Entities;

namespace Loan.Platform.Data.SqlServer.Repositories
{
    public class AuditLogRepository : BaseRepository<AuditLog, long>, IRepository<AuditLog, long>
    {
        private readonly RailCarLoungeContext _railCarLoungeContext;

        public AuditLogRepository(RailCarLoungeContext railCarLoungeContext)
        {
            this._railCarLoungeContext = railCarLoungeContext ?? throw new ArgumentNullException(nameof(railCarLoungeContext));
        }

        public async override Task<AuditLog> Create(AuditLog log)
        {
            try
            {
                var savedLog = await _railCarLoungeContext.AuditLogs.AddAsync(log);
                var res = await _railCarLoungeContext.SaveChangesAsync();
                return savedLog.Entity;
            }
            catch (Exception)
            {
                throw;
            }
        }

        public async override Task<IList<AuditLog>> SaveEntities(IList<AuditLog> auditLogs)
        {
            try
            {
                await _railCarLoungeContext.AuditLogs.AddRangeAsync(auditLogs);
                var res = await _railCarLoungeContext.SaveChangesAsync();
                return auditLogs;
            }
            catch (Exception)
            {

                throw;
            }

        }
    }
}
