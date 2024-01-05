using System;
using System.Threading.Tasks;
using StandardRail.RailCarLounge.Data.SqlServer.Pact;
using StandardRail.RailCarLounge.Models.Entities;

namespace StandardRail.RailCarLounge.Data.SqlServer.Repositories
{
    public class StorageOpportunityRepository : BaseRepository<StorageOpportunity, long>, IRepository<StorageOpportunity, long>
    {
        private readonly RailCarLoungeContext _railCarLoungeContext;
        public StorageOpportunityRepository(RailCarLoungeContext railCarLoungeContext)
        {
            _railCarLoungeContext = railCarLoungeContext ?? throw new ArgumentNullException(nameof(railCarLoungeContext));
        }

        public async override Task<StorageOpportunity> Create(StorageOpportunity storageOpportunity)
        {
            try
            {
                var savedStorageOpportunity = await _railCarLoungeContext.StorageOpportunity.AddAsync(storageOpportunity);
                _ = await _railCarLoungeContext.SaveChangesAsync();
                return savedStorageOpportunity.Entity;
            }
            catch (Exception)
            {
                throw;
            }
        }
    }
}
