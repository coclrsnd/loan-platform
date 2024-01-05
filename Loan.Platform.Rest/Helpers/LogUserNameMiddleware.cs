using System;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using Serilog.Context;

namespace Loan.Platform.Rest.Helpers
{
    public class LogUserNameMiddleware
    {
        private readonly RequestDelegate next;

        public LogUserNameMiddleware(RequestDelegate next)
        {
            this.next = next;
        }

        public async Task Invoke(HttpContext context)
        {
            var header = context.Request.Headers["CorrelationId"];
            string sessionId;

            if (header.Count > 0)
            {
                sessionId = header[0];
            }
            else
            {
                sessionId = Guid.NewGuid().ToString();
            }

            context.Items["CorrelationId"] = sessionId;

            using (LogContext.PushProperty("UserName", context.User.Identity.Name ?? "anonymous"))
            {
                await next(context);
            }
        }
    }
}
