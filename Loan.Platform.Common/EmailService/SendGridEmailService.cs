using System;
using System.Text.RegularExpressions;
using System.Threading.Tasks;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.Logging;
using SendGrid;
using SendGrid.Helpers.Mail;
using Loan.Platform.Models.Shared;

namespace Loan.Platform.Common.EmailService
{
    public class SendGridEmailService : IEmailProvider
    {
        private static readonly char[] _separator = new char[] { ',', ';' };

        private IConfiguration Configuration { get; }
        private readonly ILogger<EmailService> _logger;

        public SendGridEmailService(IConfiguration configuration, ILogger<EmailService> logger)
        {
            Configuration = configuration ?? throw new ArgumentNullException(nameof(configuration));
            _logger = logger ?? throw new ArgumentNullException(nameof(logger));
        }

        public async Task<EmailResponse> SendEmailAsync(EmailMessage emailMessage)
        {
            var message = new SendGridMessage();
            var subject = Regex.Replace(emailMessage.Subject, @"\\[abtrvfnexcu]", " ").Trim();

            message.Subject = subject.Length > 250 ? subject.Substring(0, 249) : subject;
            var senderEmail = Configuration["SendGrid:SenderEmail"];
            var senderDisplayName = Configuration["SendGrid:DisplayName"].ToString();
            message.From = message.From = !string.IsNullOrWhiteSpace(senderDisplayName) ? new EmailAddress(senderEmail, senderDisplayName) : new EmailAddress(senderEmail);
            message.AddContent(MimeType.Html, emailMessage.MessageBody);
            var recipientList = emailMessage.Recipients.Split(_separator);

            foreach (var recipient in recipientList)
            {
                message.AddTo(new EmailAddress(recipient));
            }

            var ccRecipientList = emailMessage.CcRecipients != null ? emailMessage.CcRecipients.Split(_separator) : null;
            if (ccRecipientList != null && ccRecipientList.Length > 0)
            {
                foreach (var recipient in ccRecipientList)
                {
                    message.AddCc(new EmailAddress(recipient));
                }
            }

            if (!string.IsNullOrWhiteSpace(emailMessage.BccRecipients))
            {
                var bccRecipientList = EmailHelper.GetBCCRecipients(recipientList, ccRecipientList, emailMessage.BccRecipients.Split(_separator));
                foreach (var recipient in bccRecipientList)
                {
                    message.AddBcc(new EmailAddress(recipient));
                }
            }
            if (Configuration.GetValue("SendGrid:SandboxMode", false))
            {
                message.MailSettings = new MailSettings
                {
                    SandboxMode = new SandboxMode
                    {
                        Enable = true
                    }
                };
            }
            if (emailMessage.Attachments != null && emailMessage.Attachments.Count > 0)
            {
                foreach (var attachment in emailMessage.Attachments)
                {
                    message.AddAttachment(new Attachment
                    {
                        Content = Convert.ToBase64String(attachment.Content),
                        Type = attachment.ContentType,
                        Filename = attachment.FileName
                    });
                }
            }
            var apiKey = Environment.GetEnvironmentVariable("SENDGRID_API_KEY") ?? Configuration["SendGridApiKey"];
            var client = new SendGridClient(apiKey);
            var response = await client.SendEmailAsync(message);

            System.Net.HttpStatusCode statusCode = response != null && response.StatusCode == System.Net.HttpStatusCode.Accepted ? response.StatusCode : System.Net.HttpStatusCode.InternalServerError;
            var emailResponse = EmailHelper.PrepareEmailResponse(statusCode, Guid.NewGuid().ToString(), EmailProviderEnum.SendGrid);
            return emailResponse;
        }




        public void SendEmail(EmailMessage emailMessage)
        {
            throw new NotImplementedException();
        }
    }


}
