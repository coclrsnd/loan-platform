using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;

namespace StandardRail.RailCarLounge.Models.Entities
{
    public class ContractRate: EntityBase
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public long Id { get; set; }

        public long ContractId { get; set; }

        public long RateTypeId { get; set; }

        [Precision(18, 2)]
        public decimal? SwitchIn { get; set; }

        [Precision(18, 2)]
        public decimal? SwitchOut { get; set; }

        [Precision(18, 2)]
        public decimal? SpecialSwitchingRate { get; set; }

        [Precision(18, 2)]
        public decimal? DailyStorageRate { get; set; }

        [Precision(18, 2)]
        public decimal? SwitchingRate { get; set; }

        [Precision(18, 2)]
        public decimal? HazmatSurcharge { get; set; }

        [Precision(18, 2)]
        public decimal? LoadedSurcharge { get; set; }

        [Precision(18, 2)]
        public decimal? ReservationRate { get; set; }

        [Precision(18, 2)]
        public decimal? CherryPickingRate { get; set; }

        [Precision(18, 2)]
        public decimal? BookingFee { get; set; }

        [Precision(18, 2)]
        public decimal? ListingFee { get; set; }
    }
}
