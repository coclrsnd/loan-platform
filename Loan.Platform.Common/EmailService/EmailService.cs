using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.Logging;
using Loan.Platform.Models.Shared;

namespace Loan.Platform.Common.EmailService
{
    /// <summary>
    /// Contains Common logic for sending the notifications.
    /// </summary>
    public class EmailService : IEmailService
    {
        private IConfiguration Configuration { get; }
        private readonly ILogger<EmailService> _logger;

        public EmailService(IConfiguration configuration, ILogger<EmailService> logger)
        {
            Configuration = configuration ?? throw new ArgumentNullException(nameof(configuration));
            _logger = logger ?? throw new ArgumentNullException(nameof(logger));
        }
        public async Task<EmailResponse> SendNotification(EmailRequestMessage emailRequestMessage)
        {
            try
            {
                EmailMessage emailMessage = await ParseEmailBodyByDynamicObject(emailRequestMessage);

                if (emailMessage != null)
                {
                    IEmailProvider emailProvider = GetEmailProvider(Configuration["EmailConfig:EmailProvider"]);
                    emailMessage.BccRecipients = CheckBCCSettings();
                    EmailResponse result = await emailProvider.SendEmailAsync(emailMessage);
                    result.EmailMessageInfo = emailRequestMessage.EmailMessage;
                    return result;
                }
            }
            catch (Exception ex)
            {
                _logger.LogError(emailRequestMessage.EmailMessage.Recipients, ex, emailRequestMessage);
                throw;
            }
            return new EmailResponse()
            {
                IsMailSent = false,
                EmailMessageInfo = emailRequestMessage.EmailMessage,
                StatusCode = System.Net.HttpStatusCode.InternalServerError
            };
        }

        private IEmailProvider GetEmailProvider(string emailProvider)
        {
            return emailProvider.ToLower() switch
            {
                "sendgrid" => new SendGridEmailService(Configuration, _logger),
                "azure" => new AzureEmailService(Configuration, _logger),
                "smtp" => new SMTPEmailService(Configuration),
                _ => throw new ArgumentOutOfRangeException(nameof(IEmailProvider), $"Not expected provider value -{emailProvider}")
            };
        }

        private string CheckBCCSettings()
        {
            if (!string.IsNullOrEmpty(Configuration["EmailConfig:IsBccEnabled"]) && Convert.ToBoolean(Configuration["EmailConfig:IsBccEnabled"]))
            {
                return !string.IsNullOrEmpty(Configuration["EmailConfig:BccRecipients"]) ? Configuration["EmailConfig:BccRecipients"] : string.Empty;
            }
            return string.Empty;
        }

        private async Task<EmailMessage> ParseEmailBodyByDynamicObject(EmailRequestMessage emailRequestMessage)
        {
            var message = new EmailMessage();
            if (emailRequestMessage != null)
            {
                message = emailRequestMessage.EmailMessage;
                message.Subject = emailRequestMessage.EmailConfiguration.Subject;
                message.MessageBody = ReplaceTagsWithValues(emailRequestMessage.EmailConfiguration.Body, emailRequestMessage.EmailConfiguration.TemplateTokens);

                if (emailRequestMessage.EmailMessage.Attachments != null)
                {
                    message.Attachments = emailRequestMessage.EmailMessage.Attachments;
                }
            };

            return await Task.FromResult(message);
        }

        private string ReplaceTagsWithValues(string body, List<ObjectField> lstOfTokenAndValues)
        {
            foreach (ObjectField item in lstOfTokenAndValues)
            {
                body = body.Replace("{" + item.Name + "}", item.Value);
            }
            return body;
        }
    }

    public class EmailRequestMessage
    {
        public EmailMessage EmailMessage { get; set; }

        public EmailConfiguration EmailConfiguration { get; set; }
    }

    public class EmailResponse
    {
        public System.Net.HttpStatusCode StatusCode { get; set; }

        public bool IsMailSent { get; set; }

        public string MessageId { get; set; }

        public string EmailProvider { get; set; }

        public EmailMessage EmailMessageInfo { get; set; }

    }

    public enum EmailProviderEnum
    {
        Azure,
        SendGrid,
        SMTP
    }

    public class EmailConfiguration
    {
        public string Subject { get; set; }

        public string Body { get; set; }

        public List<ObjectField> TemplateTokens { get; set; }
    }

    public class ObjectField
    {
        public string Name { get; set; }
        public string Value { get; set; }
    }
}
