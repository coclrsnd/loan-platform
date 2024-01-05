using Microsoft.AspNetCore.Http;

namespace Loan.Platform.Models.ViewModels
{
    public class UploadOpportunityAttachmentViewModel
    {
        public string CustomerName { get; set; }

        public IFormFile File { get; set; }
    }
}
