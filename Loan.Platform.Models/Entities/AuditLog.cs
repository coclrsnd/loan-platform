using System;

namespace Loan.Platform.Models.Entities
{
    public class AuditLog : EntityBase
    {
        public long Id { get; set; }

        public long EntityId { get; set; }

        public string Entity { get; set; }

        public long AssociatedEntityId { get; set; }

        public string AssociatedEntity { get; set; }

        public string LogMessage { get; set; }

        public DateTime TimeStamp { get; set; }

        public long EventId { get; set; }

        public long UserId { get; set; }
    }
}
