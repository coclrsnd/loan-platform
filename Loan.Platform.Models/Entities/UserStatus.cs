namespace Loan.Platform.Models.Entities
{
    public class UserStatus
    {
        public long Id { get; set; }

        public string Name { get; set; }

        public string Description { get; set; }

        public bool? IsActive { get; set; }
    }
}
