using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using StandardRail.RailCarLounge.Business.Pact;
using StandardRail.RailCarLounge.Data.SqlServer.Pact;
using StandardRail.RailCarLounge.Models.Entities;

namespace StandardRail.RailCarLounge.Business
{
    public class ContractTypeService : IContractTypeService
    {
        private readonly IRepository<ContractType, long> _repository;
        public ContractTypeService(IRepository<ContractType, long> repository)
        {
            this._repository = repository ?? throw new ArgumentNullException(nameof(repository));
        }

        public async Task<IList<ContractType>> GetContractTypeList()
        {
            return await _repository.GetAll();
        }        
    }
}
