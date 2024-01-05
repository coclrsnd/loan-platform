using System.Collections.Generic;

namespace Loan.Platform.Models.FreightRailModels
{
    public class GeocodeStationResponse
    {
        public List<GeocodeInfo> GeocodeInfos { get; set; }
    }

    public class GeocodeInfo
    {
        public string StationName { get; set; }
        public string State { get; set; }
        public string Railroad { get; set; }
        public double Latitude { get; set; }
        public double Longitude { get; set; }
        public List<Station> Stations { get; set; }
        public int? SPLC { get; set; }
    }

    public class Station
    {
        public string Format { get; set; }
        public string Name { get; set; }
        public string Railroad { get; set; }
    }
}
