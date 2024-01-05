using System;
using System.Threading.Tasks;
using StandardRail.RailCarLounge.Business.Pact;
using StandardRail.RailCarLounge.Data.SqlServer.Pact;
using StandardRail.RailCarLounge.Models.Entities;
using StandardRail.RailCarLounge.Models.ViewModels;

namespace StandardRail.RailCarLounge.Business
{
    public class ContractSFFeatureMappingService : IContractSFFeatureMappingService
    {
        private readonly IRepository<ContractSFFeatureMapping, long> _repository;

        public ContractSFFeatureMappingService(IRepository<ContractSFFeatureMapping, long> repository)
        {
            _repository = repository ?? throw new ArgumentNullException(nameof(repository));
        }

        public async Task SaveContractSFFeatureMappingAsync(ContractViewModel riderViewModel)
        {
            foreach (var featureid in riderViewModel.StorageFeatureIds)
            {
                ContractSFFeatureMapping contractSFFeatureMapping = new ContractSFFeatureMapping();
                contractSFFeatureMapping.ContractId = riderViewModel.Id;
                contractSFFeatureMapping.StorageFacilityid = riderViewModel.StorageFacilityId;
                contractSFFeatureMapping.StorageFeatureId = featureid;
                await _repository.Create(contractSFFeatureMapping);
            }
        }

        public async Task DeleteContractSFFeatureMappingAsync(long contractId)
        {
            await _repository.Delete(contractId);
        }
    }
}
