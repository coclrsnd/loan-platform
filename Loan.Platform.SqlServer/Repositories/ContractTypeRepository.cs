using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using StandardRail.RailCarLounge.Data.SqlServer.Pact;
using StandardRail.RailCarLounge.Models.Entities;

namespace StandardRail.RailCarLounge.Data.SqlServer.Repositories
{
    public class ContractTypeRepository : BaseRepository<ContractType, long>, IRepository<ContractType, long>
    {
        private readonly RailCarLoungeContext _railCarLoungeContext;
        public ContractTypeRepository(RailCarLoungeContext railCarLoungeContext)
        {
            _railCarLoungeContext = railCarLoungeContext ?? throw new ArgumentNullException(nameof(railCarLoungeContext));
        }
        public override async Task<IList<ContractType>> GetAll()
        {
            return await Task.Run(
                () => {return _railCarLoungeContext.ContractTypes.Where(s => s.IsActive.Value).ToList(); });
        }
    }
}
