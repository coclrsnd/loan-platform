using System;

namespace Loan.Platform.Models.ViewModels
{
    public class AttachmentViewModel
    {
        public long Id { get; set; }
        public long ContractId { get; set; }
        public string Path { get; set; }

        public string FileName { get; set; }

        public DateTime CreatedTime { get; set; }

        public string User { get; set; }
    }
}
