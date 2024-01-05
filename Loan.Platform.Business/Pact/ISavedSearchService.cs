using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using StandardRail.RailCarLounge.Models.Entities;
using StandardRail.RailCarLounge.Models.ViewModels;

namespace StandardRail.RailCarLounge.Business.Pact
{
    /// <summary>
    /// Interface to perform action related to Save Search functionality.
    /// </summary>
    public interface ISavedSearchService
    {
        Task<SavedSearch> SaveSearch(SavedSearchViewModel savedSearch);

        Task<List<SavedSearchViewModel>> GetAllSavedSearch();

        Task<List<SavedSearchViewModel>> GetSavedSearchForDashboard();
    }
}
