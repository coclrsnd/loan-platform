namespace Loan.Platform.Models.Entities
{
    public class NotificationEvent : EntityBase
    {
        public long Id { get; set; }

        public string Name { get; set; }

        public string Description { get; set; }
    }
}
