using Loan.Platform.Models.Entities;

namespace Loan.Platform.Models.UserManagementModels
{
    public class UserRoleMapping : EntityBase
    {
        public long Id { get; set; }

        public long UserId { get; set; }

        public long RoleId { get; set; }

        //navigation properties
        public virtual User User { get; set; }
    }
}
