using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using System.Threading.Tasks;
using StandardRail.RailCarLounge.Data.SqlServer.Pact;
using StandardRail.RailCarLounge.Models.Entities;

namespace StandardRail.RailCarLounge.Data.SqlServer.Repositories
{
    public class OpportunityReservedSpacesRepository : BaseRepository<OpportunityReservedSpaces, long>, IRepository<OpportunityReservedSpaces, long>
    {

        private readonly RailCarLoungeContext _railCarLoungeContext;

        public OpportunityReservedSpacesRepository(RailCarLoungeContext railCarLoungeContext)
        {
            _railCarLoungeContext = railCarLoungeContext ?? throw new ArgumentNullException(nameof(railCarLoungeContext));
        }

        public async override Task<IList<OpportunityReservedSpaces>> SaveEntities(IList<OpportunityReservedSpaces> opportunityReservedSpaces)
        {
            try
            {
                if (opportunityReservedSpaces != null && opportunityReservedSpaces.Where(t => t.Id > 0).Count() > 0)
                {
                    _railCarLoungeContext.OpportunityReservedSpaces.UpdateRange(opportunityReservedSpaces);
                    await _railCarLoungeContext.SaveChangesAsync();
                }
                else
                {
                    await _railCarLoungeContext.OpportunityReservedSpaces.AddRangeAsync(opportunityReservedSpaces);
                    var res = await _railCarLoungeContext.SaveChangesAsync();
                }
                return opportunityReservedSpaces;
            }
            catch (Exception)
            {
                throw;
            }

        }

        public async override Task<OpportunityReservedSpaces> Create(OpportunityReservedSpaces reservedSpace)
        {
            try
            {
                var savedReservedSpaces = await _railCarLoungeContext.OpportunityReservedSpaces.AddAsync(reservedSpace);
                var res = await _railCarLoungeContext.SaveChangesAsync();
                return savedReservedSpaces.Entity;
            }
            catch (Exception)
            {
                throw;
            }
        }

        public async override Task Update(OpportunityReservedSpaces opportunityReservedSpaces)
        {
            try
            {
                var reservedSpace = _railCarLoungeContext.OpportunityReservedSpaces.Update(opportunityReservedSpaces);
                await _railCarLoungeContext.SaveChangesAsync();
            }
            catch (Exception)
            {
                throw;
            }
        }

        public override async Task<IQueryable<OpportunityReservedSpaces>> GetByCondition(Expression<Func<OpportunityReservedSpaces, bool>> expression)
        {
            return await Task.Run(
                () => { return this._railCarLoungeContext.OpportunityReservedSpaces.Where(expression); });
        }

        public async override Task<OpportunityReservedSpaces> GetById(long Id)
        {
            return await _railCarLoungeContext.OpportunityReservedSpaces.FindAsync(Id);
        }
    }
}
