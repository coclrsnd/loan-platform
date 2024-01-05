using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using StandardRail.RailCarLounge.Models.Entities;

namespace StandardRail.RailCarLounge.Business.Pact
{
    public interface IStorageFeatureService
    {
        Task<StorageFeature> Save(StorageFeature storageFeature);

        Task<IList<StorageFeature>> GetStorageFeatures();

        Task<StorageFeature> GetStorageFeatureById(int id);
    }
}
