using System;
using System.Data;
using System.Linq;
using System.Linq.Expressions;
using System.Threading.Tasks;
using StandardRail.RailCarLounge.Data.SqlServer.Pact;
using StandardRail.RailCarLounge.Models.Entities;

namespace StandardRail.RailCarLounge.Data.SqlServer.Repositories
{

    public class ContractRepository : BaseRepository<Contract, long>, IRepository<Contract, long>

    {
        private readonly RailCarLoungeContext _railCarLoungeContext;

        public ContractRepository(RailCarLoungeContext railCarLoungeContext)
        {
            _railCarLoungeContext = railCarLoungeContext ?? throw new ArgumentNullException(nameof(railCarLoungeContext));
        }
        public async override Task<Contract> Create(Contract contract)
        {
            try
            {
                var savedContract = await _railCarLoungeContext.Contracts.AddAsync(contract);
                var res = await _railCarLoungeContext.SaveChangesAsync();
                return savedContract.Entity;
            }
            catch (Exception)
            {

                throw;
            }
        }

        public async override Task Update(Contract contract)
        {
            try
            {
                var savedContract = _railCarLoungeContext.Contracts.Update(contract);
                var res = await _railCarLoungeContext.SaveChangesAsync();
            }
            catch (Exception)
            {
                throw;
            }
        }

        public override async Task<IQueryable<Contract>> GetByCondition(Expression<Func<Contract, bool>> expression)
        {
            return await Task.Run(
                () => { return this._railCarLoungeContext.Contracts.Where(expression); });
        }
    }
}
