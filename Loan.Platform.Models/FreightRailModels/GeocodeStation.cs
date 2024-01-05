namespace Loan.Platform.Models.FreightRailModels
{
    public class GeocodeStation
    {
        public string StationName { get; set; }
        public string StationFullName { get; set; }

        public string Railroad { get; set; }

        public double Latitude { get; set; }

        public double Longitude { get; set; }

        public int SPLC { get; set; }

        public int FSAC { get; set; }

        public string R260 { get; set; }

        public string StationState { get; set; }
    }
}
