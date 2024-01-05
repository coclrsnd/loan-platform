using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using AutoMapper;
using StandardRail.RailCarLounge.Business.Pact;
using StandardRail.RailCarLounge.Data.SqlServer.Pact;
using StandardRail.RailCarLounge.Models.Entities;
using StandardRail.RailCarLounge.Models.Enums;
using StandardRail.RailCarLounge.Models.ViewModels;

namespace StandardRail.RailCarLounge.Business
{
    public class ContractNoteMappingService : IContractNoteMappingService
    {
        private readonly IRepository<ContractNoteMapping, long> _repository;
        private readonly IRepository<NoteViewModel, long> _adoRepository;
        private readonly IMapper _mapper;
        private readonly IAuditLogService _auditLogService;

        public ContractNoteMappingService(IRepository<ContractNoteMapping, long> repository, IMapper mapper, IRepository<NoteViewModel, long> adoRepository, IAuditLogService auditLogService)
        {
            this._repository = repository ?? throw new ArgumentNullException(nameof(repository));
            this._mapper = mapper ?? throw new ArgumentNullException(nameof(mapper));
            this._adoRepository = adoRepository ?? throw new ArgumentNullException(nameof(adoRepository));
            this._auditLogService = auditLogService ?? throw new ArgumentNullException(nameof(auditLogService));
        }

        public async Task<NoteViewModel> SaveContractNoteMappingAsync(NoteViewModel noteViewModel)
        {

            ContractNoteMapping contractNoteMapping = new ContractNoteMapping();
            contractNoteMapping.ContractId = noteViewModel.ContractId;
            contractNoteMapping.Description = noteViewModel.Description;
            var savedNote = await _repository.Create(contractNoteMapping);
            if (savedNote.Id > 0)
            {
                await _auditLogService.LogStorageOrderNoteEvents(noteViewModel.ContractId, savedNote.Id, AuditLogEvents.NotesAdded, savedNote.Description);
            }
            var mappedNoteViewModel = this._mapper.Map<NoteViewModel>(savedNote);
            return mappedNoteViewModel;
        }

        public async Task<IList<NoteViewModel>> GetNotesByContractId(long Id)
        {
            return await _adoRepository.GetListById(Id);
        }
    }
}

