using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Loan.Platform.Common.StorageAccountHelper.BlobHelper
{
    /// <summary>
    /// Holds response model of file upload.
    /// </summary>
    public class AzureUploadResponseModel
    {
        public string fileUri { get; set; }

        public string fileType { get; set; }

        public string fileExtention { get; set; }
    }
}
