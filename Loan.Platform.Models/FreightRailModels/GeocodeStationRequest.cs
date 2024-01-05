namespace Loan.Platform.Models.FreightRailModels
{
    public class GeocodeStationRequest
    {
        public string Name { get; set; }
        public string Format { get; set; }
        public string Railroad { get; set; }
        public bool IntermodalOnlyStations { get; set; }
    }
}
