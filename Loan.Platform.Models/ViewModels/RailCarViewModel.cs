using System;
using System.Collections.Generic;

namespace Loan.Platform.Models.ViewModels
{
    public class RailCarViewModel
    {
        public long Id { get; set; }
        public long ContractId { get; set; }

        public bool? IsDefault { get; set; }

        public long RailCarId { get; set; }
        public string CarId { get; set; }
        public List<string> CarIds { get; set; }
        public long? RailCarTypeId { get; set; }

        public long? LEId { get; set; }

        public string BolDate { get; set; }

        public string ArrivalDate { get; set; }

        public string DepartureDate { get; set; }

        public bool IsUnderStorage { get; set; }

        public string LEContents { get; set; }

        public string Notes { get; set; }

        public string Fleet { get; set; }

        public string CarInitial { get; set; }

        public string CarNumber { get; set; }

        public string LEName { get; set; }

        public string CarTypeName { get; set; }

        public long ContractRailCarMappingId { get; set; }

        public List<string> InvalidCars { get; set; }
        public bool IsSaved { get; set; }

        public DateTime CreatedTime { get; set; }

        public long CustomerId { get; set; }

        public int? CarsStored { get; set; }

        public bool IsDuplicate { get; set; }

        public string StorageOrder { get; set; }

        public long? StorageOrderId { get; set; }

        public List<RailCarViewModel> RailCarList { get; set; }

        public RailCarRibbon RailCarRibbon { get; set; }

        public List<ContractRailCarChargeViewModel> ContractRailCarCharge { get; set; }

        public bool IsHazmatCar { get; set; }

    }
}
