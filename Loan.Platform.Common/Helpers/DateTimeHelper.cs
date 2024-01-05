using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Loan.Platform.Common.Helpers
{
    /// <summary>
    /// Contains all common method which is used for converting datetime
    /// </summary>
    public static class DateTimeHelper
    {
        public static string ToDateTimeFormat(this object inputDate)
        {
            if (inputDate!=null && !string.IsNullOrEmpty(inputDate.ToString()))
            {
                return Convert.ToDateTime(inputDate).ToString("MM/dd/yyyy hh:mm:ss");
            }
            return string.Empty;
        }

        public static DateTime ToDefaultTimeZone(this DateTime dateTime, string defaultTimeZone)
        {
            long totalOffset = 0; 
               
            TimeZoneInfo tzInfo = GetTimeZoneDetailById(defaultTimeZone);

            // with TZConversion
            if (tzInfo != null)
            {
                totalOffset = GetSecondsOffsetDetailByTimezone(tzInfo);
            }
            return dateTime.AddSeconds(totalOffset);
        }

        private static TimeZoneInfo GetTimeZoneDetailById(string currentTimeZoneId)
        {
            try
            {
                return TimeZoneInfo.FindSystemTimeZoneById(currentTimeZoneId);
            }
            catch (Exception)
            {
            }
            return null;
        }

        private static Int64 GetSecondsOffsetDetailByTimezone(TimeZoneInfo tzInfo)
        {
            if (tzInfo == null)
                return 0;

            if (tzInfo.IsDaylightSavingTime(DateTime.Now))
            {
                var ruleAdjDetail = tzInfo.GetAdjustmentRules();
                return (Int64)tzInfo.BaseUtcOffset.TotalSeconds + (ruleAdjDetail == null ? 0 : (Int64)ruleAdjDetail[0].DaylightDelta.TotalSeconds);
            }
            else
            {
                return (Int64)tzInfo.BaseUtcOffset.TotalSeconds;
            }
        }
    }
}
