namespace Loan.Platform.Common.UserContext
{

    /// <summary>
    /// Interface to store user context.
    /// </summary>
    public interface IUserContext
    {
        long? OrganizationId { get; }

        long? TenantId { get; }

        long? UserId { get; }

        string CurrentRole { get; }
    }
}
