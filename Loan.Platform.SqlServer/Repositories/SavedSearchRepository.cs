using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using System.Threading.Tasks;
using StandardRail.RailCarLounge.Data.SqlServer.Pact;
using StandardRail.RailCarLounge.Models.Entities;

namespace StandardRail.RailCarLounge.Data.SqlServer.Repositories
{
    public class SavedSearchRepository : BaseRepository<SavedSearch, long>, IRepository<SavedSearch, long>
    {
        private readonly RailCarLoungeContext _railCarLoungeContext;

        public SavedSearchRepository(RailCarLoungeContext railCarLoungeContext)
        {
            _railCarLoungeContext = railCarLoungeContext ?? throw new ArgumentNullException(nameof(railCarLoungeContext));
        }

        public async override Task<SavedSearch> Create(SavedSearch savedSearch)
        {
            try
            {
                var savedContract = await _railCarLoungeContext.SavedSearches.AddAsync(savedSearch);
                var res = await _railCarLoungeContext.SaveChangesAsync();
                return savedContract.Entity;
            }
            catch (Exception)
            {

                throw;
            }
        }

        public async override Task Update(SavedSearch savedSearch)
        {
            try
            {
                var updateResult = _railCarLoungeContext.SavedSearches.Update(savedSearch);
                var res = await _railCarLoungeContext.SaveChangesAsync();
            }
            catch (Exception)
            {

                throw;
            }
        }

        public override async Task<IList<SavedSearch>> GetAll()
        {
            return await Task.Run(
                () => { return this._railCarLoungeContext.SavedSearches.Where(s => s.IsActive.Value).ToList(); });
        }

        public override async Task<IQueryable<SavedSearch>> GetByCondition(Expression<Func<SavedSearch, bool>> expression)
        {
            return await Task.Run(
                () => { return _railCarLoungeContext.SavedSearches.Where(expression); });
        }
    }
}
