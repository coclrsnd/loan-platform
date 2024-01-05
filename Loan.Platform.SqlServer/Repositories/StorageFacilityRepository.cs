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
    /// Performs database operations for Storage facility entity.
    /// </summary>
    public class StorageFacilityRepository : BaseRepository<StorageFacility, long>, IRepository<StorageFacility, long>
    {
        private readonly RailCarLoungeContext _railCarLoungeContext;
        public StorageFacilityRepository(RailCarLoungeContext railCarLoungeContext)
        {
            _railCarLoungeContext = railCarLoungeContext ?? throw new ArgumentNullException(nameof(railCarLoungeContext));
        }
        public async override Task<StorageFacility> Create(StorageFacility storageFacility)
        {
            try
            {
                var savedStorageFacility = await _railCarLoungeContext.StorageFacilities.AddAsync(storageFacility);
                _ = await _railCarLoungeContext.SaveChangesAsync();
                return savedStorageFacility.Entity;
            }
            catch (Exception)
            {

                throw;
            }
        }
        public override async Task<IList<StorageFacility>> GetListById(long vendorId)
        {
            return await Task.Run(
                () => { return _railCarLoungeContext.StorageFacilities.Where(s => s.IsActive.Value && s.VendorId == vendorId).ToList(); });
        }

        public override async Task<IQueryable<StorageFacility>> GetByCondition(Expression<Func<StorageFacility, bool>> expression)
        {
            return await Task.Run(
                () => { return this._railCarLoungeContext.StorageFacilities.Where(expression); });
        }

        public async Task<IList<StorageFacility>> GetListByRegionId(long regionId)
        {
            return await Task.Run(
                () => { return _railCarLoungeContext.StorageFacilities.Where(s => s.IsActive.Value && s.RegionId == regionId).ToList(); });
        }

        public async override Task<StorageFacility> GetById(long storageFacilityId)
        {
            return await _railCarLoungeContext.StorageFacilities.FindAsync(storageFacilityId);

        }
    }
}
