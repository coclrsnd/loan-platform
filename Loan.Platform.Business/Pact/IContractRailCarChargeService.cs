using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using StandardRail.RailCarLounge.Models.Entities;

namespace StandardRail.RailCarLounge.Business.Pact
{
    /// <summary>
    /// Defines interface for Contract RailCar Charges operations.
    /// </summary>
    public interface IContractRailCarChargeService
    {
        /// <summary>
        /// Save All RailCar Charges
        /// </summary>
        /// <returns>List of Contract RailCar charges that is saved</returns>
        Task<IList<ContractRailCarCharges>> SaveContractRailCarChargeDetail(IList<ContractRailCarCharges> contractRailCarCharges);
    }
}
