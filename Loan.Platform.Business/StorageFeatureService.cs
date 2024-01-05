using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using StandardRail.RailCarLounge.Business.Pact;
using StandardRail.RailCarLounge.Data.SqlServer.Pact;
using StandardRail.RailCarLounge.Models.Entities;

namespace StandardRail.RailCarLounge.Business
{
    public class StorageFeatureService : IStorageFeatureService
    {
        private readonly IRepository<StorageFeature,long> _repository;
        public StorageFeatureService(IRepository<StorageFeature,long> repository)
        {
            _repository = repository ?? throw new ArgumentNullException(nameof(repository));
        }
        public async Task<StorageFeature> Save(StorageFeature storageFeature)
        {
            storageFeature.IsActive = true;
            return await  _repository.Create(storageFeature);
            
        }

        //public async Task<StorageFeature> UpdateStorageFeature(StorageFeature storageFeature)
        //{
        //    return await _repository.Update(storageFeature);
        //}

        public async Task<IList<StorageFeature>> GetStorageFeatures()
        {
            return await _repository.GetAll();
        }

        public Task<StorageFeature> GetStorageFeatureById(int id)
        {
            return _repository.GetById(id);
        }

        //public async Task<StorageFeature> GetStorageFeatureById(int id)
        //{

        //}

        //public async Task DeleteStorageFeature(int id)
        //{

        //}
    }
}
