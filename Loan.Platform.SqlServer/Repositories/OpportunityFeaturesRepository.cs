using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using System.Threading.Tasks;
using StandardRail.RailCarLounge.Data.SqlServer.Pact;
using StandardRail.RailCarLounge.Models.Entities;

namespace StandardRail.RailCarLounge.Data.SqlServer.Repositories
{
    public class OpportunityFeaturesRepository : BaseRepository<OpportunityFeatures, long>, IRepository<OpportunityFeatures, long>
    {

        private readonly RailCarLoungeContext _railCarLoungeContext;

        public OpportunityFeaturesRepository(RailCarLoungeContext railCarLoungeContext)
        {
            this._railCarLoungeContext = railCarLoungeContext ?? throw new ArgumentNullException(nameof(railCarLoungeContext));
        }

        public override async Task<IQueryable<OpportunityFeatures>> GetByCondition(Expression<Func<OpportunityFeatures, bool>> expression)
        {
            return await Task.Run(
                () => { return this._railCarLoungeContext.OpportunityFeatures.Where(expression); });
        }

        public override async Task<IList<OpportunityFeatures>> GetAll()
        {
            return await Task.Run(
                () => { return this._railCarLoungeContext.OpportunityFeatures.Where(s => s.IsActive.Value).ToList(); });
        }

        public async override Task<IList<OpportunityFeatures>> SaveEntities(IList<OpportunityFeatures> opportunityFeatures)
        {
            try
            {
                if (opportunityFeatures != null && opportunityFeatures.Where(t => t.Id > 0).Count() > 0)
                {
                    _railCarLoungeContext.OpportunityFeatures.UpdateRange(opportunityFeatures);
                    await _railCarLoungeContext.SaveChangesAsync();
                }
                else
                {
                    await _railCarLoungeContext.OpportunityFeatures.AddRangeAsync(opportunityFeatures);
                    var res = await _railCarLoungeContext.SaveChangesAsync();
                }
                return opportunityFeatures;
            }
            catch (Exception)
            {
                throw;
            }

        }
    }
}

