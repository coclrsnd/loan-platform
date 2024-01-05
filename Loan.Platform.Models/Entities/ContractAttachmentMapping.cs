namespace StandardRail.RailCarLounge.Models.Entities
{
    public class ContractAttachmentMapping : EntityBase
    {
        public long Id { get; set; }
        public long ContractId { get; set; }
        public string Path { get; set; }

        public string Name { get; set; }
        //Navigation properties
        public Contract Contract { get; set; }
    }
}
