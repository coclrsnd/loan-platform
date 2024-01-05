using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using StandardRail.RailCarLounge.Business.Pact;
using StandardRail.RailCarLounge.Data.SqlServer.Pact;
using StandardRail.RailCarLounge.Models.Entities;

namespace StandardRail.RailCarLounge.Business
{
    public class RailRoadService : IRailRoadService
    {
        private readonly IRepository<RailRoad, long> _repository;

        public RailRoadService(IRepository<RailRoad, long> repository)
        {
            _repository = repository ?? throw new ArgumentNullException(nameof(repository));
        }
        public async Task<RailRoad> Save(RailRoad railRoad)
        {
            return await  _repository.Create(railRoad);
        }

        public async Task<IList<RailRoad>> GetRailRoads()
        {
            return await _repository.GetAll();
        }
    }
}
