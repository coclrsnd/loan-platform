using System;
using System.Collections.Generic;
using Loan.Platform.Common.EmailService;

namespace Loan.Platform.Models.Shared
{
    public class EmailMessage
    {
        public Guid Id { get; set; }

        public string DisplayName { get; set; }

        public string Recipients { get; set; }

        public string CcRecipients { get; set; }

        public string BccRecipients { get; set; }

        public string ReplyTo { get; set; }

        public string Subject { get; set; }

        public string MessageBody { get; set; }

        public List<EmailAttachment> Attachments { get; set; }
    }
}