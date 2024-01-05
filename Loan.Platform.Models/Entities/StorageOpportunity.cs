using System;
using Microsoft.EntityFrameworkCore;

namespace StandardRail.RailCarLounge.Models.Entities
{
    public class StorageOpportunity : EntityBase
    {
        public long Id { get; set; }

        public string BookingId { get; set; }

        public long UserId { get; set; }

        public string Email { get; set; }

        public long CustomerId { get; set; }

        public long VendorId { get; set; }

        public long StorageId { get; set; }

        public string StorageName { get; set; }

        [Precision(18, 2)]
        public decimal? DailyStorageRate { get; set; }

        public DateTime BookingDate { get; set; }
    }
}