using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using StandardRail.RailCarLounge.Business.Pact;
using StandardRail.RailCarLounge.Data.SqlServer.Pact;
using StandardRail.RailCarLounge.Models.Entities;

namespace StandardRail.RailCarLounge.Business
{
    public class RailCarTypeService : IRailCarTypeService
    {
        private readonly IRepository<RailCarType, long> _repository;
        public RailCarTypeService(IRepository<RailCarType, long> repository)
        {
            _repository = repository ?? throw new ArgumentNullException(nameof(repository));
        }
       
        public async Task<IList<RailCarType>> GetRailCarTypes()
        {
            return await _repository.GetAll();
        }

    }
}
