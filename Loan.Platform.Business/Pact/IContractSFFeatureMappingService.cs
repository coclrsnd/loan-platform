using System.Threading.Tasks;
using StandardRail.RailCarLounge.Models.ViewModels;

namespace StandardRail.RailCarLounge.Business.Pact
{
    /// <summary>
    /// Defines interface to get Contract Storage Feature Mapping Data.
    /// </summary>
    public interface IContractSFFeatureMappingService
    {
        /// <summary>
        /// Save Contract Storage features mapping.
        /// </summary>
        /// <param name="riderViewModel">ContractViewModel</param>
        /// <returns></returns>
        Task SaveContractSFFeatureMappingAsync(ContractViewModel riderViewModel);

        /// <summary>
        /// Delete contract storage features mapping.
        /// </summary>
        /// <param name="contractId">long</param>
        /// <returns></returns>
        Task DeleteContractSFFeatureMappingAsync(long contractId);
    }
}
