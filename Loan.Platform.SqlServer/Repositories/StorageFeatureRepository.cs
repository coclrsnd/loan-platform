using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using StandardRail.RailCarLounge.Data.SqlServer.Pact;
using StandardRail.RailCarLounge.Models.Entities;

namespace StandardRail.RailCarLounge.Data.SqlServer.Repositories
{
    public class StorageFeatureRepository : BaseRepository<StorageFeature, long>, IRepository<StorageFeature,long>
    {
        private readonly RailCarLoungeContext _railCarLoungeContext;
        public StorageFeatureRepository(RailCarLoungeContext railCarLoungeContext)
        {
            _railCarLoungeContext = railCarLoungeContext ?? throw new ArgumentNullException(nameof(railCarLoungeContext));
        }
        public async override Task<StorageFeature> Create(StorageFeature _object)
        {
            var obj = await _railCarLoungeContext.StorageFeatures.AddAsync(_object);
            _ = await _railCarLoungeContext.SaveChangesAsync();
            return obj.Entity;
        }

        public override async Task<IList<StorageFeature>> GetAll()
        {
            return await Task.Run(
                () => {return _railCarLoungeContext.StorageFeatures.Where(s => s.IsActive.Value).ToList(); });
        }
    }
}
