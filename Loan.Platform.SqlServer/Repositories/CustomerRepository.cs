using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Linq.Expressions;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;
using StandardRail.RailCarLounge.Data.SqlServer.Pact;
using StandardRail.RailCarLounge.Models.Entities;

namespace StandardRail.RailCarLounge.Data.SqlServer.Repositories
{
    /// <summary>
    /// Performs database operations for Customer entity.
    /// </summary>
    public class CustomerRepository : BaseRepository<Customer, long>, IRepository<Customer, long>
    {
        private readonly RailCarLoungeContext _railCarLoungeContext;

        public CustomerRepository(RailCarLoungeContext railCarLoungeContext)
        {
            this._railCarLoungeContext = railCarLoungeContext ?? throw new ArgumentNullException(nameof(railCarLoungeContext));
        }
        public async override Task<Customer> Create(Customer customer)
        {
            try
            {
                // Set default value to default column
                customer.IsActive = true;
                customer.CustomerUserId = Guid.NewGuid();

                // Run customer data saving EF db call
                var savedCustomer = await this._railCarLoungeContext.Customers.AddAsync(customer);
                var res = await this._railCarLoungeContext.SaveChangesAsync();
                return savedCustomer.Entity;
            }
            catch (Exception)
            {
                throw;
            }
        }

        public override async Task<IList<Customer>> GetAll()
        {
            return await Task.Run(
                () => { return this._railCarLoungeContext.Customers.Where(s => s.IsActive.Value).ToList(); });
        }

        public override async Task<IQueryable<Customer>> GetByCondition(Expression<Func<Customer, bool>> expression)
        {
            return await Task.Run(
                () => { return this._railCarLoungeContext.Customers.Include(c => c.Organization).Where(expression); });
        }

        public override async Task<Customer> GetById(long id)
        {
            return await Task.Run(
                () => { return this._railCarLoungeContext.Customers.Where(t => t.Id == id).Include(t => t.Organization).FirstOrDefault(); });
        }

        public async override Task Update(Customer customer)
        {
            try
            {
                customer.IsActive = true;
                var savedContract = _railCarLoungeContext.Customers.Update(customer);
                await _railCarLoungeContext.SaveChangesAsync();
            }
            catch (Exception)
            {
                throw;
            }
        }
    }
}
