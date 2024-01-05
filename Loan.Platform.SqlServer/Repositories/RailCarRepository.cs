using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using StandardRail.RailCarLounge.Data.SqlServer.Pact;
using StandardRail.RailCarLounge.Models.Entities;

namespace StandardRail.RailCarLounge.Data.SqlServer.Repositories
{

    public class RailCarRepository : BaseRepository<RailCar, long>, IRepository<RailCar, long>

    {
        private readonly RailCarLoungeContext _railCarLoungeContext;

        public RailCarRepository(RailCarLoungeContext railCarLoungeContext)
        {
            _railCarLoungeContext = railCarLoungeContext ?? throw new ArgumentNullException(nameof(railCarLoungeContext));
        }
        public async override Task<RailCar> Create(RailCar railCar)
        {
            try
            {
                var savedRailCar = await _railCarLoungeContext.RailCars.AddAsync(railCar);
                var res = await _railCarLoungeContext.SaveChangesAsync();
                return savedRailCar.Entity;
            }
            catch (Exception)
            {
                throw;
            }
        }

        public async override Task<IList<RailCar>> SaveEntities(IList<RailCar> railCars)
        {
            try
            {
                await _railCarLoungeContext.RailCars.AddRangeAsync(railCars);
                var res = await _railCarLoungeContext.SaveChangesAsync();
                return railCars;
            }
            catch (Exception)
            {

                throw;
            }

        }

        public async override Task Update(RailCar railCar)
        {
            try
            {
                var savedRailCar = _railCarLoungeContext.RailCars.Update(railCar);
                var res = await _railCarLoungeContext.SaveChangesAsync();
            }
            catch (Exception)
            {

                throw;
            }
        }
    }
}
