using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Threading.Tasks;
using Azure.Storage.Blobs;
using Azure.Storage.Blobs.Models;
using Microsoft.AspNetCore.Http;
using Microsoft.Extensions.Configuration;

namespace Loan.Platform.Common.StorageAccountHelper.BlobHelper
{
    public class AzureBlobService : IAzureBlobService
    {
        private BlobServiceClient _blobServiceClient;
        public AzureBlobService(IConfiguration configuration)
        {
            _blobServiceClient = new BlobServiceClient(configuration["StorageAccountConnectionString"]);
        }

        public async Task<byte[]> DownloadAsync(string fileName, string container)
        {
            try
            {
                var containerClient = _blobServiceClient.GetBlobContainerClient(container);

                var blobClient = containerClient.GetBlobClient(fileName);

                var downloadContent = await blobClient.DownloadAsync();

                using (var ms = new MemoryStream())
                {
                    await downloadContent.Value.Content.CopyToAsync(ms);

                    return ms.ToArray();
                }
            }
            catch (Exception)
            {

                throw;
            }

        }

        public async Task<AzureUploadResponseModel> UploadAsync(string filePath, string container)
        {

            try
            {
                if (!File.Exists(filePath)) return new AzureUploadResponseModel();

                var containerClient = _blobServiceClient.GetBlobContainerClient(container);

                await containerClient.CreateIfNotExistsAsync();

                var fileName = Path.GetFileName(filePath);

                var blobClient = containerClient.GetBlobClient(fileName);

                await blobClient.UploadAsync(filePath, new BlobHttpHeaders
                {
                    ContentType = filePath.GetContentType()
                });

                return new AzureUploadResponseModel
                {
                    fileExtention = Path.GetExtension(fileName),
                    fileType = filePath.GetContentType(),
                    fileUri = blobClient.Uri.AbsoluteUri
                };
            }
            catch (Exception)
            {

                throw;
            }

        }

        public async Task<List<AzureUploadResponseModel>> UploadAsync(List<IFormFile> files, string container)
        {
            if (!files.Any()) return new List<AzureUploadResponseModel>();

            var containerClient = _blobServiceClient.GetBlobContainerClient(container);

            await containerClient.CreateIfNotExistsAsync();

            var responseList = new List<AzureUploadResponseModel>();

            foreach (var file in files)
            {
                var blobClient = containerClient.GetBlobClient(file.FileName);

                await blobClient.UploadAsync(file.OpenReadStream(), new BlobHttpHeaders
                {
                    ContentType = file.FileName.GetContentType()
                });

                responseList.Add(new AzureUploadResponseModel
                {
                    fileExtention = Path.GetExtension(file.FileName),
                    fileType = file.FileName.GetContentType(),
                    fileUri = blobClient.Uri.AbsoluteUri
                });
            }


            return responseList;
        }

        public async Task<AzureUploadResponseModel> UploadAsync(AzureBlobModel file, string container, string filePath)
        {
            if (file == null) return new AzureUploadResponseModel();

            var containerClient = _blobServiceClient.GetBlobContainerClient(container);

            await containerClient.CreateIfNotExistsAsync();

            var fileName = Path.GetFileName(file.FileName);

            var blobClient = containerClient.GetBlobClient(filePath);

            await blobClient.UploadAsync(file.FileContent, new BlobHttpHeaders
            {
                ContentType = file.ContentType
            });

            return new AzureUploadResponseModel
            {
                fileExtention = Path.GetExtension(file.FileName),
                fileType = file.FileName.GetContentType(),
                fileUri = blobClient.Uri.AbsoluteUri
            };
        }

        public bool DeleteContainer(string container)
        {
            if (!string.IsNullOrEmpty(container))
            {
                var containerClient = _blobServiceClient.GetBlobContainerClient(container);

                var response = containerClient.DeleteIfExists();

                return response.Value;
            }
            return false;
        }

        public bool DeleteBlob(string container, string fileName)
        {
            if (!string.IsNullOrEmpty(container) && !string.IsNullOrEmpty(fileName))
            {
                var containerClient = _blobServiceClient.GetBlobContainerClient(container);

                var blobClient = containerClient.GetBlobClient(fileName);
                var response = blobClient.DeleteIfExists();
                return response.Value;
            }
            return false;
        }

    }
}
