using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using StandardRail.RailCarLounge.Data.SqlServer.Pact;
using StandardRail.RailCarLounge.Models.Entities;

namespace StandardRail.RailCarLounge.Data.SqlServer.Repositories
{

    public class RangeMasterRepository : BaseRepository<RangeMaster, long>, IRepository<RangeMaster, long>
    {
        private readonly RailCarLoungeContext _railCarLoungeContext;

        public RangeMasterRepository(RailCarLoungeContext railCarLoungeContext)
        {
            this._railCarLoungeContext = railCarLoungeContext ?? throw new ArgumentNullException(nameof(railCarLoungeContext));
        }

        public override async Task<IList<RangeMaster>> GetAll()
        {
            return await Task.Run(
                () => { return this._railCarLoungeContext.Range.OrderBy(x=>x.Sequence).ToList(); });
        }

    }
}
