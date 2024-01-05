using System;
using System.Linq;
using System.Threading.Tasks;
using StandardRail.RailCarLounge.Data.SqlServer.Pact;
using StandardRail.RailCarLounge.Models.Entities;

namespace StandardRail.RailCarLounge.Data.SqlServer.Repositories
{
    public class ContractSFFeatureMappingRepository : BaseRepository<ContractSFFeatureMapping, long>, IRepository<ContractSFFeatureMapping, long>
    {
        private readonly RailCarLoungeContext _railCarLoungeContext;
        public ContractSFFeatureMappingRepository(RailCarLoungeContext railCarLoungeContext)
        {
            _railCarLoungeContext = railCarLoungeContext ?? throw new ArgumentNullException(nameof(railCarLoungeContext));
        }

        public async override Task<ContractSFFeatureMapping> Create(ContractSFFeatureMapping contractSFFeatureMapping)
        {
            try
            {
                var savedContractSFFeatureMapping = await _railCarLoungeContext.ContractSFFeatureMappings.AddAsync(contractSFFeatureMapping);
                var res = await _railCarLoungeContext.SaveChangesAsync();
                return savedContractSFFeatureMapping.Entity;
            }
            catch (Exception)
            {
                throw;
            }
        }

        public async override Task Delete(long contractId)
        {
            try
            {

                var result = _railCarLoungeContext.ContractSFFeatureMappings.Where(s => s.ContractId == contractId).ToList();
                if (result != null && result.Count > 0)
                {
                    _railCarLoungeContext.ContractSFFeatureMappings.RemoveRange(result);
                    var res = await _railCarLoungeContext.SaveChangesAsync();
                }
            }
            catch (Exception)
            {

                throw;
            }
        }
    }
}
