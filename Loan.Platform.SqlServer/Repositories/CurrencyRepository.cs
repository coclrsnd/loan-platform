using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using StandardRail.RailCarLounge.Data.SqlServer.Pact;
using StandardRail.RailCarLounge.Models.Entities;

namespace StandardRail.RailCarLounge.Data.SqlServer.Repositories
{
    public class CurrencyRepository : BaseRepository<Currency, long>, IRepository<Currency, long>
    {
        private readonly RailCarLoungeContext _railCarLoungeContext;
        public CurrencyRepository(RailCarLoungeContext railCarLoungeContext)
        {
            _railCarLoungeContext = railCarLoungeContext ?? throw new ArgumentNullException(nameof(railCarLoungeContext));
        }
        public override async Task<IList<Currency>> GetAll()
        {
            return await Task.Run(
                () => {return _railCarLoungeContext.Currency.Where(s => s.IsActive.Value).ToList(); });
        }
    }
}
