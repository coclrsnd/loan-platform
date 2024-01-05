using System;

namespace Loan.Platform.Models.ViewModels
{
    public class AuditLogViewModel
    {
        public long Id { get; set; }
        public string Description { get; set; }
        public string Action { get; set; }
        public DateTime CreatedTime { get; set; }

        public string User { get; set; }
    }
}
