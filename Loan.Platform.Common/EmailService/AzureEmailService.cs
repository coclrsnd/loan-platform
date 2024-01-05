using System;
using System.Collections.Generic;
using System.Text.RegularExpressions;
using System.Threading;
using System.Threading.Tasks;
using Azure.Communication.Email;
using Azure.Communication.Email.Models;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.Logging;
using EmailAddress = Azure.Communication.Email.Models.EmailAddress;
using EmailMessage = Azure.Communication.Email.Models.EmailMessage;

namespace Loan.Platform.Common.EmailService
{
    public class AzureEmailService : IEmailProvider
    {
        private static readonly char[] _separator = new char[] { ',', ';' };

        private IConfiguration Configuration { get; }
        private readonly ILogger<EmailService> _logger;
        public AzureEmailService(IConfiguration configuration, ILogger<EmailService> logger)
        {
            Configuration = configuration ?? throw new ArgumentNullException(nameof(configuration));
            _logger = logger ?? throw new ArgumentNullException(nameof(logger));
        }
        public void SendEmail(EmailMessage emailMessage)
        {
            throw new NotImplementedException();
        }

        public async Task<EmailResponse> SendEmailAsync(Loan.Platform.Models.Shared.EmailMessage emailMessage)
        {
            EmailClient emailClient = new EmailClient(Configuration["EmailServiceConStr"]);

            var subject = Regex.Replace(emailMessage.Subject, @"\\[abtrvfnexcu]", " ").Trim();
            EmailContent emailContent = new EmailContent(subject.Length > 250 ? subject.Substring(0, 249) : subject);
            emailContent.Html = emailMessage.MessageBody;

            var senderEmail = Configuration["EmailConfig:SenderEmail"];
            var senderDisplayName = Configuration["EmailConfig:DisplayName"].ToString();

            List<EmailAddress> toEmailAddresses = new List<EmailAddress>();
            var recipientList = emailMessage.Recipients.Split(_separator);
            foreach (var recipient in recipientList)
            {
                toEmailAddresses.Add(new EmailAddress(recipient));
            }

            List<EmailAddress> ccEmailAddresses = new List<EmailAddress>();
            var ccRecipientList = emailMessage.CcRecipients != null ? emailMessage.CcRecipients.Split(_separator) : null;
            if (ccRecipientList != null && ccRecipientList.Length > 0)
            {
                foreach (var recipient in ccRecipientList)
                {
                    ccEmailAddresses.Add(new EmailAddress(recipient));
                }
            }

            List<EmailAddress> bccEmailAddresses = new List<EmailAddress>();
            if (!string.IsNullOrWhiteSpace(emailMessage.BccRecipients))
            {
                var bccRecipientList = EmailHelper.GetBCCRecipients(recipientList, ccRecipientList, emailMessage.BccRecipients.Split(_separator));
                foreach (var recipient in bccRecipientList)
                {
                    bccEmailAddresses.Add(new EmailAddress(recipient));
                }
            }

            EmailRecipients emailRecipients = new EmailRecipients(toEmailAddresses, ccEmailAddresses, bccEmailAddresses);

            EmailMessage email = new EmailMessage(senderEmail, emailContent, emailRecipients);

            if (emailMessage.Attachments != null && emailMessage.Attachments.Count > 0)
            {
                foreach (var attachment in emailMessage.Attachments)
                {
                    Azure.Communication.Email.Models.EmailAttachment emailAttachment = new Azure.Communication.Email.Models.EmailAttachment(attachment.FileName, attachment.ContentType, Convert.ToBase64String(attachment.Content));
                    email.Attachments.Add(emailAttachment);
                }
            }

            SendEmailResult emailResult = await emailClient.SendAsync(email, CancellationToken.None);

            System.Net.HttpStatusCode statusCode = emailResult != null ? System.Net.HttpStatusCode.Accepted : System.Net.HttpStatusCode.InternalServerError;

            var emailResponse = EmailHelper.PrepareEmailResponse(statusCode, emailResult.MessageId, EmailProviderEnum.Azure);
            return emailResponse;
        }

        public void SendEmail(Models.Shared.EmailMessage emailMessage)
        {
            throw new NotImplementedException();
        }
    }
}
