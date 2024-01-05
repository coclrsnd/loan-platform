using System.Collections.Generic;
using System.Text.Json;
using Microsoft.AspNetCore.Mvc.Filters;
using Microsoft.Extensions.Logging;
using Loan.Platform.Rest.Services;

namespace Loan.Platform.Rest.Filters
{
    public class HttpGlobalExceptionFilter : IExceptionFilter
    {
        private readonly ILogger<HttpGlobalExceptionFilter> _logger;
        private readonly IHttpAccessor _httpContextAccessor;

        public HttpGlobalExceptionFilter(ILogger<HttpGlobalExceptionFilter> logger, IHttpAccessor httpContextAccessor)
        {
            _logger = logger;
            _httpContextAccessor = httpContextAccessor;
        }

        public void OnException(ExceptionContext context)
        {
            UserInfo userInfo = _httpContextAccessor.GetLoggedInUserInfo();

            Dictionary<string, string> properties = new Dictionary<string, string>()
            {
                { "UserId", userInfo?.UserId },
                { "UserRole", userInfo?.UserRole },
                { "ErrorType", context.Exception.GetType().Name },
                { "ErrorMsg", context.Exception.Message }
            };

            var errorProperties = JsonSerializer.Serialize<Dictionary<string, string>>(properties);

            _logger.LogError(new EventId(context.Exception.HResult),
               context.Exception,
               errorProperties);
        }
    }
}
