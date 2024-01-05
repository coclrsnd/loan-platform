using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Loan.Platform.Models.ViewModels
{
    public class AuditLogFilterViewModel
    {
        public long ContractId { get; set; }

        public PaginationModel Pagination { get; set; }

        public SortingModel Sorting { get; set; }

        public List<AuditLogViewModel> AuditLogModel { get; set; }
    }
}
