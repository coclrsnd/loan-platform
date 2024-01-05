using Microsoft.EntityFrameworkCore;

namespace Loan.Platform.Models.ViewModels
{
    /// <summary>
    /// Hold information for Customers, such as on-board customer, get-customers list
    /// </summary>
    public class CustomerViewModel
    {
        public long Id { get; set; }

        public string Name { get; set; }

        public string PrimaryContactNo { get; set; }

        public string PrimaryContactEmail { get; set; }

        public string SecondaryContactNo { get; set; }

        public string SecondaryContactEmail { get; set; }

        public string Address { get; set; }

        public string ZipCode { get; set; }

        public string City { get; set; }

        public long? StateId { get; set; }

        public long? CountryId { get; set; }

        public string Organization { get; set; }

        public string EffectiveDate { get; set; }

        public string ExpiryDate { get; set; }

        public string Website { get; set; }

        public string Description { get; set; }

        public string Location { get; set; }

        public long OrganizationId { get; set; }

        [Precision(18, 2)]
        public decimal? PercentageMargin { get; set; }
    }
}
