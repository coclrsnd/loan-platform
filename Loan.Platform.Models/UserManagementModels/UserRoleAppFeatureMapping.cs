namespace Loan.Platform.Models.UserManagementModels
{
    public class UserRoleAppFeatureMapping
    {
        public long Id { get; set; }

        public long RoleId { get; set; }

        public long FeatureId { get; set; }

        public bool? IsActive { get; set; }
    }
}
