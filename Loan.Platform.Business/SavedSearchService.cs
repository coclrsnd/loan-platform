using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using AutoMapper;
using StandardRail.RailCarLounge.Business.Pact;
using StandardRail.RailCarLounge.Data.SqlServer.Pact;
using StandardRail.RailCarLounge.Models.Entities;
using StandardRail.RailCarLounge.Models.ViewModels;

namespace StandardRail.RailCarLounge.Business
{
    public class SavedSearchService : ISavedSearchService
    {
        private readonly IRepository<SavedSearch, long> _repository;
        private readonly IMapper _mapper;

        public SavedSearchService(IRepository<SavedSearch,long> repository, IMapper mapper)
        {
            this._repository = repository ?? throw new ArgumentNullException(nameof(repository));
            this._mapper = mapper ?? throw new ArgumentNullException(nameof(mapper));
        }

        public async Task<List<SavedSearchViewModel>> GetAllSavedSearch()
        {
            var savedSearches =(await _repository.GetAll()).ToList();
            return MapSavedSearchViewModel(savedSearches);
        }

        public async Task<List<SavedSearchViewModel>> GetSavedSearchForDashboard()
        {
            var savedSearches = (await _repository.GetAll()).OrderByDescending(o=>o.LastRun).Take(5).ToList();
            return MapSavedSearchViewModel(savedSearches);
        }

        public Task<SavedSearch> SaveSearch(SavedSearchViewModel savedSearch)
        {
            var savedSearchEntity = this._mapper.Map<SavedSearch>(savedSearch);
            return _repository.Create(savedSearchEntity);
        }

        private List<SavedSearchViewModel> MapSavedSearchViewModel(List<SavedSearch> savedSearches)
        {
            List<SavedSearchViewModel> savedSearchList = new List<SavedSearchViewModel>();
            if (savedSearches != null && savedSearches.Count > 0)
            {
                foreach (SavedSearch search in savedSearches)
                {
                    SavedSearchViewModel savedSearchViewModel = new SavedSearchViewModel();
                    savedSearchViewModel = _mapper.Map<SavedSearchViewModel>(search);
                    savedSearchList.Add(savedSearchViewModel);
                }
            }
            return savedSearchList;
        }
    }
}
