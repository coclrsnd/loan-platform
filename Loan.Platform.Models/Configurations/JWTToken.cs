namespace Loan.Platform.Models.Configurations
{
    /// <summary>
    /// Hold information of JWT token configuration
    /// </summary>
    public class JWTToken
    {
        public string ValidAudience { get; set; }

        public string ValidIssuer { get; set; }

        public string Secret { get; set; }

        public string EncryptSecret { get; set; }
    }
}
