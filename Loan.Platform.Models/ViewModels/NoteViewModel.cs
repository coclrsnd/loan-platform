using System;

namespace Loan.Platform.Models.ViewModels
{
    public class NoteViewModel
    {
        public long Id { get; set; }
        public long ContractId { get; set; }
        public string Description { get; set; }

        public DateTime CreatedTime { get; set; }
        public string User { get; set; }
    }
}
