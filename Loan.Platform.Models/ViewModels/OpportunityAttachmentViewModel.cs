namespace Loan.Platform.Models.ViewModels
{
    public class OpportunityAttachmentViewModel
    {
        public long Id { get; set; }

        public long OpportunityId { get; set; }

        public string Path { get; set; }

        public string Name { get; set; }

        public string FolderName { get; set; }

        public string CreatedDate { get; set; }

        public string Size { get; set; }

        public bool IsActive { get; set; }
    }
}
