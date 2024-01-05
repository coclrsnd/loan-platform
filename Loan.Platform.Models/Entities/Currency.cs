using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace StandardRail.RailCarLounge.Models.Entities
{
    public class Currency : EntityBase
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public short Id { get; set; }

        [Required(AllowEmptyStrings = false)]
        public string Name { get; set; }

        public string Code { get; set; }
    }
}
