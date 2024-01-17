using Loan.Platform.Business.Pact;
using Loan.Platform.Data.SqlServer.Pact;
using Loan.Platform.Models.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using System.Text;
using System.Threading.Tasks;

namespace Loan.Platform.Business
{
    public class LoanService : ILoanService
    {
        private readonly IRepository<Loans, long> _loanRepository;
        public LoanService(IRepository<Loans, long> loanRepository)
        {
            _loanRepository = loanRepository;
        }

        public async  Task<IEnumerable<Loans>> GetLoanByAdhar(string adharNumber)
        {
            Expression<Func<Loans, bool>> expression = ex => adharNumber == ex.AdharNumber;
            return (await _loanRepository.GetByCondition(expression)).ToList();
        }
    }
}
