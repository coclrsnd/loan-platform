using StandardRail.RailCarLounge.Models.Entities;
using StandardRail.RailCarLounge.Models.ViewModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace StandardRail.RailCarLounge.Business.Pact
{
    public interface IContractTypeService
    {
        Task<IList<ContractType>> GetContractTypeList();
    }
}
