using System;
using System.IdentityModel.Tokens.Jwt;
using System.Linq;
using Microsoft.AspNetCore.Http;
using Loan.Platform.Common.UserContext;

namespace Loan.Platform.Data.SqlServer
{
    public class UserContext : IUserContext
    {
        public UserContext(IHttpContextAccessor httpContextAccessor)
        {
            var headers = httpContextAccessor.HttpContext?.Request.Headers;
            if (headers != null)
            {
                string token = string.Empty;
                string authHeader = headers["Authorization"];
                if (!string.IsNullOrEmpty(authHeader))
                {
                    if (authHeader.StartsWith("Bearer", StringComparison.OrdinalIgnoreCase))
                    {
                        token = authHeader.Substring("Bearer ".Length).Trim();
                    }
                    else
                    {
                        token = authHeader.Trim();
                    }
                }
                if (!string.IsNullOrEmpty(token) && !token.Equals("null"))
                {
                    var handler = new JwtSecurityTokenHandler();
                    var jwtSecurityToken = handler.ReadJwtToken(token);
                    var userId = jwtSecurityToken.Claims.First(claim => claim.Type == "UserId").Value;
                    string[] userContextValues = userId.Split("|");

                    UserId = !string.IsNullOrEmpty(userContextValues[0]) ? Convert.ToInt64(userContextValues[0]) : default;
                    OrganizationId = !string.IsNullOrEmpty(userContextValues[1]) ? Convert.ToInt64(userContextValues[1]) : default;
                    TenantId = !string.IsNullOrEmpty(userContextValues[2]) ? Convert.ToInt64(userContextValues[2]) : default;

                    var currentRole = jwtSecurityToken.Claims.First(claim => claim.Type == "CurrentRole").Value;
                    CurrentRole = currentRole;
                }
            }
        }
        public long? OrganizationId { get; }

        public long? TenantId { get; }

        public long? UserId { get; }

        public string CurrentRole { get; }
    }
}
