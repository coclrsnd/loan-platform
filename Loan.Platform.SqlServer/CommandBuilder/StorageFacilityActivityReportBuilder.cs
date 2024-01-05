using System.Data;
using StandardRail.RailCarLounge.Data.SqlServer.Extensions;
using StandardRail.RailCarLounge.Models.Entities;
using StandardRail.RailCarLounge.Models.ReportModels;

namespace StandardRail.RailCarLounge.Data.SqlServer.CommandBuilder
{
    public class StorageFacilityActivityReportBuilder : BaseCommandBuilder<StorageFacilityActivityReportViewModel, long>
    {
        public override IDbCommand Search(StorageFacilityActivityReportViewModel storageFacilityActivityReportViewModel)
        {
            var command = CreateCommand();
            command.CommandType = CommandType.StoredProcedure;
            command.CommandText = "SP_StorageFacilityActivityReport"; 
            command.AddParameter("Id", storageFacilityActivityReportViewModel.StorageFacilityActivityReportRequest.ContractId);
            command.AddParameter("ContractTypeId", storageFacilityActivityReportViewModel.StorageFacilityActivityReportRequest.ContractTypeId);
            command.AddParameter("FromDate", storageFacilityActivityReportViewModel.StorageFacilityActivityReportRequest.FromDate);
            command.AddParameter("ToDate", storageFacilityActivityReportViewModel.StorageFacilityActivityReportRequest.ToDate);
            return command;
        }
    }
}
