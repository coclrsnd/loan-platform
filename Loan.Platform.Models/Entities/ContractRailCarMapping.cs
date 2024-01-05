using System;
using System.ComponentModel.DataAnnotations.Schema;

namespace StandardRail.RailCarLounge.Models.Entities
{
    public class ContractRailCarMapping : EntityBase
    {
        public long Id { get; set; }

        public long RailCarId { get; set; }

        public long ContractId { get; set; }

        public DateTime? ArrivalDate { get; set; }

        public DateTime? DepartureDate { get; set; }

        public DateTime? BolDate { get; set; }

        public bool IsUnderStorage { get; set; }

        public int LEId { get; set; }

        public string LEContents { get; set; }

        public string Fleet { get; set; }

        public string Notes { get; set; }

        //Navigation properties
        public RailCar RailCar { get; set; }

        public Contract Contract { get; set; }

        public int? CustomerId { get; set; }

        public bool IsHazmatCar { get; set; }

        [NotMapped]
        public string CarInitial { get; set; }

        [NotMapped]
        public string CarNumber { get; set; }

    }
}
