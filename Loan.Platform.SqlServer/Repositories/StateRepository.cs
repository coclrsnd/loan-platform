using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using StandardRail.RailCarLounge.Data.SqlServer.Pact;
using StandardRail.RailCarLounge.Models.Entities;

namespace StandardRail.RailCarLounge.Data.SqlServer.Repositories
{
    /// <summary>
    /// Performs database operations for State entity.
    /// </summary>
    public class StateRepository :  BaseRepository<State, long>, IRepository<State, long>
    {
        private readonly RailCarLoungeContext _railCarLoungeContext;

        public StateRepository(RailCarLoungeContext railCarLoungeContext)
        {
            this._railCarLoungeContext = railCarLoungeContext ?? throw new ArgumentNullException(nameof(railCarLoungeContext));
        }

        public override async Task<IList<State>> GetAll()
        {
            return await Task.Run(
                () => { return this._railCarLoungeContext.States.Where(s => s.IsActive.HasValue && s.IsActive.Value).ToList(); });
        }
        public override async Task<IList<State>> GetListById(long countryID)
        {
            return await Task.Run(
                () => { return this._railCarLoungeContext.States.Where(s => s.IsActive == true && s.CountryId == countryID).ToList(); });
        }
    }
}
