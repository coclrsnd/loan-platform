using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using System.Threading.Tasks;
using StandardRail.RailCarLounge.Data.SqlServer.Pact;
using StandardRail.RailCarLounge.Models.Entities;

namespace StandardRail.RailCarLounge.Data.SqlServer.Repositories
{
    public class VendorRepository : BaseRepository<Vendor, long>, IRepository<Vendor, long>
    {
        private readonly RailCarLoungeContext _railCarLoungeContext;
        public VendorRepository(RailCarLoungeContext railCarLoungeContext)
        {
            _railCarLoungeContext = railCarLoungeContext ?? throw new ArgumentNullException(nameof(railCarLoungeContext));
        }
        public async override Task<Vendor> Create(Vendor vendor)
        {
            try
            {
                var savedVendor = await _railCarLoungeContext.Vendors.AddAsync(vendor);
                var res = await _railCarLoungeContext.SaveChangesAsync();
                return savedVendor.Entity;
            }
            catch (Exception)
            {

                throw;
            }
        }

        public override async Task<IList<Vendor>> GetAll()
        {
            return await Task.Run(
                () => { return _railCarLoungeContext.Vendors.Where(s => s.IsActive.Value).ToList(); });
        }

        public override async Task<IQueryable<Vendor>> GetByCondition(Expression<Func<Vendor, bool>> expression)
        {
            return await Task.Run(
                () => { return _railCarLoungeContext.Vendors.Where(expression); });
        }
    }
}
