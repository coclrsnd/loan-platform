using System;
using System.Globalization;
using System.Runtime.Serialization;

namespace Loan.Platform.Business.Helpers
{
    /// <summary>
    /// App Exception class for throwing application specific exceptions 
    /// </summary>
    [Serializable]
    public class AppException : Exception
    {
        public AppException(string message, params object[] args)
            : base(String.Format(CultureInfo.CurrentCulture, message, args))
        {
        }

        public AppException() : base() { }

        protected AppException(SerializationInfo serializationInfo, StreamingContext streamingContext)
            : base(serializationInfo, streamingContext)
        { }

        public AppException(string message)
            : base(message)
        { }

        public AppException(string message, Exception innerException)
            : base(message, innerException)
        { }
    }
}
