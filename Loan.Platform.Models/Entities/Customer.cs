using Microsoft.EntityFrameworkCore;

namespace StandardRail.RailCarLounge.Models.Entities
{
    public class Customer : BaseUserDetails
    {
        [Precision(18, 2)]
        public decimal? PercentageMargin { get; set; }
    }
}
