using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using StandardRail.RailCarLounge.Business.Pact;
using StandardRail.RailCarLounge.Data.SqlServer.Pact;
using StandardRail.RailCarLounge.Models.Entities;

namespace StandardRail.RailCarLounge.Business
{
    public class StorageFacilityFeatureMappingService : IStorageFacilityFeatureMappingService
    {
        private readonly IRepository<StorageFacilityFeatureMapping, long> _repository;

        public StorageFacilityFeatureMappingService(IRepository<StorageFacilityFeatureMapping, long> repository)
        {
            this._repository = repository ?? throw new ArgumentNullException(nameof(repository));
        }

        public Task<IList<StorageFacilityFeatureMapping>> GetStorageFacilityFeatureMapping(long id)
        {
            return this._repository.GetListById(id);
        }

    }
}
