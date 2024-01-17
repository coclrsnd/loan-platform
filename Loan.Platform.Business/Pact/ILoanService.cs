using Loan.Platform.Models.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Loan.Platform.Business.Pact
{
    public interface ILoanService
    {
        Task<IEnumerable<Loans>> GetLoanByAdhar(string adharNumber);
    }
}
