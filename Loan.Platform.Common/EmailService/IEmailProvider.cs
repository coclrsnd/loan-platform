using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Loan.Platform.Models.Shared;

namespace Loan.Platform.Common.EmailService
{
    public interface IEmailProvider
    {
        void SendEmail(EmailMessage emailMessage);

        Task<EmailResponse> SendEmailAsync(EmailMessage emailMessage);
    }
}
