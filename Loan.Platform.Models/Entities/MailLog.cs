using System;

namespace Loan.Platform.Models.Entities
{
    public class MailLog : EntityBase
    {
        public long Id { get; set; }

        public string ToMail { get; set; }

        public string CCMail { get; set; }

        public string BCCMail { get; set; }

        public string Subject { get; set; }

        public string Status { get; set; }

        public string EmailProvider { get; set; }
        
        public string MessageId { get; set; }

        public string ErrorMsg { get; set; }

    }
}
