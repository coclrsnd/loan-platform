using System.Threading.Tasks;

namespace Loan.Platform.Common.EmailService
{
    public interface IEmailService
    {
        /// <summary>
        /// Sends email to user prepared in EmailRequestMessage object.
        /// </summary>
        /// <returns>EmailResponse Object</returns>
        Task<EmailResponse> SendNotification(EmailRequestMessage emailRequestMessage);
    }
}
