using System.Collections.Generic;

namespace Loan.Platform.Models.FreightRailModels
{
    public class GeocodeSingleSearchResponse
    {
        public int Err { get; set; }
        public string ErrString { get; set; }
        public int QueryConfidence { get; set; }
        public int TimeInMilliseconds { get; set; }
        public string GridDataVersion { get; set; }
        public string CommitID { get; set; }
        public List<Location> Locations { get; set; }
    }

    public class Location
    {
        public Address Address { get; set; }
        public Coords Coords { get; set; }
        public int Region { get; set; }
        public int POITypeID { get; set; }
        public int PersistentPOIID { get; set; }
        public int SiteID { get; set; }
        public int ResultType { get; set; }
        public string ShortString { get; set; }
        public string TimeZone { get; set; }
    }

    public class Address
    {
        public string StreetAddress { get; set; }
        public string City { get; set; }
        public string State { get; set; }
        public string StateName { get; set; }
        public string Zip { get; set; }
        public string County { get; set; }
        public string Country { get; set; }
        public string CountryFullName { get; set; }
        public object SPLC { get; set; }
    }

    public class Coords
    {
        public string Lat { get; set; }
        public string Lon { get; set; }
    }

    public class SingleSearchRequest
    {
       public FieldQuery Query { get; set; }

        public int MaxResults { get; set; }

        public string IncludeOnly { get; set; }

        public string Country { get; set; }

        public string States { get; set; }

    }

    public class FieldQuery
    {
        public string Field { get; set; }
        public string Value { get; set; }
    }
}
