using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using System.Threading.Tasks;
using StandardRail.RailCarLounge.Data.SqlServer.Pact;
using StandardRail.RailCarLounge.Models.Entities;

namespace StandardRail.RailCarLounge.Data.SqlServer.Repositories
{
    /// <summary>
    /// Performs database operations for Storage Facility Interchange entity.
    /// </summary>
    public class StorageFacilityInterchangeRepository : BaseRepository<StorageFacilityInterchange, long>, IRepository<StorageFacilityInterchange, long>
    {
        private readonly RailCarLoungeContext _railCarLoungeContext;

        public StorageFacilityInterchangeRepository(RailCarLoungeContext railCarLoungeContext)
        {
            this._railCarLoungeContext = railCarLoungeContext ?? throw new ArgumentNullException(nameof(railCarLoungeContext));
        }

        public override async Task<IList<StorageFacilityInterchange>> GetAll()
        {
            return await Task.Run(
                () => { return this._railCarLoungeContext.StorageFacilityInterchanges.Where(s => s.IsActive.HasValue && s.IsActive.Value).ToList(); });
        }

        public override async Task<IQueryable<StorageFacilityInterchange>> GetByCondition(Expression<Func<StorageFacilityInterchange, bool>> expression)
        {
            return await Task.Run(
                () => { return this._railCarLoungeContext.StorageFacilityInterchanges.Where(expression); });
        }
    }
}
