namespace Loan.Platform.Models.Entities
{
    public class MailConfiguration : EntityBase
    {
        public long Id { get; set; }

        public long NotificationEventId { get; set; }

        public string Subject { get; set; }

        public string Body { get; set; }

        //navigation property
        public NotificationEvent NotificationEvent { get; set; }
    }
}
