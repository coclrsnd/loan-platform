using StandardRail.RailCarLounge.Models.Entities;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace StandardRail.RailCarLounge.Business.Pact
{
    public interface IRailRoadService
    {
        Task<RailRoad> Save(RailRoad railRoad);

        Task<IList<RailRoad>> GetRailRoads();
    }
}
