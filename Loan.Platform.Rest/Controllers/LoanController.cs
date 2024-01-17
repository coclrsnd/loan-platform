using Loan.Platform.Models.Accounts;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using System.Threading.Tasks;
using System;
using Loan.Platform.Business.Pact;
using System.Linq.Dynamic.Core;
using System.Linq;

namespace Loan.Platform.Rest.Controllers
{
    //[Authorize]
    [Route("api/[controller]")]
    [ApiController]
    public class LoanController : ControllerBase
    {
        private readonly ILoanService _loanService;

        public LoanController(ILoanService loanService)
        {
            _loanService = loanService;
        }

        [HttpGet("loan-search/{adharNumber}")]
        public async Task<IActionResult> VerifyEmail(string adharNumber)
        {
            try
            {
                var loans = (await _loanService.GetLoanByAdhar(adharNumber));
                if (loans != null)
                {
                    return Ok(loans);
                }
                else
                {
                    return NoContent();
                }
            }
            catch (Exception ex)
            {
                return BadRequest();
            }
            }

    }
}
