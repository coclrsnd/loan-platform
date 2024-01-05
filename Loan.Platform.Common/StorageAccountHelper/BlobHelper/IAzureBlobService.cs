using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;

namespace Loan.Platform.Common.StorageAccountHelper.BlobHelper
{
    //interface for performing blob operations
    public interface IAzureBlobService
    {
        Task<AzureUploadResponseModel> UploadAsync(string filePath, string container);

        Task<List<AzureUploadResponseModel>> UploadAsync(List<IFormFile> files, string container);

        Task<AzureUploadResponseModel> UploadAsync(AzureBlobModel file, string container,string filePath);

        Task<byte[]> DownloadAsync(string fileName, string container);

        bool DeleteContainer(string container);

        bool DeleteBlob(string container, string fileName);
    }
}
