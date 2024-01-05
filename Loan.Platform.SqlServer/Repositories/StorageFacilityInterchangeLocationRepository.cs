using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using System.Text;
using System.Threading.Tasks;
using StandardRail.RailCarLounge.Data.SqlServer.Pact;
using StandardRail.RailCarLounge.Models.Entities;

namespace StandardRail.RailCarLounge.Data.SqlServer.Repositories
{
    /// <summary>
    /// Performs database operations for Storage Facility Interchange Location entity.
    /// </summary>
    public class StorageFacilityInterchangeLocationRepository : BaseRepository<StorageFacilityInterchangeLocation, long>, IRepository<StorageFacilityInterchangeLocation, long>
    {
        private readonly RailCarLoungeContext _railCarLoungeContext;

        public StorageFacilityInterchangeLocationRepository(RailCarLoungeContext railCarLoungeContext)
        {
            this._railCarLoungeContext = railCarLoungeContext ?? throw new ArgumentNullException(nameof(railCarLoungeContext));
        }

        public override async Task<IList<StorageFacilityInterchangeLocation>> GetAll()
        {
            return await Task.Run(
                () => { return this._railCarLoungeContext.StorageFacilityInterchangeLocations.Where(s => s.IsActive.HasValue && s.IsActive.Value).ToList(); });
        }
        public override async Task<IQueryable<StorageFacilityInterchangeLocation>> GetByCondition(Expression<Func<StorageFacilityInterchangeLocation, bool>> expression)
        {
            return await Task.Run(
                () => { return this._railCarLoungeContext.StorageFacilityInterchangeLocations.Where(expression); });
        }
    }
}
