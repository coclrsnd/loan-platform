namespace Loan.Platform.Models.CustomModels
{
    /// <summary>
    /// Holds information related to JWT token.
    /// </summary>
    public class JWTToken
    {
        /// <summary>
        /// This identifies the recipients that the JWT is intended for.
        /// </summary>
        public string Audience { get; set; }

        /// <summary>
        /// This identifies provider that issued the JWT.
        /// </summary>
        public string Issuer { get; set; }

        /// <summary>
        /// This is a SECRET key that both the issuer and audience have to have.
        /// </summary>
        public string Secret { get; set; }
    }
}
