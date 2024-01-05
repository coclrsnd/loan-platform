namespace Loan.Platform.Models.Entities
{
    public class AuditLogEvent : EntityBase
    {
        public long Id { get; set; }

        public string Name { get; set; }

        public string Description { get; set; }
    }
}
