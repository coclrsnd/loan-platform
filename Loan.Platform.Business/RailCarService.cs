using System;
using System.Collections.Generic;
using System.Linq;
using System.Text.RegularExpressions;
using System.Threading.Tasks;
using AutoMapper;
using Microsoft.EntityFrameworkCore;
using StandardRail.RailCarLounge.Business.Pact;
using StandardRail.RailCarLounge.Data.SqlServer;
using StandardRail.RailCarLounge.Data.SqlServer.Pact;
using StandardRail.RailCarLounge.Models.Entities;
using StandardRail.RailCarLounge.Models.ViewModels;

namespace StandardRail.RailCarLounge.Business
{
    public class RailCarService : IRailCarService
    {
        private readonly IRepository<RailCarViewModel, long> _adoRepository;
        private readonly IRepository<RailCar, long> _repository;
        private readonly IMapper _mapper;
        private readonly RailCarLoungeContext _railCarLoungeContext;
        
        public RailCarService(IRepository<RailCar, long> repository, IMapper mapper, IRepository<RailCarViewModel, long> adoRepository, RailCarLoungeContext railCarLoungeContext)
        {
            _repository = repository ?? throw new ArgumentNullException(nameof(repository));
            _mapper = mapper ?? throw new ArgumentNullException(nameof(mapper));
            _adoRepository = adoRepository ?? throw new ArgumentNullException(nameof(adoRepository));
            _railCarLoungeContext = railCarLoungeContext ?? throw new ArgumentNullException(nameof(railCarLoungeContext));
        }

        public async Task<IList<RailCar>> SaveRailCarDetailsForStorageOrder(List<RailCar> railCars)
        {
            var savedRailCars = await _repository.SaveEntities(railCars);
            return savedRailCars;
        }

        public async Task<RailCarViewModel> GetRailCarDetails(RailCarViewModel railCarViewModel)
        {
            if (!string.IsNullOrEmpty(railCarViewModel.CarId))
            {
                var CarIdData = GetCarInitialAndNumber(railCarViewModel.CarId);
                railCarViewModel.CarInitial = CarIdData.Item1.Trim();
                railCarViewModel.CarNumber = CarIdData.Item2.Trim();
            }
            return await _adoRepository.SearchWithPagination(railCarViewModel);
        }

        public Tuple<bool, List<RailCar>> ValidateRailCars(RailCarViewModel railCarViewModel)
        {
            bool isValid = true;
            List<RailCar> railCars = new List<RailCar>();
            List<RailCar> railCarsToSave = new List<RailCar>();
            List<RailCar> AlreadyStoredCars = new List<RailCar>();
            List<RailCar> DuplicateRailCars = new List<RailCar>();
            foreach (var railCar in railCarViewModel.CarIds)
            {
                var railCarData = this._mapper.Map<RailCar>(railCarViewModel);
                var CarIdData = GetCarInitialAndNumber(railCar);
                railCarData.CarInitial = CarIdData.Item1.Trim();
                railCarData.CarNumber = CarIdData.Item2.Trim();
                railCars.Add(railCarData);
            }

            var railcarDistinct = railCars
                     .Select(i => new { i.CarInitial, i.CarNumber })
                     .Distinct()
                     .OrderByDescending(i => i.CarInitial)
                     .ToList();
            if (railcarDistinct.Count != railCarViewModel.CarIds.Count)
            {
                isValid = false;
                railCarViewModel.IsDuplicate = true;
                return new Tuple<bool, List<RailCar>>(isValid, railCarsToSave);
            }

            List<string> CarInitials = new List<string>();
            if (railCars.Any())
            {
                CarInitials = railCars.Select(c => c.CarInitial).ToList();
            }
            List<string> CarNumbers = new List<string>();
            if (railCars.Any())
            {
                CarNumbers = railCars.Select(c => c.CarNumber).ToList();
            }
            var existingRailCarData = from railCar in _railCarLoungeContext.RailCars.AsNoTracking()
                                      where CarInitials.Contains(railCar.CarInitial) && CarNumbers.Contains(railCar.CarNumber) && railCar.IsActive == true
                                      select railCar;


            if (existingRailCarData != null && existingRailCarData.Count() > 0)
            {
                List<long> cardIds = new List<long>();
                cardIds = existingRailCarData.Select(c => c.Id).ToList();

                var existingRailCarMappings = from railCar in _railCarLoungeContext.ContractRailCarMappings.AsNoTracking()
                                              where cardIds.Contains(railCar.RailCarId) /*&& railCar.IsUnderStorage == true*/ && railCar.IsActive == true
                                              select railCar;



                if (existingRailCarMappings != null && existingRailCarMappings.Count() > 0)
                {
                    //validation for duplicate cars in same contract
                    var existingRailCarMappingsForSameContract = existingRailCarMappings.Where(s => s.ContractId == railCarViewModel.ContractId && s.DepartureDate == null).ToList();
                    if (existingRailCarMappingsForSameContract != null && existingRailCarMappingsForSameContract.Count() > 0)
                    {
                        isValid = false;
                        List<long> duplicateRailCarIds = new List<long>();
                        duplicateRailCarIds = existingRailCarMappingsForSameContract.Select(c => c.RailCarId).ToList();
                        var duplicateRailCars = from railCar in existingRailCarData
                                                where duplicateRailCarIds.Contains(railCar.Id)
                                                select railCar;
                        duplicateRailCars = duplicateRailCars.Distinct();
                        DuplicateRailCars.AddRange(duplicateRailCars);
                        railCarViewModel.IsDuplicate = true;
                        return new Tuple<bool, List<RailCar>>(isValid, DuplicateRailCars);
                    }
                    //validation for already stored cars 
                    var existingRailCarMappingsUnderStorage = existingRailCarMappings.Where(s => s.IsUnderStorage == true).ToList();
                    if (existingRailCarMappingsUnderStorage != null && existingRailCarMappingsUnderStorage.Count() > 0)
                    {
                        isValid = false;
                        List<long> existingRailCarIds = new List<long>();
                        existingRailCarIds = existingRailCarMappingsUnderStorage.Select(c => c.RailCarId).ToList();

                        var invalidRailCars = from railCar in existingRailCarData
                                              where existingRailCarIds.Contains(railCar.Id)
                                              select railCar;

                        invalidRailCars = invalidRailCars.Distinct();
                        AlreadyStoredCars.AddRange(invalidRailCars);
                        railCarViewModel.IsDuplicate = false;
                        return new Tuple<bool, List<RailCar>>(isValid, AlreadyStoredCars);
                    }
                }
                railCarsToSave.AddRange(existingRailCarData);
                foreach (var existingRailCar in existingRailCarData)
                {
                    railCars.RemoveAll(r => r.CarInitial == existingRailCar.CarInitial && r.CarNumber == existingRailCar.CarNumber);
                }
                railCarsToSave.AddRange(railCars);
            }
            else
            {
                railCarsToSave = railCars;
            }
            return new Tuple<bool, List<RailCar>>(isValid, railCarsToSave);
        }
        public async Task<IList<RailCarViewModel>> GetRailCarDetailsByContractId(long Id)
        {
            return await _adoRepository.GetListById(Id);
        }

        private Tuple<string, string> GetCarInitialAndNumber(string CarID)
        {
            Regex re = new Regex(@"(^[a-zA-Z]{2,4})\s?\-?((\d){1,6}$)");
            Match result = re.Match(CarID);
            string carInitial = result.Groups[1].Value;
            string carNumber = CarID!="" && result.Groups[2].Value!=""? result.Groups[2].Value: "-1";
            if (!carNumber.Equals("-1"))
            {
                carNumber = (carNumber.Length < 6 ? new string('0', 6 - carNumber.Length) : string.Empty) + carNumber;
            }
            return new Tuple<string, string>(carInitial.ToUpper(), carNumber);
        }
    }
}
