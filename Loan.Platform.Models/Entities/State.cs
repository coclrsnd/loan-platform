using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace StandardRail.RailCarLounge.Models.Entities
{
    public class State : EntityBase
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public long Id { get; set; }

        [Required(AllowEmptyStrings = false)]
        public string Name { get; set; }

        [Required(AllowEmptyStrings = false)]
        public string Code { get; set; }

        [Required(AllowEmptyStrings = false)]
        public long? CountryId { get; set; }

        //Navigation Properties
        public virtual Country Country { get; set; }
    }
}
