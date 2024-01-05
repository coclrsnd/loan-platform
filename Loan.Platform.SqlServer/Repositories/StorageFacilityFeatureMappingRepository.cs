using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using StandardRail.RailCarLounge.Data.SqlServer.Pact;
using StandardRail.RailCarLounge.Models.Entities;

namespace StandardRail.RailCarLounge.Data.SqlServer.Repositories
{
    public class StorageFacilityFeatureMappingRepository : BaseRepository<StorageFacilityFeatureMapping, long>, IRepository<StorageFacilityFeatureMapping, long>
    {
        private readonly RailCarLoungeContext _railCarLoungeContext;
        public StorageFacilityFeatureMappingRepository(RailCarLoungeContext railCarLoungeContext)
        {
            _railCarLoungeContext = railCarLoungeContext ?? throw new ArgumentNullException(nameof(railCarLoungeContext));
        }        

        public override async Task<IList<StorageFacilityFeatureMapping>> GetListById(long id)
        {
            return await Task.Run(
                () => { return _railCarLoungeContext.StorageFacilityFeatureMappings.Where(s => s.StorageFacilityId == id).ToList(); });
        }
    }
}
