using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;
using System.Threading.Tasks;
using System.Web;
using Microsoft.Extensions.Configuration;
using Loan.Platform.Business.Pact;
using Loan.Platform.Common.EmailService;
using Loan.Platform.Common.StorageAccountHelper.BlobHelper;
using Loan.Platform.Common.UserContext;
using Loan.Platform.Data.SqlServer.Pact;
using Loan.Platform.Models.Accounts;
using Loan.Platform.Models.Entities;
using Loan.Platform.Models.ViewModels;
using DateTime = System.DateTime;

namespace Loan.Platform.Business
{
    /// <summary>
    /// Contains Common logic which can be used from different services.
    /// </summary>
    public class CommonService : ICommonService
    {
        private readonly IRepository<MailConfiguration, long> _mailConfigurationRepository;
        private readonly IRepository<User, long> _userRepository;
        private readonly IRepository<SignUpUser, long> _signUpUserRepository;
        private readonly IRepository<MailLog, long> _mailLogRepository;
        private readonly IAzureBlobService _azureBlobService;

        private readonly IEmailService _emailService;
        private IConfiguration _configuration;
        private readonly IUserContext _userContext;
        private long? OrganizationId;
        public CommonService( IUserContext userContext,
             IRepository<MailConfiguration, long> mailConfigurationRepository, IEmailService emailService, IRepository<User, long> userRepository, IConfiguration configuration, IRepository<SignUpUser, long> signUpUserRepository, IRepository<MailLog, long> mailLogRepository, IAzureBlobService azureBlobService)
        {            
            _userContext = userContext ?? throw new ArgumentNullException(nameof(userContext));
            OrganizationId = userContext.OrganizationId;
            _mailConfigurationRepository = mailConfigurationRepository ?? throw new ArgumentNullException(nameof(mailConfigurationRepository));
            _emailService = emailService ?? throw new ArgumentNullException(nameof(emailService));
            _userRepository = userRepository ?? throw new ArgumentNullException(nameof(userRepository));
            _configuration = configuration ?? throw new ArgumentNullException(nameof(configuration));
            _signUpUserRepository = signUpUserRepository ?? throw new ArgumentNullException(nameof(configuration));
            _mailLogRepository = mailLogRepository ?? throw new ArgumentNullException(nameof(mailLogRepository));
            _azureBlobService = azureBlobService ?? throw new ArgumentNullException(nameof(azureBlobService));
        }
        /// <inheritdoc cref="Loan.Platform.Business.Pact.ICommonService"/>
        public async Task<bool> SendVerificationEmailAsync(SignUpUser user, string origin)
        {
            string verifyUrl;
            if (!string.IsNullOrEmpty(origin))
            {
                // origin exists if request sent from browser single page app (e.g. Angular)
                // so send link to verify via single page app
                verifyUrl = $"{origin}/verify-email?token={user.VerificationToken}";
            }
            else
            {
                // origin missing if request sent directly to api (e.g. from Postman)
                // so send instructions to verify directly with api
                verifyUrl = $"/verify-email?token={user.VerificationToken}";
            }

            //GetMailConfiguration for email to be sent
            var mailConfiguration = this._mailConfigurationRepository.GetByCondition(t => t.NotificationEvent != null && t.NotificationEvent.Name == "SignUpVerification").Result.FirstOrDefault();
            if (mailConfiguration != null && !string.IsNullOrEmpty(verifyUrl))
            {
                EmailRequestMessage emailRequestMessage = new EmailRequestMessage()
                {
                    EmailMessage = new Models.Shared.EmailMessage()
                    {
                        Recipients = user.EmailId,
                        DisplayName = string.Concat(user.FirstName, " ", user.LastName)
                    },
                    EmailConfiguration = new EmailConfiguration()
                    {
                        Body = mailConfiguration.Body,
                        Subject = mailConfiguration.Subject,
                        TemplateTokens = new List<ObjectField>() {
                            new ObjectField() { Name = "verifyUrl", Value = verifyUrl },
                            new ObjectField() { Name = "userEmail", Value = user.EmailId }
                        }
                    }
                };
                //Send email for sign up.
                var emailResponse = await _emailService.SendNotification(emailRequestMessage);
                await LogMailResponse(emailResponse);
                if (emailResponse.IsMailSent)
                {
                    return true;
                }
            }
            return false;
        }

        /// <inheritdoc cref="Loan.Platform.Business.Pact.ICommonService"/>
        public async Task<bool> SendPasswordResetEmail(SignUpUser account, string origin)
        {
            string resetPasswordURL;
            if (!string.IsNullOrEmpty(origin))
            {
                resetPasswordURL = $"{origin}/reset-password?token={HttpUtility.UrlEncode(account.ResetToken)}";
            }
            else
            {
                resetPasswordURL = $"/reset-password?token={HttpUtility.UrlEncode(account.ResetToken)}";
            }

            //GetMailConfiguration for email to be sent
            var mailConfiguration = this._mailConfigurationRepository.GetByCondition(t => t.NotificationEvent != null && t.NotificationEvent.Name == "PasswordReset").Result.FirstOrDefault();
            if (mailConfiguration != null && !string.IsNullOrEmpty(resetPasswordURL))
            {
                EmailRequestMessage emailRequestMessage = new EmailRequestMessage()
                {
                    EmailMessage = new Models.Shared.EmailMessage()
                    {
                        Recipients = account.EmailId,
                        DisplayName = string.Concat(account.FirstName, " ", account.LastName)
                    },
                    EmailConfiguration = new EmailConfiguration()
                    {
                        Body = mailConfiguration.Body,
                        Subject = mailConfiguration.Subject,
                        TemplateTokens = new List<ObjectField>() { new ObjectField() { Name = "resetPasswordURL", Value = resetPasswordURL },
                        new ObjectField() { Name = "userEmail", Value = account.EmailId }}
                    }
                };
                //Send email for sign up.
                var emailResponse = await _emailService.SendNotification(emailRequestMessage);
                await LogMailResponse(emailResponse);
                if (emailResponse.IsMailSent)
                {
                    return true;
                }
            }
            return false;
        }

        /// <inheritdoc cref="Loan.Platform.Business.Pact.ICommonService"/>
        public async Task<bool> SendAlreadyRegisteredEmail(RegisterRequest user, string origin)
        {
            //GetMailConfiguration for email to be sent
            var mailConfiguration = this._mailConfigurationRepository.GetByCondition(t => t.NotificationEvent != null && t.NotificationEvent.Name == "AlreadySignedUp").Result.FirstOrDefault();
            if (mailConfiguration != null)
            {
                EmailRequestMessage emailRequestMessage = new EmailRequestMessage()
                {
                    EmailMessage = new Models.Shared.EmailMessage()
                    {
                        Recipients = user.EmailId,
                        DisplayName = string.Concat(user.FirstName, " ", user.LastName)
                    },
                    EmailConfiguration = new EmailConfiguration()
                    {
                        Body = mailConfiguration.Body,
                        Subject = mailConfiguration.Subject,
                        TemplateTokens = new List<ObjectField>() {
                            new ObjectField() { Name = "userEmail", Value = user.EmailId },
                        new ObjectField() { Name = "forgotPassword", Value = $"{origin}/forgot-password" },
                        }
                    }
                };
                //Send email for sign up.
                var emailResponse = await _emailService.SendNotification(emailRequestMessage);
                await LogMailResponse(emailResponse);
                if (emailResponse.IsMailSent)
                {
                    return true;
                }
            }
            return false;
        }

        /// <inheritdoc cref="Loan.Platform.Business.Pact.ICommonService"/>
        public async Task<bool> SendUserApprovalRequestEmail(SignUpUser signedUser)
        {
            //GetMailConfiguration for email to be sent
            var mailConfiguration = this._mailConfigurationRepository.GetByCondition(t => t.NotificationEvent != null && t.NotificationEvent.Name == "ApprovalRequest").Result.FirstOrDefault();
            if (mailConfiguration != null && signedUser != null)
            {
                var recipientToEmail = _configuration["EmailConfig:RCLSupport"];
                if (string.IsNullOrEmpty(recipientToEmail))
                {
                    return false;
                }

                EmailRequestMessage emailRequestMessage = new EmailRequestMessage()
                {
                    EmailMessage = new Models.Shared.EmailMessage()
                    {
                        Recipients = recipientToEmail
                    },
                    EmailConfiguration = new EmailConfiguration()
                    {
                        Body = mailConfiguration.Body,
                        Subject = mailConfiguration.Subject,
                        TemplateTokens = new List<ObjectField>() { new ObjectField() { Name = "companyName", Value = signedUser.CompanyName },
                        new ObjectField() { Name = "userEmail", Value = signedUser.EmailId }}
                    }
                };
                //Send email for sign up.
                var emailResponse = await _emailService.SendNotification(emailRequestMessage);
                await LogMailResponse(emailResponse);
                if (emailResponse.IsMailSent)
                {
                    return true;
                }
            }
            return false;
        }

        /// <inheritdoc cref="Loan.Platform.Business.Pact.ICommonService"/>
        public async Task<bool> SendApprovalEmail(SignUpUserViewModel user, string password)
        {
            //GetMailConfiguration for email to be sent
            var mailConfiguration = this._mailConfigurationRepository.GetByCondition(t => t.NotificationEvent != null && t.NotificationEvent.Name == "Approved").Result.FirstOrDefault();
            if (mailConfiguration != null)
            {
                EmailRequestMessage emailRequestMessage = new EmailRequestMessage()
                {
                    EmailMessage = new Models.Shared.EmailMessage()
                    {
                        Recipients = user.EmailId,
                        DisplayName = string.Concat(user.FirstName, " ", user.LastName)
                    },
                    EmailConfiguration = new EmailConfiguration()
                    {
                        Body = mailConfiguration.Body,
                        Subject = mailConfiguration.Subject,
                        TemplateTokens = new List<ObjectField>()
                        {
                            new ObjectField() { Name = "organizationName", Value = user.Organization },
                            new ObjectField() { Name = "userEmail", Value = user.EmailId },
                            new ObjectField() { Name = "password", Value = password }
                        }
                    }
                };
                //Send email for sign up.
                var emailResponse = await _emailService.SendNotification(emailRequestMessage);
                await LogMailResponse(emailResponse);
                if (emailResponse.IsMailSent)
                {
                    return true;
                }
            }
            return false;
        }

        /// <inheritdoc cref="Loan.Platform.Business.Pact.ICommonService"/>
        public async Task<bool> SendRejectionEmail(SignUpUserViewModel user)
        {
            //GetMailConfiguration for email to be sent
            var mailConfiguration = this._mailConfigurationRepository.GetByCondition(t => t.NotificationEvent != null && t.NotificationEvent.Name == "Rejected").Result.FirstOrDefault();
            if (mailConfiguration != null)
            {
                EmailRequestMessage emailRequestMessage = new EmailRequestMessage()
                {
                    EmailMessage = new Models.Shared.EmailMessage()
                    {
                        Recipients = user.EmailId,
                        DisplayName = string.Concat(user.FirstName, " ", user.LastName)
                    },
                    EmailConfiguration = new EmailConfiguration()
                    {
                        Body = mailConfiguration.Body,
                        Subject = mailConfiguration.Subject,
                        TemplateTokens = new List<ObjectField>() { new ObjectField() { Name = "userEmail", Value = user.EmailId } }
                    }
                };
                //Send email for sign up.
                var emailResponse = await _emailService.SendNotification(emailRequestMessage);
                await LogMailResponse(emailResponse);
                if (emailResponse.IsMailSent)
                {
                    return true;
                }
            }
            return false;
        }

        /// <inheritdoc cref="Loan.Platform.Business.Pact.ICommonService"/>
        public async Task<bool> SendStorageOpportunityEmailAsync(User user, OpportunityViewModel opportunity, byte[] opportunitySummary)
        {
            EmailAttachment opportunityAttachment = new EmailAttachment();
            opportunityAttachment.Content = opportunitySummary;
            opportunityAttachment.FileName = _configuration["OpportunityOrderEmailConfig:OpportunityAttachmentFileName"];
            opportunityAttachment.ContentType = _configuration["OpportunityOrderEmailConfig:OpportunityAttachmentContentType"];

            //GetMailConfiguration for email to be sent
            var mailConfiguration = this._mailConfigurationRepository.GetByCondition(t => t.NotificationEvent != null && t.NotificationEvent.Name == "StorageOpportunity").Result.FirstOrDefault();
            if (mailConfiguration != null)
            {
                var recipientToEmail = _configuration["EmailConfig:SalesTo"];
                var recipientCcEmail = _configuration["EmailConfig:SalesCc"];
                if (string.IsNullOrEmpty(recipientToEmail) || string.IsNullOrEmpty(recipientCcEmail))
                {
                    return false;
                }
                EmailRequestMessage emailRequestMessage = new EmailRequestMessage()
                {
                    EmailMessage = new Models.Shared.EmailMessage()
                    {
                        Recipients = recipientToEmail,
                        CcRecipients = recipientCcEmail
                    },
                    EmailConfiguration = new EmailConfiguration()
                    {
                        Body = mailConfiguration.Body,
                        Subject = mailConfiguration.Subject,
                        TemplateTokens = new List<ObjectField>() {

                             new ObjectField()
                            {
                                Name = "bookingID", Value = opportunity.Name
                            },
                            new ObjectField()
                            {
                                Name = "userEmail", Value= user.EmailId
                            },
                            new ObjectField()
                            {
                                Name="organizationName", Value= user.CompanyName
                            },
                            new ObjectField()
                            {
                                Name="storageFacility", Value= opportunity.Name.Split('-')[0]
                            }
                        }
                    }
                };

                //adding attachment summary
                emailRequestMessage.EmailMessage.Attachments = new List<EmailAttachment>();
                emailRequestMessage.EmailMessage.Attachments.Add(opportunityAttachment);

                //Send email for sign up.
                var emailResponse = await _emailService.SendNotification(emailRequestMessage);
                await LogMailResponse(emailResponse);
                if (emailResponse.IsMailSent)
                {
                    return true;
                }
            }
            return false;
        }

        /// <inheritdoc cref="Loan.Platform.Business.Pact.ICommonService"/>
        public string GenerateVerificationToken()
        {
            // token is a cryptographically strong random sequence of values
            var token = Convert.ToHexString(RandomNumberGenerator.GetBytes(64));

            // ensure token is unique by checking against db
            var tokenIsUnique = _userRepository.GetByCondition(x => x.VerificationToken == token).Result.Any();
            if (tokenIsUnique)
                return GenerateVerificationToken();

            return token;
        }

        /// <inheritdoc cref="Loan.Platform.Business.Pact.ICommonService"/>
        public string GenerateLinkWithToken(string url, string token, string origin = null)
        {
            string newUrl;
            if (!string.IsNullOrEmpty(origin))
            {
                // origin exists if request sent from browser single page app (e.g. Angular)
                // so send link to verify via single page app
                newUrl = $"{origin}/{url}?token={token}";
            }
            else
            {
                // origin missing if request sent directly to api (e.g. from Postman)
                // so send instructions to verify directly with api
                newUrl = $"/{url}?token={token}";
            }
            return newUrl;
        }

        /// <inheritdoc cref="Loan.Platform.Business.Pact.ICommonService"/>
        public string GenerateResetToken()
        {
            // token is a cryptographically strong random sequence of values
            var token = Convert.ToHexString(RandomNumberGenerator.GetBytes(64));

            // ensure token is unique by checking against db
            var tokenIsUnique = !_signUpUserRepository.GetByCondition(x => x.ResetToken == token).Result.Any();
            if (!tokenIsUnique)
                return GenerateResetToken();

            return token;
        }

        /// <inheritdoc cref="Loan.Platform.Business.Pact.ICommonService"/>
        public async Task LogMailResponse(EmailResponse emailResponse)
        {
            var mailLog = new MailLog()
            {
                ToMail = emailResponse.EmailMessageInfo.Recipients,
                EmailProvider = emailResponse.EmailProvider,
                Status = emailResponse.StatusCode.ToString(),
                Subject = emailResponse.EmailMessageInfo.Subject,
                CCMail = emailResponse.EmailMessageInfo.CcRecipients,
                BCCMail = emailResponse.EmailMessageInfo.BccRecipients,
                MessageId = emailResponse.MessageId
            };
            mailLog.OrganizationId = _userContext.OrganizationId != null ? _userContext.OrganizationId.Value : 0;
            mailLog.TenantId = _userContext.TenantId != null ? _userContext.TenantId.Value : 0;
            mailLog.CreatedBy = _userContext.UserId != null ? _userContext.UserId.Value : 0;
            mailLog.CreatedTime = DateTime.Now;

            await _mailLogRepository.Create(mailLog);
        }

    }
}
