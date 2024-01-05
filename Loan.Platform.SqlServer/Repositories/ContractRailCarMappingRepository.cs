using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using StandardRail.RailCarLounge.Data.SqlServer.Pact;
using StandardRail.RailCarLounge.Models.Entities;

namespace StandardRail.RailCarLounge.Data.SqlServer.Repositories
{
    public class ContractRailCarMappingRepository : BaseRepository<ContractRailCarMapping, long>, IRepository<ContractRailCarMapping, long>
    {
        private readonly RailCarLoungeContext _railCarLoungeContext;
        public ContractRailCarMappingRepository(RailCarLoungeContext railCarLoungeContext)
        {
            _railCarLoungeContext = railCarLoungeContext ?? throw new ArgumentNullException(nameof(railCarLoungeContext));
        }

        public async override Task<IList<ContractRailCarMapping>> SaveEntities(IList<ContractRailCarMapping> contractRailCarMappings)
        {
            try
            {
                await _railCarLoungeContext.ContractRailCarMappings.AddRangeAsync(contractRailCarMappings);
                var res = await _railCarLoungeContext.SaveChangesAsync();
                return contractRailCarMappings;
            }
            catch (Exception)
            {

                throw;
            }

        }

        public async override Task<ContractRailCarMapping> Update(ContractRailCarMapping contractRailCarMapping)
        {
            try
            {
                var savedContractRailCarMapping = _railCarLoungeContext.ContractRailCarMappings.Update(contractRailCarMapping);
                var res = await _railCarLoungeContext.SaveChangesAsync();
                return savedContractRailCarMapping.Entity;
            }
            catch (Exception)
            {

                throw;
            }
        }
    }
}
