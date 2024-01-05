using System;

namespace Loan.Platform.Models.ViewModels
{
    public class StorageFacilityBookNowRequestViewModel
    {
        public int StorageFacilityId { get; set; }
        public long UserId { get; set; }
        public DateTime BookingDate { get; set; }
        public int DailyStorageRate { get; set; }
        public int AvailableCars { get; set; }
        public int Capacity { get; set; }
    }
}
