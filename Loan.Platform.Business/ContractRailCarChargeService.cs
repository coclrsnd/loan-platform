using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using AutoMapper;
using StandardRail.RailCarLounge.Business.Pact;
using StandardRail.RailCarLounge.Data.SqlServer.Pact;
using StandardRail.RailCarLounge.Models.Entities;
using StandardRail.RailCarLounge.Models.Enums;

namespace StandardRail.RailCarLounge.Business
{
    /// <summary>
    /// Contains Business Logic for Contract RailCar Charges.
    /// </summary>
    public class ContractRailCarChargeService: IContractRailCarChargeService
    {
        private readonly IRepository<ContractRailCarCharges, long> _repository;
        private readonly IMapper _mapper;

        public ContractRailCarChargeService(IRepository<ContractRailCarCharges, long> repository, IMapper mapper)
        {
            this._repository = repository ?? throw new ArgumentNullException(nameof(repository));
            this._mapper = mapper ?? throw new ArgumentNullException(nameof(mapper));
        }

        /// <inheritdoc cref="StandardRail.RailCarLounge.Business.Pact.IContractRailCarChargeService"/>
        public async Task<IList<ContractRailCarCharges>> SaveContractRailCarChargeDetail(IList<ContractRailCarCharges> contractRailCarCharges)
        {
            var savedContractRailCarCharges = await _repository.SaveEntities(contractRailCarCharges);          
            return savedContractRailCarCharges;

        }

    }
}
