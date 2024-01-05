namespace Loan.Platform.Models.Entities
{
    public class UserCustomerMapping : EntityBase
    {
        public long Id { get; set; }

        public long UserId { get; set; }

        public long CustomerId { get; set; }
    }
}
