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
    /// Performs database operations for RailRoad entity.
    /// </summary>
    public class RailRoadRepository : BaseRepository<RailRoad, long>, IRepository<RailRoad, long>
    {
        private readonly RailCarLoungeContext _railCarLoungeContext;

        public RailRoadRepository(RailCarLoungeContext railCarLoungeContext)
        {
            this._railCarLoungeContext = railCarLoungeContext ?? throw new ArgumentNullException(nameof(railCarLoungeContext));
        }

        public override async Task<IList<RailRoad>> GetAll()
        {
            return await Task.Run(
                () => { return this._railCarLoungeContext.RailRoads.Where(s => s.IsActive.HasValue && s.IsActive.Value).OrderBy(r=>r.Name).ToList(); });
        }

        public override async Task<IQueryable<RailRoad>> GetByCondition(Expression<Func<RailRoad, bool>> expression)
        {
            return await Task.Run(
                () => { return this._railCarLoungeContext.RailRoads.Where(expression); });
        }
    }
}
