using System.Collections.Generic;
using System;
using System.Net;
using System.Linq;

namespace Loan.Platform.Common.EmailService
{
    public static class EmailHelper
    {
        public static EmailResponse PrepareEmailResponse(HttpStatusCode statusCode, string MessageId, EmailProviderEnum emailProviderEnum)
        {
            var emailResponse = new EmailResponse();

            if (statusCode == HttpStatusCode.Accepted)
            {
                emailResponse.IsMailSent = true;
            }
            else
            {
                emailResponse.IsMailSent = false;
            }

            emailResponse.EmailMessageInfo = null;
            emailResponse.StatusCode = statusCode;
            emailResponse.MessageId = MessageId;
            emailResponse.EmailProvider = emailProviderEnum.ToString();

            return emailResponse;
        }

        public static string[] GetBCCRecipients(string[] recipients, string[] ccRecipients, string[] bccRecipient)
        {
            List<string> listOfRecipients = new List<string>();
            if (recipients != null && recipients.Length > 0)
            {
                listOfRecipients.AddRange(recipients);
            }
            if (ccRecipients != null && ccRecipients.Length > 0)
            {
                listOfRecipients.AddRange(ccRecipients);
            }
            var listOfBccNotExistinCCRecipientList = bccRecipient.Except(listOfRecipients, StringComparer.OrdinalIgnoreCase);
            return  listOfBccNotExistinCCRecipientList.ToArray();
        }
    }   
}
