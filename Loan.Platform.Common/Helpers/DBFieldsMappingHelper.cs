using System;
using System.Data;

namespace Loan.Platform.Common.Helpers
{
    /// <summary>
    /// Contains all common method which is used for Databinding from DataTable.
    /// </summary>
    public class DBFieldsMappingHelper
    {
        public static long? GetNullableInt64Value(DataRow row, string colName)
        {
            if (row[colName] != DBNull.Value)
            {
                return Convert.ToInt64(row[colName]);
            }
            else
            {
                return null;
            }
        }

        public static int? GetNullableIntValue(DataRow row, string colName)
        {
            if (row[colName] != DBNull.Value)
            {
                return Convert.ToInt32(row[colName]);
            }
            else
            {
                return null;
            }
        }

        public static decimal? GetNullableDecimalValue(DataRow row, string colName)
        {
            if (row[colName] != DBNull.Value)
            {
                return Convert.ToDecimal(row[colName]);
            }
            else
            {
                return null;
            }
        }
    }
}
