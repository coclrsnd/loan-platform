using System.Collections.Generic;
using System.Threading.Tasks;
using StandardRail.RailCarLounge.Models.Entities;
using StandardRail.RailCarLounge.Models.Enums;
using StandardRail.RailCarLounge.Models.ViewModels;

namespace StandardRail.RailCarLounge.Business.Pact
{
    /// <summary>
    /// Interface to perform audit logging events.
    /// </summary>
    public interface IAuditLogService
    {
        Task LogMessage(AuditLog auditLog);

        Task LogStorageOrderEvents(long orderId, AuditLogEvents auditLogEvent,string logMessage);

        Task LogStorageOrderNoteEvents(long orderId, long noteId, AuditLogEvents auditLogEvent, string logMessage);

        Task LogStorageOrderAttachmentEvents(long orderId, long attachmentId, AuditLogEvents auditLogEvent, string logMessage);

        Task LogStorageOrderRailCarAddEvents(IList<AuditLog> auditLogs);

        Task LogStorageOrderRailCarUpdateEvents(long orderId, long contractRailCarMappingId, AuditLogEvents auditLogEvent, string logMessage);

        Task<IList<AuditLogViewModel>> GetAuditLogsByContractId(long Id);

        Task<AuditLogFilterViewModel> GetAuditLogsOnFilter(AuditLogFilterViewModel auditLogFilterViewModel);
    }
}
