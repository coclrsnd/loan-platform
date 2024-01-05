namespace Loan.Platform.Rest.Services
{
    public interface IHttpAccessor
    {
        public UserInfo GetLoggedInUserInfo();
        public string GetLoggedInUserHeader();
    }

    public class UserInfo
    {
        public string UserId { get; set; }
        public string UserRole { get; set; }
    }
}
