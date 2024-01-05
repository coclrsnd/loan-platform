namespace Loan.Platform.Models.CustomModels
{
    public class SecurityContext
    {
        public string Token { get; set; }

        public long UserId { get; set; }
        
        public string RoleName { get; set; }
        
        public string EmailId { get; set; }
        
        public string Name { get; set; }

        public long OrganizationId { get; set; }

        public long TenantId { get; set; }

        public string CurrentRole { get; set; }
    }
}
