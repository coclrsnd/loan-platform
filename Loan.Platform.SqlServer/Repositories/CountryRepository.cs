using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using StandardRail.RailCarLounge.Data.SqlServer.Pact;
using StandardRail.RailCarLounge.Models.Entities;

namespace StandardRail.RailCarLounge.Data.SqlServer.Repositories
{
    /// <summary>
    /// Performs database operations for Country entity.
    /// </summary>
    public class CountryRepository: BaseRepository<Country, long>, IRepository<Country, long>
    {

        private readonly RailCarLoungeContext _railCarLoungeContext;
        public CountryRepository(RailCarLoungeContext railCarLoungeContext)
        {
            this._railCarLoungeContext = railCarLoungeContext ?? throw new ArgumentNullException(nameof(railCarLoungeContext));
        }

        public override async Task<IList<Country>> GetAll()
        {
            return await Task.Run(
                () => { return this._railCarLoungeContext.Countries.Where(s => s.IsActive.Value).ToList(); });
        }
    }
}
