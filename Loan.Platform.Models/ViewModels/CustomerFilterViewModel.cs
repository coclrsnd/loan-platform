using System.Collections.Generic;

namespace Loan.Platform.Models.ViewModels
{
    /// <summary>
    /// Hold information for Customer Search form 
    /// </summary>
    public class CustomerFilterViewModel
    {
        public long OrganizationId { get; set; }

        public string Organization { get; set; }

        public long CountryId { get; set; }

        public long StateId { get; set; }

        public List<string> CityName { get; set; }

        public PaginationModel Pagination{ get; set; }

        public List<CustomerViewModel> CustomerModel { get; set; }

        public SortingModel Sorting { get; set; }

        public CustomerRibbon CustomerRibbon { get; set; }
    }
}