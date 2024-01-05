using System.IO;

namespace Loan.Platform.Common.StorageAccountHelper.BlobHelper
{
    public class AzureBlobModel
    {
        public string FileName { get; set; }

        public Stream FileContent { get; set; }

        public string ContentType { get; set; }
    }
}
