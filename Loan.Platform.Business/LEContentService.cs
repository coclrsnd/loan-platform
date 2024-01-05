using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using StandardRail.RailCarLounge.Business.Pact;
using StandardRail.RailCarLounge.Data.SqlServer.Pact;
using StandardRail.RailCarLounge.Models.Entities;

namespace StandardRail.RailCarLounge.Business
{
    public class LEContentService : ILEContentService
    {
        private readonly IRepository<LEContent, long> _repository;
        public LEContentService(IRepository<LEContent, long> repository)
        {
            _repository = repository ?? throw new ArgumentNullException(nameof(repository));
        }
       
        public async Task<IList<LEContent>> GetLEContents()
        {
            return await _repository.GetAll();
        }
    }
}
