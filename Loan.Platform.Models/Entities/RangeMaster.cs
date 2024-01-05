using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace StandardRail.RailCarLounge.Models.Entities
{
    public class RangeMaster
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public short Id { get; set; }

        public int Min { get; set; }

        public int Max { get; set; }

        public string DisplayValue { get; set; }

        public string Category { get; set; }

        public int Sequence { get; set; }

    }
}
