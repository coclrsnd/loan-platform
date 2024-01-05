using System.Collections.Generic;

namespace Loan.Platform.Models.FreightRailModels
{
    public class RailReportRequest
    {
        public List<Stop> Stops { get; set; }
        public Options Options { get; set; }
        public string Report { get; set; }

        public RailReportRequest()
        {
            this.Stops = new List<Stop>();
            this.Options = new Options();
        }
    }
}
