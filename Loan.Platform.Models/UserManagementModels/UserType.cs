namespace Loan.Platform.Models.UserManagementModels
{
    public class UserType
    {
        public long Id { get; set; }

        public string Name { get; set; }

        public string Description { get; set; }

        public bool? IsActive { get; set; }
    }
}
