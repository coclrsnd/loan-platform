namespace Loan.Platform.Models.UserManagementModels
{
    public class UserRoles
    {

        public long Id { get; set; }

        public string Name { get; set; }

        public string Description { get; set; }

        public bool? IsActive { get; set; }
    }
}
