using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using StandardRail.RailCarLounge.Data.SqlServer.Pact;
using StandardRail.RailCarLounge.Models.Entities;

namespace StandardRail.RailCarLounge.Data.SqlServer.Repositories
{
    public class ContractRailCarChargeRepository : BaseRepository<ContractRailCarCharges, long>, IRepository<ContractRailCarCharges, long>
    {
        private readonly RailCarLoungeContext _railCarLoungeContext;
        public ContractRailCarChargeRepository(RailCarLoungeContext railCarLoungeContext)
        {
            _railCarLoungeContext = railCarLoungeContext ?? throw new ArgumentNullException(nameof(railCarLoungeContext));
        }

        public async override Task<IList<ContractRailCarCharges>> SaveEntities(IList<ContractRailCarCharges> contractRailCarCharges)
        {
            try
            {
                if (contractRailCarCharges != null && contractRailCarCharges.Where(t => t.Id > 0).Count() > 0)
                {
                    _railCarLoungeContext.ContractRailCarCharges.UpdateRange(contractRailCarCharges);
                    await _railCarLoungeContext.SaveChangesAsync();
                }
                else
                {
                    await _railCarLoungeContext.ContractRailCarCharges.AddRangeAsync(contractRailCarCharges);
                    var res = await _railCarLoungeContext.SaveChangesAsync();
                }
                return contractRailCarCharges;
            }
            catch (Exception)
            {
                throw;
            }

        }
    }
}
