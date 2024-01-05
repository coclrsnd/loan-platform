using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using StandardRail.RailCarLounge.Business.Pact;
using StandardRail.RailCarLounge.Data.SqlServer.Pact;
using StandardRail.RailCarLounge.Models.Entities;
using StandardRail.RailCarLounge.Models.Enums;
using StandardRail.RailCarLounge.Models.ViewModels;

namespace StandardRail.RailCarLounge.Business
{
    public class AuditLogService : IAuditLogService
    {
        private readonly IRepository<AuditLog, long> _repository;
        private readonly IRepository<AuditLogFilterViewModel, long> _adoRepository;

        public AuditLogService(IRepository<AuditLog, long> repository, IRepository<AuditLogFilterViewModel, long> adoRepository)
        {
            this._repository = repository ?? throw new ArgumentNullException(nameof(repository));
            this._adoRepository = adoRepository ?? throw new ArgumentNullException(nameof(adoRepository));
        }

        public async Task LogStorageOrderEvents(long orderId, AuditLogEvents auditLogEvent,string logMessage)
        {
            AuditLog auditLog = new AuditLog();
            auditLog.Entity = AuditLogEntities.StorageOrder;
            auditLog.EntityId = orderId;
            auditLog.TimeStamp = DateTime.UtcNow;
            auditLog.LogMessage = logMessage;
            auditLog.EventId = Convert.ToInt32(auditLogEvent);
            await this._repository.Create(auditLog);
        }

        public async Task LogMessage(AuditLog auditLog)
        {
            await _repository.Create(auditLog);
        }

        public async Task LogMessages(List<AuditLog> auditLogs)
        {
            await _repository.SaveEntities(auditLogs);
        }

        public async Task LogStorageOrderNoteEvents(long orderId, long noteId, AuditLogEvents auditLogEvent, string logMessage)
        {
            AuditLog auditLog = new AuditLog();
            auditLog.Entity = AuditLogEntities.StorageOrder;
            auditLog.EntityId = orderId;
            auditLog.AssociatedEntity = AuditLogEntities.Notes;
            auditLog.AssociatedEntityId = noteId;
            auditLog.TimeStamp = DateTime.UtcNow;
            auditLog.LogMessage = logMessage;
            auditLog.EventId = Convert.ToInt32(auditLogEvent);
            await this._repository.Create(auditLog);
        }

        public async Task LogStorageOrderAttachmentEvents(long orderId, long attachmentId, AuditLogEvents auditLogEvent, string logMessage)
        {
            AuditLog auditLog = new AuditLog();
            auditLog.Entity = AuditLogEntities.StorageOrder;
            auditLog.EntityId = orderId;
            auditLog.AssociatedEntity = AuditLogEntities.Attachments;
            auditLog.AssociatedEntityId = attachmentId;
            auditLog.TimeStamp = DateTime.UtcNow;
            auditLog.LogMessage = logMessage;
            auditLog.EventId = Convert.ToInt32(auditLogEvent);
            await this._repository.Create(auditLog);
        }

        public async Task LogStorageOrderRailCarAddEvents(IList<AuditLog> auditLogs)
        {
            await this._repository.SaveEntities(auditLogs);
        }

        public async Task LogStorageOrderRailCarUpdateEvents(long orderId, long contractRailCarMappingId, AuditLogEvents auditLogEvent, string logMessage)
        {
            AuditLog auditLog = new AuditLog();
            auditLog.Entity = AuditLogEntities.StorageOrder;
            auditLog.EntityId = orderId;
            auditLog.AssociatedEntity = AuditLogEntities.RailCars;
            auditLog.AssociatedEntityId = contractRailCarMappingId;
            auditLog.TimeStamp = DateTime.UtcNow;
            auditLog.LogMessage = logMessage;
            auditLog.EventId = Convert.ToInt32(auditLogEvent);
            await this._repository.Create(auditLog);

        }

        public async Task<IList<AuditLogViewModel>> GetAuditLogsByContractId(long Id)
        {
            var audiLogFilterViewModel = await _adoRepository.GetById(Id);
            return audiLogFilterViewModel.AuditLogModel;
        }

        public async Task<AuditLogFilterViewModel> GetAuditLogsOnFilter(AuditLogFilterViewModel auditLogFilterViewModel)
        {
            return await _adoRepository.SearchWithPagination(auditLogFilterViewModel);
        }
    }
}
