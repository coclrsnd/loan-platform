using System;
using System.Net;
using System.Net.Mail;
using System.Text.RegularExpressions;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using Microsoft.Extensions.Configuration;
using Loan.Platform.Models.Shared;

namespace Loan.Platform.Common.EmailService
{
    public class SMTPEmailService : IEmailProvider
    {
        private static readonly char[] _separator = new char[] { ',', ';' };

        public IConfiguration Configuration { get; }

        public SMTPEmailService(IConfiguration configuration)
        {
            Configuration = configuration ?? throw new ArgumentNullException(nameof(configuration));
        }

        public void SendEmail(EmailMessage emailMessage)
        {
            var message = new MailMessage();
            var subject = Regex.Replace(emailMessage.Subject, @"\\[abtrvfnexcu]", " ").Trim();

            message.Subject = subject.Length > 250 ? subject.Substring(0, 249) : subject;
            var senderEmail = Configuration["MailSettings:SenderEmail"];
            var senderPassword = Configuration["MailSettings:SenderPassword"];
            var senderDisplayName = Configuration["MailSettings:DisplayName"];
            message.From = message.From = !string.IsNullOrWhiteSpace(senderDisplayName) ? new MailAddress(senderEmail, senderDisplayName) : new MailAddress(senderEmail);
            message.Body = emailMessage.MessageBody;
            var recipientList = emailMessage.Recipients.Split(_separator);

            foreach (var recipient in recipientList)
            {
                message.To.Add(new MailAddress(recipient));
            }

            if (!string.IsNullOrWhiteSpace(emailMessage.CcRecipients))
            {
                var ccrecipientList = emailMessage.CcRecipients.Split(_separator);
                foreach (var recipient in ccrecipientList)
                {
                    message.CC.Add(new MailAddress(recipient));
                }
            }

            if (!string.IsNullOrWhiteSpace(emailMessage.BccRecipients))
            {
                var bccrecipientList = emailMessage.BccRecipients.Split(_separator);
                foreach (var recipient in bccrecipientList)
                {
                    message.Bcc.Add(new MailAddress(recipient));
                }
            }

            using (SmtpClient client = new SmtpClient()
            {
                PickupDirectoryLocation = @"C:\Emails",
                Host = "smtp.office365.com",
                Port = 587,
                UseDefaultCredentials = false,
                DeliveryMethod = SmtpDeliveryMethod.SpecifiedPickupDirectory,
                Credentials = new NetworkCredential(senderEmail, senderPassword), // you must give a full email address for authentication 
                //TargetName = "STARTTLS/smtp.office365.com", // Set to avoid MustIssueStartTlsFirst exception
                EnableSsl = true // Set to avoid secure connection exception
            })
            {
                client.Send(message);
            }
        }

        public async Task<EmailResponse> SendEmailAsync(EmailMessage emailMessage)
        {
            var message = new MailMessage();
            var subject = Regex.Replace(emailMessage.Subject, @"\\[abtrvfnexcu]", " ").Trim();

            message.Subject = subject.Length > 250 ? subject.Substring(0, 249) : subject;
            var senderEmail = Configuration["EmailConfig:SenderEmail"];
            var senderPassword = Configuration["EmailConfig:SenderPassword"];
            var senderDisplayName = Configuration["EmailConfig:DisplayName"];
            message.From = message.From = !string.IsNullOrWhiteSpace(senderDisplayName) ? new MailAddress(senderEmail, senderDisplayName) : new MailAddress(senderEmail);
            message.Body = emailMessage.MessageBody;
            message.IsBodyHtml = true;
            var recipientList = emailMessage.Recipients.Split(_separator);

            foreach (var recipient in recipientList)
            {
                message.To.Add(new MailAddress(recipient));
            }

            if (!string.IsNullOrWhiteSpace(emailMessage.CcRecipients))
            {
                var ccrecipientList = emailMessage.CcRecipients.Split(_separator);
                foreach (var recipient in ccrecipientList)
                {
                    message.CC.Add(new MailAddress(recipient));
                }
            }

            if (!string.IsNullOrWhiteSpace(emailMessage.BccRecipients))
            {
                var bccrecipientList = emailMessage.BccRecipients.Split(_separator);
                foreach (var recipient in bccrecipientList)
                {
                    message.Bcc.Add(new MailAddress(recipient));
                }
            }
            try
            {
                using (SmtpClient client = new SmtpClient()
                {
                    Host = "smtp.gmail.com",
                    Port = 587,
                    UseDefaultCredentials = false,
                    EnableSsl = true,
                    Credentials = new NetworkCredential(senderEmail, senderPassword),
                })
                {
                    await client.SendMailAsync(message);
                }
            }
            catch(Exception ex)
            {
                
            }
           
            var emailResponse = EmailHelper.PrepareEmailResponse(HttpStatusCode.OK, Guid.NewGuid().ToString(), EmailProviderEnum.SMTP);
            return emailResponse;
        }

        public Task<bool> SendNotification(EmailRequestMessage emailRequestMessage)
        {
            throw new System.NotImplementedException();
        }
    }
}
