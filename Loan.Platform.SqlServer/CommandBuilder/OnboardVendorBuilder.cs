using System.Data;
using StandardRail.RailCarLounge.Data.SqlServer.Extensions;
using StandardRail.RailCarLounge.Models.Shared;

namespace StandardRail.RailCarLounge.Data.SqlServer.CommandBuilder
{
    public class OnboardVendorBuilder : BaseCommandBuilder<OnboardVendorModel, long>
    {
        /// <summary>
        /// Creates command for Vendor save.
        /// </summary>
        /// <param name="onboardVendorModel"></param>
        /// <returns></returns>
        public override IDbCommand Create(OnboardVendorModel onboardVendorModel)
        {
            var command = CreateCommand();
            command.CommandType = CommandType.StoredProcedure;
            command.CommandText = "usp_CreateOrUpdateVendor";

            command.AddParameter("Vendor", onboardVendorModel.Vendor);
            command.AddParameter("StorageFacility", onboardVendorModel.StorageFacilities);
            command.AddParameter("StorageFacilityRates", onboardVendorModel.StorageFacilitiesRates);
            command.AddParameter("StorageFacilityFeatures", onboardVendorModel.StorageFacilitiesFeatures);
            command.AddParameter("StorageFacilityInterchanges", onboardVendorModel.StorageFacilitiesInterchanges);
            command.AddParameter("StorageFacilityInterchangeLocations", onboardVendorModel.StorageFacilitiesInterchangeLocations);
            return command;
        }

        /// <summary>
        /// Creates command for Get Vendor Details by Id.
        /// </summary>
        /// <param name="onboardVendorModel"></param>
        /// <returns></returns>
        public override IDbCommand GetById(long vendorId)
        {
            var command = CreateCommand();
            command.CommandType = CommandType.StoredProcedure;
            command.CommandText = "sp_GetVendorDetails";

            command.AddParameter("vendorId", vendorId);
            return command;
        }
    }
}
