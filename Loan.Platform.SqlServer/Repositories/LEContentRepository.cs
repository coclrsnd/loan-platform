using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using StandardRail.RailCarLounge.Data.SqlServer.Pact;
using StandardRail.RailCarLounge.Models.Entities;

namespace StandardRail.RailCarLounge.Data.SqlServer.Repositories
{
    public class LEContentRepository : BaseRepository<LEContent, long>, IRepository<LEContent, long>
    {
        private readonly RailCarLoungeContext _railCarLoungeContext;
        public LEContentRepository(RailCarLoungeContext railCarLoungeContext)
        {
            _railCarLoungeContext = railCarLoungeContext ?? throw new ArgumentNullException(nameof(railCarLoungeContext));
        }

        public override async Task<IList<LEContent>> GetAll()
        {
            return await Task.Run(
                () => {return _railCarLoungeContext.LEContents.Where(s => s.IsActive.Value).ToList(); });
        }
    }
}
