using System.Collections.Generic;

namespace Loan.Platform.Models.FreightRailModels
{
    public class Options
    {
        public string RoutingPreference { get; set; }
        public bool AmtrakRoutes { get; set; }
        public bool IntermodalOnlyStations { get; set; }
        public string DistUnit { get; set; }
    }

   
}
