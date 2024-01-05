using System;
using System.Collections.Generic;

namespace Loan.Platform.Models.ViewModels
{
    public class ContractViewModel
    {
        public long Id { get; set; }

        public string Rider { get; set; }

        public string VendorName { get; set; }

        public string StorageFacilityName { get; set; }

        public string EffectiveDate { get; set; }

        public string ExpiryDate { get; set; }

        public decimal? SwitchIn { get; set; }

        public decimal? SwitchOut { get; set; }

        public int? TotalCars { get; set; }

        // Need to discuss with Pavithra because it is used in ribbon creation
        public string Hazmat { get; set; }

        public decimal? SwitchInMin { get; set; }

        public decimal? SwitchInMax { get; set; }

        public decimal? SwitchOutMin { get; set; }

        public decimal? SwitchOutMax { get; set; }

        public int? CurrencyId { get; set; }

       // public bool? IsDefault { get; set; }

        public List<int> StorageFeatureIds { get; set; }

        public int VendorId { get; set; }

        public int StorageFacilityId { get; set; }

        public int CustomerId { get; set; }

        public int ContractTypeId { get; set; }

        public int? CarsStored { get; set; }

        public string Location { get; set; }

        public string CustomerName { get; set; }

        public string ContractTypeName { get; set; }

        public string CurrencyName { get; set; }

        public List<StorageFeatureViewModel> storageFeatureViewModels { get; set; }
        
        public DateTime CreatedTime { get; set; }

        public List<ContractViewModel> RiderModel { get; set; }

        public StorageOrderRibbon StorageOrderRibbon { get; set; }

        public string Description { get; set; }

        public bool IsFlatRateContract { get; set; }

        public ContractRatesViewModel VendorCost { get; set; }

        public ContractRatesViewModel CustomerRate { get; set; }

        public ContractRatesViewModel PercentageRate { get; set; }

        public int? ReservedSpaces { get; set; }

        public bool IsAdvancedSwitchingRatesEnabled { get; set; }
    }
}
