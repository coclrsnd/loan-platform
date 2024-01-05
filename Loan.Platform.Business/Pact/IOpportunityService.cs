using System.Collections.Generic;
using System.Threading.Tasks;
using StandardRail.RailCarLounge.Common.StorageAccountHelper.BlobHelper;
using StandardRail.RailCarLounge.Models.ViewModels;

namespace StandardRail.RailCarLounge.Business.Pact
{

    /// <summary>
    /// Contains methods for Opportunity.
    /// </summary>
    public interface IOpportunityService
    {
        /// <summary>
        /// Save Opportunity Rail Cars and attachments
        /// </summary>
        /// <param name="opportunityViewModel"></param>
        /// <returns></returns>
        Task<OpportunityViewModel> SaveOpportunity(OpportunityViewModel opportunityViewModel);

        /// <summary>
        /// Save Opportunity Attachments
        /// </summary>
        /// <param name="opportunityAttachments"></param>
        void SaveOpportunityAttachments(OpportunityAttachmentViewModel opportunityAttachments);

        /// <summary>
        /// Save Opportunity Features
        /// </summary>
        /// <param name="opportunityFeatures"></param>
        /// <returns></returns>
        Task<List<OpportunityFeaturesViewModel>> SaveOpportunityFeatures(IList<OpportunityFeaturesViewModel> opportunityFeatures);

        /// <summary>
        /// GetOpportunity By Id
        /// </summary>
        /// <param name="opportunityId"></param>
        /// <returns></returns>
        Task<OpportunityViewModel> GetOpportunityById(long opportunityId);

        /// <summary>
        /// Upload Opportunity Attachment
        /// </summary>
        /// <param name="azureBlobModel"></param>
        /// <param name="FilePath"></param>
        /// <returns></returns>
        Task<string> UploadOpportunityAttachment(AzureBlobModel azureBlobModel, string FilePath);

        /// <summary>
        /// Delete Opportunity Attachment
        /// </summary>
        /// <param name="filePath"></param>
        /// <returns></returns>
        public bool DeleteOpportunityAttachment(string filePath);

        /// <summary>
        /// Check Valid Extension
        /// </summary>
        /// <param name="filePath"></param>
        /// <returns></returns>
        public bool CheckValidExtension(string filePath);

        /// <summary>
        /// Download Opportunity Summary
        /// </summary>
        /// <param name="aggrementPath"></param>
        /// <returns></returns>
        Task<byte[]> DownloadOpportunitySummary(string agreementPath);

        /// <summary>
        /// Get Content Type
        /// </summary>
        /// <param name="path"></param>
        /// <returns></returns>
        public string GetContentType(string path);

        /// <summary>
        /// Get Opportunity Features
        /// </summary>
        /// <param name="OpportunityId"></param>
        /// <returns></returns>
        IList<OpportunityFeaturesViewModel> GetOpportunityFeatures(long OpportunityId);

        /// <summary>
        /// Place Opportunity
        /// </summary>
        /// <param name="opportunity"></param>
        /// <returns></returns>
        Task<OpportunityViewModel> PlaceOpportunity(OpportunityViewModel opportunity);

        /// <summary>
        /// Save Opportunity ReservedSpaces
        /// </summary>
        /// <param name="opportunityReservedSpacesViewModels"></param>
        /// <returns></returns>
        Task<List<OpportunityReservedSpacesViewModel>> SaveOpportunityReservedSpaces(IList<OpportunityReservedSpacesViewModel> opportunityReservedSpacesViewModels);

        /// <summary>
        /// Delete Opportunity ReservedSpaces
        /// </summary>
        /// <param name="Id"></param>
        /// <returns></returns>
        Task<bool> DeleteOpportunityReservedSpaces(long Id);
    }
}
