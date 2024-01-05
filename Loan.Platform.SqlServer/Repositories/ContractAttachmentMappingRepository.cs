using System;
using System.Threading.Tasks;
using StandardRail.RailCarLounge.Data.SqlServer.Pact;
using StandardRail.RailCarLounge.Models.Entities;

namespace StandardRail.RailCarLounge.Data.SqlServer.Repositories
{
    public class ContractAttachmentMappingRepository : BaseRepository<ContractAttachmentMapping, long>, IRepository<ContractAttachmentMapping, long>
    {
        private readonly RailCarLoungeContext _railCarLoungeContext;
        public ContractAttachmentMappingRepository(RailCarLoungeContext railCarLoungeContext)
        {
            _railCarLoungeContext = railCarLoungeContext ?? throw new ArgumentNullException(nameof(railCarLoungeContext));
        }

        public async override Task<ContractAttachmentMapping> Create(ContractAttachmentMapping contractAttachmentMapping)
        {
            try
            {
                var savedContractAttachmnetMapping = await _railCarLoungeContext.ContractAttachmentMappings.AddAsync(contractAttachmentMapping);
                var res = await _railCarLoungeContext.SaveChangesAsync();
                return savedContractAttachmnetMapping.Entity;
            }
            catch (Exception)
            {

                throw;
            }
        }
    }
}
