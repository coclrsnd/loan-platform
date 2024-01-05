using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Microsoft.AspNetCore.StaticFiles;

namespace Loan.Platform.Common.StorageAccountHelper.BlobHelper
{
    public static class AzureBlobServiceHelper
    {
        private static readonly FileExtensionContentTypeProvider Provider = new FileExtensionContentTypeProvider();

        public static string GetContentType(this string fileName)
        {
            if (!Provider.TryGetContentType(fileName, out var contentType))
            {
                contentType = "application/octet-stream";
            }

            return contentType;
        }


        public static bool IsImage(this string fileName)
        {

            return Provider.TryGetContentType(fileName, out var contentType)
                && contentType.StartsWith("image/");
        }
    }
}
