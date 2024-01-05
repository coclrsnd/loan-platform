namespace Loan.Platform.Models.Entities
{
    public class UserVendorMapping : EntityBase
    {
        public long Id { get; set; }

        public long UserId { get; set; }

        public long VendorId { get; set; }
    }
}
