using AutoMapper;
using StandardRail.RailCarLounge.Business.Pact;
using StandardRail.RailCarLounge.Data.SqlServer.Pact;
using StandardRail.RailCarLounge.Models.Entities;
using StandardRail.RailCarLounge.Models.Enums;
using StandardRail.RailCarLounge.Models.ViewModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace StandardRail.RailCarLounge.Business
{
    public class ContractRailCarMappingService : IContractRailCarMappingService
    {
        private readonly IRepository<ContractRailCarMapping, long> _repository;
        private readonly IMapper _mapper;
        private readonly IAuditLogService _auditLogService;

        public ContractRailCarMappingService(IRepository<ContractRailCarMapping, long> repository, IMapper mapper, IAuditLogService auditLogService)
        {
            this._repository = repository ?? throw new ArgumentNullException(nameof(repository));
            this._mapper = mapper ?? throw new ArgumentNullException(nameof(mapper));
            this._auditLogService = auditLogService ?? throw new ArgumentNullException(nameof(auditLogService));
        }

        public async Task<IList<ContractRailCarMapping>> SaveContractRailCarMappingAsync(IList<ContractRailCarMapping> contractRailCarMappings)
        {
            var savedContractRailCarMappings = await _repository.SaveEntities(contractRailCarMappings);
            if (savedContractRailCarMappings != null && savedContractRailCarMappings.Any())
            {
                IList<AuditLog> auditLogs = new List<AuditLog>();
                foreach (var contractRailCarMapping in savedContractRailCarMappings)
                {
                    AuditLog auditLog = new AuditLog();
                    auditLog.Entity = AuditLogEntities.StorageOrder;
                    auditLog.EntityId = contractRailCarMapping.ContractId;
                    auditLog.AssociatedEntity = AuditLogEntities.RailCars;
                    auditLog.AssociatedEntityId = contractRailCarMapping.Id;
                    auditLog.TimeStamp = DateTime.UtcNow;
                    auditLog.LogMessage = "Railcar " + contractRailCarMapping.CarInitial + contractRailCarMapping.CarNumber + " Added.";
                    auditLog.EventId = Convert.ToInt32(AuditLogEvents.RailCarAdded);
                    auditLogs.Add(auditLog);
                }
                await _auditLogService.LogStorageOrderRailCarAddEvents(auditLogs);
            }
            return savedContractRailCarMappings;

        }

        public async Task UpdateContractRailCarMappingAsync(RailCarViewModel railCarViewModel)
        {
            var contractRailCarMapping = this._mapper.Map<ContractRailCarMapping>(railCarViewModel);
            contractRailCarMapping.Id = railCarViewModel.ContractRailCarMappingId;
            contractRailCarMapping.IsActive = true;
            await _repository.Update(contractRailCarMapping);
            await _auditLogService.LogStorageOrderRailCarUpdateEvents(railCarViewModel.ContractId, railCarViewModel.ContractRailCarMappingId, AuditLogEvents.RailCarUpdated, "Rail Car " + railCarViewModel.CarId + " Updated.");
        }
    }
}
