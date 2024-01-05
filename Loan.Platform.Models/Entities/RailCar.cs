namespace StandardRail.RailCarLounge.Models.Entities
{
    public class RailCar : EntityBase
    {
        public long Id { get; set; }

        public string CarInitial { get; set; }

        public string CarNumber { get; set; }

        public decimal? Length { get; set; }


        public long? RailCarTypeId { get; set; }

        public string OwnerMark { get; set; }

        //Navigation properties
        public RailCarType RailCarType { get; set; }
    }
}
