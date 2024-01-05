namespace StandardRail.RailCarLounge.Models.Entities
{
    public class ContractNoteMapping : EntityBase
    {
        public long Id { get; set; }
        public long ContractId { get; set; }
        public string Description { get; set; }
        //Navigation properties
        public Contract Contract { get; set; }
    }
}
