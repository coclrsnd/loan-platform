using System;
using System.Threading.Tasks;
using StandardRail.RailCarLounge.Data.SqlServer.Pact;
using StandardRail.RailCarLounge.Models.Entities;

namespace StandardRail.RailCarLounge.Data.SqlServer.Repositories
{
    public class ContractNoteMappingRepository : BaseRepository<ContractNoteMapping, long>, IRepository<ContractNoteMapping, long>
    {
        private readonly RailCarLoungeContext _railCarLoungeContext;
        public ContractNoteMappingRepository(RailCarLoungeContext railCarLoungeContext)
        {
            _railCarLoungeContext = railCarLoungeContext ?? throw new ArgumentNullException(nameof(railCarLoungeContext));
        }
        
        public async override Task<ContractNoteMapping> Create(ContractNoteMapping contractNoteMapping)
        {
            try
            {
                var savedContractNoteMapping = await _railCarLoungeContext.ContractNoteMappings.AddAsync(contractNoteMapping);
                var res = await _railCarLoungeContext.SaveChangesAsync();
                return savedContractNoteMapping.Entity;
            }
            catch (Exception)
            {

                throw;
            }
        }
    }
}
