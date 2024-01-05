using StandardRail.RailCarLounge.Models.Entities;
using StandardRail.RailCarLounge.Models.ViewModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace StandardRail.RailCarLounge.Business.Pact
{
    public interface IContractNoteMappingService
    {
        Task<NoteViewModel> SaveContractNoteMappingAsync(NoteViewModel noteViewModel);

        Task<IList<NoteViewModel>> GetNotesByContractId(long Id);
    }
}
