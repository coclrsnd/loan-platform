namespace StandardRail.RailCarLounge.Models.Entities
{
    public class Region : EntityBase
    {
        public long Id { get; set; }

        public string Name { get; set; }

        public long? CountryId { get; set; }

        //Navigation properties
        public virtual Country Country { get; set; }

    }
}
