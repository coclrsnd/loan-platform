using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using StandardRail.RailCarLounge.Data.SqlServer.Pact;
using StandardRail.RailCarLounge.Models.Entities;

namespace StandardRail.RailCarLounge.Data.SqlServer.Repositories
{
    /// <summary>
    /// Performs database operations for RateType entity.
    /// </summary>
    public class RateTypeRepository : BaseRepository<RateType, long>, IRepository<RateType, long>
    {
        private readonly RailCarLoungeContext _railCarLoungeContext;

        public RateTypeRepository(RailCarLoungeContext railCarLoungeContext)
        {
            this._railCarLoungeContext = railCarLoungeContext ?? throw new ArgumentNullException(nameof(railCarLoungeContext));
        }

        public override async Task<IList<RateType>> GetAll()
        {
            return await Task.Run(
                () => { return this._railCarLoungeContext.RateTypes.Where(s => s.IsActive.HasValue && s.IsActive.Value).ToList(); });
        }
       
    }
}
