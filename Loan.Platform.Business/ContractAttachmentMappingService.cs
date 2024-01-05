using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Threading.Tasks;
using AutoMapper;
using Microsoft.Extensions.Configuration;
using StandardRail.RailCarLounge.Business.Pact;
using StandardRail.RailCarLounge.Data.SqlServer.Pact;
using StandardRail.RailCarLounge.Models.Entities;
using StandardRail.RailCarLounge.Models.Enums;
using StandardRail.RailCarLounge.Models.ViewModels;

namespace StandardRail.RailCarLounge.Business
{
    public class ContractAttachmentMappingService : IContractAttachmentMappingService
    {
        private readonly IRepository<ContractAttachmentMapping, long> _repository;
        private readonly IRepository<AttachmentViewModel, long> _adoRepository;
        private readonly IMapper _mapper;
        private readonly IAuditLogService _auditLogService;
        private readonly IConfiguration _configuration;

        public ContractAttachmentMappingService(IRepository<ContractAttachmentMapping, long> repository, IMapper mapper, 
            IRepository<AttachmentViewModel, long> adoRepository, IAuditLogService auditLogService, IConfiguration configuration)
        {
            _repository = repository ?? throw new ArgumentNullException(nameof(repository));
            _mapper = mapper ?? throw new ArgumentNullException(nameof(mapper));
            _adoRepository = adoRepository ?? throw new ArgumentNullException(nameof(adoRepository));
            _auditLogService = auditLogService ?? throw new ArgumentNullException(nameof(auditLogService));
            _configuration = configuration ?? throw new ArgumentNullException(nameof(configuration));
        }

        public async Task<AttachmentViewModel> SaveContractAttachmentMappingAsync(AttachmentViewModel attachmentViewModel)
        {

            ContractAttachmentMapping contractAttachmentMapping = new ContractAttachmentMapping();
            contractAttachmentMapping.ContractId = attachmentViewModel.ContractId;
            contractAttachmentMapping.Name = attachmentViewModel.FileName;
            contractAttachmentMapping.Path = attachmentViewModel.Path;
            var savedAttachment = await _repository.Create(contractAttachmentMapping);
            if (savedAttachment.Id > 0)
            {
                await _auditLogService.LogStorageOrderAttachmentEvents(attachmentViewModel.ContractId, savedAttachment.Id, AuditLogEvents.AttachmentAdded, "Attachment " + attachmentViewModel.FileName + " Added.");
            }
            var mappedAttachmentViewModel = this._mapper.Map<AttachmentViewModel>(savedAttachment);
            return mappedAttachmentViewModel;
        }

        public async Task<IList<AttachmentViewModel>> GetAttachmentsByContractId(long Id)
        {
            return await _adoRepository.GetListById(Id);
        }

        public bool CheckValidExtension(string filePath)
        {
            string validExtensions = _configuration["ValidFileExtensions"];
            if(string.IsNullOrEmpty(validExtensions))
            {
                return true;
            }
            if (!string.IsNullOrEmpty(filePath))
            {
                string ext = Path.GetExtension(filePath);
                
                string[] validExtensionList = validExtensions.Split(',');
                if (validExtensionList.Contains(ext.ToLower()))
                { 
                    return true; 
                }
                return false;
            }
            return false;
        }
    }
}

