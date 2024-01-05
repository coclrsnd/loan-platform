using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using StandardRail.RailCarLounge.Data.SqlServer.Pact;
using StandardRail.RailCarLounge.Models.Entities;

namespace StandardRail.RailCarLounge.Data.SqlServer.Repositories
{
    public class RailCarTypeRepository : BaseRepository<RailCarType, long>, IRepository<RailCarType, long>
    {
        private readonly RailCarLoungeContext _railCarLoungeContext;
        public RailCarTypeRepository(RailCarLoungeContext railCarLoungeContext)
        {
            _railCarLoungeContext = railCarLoungeContext ?? throw new ArgumentNullException(nameof(railCarLoungeContext));
        }

        public override async Task<IList<RailCarType>> GetAll()
        {
            return await Task.Run(
                () => {return _railCarLoungeContext.RailCarTypes.Where(s => s.IsActive.Value).ToList(); });
        }
    }
}
