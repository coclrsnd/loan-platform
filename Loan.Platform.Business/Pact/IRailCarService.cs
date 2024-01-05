using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using StandardRail.RailCarLounge.Models.Entities;
using StandardRail.RailCarLounge.Models.ViewModels;

namespace StandardRail.RailCarLounge.Business.Pact
{
    public interface IRailCarService
    {
        Task<IList<RailCar>> SaveRailCarDetailsForStorageOrder(List<RailCar> railCars);
        Task<IList<RailCarViewModel>> GetRailCarDetailsByContractId(long Id);
        Tuple<bool, List<RailCar>> ValidateRailCars(RailCarViewModel railCarViewModel);
        Task<RailCarViewModel> GetRailCarDetails(RailCarViewModel railCarViewModel);
    }
}
