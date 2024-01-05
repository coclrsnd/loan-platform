using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using StandardRail.RailCarLounge.Business.Pact;
using StandardRail.RailCarLounge.Data.SqlServer.Pact;
using StandardRail.RailCarLounge.Models.Entities;

namespace StandardRail.RailCarLounge.Business
{
    public class CurrencyService : ICurrencyService
    {
        private readonly IRepository<Currency, long> _repository;
        public CurrencyService(IRepository<Currency, long> repository)
        {
            _repository = repository ?? throw new ArgumentNullException(nameof(repository));
        }

        public async Task<IList<Currency>> GetCurrencyList()
        {
            return await _repository.GetAll();
        }        
    }
}
