using System.Linq;
using Microsoft.AspNetCore.Http;
using Microsoft.Extensions.Primitives;

namespace Loan.Platform.Rest.Services
{
    public class HttpAccessor : IHttpAccessor
    {
        private readonly IHttpContextAccessor _httpContextAccessor;

        public HttpAccessor(IHttpContextAccessor httpContextAccessor)
        {
            _httpContextAccessor = httpContextAccessor;
        }

        public string GetLoggedInUserHeader()
        {
            _httpContextAccessor.HttpContext.Request.Headers.TryGetValue("userlog", out StringValues customHeader);
            return customHeader.FirstOrDefault() ?? string.Empty;
        }

        public UserInfo GetLoggedInUserInfo()
        {
            UserInfo userInfo = new UserInfo();
            _httpContextAccessor.HttpContext.Request.Headers.TryGetValue("userlog", out StringValues customHeader);
            if (customHeader.Count > 0)
            {
                string[] headerValues = customHeader.FirstOrDefault().Split("|");
                if (!string.IsNullOrEmpty(headerValues[0]))
                {
                    userInfo.UserId = headerValues[0];
                    userInfo.UserRole = headerValues[1];//_roleIdentifier.GetRoleValue(headerValues[1]);
                }
            }
            return userInfo;
        }
    }
}
