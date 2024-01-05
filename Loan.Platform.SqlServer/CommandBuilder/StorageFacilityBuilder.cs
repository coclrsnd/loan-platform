using System.Data;
using System.Linq;
using StandardRail.RailCarLounge.Data.SqlServer.Extensions;
using StandardRail.RailCarLounge.Models.ViewModels;

namespace StandardRail.RailCarLounge.Data.SqlServer.CommandBuilder
{
    public class StorageFacilityBuilder : BaseCommandBuilder<FacilityMapSearchViewModel, long>
    {
        public override IDbCommand Search(FacilityMapSearchViewModel facilityMapSearchViewModel)
        {
            var command = CreateCommand();
            command.CommandType = CommandType.StoredProcedure;
            command.CommandText = "sp_SearchFacility";
            command.AddParameter("isMulticityEnable", facilityMapSearchViewModel.FacilityMapSearchRequest.isMulticityEnable);
            command.AddParameter("origin", facilityMapSearchViewModel.FacilityMapSearchRequest.Origin?.StationName);
            command.AddParameter("destination", facilityMapSearchViewModel.FacilityMapSearchRequest.Destination?.StationName);
            command.AddParameter("railroads", facilityMapSearchViewModel.FacilityMapSearchRequest.Railroads);
            command.AddParameter("region", facilityMapSearchViewModel.FacilityMapSearchRequest.RegionId);
            command.AddParameter("expiryDate", facilityMapSearchViewModel.FacilityMapSearchRequest.ExpiryDate);
            command.AddParameter("effectiveDate", facilityMapSearchViewModel.FacilityMapSearchRequest.EffectiveDate);
            command.AddParameter("dailyRate", facilityMapSearchViewModel.FacilityMapSearchRequest.DailyRate);
            command.AddParameter("switchingFee", facilityMapSearchViewModel.FacilityMapSearchRequest.SwitchingFee);
            command.AddParameter("features", facilityMapSearchViewModel.FacilityMapSearchRequest.Features != null ? string.Join(",", facilityMapSearchViewModel.FacilityMapSearchRequest.Features.Select(e => e.Id)) : null);
            command.AddParameter("splcs", facilityMapSearchViewModel.FacilityMapSearchRequest.SPLCs);
            command.AddParameter("splcMilesMap", facilityMapSearchViewModel.FacilityMapSearchRequest.SPLCMilesMap);
            return command;
        }
    }
}
