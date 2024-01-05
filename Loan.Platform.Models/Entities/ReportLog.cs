using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace StandardRail.RailCarLounge.Models.Entities
{
    public class ReportLog
    {
        public long Id { get; set; }

        public long CustomerId { get; set; }

        public long ContractId { get; set; }

        public long ContractTypeId { get; set; }

        public bool Status { get; set; }

        public string ReportURL { get; set; }

        public DateTime FromDate { get; set; }

        public DateTime? ToDate { get; set; }

        public string ErrorMsg { get; set; }

        public DateTime CreatedTime { get; set; }

        public long CreatedBy { get; set; }

        public DateTime ModifiedTime { get; set; }

        public long ModifiedBy { get; set; }

        [DefaultValue(0)]
        public long OrganizationId { get; set; }

        [DefaultValue(0)]
        public long TenantId { get; set; }
    }
}
