using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using System.Threading.Tasks;
using Loan.Platform.Data.SqlServer.Pact;
using Loan.Platform.Models.Entities;

namespace Loan.Platform.Data.SqlServer.Repositories
{
    /// <summary>
    /// Performs database operations for Organization entity.
    /// </summary>
    public class OrganizationRepository : BaseRepository<Organization, long>, IRepository<Organization, long>
    {
        private readonly RailCarLoungeContext _railCarLoungeContext;

        public OrganizationRepository(RailCarLoungeContext railCarLoungeContext)
        {
            this._railCarLoungeContext = railCarLoungeContext ?? throw new ArgumentNullException(nameof(railCarLoungeContext));
        }

        public override async Task<IList<Organization>> GetAll()
        {
            return await Task.Run(
                () => { return this._railCarLoungeContext.Organizations.Where(s => s.IsActive.HasValue && s.IsActive.Value).ToList(); });
        }

        public async override Task<Organization> Create(Organization organizationDetail)
        {
            try
            {
                // Passing default value to default column 
                organizationDetail.IsActive = true;

                // Run Save Organization EF call
                var savedOrganization = await this._railCarLoungeContext.Organizations.AddAsync(organizationDetail);
                var res = await this._railCarLoungeContext.SaveChangesAsync();
                return organizationDetail;
            }
            catch (Exception)
            {
                throw;
            }
        }

        public override async Task<IQueryable<Organization>> GetByCondition(Expression<Func<Organization, bool>> expression)
        {
            return await Task.Run(
                () => { return this._railCarLoungeContext.Organizations.Where(expression); });
        }
    }
}
