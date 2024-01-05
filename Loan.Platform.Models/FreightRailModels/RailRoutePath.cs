using System.Collections.Generic;

namespace Loan.Platform.Models.FreightRailModels
{
    public class RailRoutePath
    {
        public List<Stop> Stops { get; set; }
        public Options Options { get; set; }

        public RailRoutePath()
        {
            this.Stops = new List<Stop>();
            this.Options = new Options();
        }
    }
}
