using AutoMapper;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;
using StandardRail.RailCarLounge.Business.Pact;
using StandardRail.RailCarLounge.Data.SqlServer;
using StandardRail.RailCarLounge.Models.Entities;
using StandardRail.RailCarLounge.Models.ViewModels;
using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Threading.Tasks;

namespace StandardRail.RailCarLounge.Rest.Controllers
{
    /// <summary>
    /// RailCar Controller.
    /// </summary>
    /// 
    [Route("api/[controller]")]
    [ApiController]
    [Authorize]
    public class RailCarController : ControllerBase
    {
        private readonly IRailCarService _railCarService;
        private readonly IContractRailCarMappingService _contractRailCarMappingService;
        private readonly IContractRailCarChargeService _contractRailCarChargeService;
        private readonly IContractService _contractService;
        private readonly IMapper _mapper;
        private readonly RailCarLoungeContext _railCarLoungeContext;
        private readonly ILogger<RailCarController> _logger;

        /// <summary>
        /// Parameterized Constructor of RailCar Controller.
        /// </summary>
        /// <param name="railCarService">IRailCarService</param>
        /// <param name="contractRailCarMappingService">IContractRailCarMappingService</param>
        /// <param name="contractService">IContractService</param>
        /// <param name="mapper">IMapper</param>
        /// <param name="railCarLoungeContext">RailCarLoungeContext</param>
        public RailCarController(IRailCarService railCarService, IContractRailCarMappingService contractRailCarMappingService,
            IContractService contractService, IMapper mapper, RailCarLoungeContext railCarLoungeContext, ILogger<RailCarController> logger,
            IContractRailCarChargeService contractRailCarChargeService)
        {
            _railCarService = railCarService ?? throw new ArgumentNullException(nameof(railCarService));
            _contractRailCarMappingService = contractRailCarMappingService ?? throw new ArgumentNullException(nameof(contractRailCarMappingService));
            _contractService = contractService ?? throw new ArgumentNullException(nameof(contractService));
            _mapper = mapper ?? throw new ArgumentNullException(nameof(mapper));
            _railCarLoungeContext = railCarLoungeContext ?? throw new ArgumentNullException(nameof(railCarLoungeContext));
            _logger = logger ?? throw new ArgumentNullException(nameof(logger));
            _contractRailCarChargeService = contractRailCarChargeService;
        }

        /// <summary>
        /// Endpoint to SaveRailCarDetailsForStorageOrder.
        /// </summary>
        /// <param name="railCarViewModel">RailCarViewModel</param>
        /// <returns>RailCarViewModel</returns>
        [HttpPost]
        [Route("SaveRailCarDetailsForStorageOrder", Name = "SaveRailCarDetailsForStorageOrder")]
        public async Task<ActionResult<RailCarViewModel>> SaveRailCarDetailsForStorageOrder(RailCarViewModel railCarViewModel)
        {
            try
            {
                int carStored = 0;
                List<string> inValidRailCars = new List<string>();
                if ((!string.IsNullOrEmpty(railCarViewModel.ArrivalDate) && DateTime.Parse(railCarViewModel.ArrivalDate, CultureInfo.InvariantCulture) <= DateTime.Now.Date) && (railCarViewModel.DepartureDate == null || DateTime.Parse(railCarViewModel.DepartureDate, CultureInfo.InvariantCulture) >= DateTime.Now.Date) && !railCarViewModel.IsUnderStorage)
                {
                    railCarViewModel.IsUnderStorage = true;
                }
                else if (((!string.IsNullOrEmpty(railCarViewModel.DepartureDate) && DateTime.Parse(railCarViewModel.DepartureDate, CultureInfo.InvariantCulture) < DateTime.Now.Date) || (!string.IsNullOrEmpty(railCarViewModel.ArrivalDate) && DateTime.Parse(railCarViewModel.ArrivalDate, CultureInfo.InvariantCulture) > DateTime.Now.Date)) && railCarViewModel.IsUnderStorage)
                {
                    railCarViewModel.IsUnderStorage = false;
                }
                railCarViewModel.CarIds = railCarViewModel.CarIds.Distinct().ToList();
                var result = _railCarService.ValidateRailCars(railCarViewModel);
                if (result.Item1)
                {
                    List<RailCar> AllRailCars = new List<RailCar>();
                    var validCars = result.Item2;
                    if (validCars.Where(s => s.Id > 0).Any())
                    {
                        AllRailCars.AddRange(validCars.Where(s => s.Id > 0));
                    }
                    var carsToSave = validCars.Where(s => s.Id == 0);
                    if (carsToSave != null && carsToSave.Count() > 0)
                    {
                        var savedRailCars = await _railCarService.SaveRailCarDetailsForStorageOrder(carsToSave.ToList());
                        if (savedRailCars != null && savedRailCars.Count() > 0)
                        {
                            AllRailCars.AddRange(savedRailCars);
                        }
                    }
                    List<ContractRailCarMapping> contractRailCarMappings = new List<ContractRailCarMapping>();
                    foreach (var railCar in AllRailCars)
                    {
                        ContractRailCarMapping railCarViewModelForContractMapping = new ContractRailCarMapping();
                        railCarViewModelForContractMapping = this._mapper.Map<ContractRailCarMapping>(railCarViewModel);
                        railCarViewModelForContractMapping.RailCarId = railCar.Id;
                        railCarViewModelForContractMapping.CarInitial = railCar.CarInitial;
                        railCarViewModelForContractMapping.CarNumber = railCar.CarNumber;
                        contractRailCarMappings.Add(railCarViewModelForContractMapping);
                    }
                    if (contractRailCarMappings != null && contractRailCarMappings.Any())
                    {
                        var savedContractRailCarMappings = await this._contractRailCarMappingService.SaveContractRailCarMappingAsync(contractRailCarMappings);
                        if (savedContractRailCarMappings != null && savedContractRailCarMappings.Count() > 0)
                        {
                            railCarViewModel.IsSaved = true;
                            if (railCarViewModel.IsUnderStorage)
                            {
                                carStored = contractRailCarMappings.Count();
                            }
                        }
                    }

                    // Save Contract Rail Car Charges
                    List<ContractRailCarCharges> contractRailCarChargeList = new List<ContractRailCarCharges>();
                    foreach (var railCar in AllRailCars)
                    {
                        foreach (var railCarCharge in railCarViewModel.ContractRailCarCharge)
                        {
                            if (railCarCharge.Amount != null && railCarCharge.Date != null)
                            {
                                ContractRailCarCharges contractRailCarChargeEntity = new ContractRailCarCharges();
                                contractRailCarChargeEntity = this._mapper.Map<ContractRailCarCharges>(railCarCharge);
                                contractRailCarChargeEntity.ContractRailCarMappingId =
                                    contractRailCarMappings.FirstOrDefault(t => t.RailCarId == railCar.Id &&
                                t.CarInitial == railCar.CarInitial && t.CarNumber == railCar.CarNumber).Id;
                                contractRailCarChargeList.Add(contractRailCarChargeEntity);
                            }
                        }
                    }
                    if (contractRailCarChargeList != null && contractRailCarChargeList.Any())
                    {
                        await this._contractRailCarChargeService.SaveContractRailCarChargeDetail(contractRailCarChargeList);
                    }
                }
                else
                {
                    railCarViewModel.IsSaved = false;
                    var invalidCars = result.Item2;
                    foreach (var invalidCar in invalidCars)
                    {
                        inValidRailCars.Add(invalidCar.CarInitial + invalidCar.CarNumber);
                        railCarViewModel.InvalidCars = inValidRailCars;
                    }
                }
                if (carStored > 0)
                {

                    await _contractService.UpdateStorageOrderForCarsStored(railCarViewModel.ContractId, carStored);
                }
                return railCarViewModel;
            }
            catch (Exception ex)
            {
                _logger.LogError("Error in SaveRailCarDetailsForStorageOrder - " + ex.Message);
                return BadRequest();
            }
        }

        /// <summary>
        /// Endpoint to UpdateRailCarDetailsForStorageOrder.
        /// </summary>
        /// <param name="railCarViewModel">RailCarViewModel</param>
        /// <returns>RailCarViewModel</returns>
        [HttpPost]
        [Route("UpdateRailCarDetailsForStorageOrder", Name = "UpdateRailCarDetailsForStorageOrder")]
        public async Task<ActionResult<RailCarViewModel>> UpdateRailCarDetailsForStorageOrder(RailCarViewModel railCarViewModel)
        {
            try
            {
                if (railCarViewModel != null && railCarViewModel.RailCarId > 0)
                {
                    int carStored = 0;
                    bool isCarAlreadyStored = false;

                    var existingRailCarMappings = _railCarLoungeContext.ContractRailCarMappings.AsNoTracking().Where(s => s.RailCarId == railCarViewModel.RailCarId && s.IsActive == true && s.IsUnderStorage == true).ToList();
                    if (existingRailCarMappings != null && existingRailCarMappings.Count() > 0)
                    {
                        if (existingRailCarMappings.Any(s => s.ContractId != railCarViewModel.ContractId))
                        {
                            isCarAlreadyStored = true;
                            railCarViewModel.IsSaved = false;
                        }
                    }
                    if (!isCarAlreadyStored)
                    {
                        if (!railCarViewModel.IsUnderStorage &&
                            (!string.IsNullOrEmpty(railCarViewModel.ArrivalDate) &&
                            DateTime.Parse(railCarViewModel.ArrivalDate, CultureInfo.InvariantCulture).Date <= DateTime.Now.Date) &&
                            (railCarViewModel.DepartureDate == null ||
                            DateTime.Parse(railCarViewModel.DepartureDate, CultureInfo.InvariantCulture).Date >= DateTime.Now.Date))
                        {
                            railCarViewModel.IsUnderStorage = true;
                            carStored = 1;
                        }
                        if (railCarViewModel.IsUnderStorage &&
                            (!string.IsNullOrEmpty(railCarViewModel.DepartureDate) &&
                            (DateTime.Parse(railCarViewModel.DepartureDate, CultureInfo.InvariantCulture).Date < DateTime.Now.Date) ||
                            (!string.IsNullOrEmpty(railCarViewModel.ArrivalDate) &&
                            DateTime.Parse(railCarViewModel.ArrivalDate, CultureInfo.InvariantCulture).Date > DateTime.Now.Date)))
                        {
                            railCarViewModel.IsUnderStorage = false;
                            carStored = -1;
                        }
                        await this._contractRailCarMappingService.UpdateContractRailCarMappingAsync(railCarViewModel);
                        railCarViewModel.IsSaved = true;
                    }

                    // Save Contract Rail Car Charges
                    List<ContractRailCarCharges> contractRailCarChargeList = new List<ContractRailCarCharges>();
                    foreach (var railCarCharge in railCarViewModel.ContractRailCarCharge)
                    {
                        if (railCarCharge.Amount != null && railCarCharge.Date != null)
                        {
                            ContractRailCarCharges contractRailCarChargeEntity = new ContractRailCarCharges();
                            contractRailCarChargeEntity = this._mapper.Map<ContractRailCarCharges>(railCarCharge);
                            contractRailCarChargeEntity.ContractRailCarMappingId = railCarViewModel.ContractRailCarMappingId;
                            contractRailCarChargeList.Add(contractRailCarChargeEntity);
                        }
                    }

                    if (contractRailCarChargeList != null && contractRailCarChargeList.Any())
                    {
                        await this._contractRailCarChargeService.SaveContractRailCarChargeDetail(contractRailCarChargeList);
                    }

                    if (railCarViewModel.IsSaved)
                    {
                        if (carStored != 0)
                        {
                            await _contractService.UpdateStorageOrderForCarsStored(railCarViewModel.ContractId, carStored);
                        }
                    }
                }
                return railCarViewModel;
            }
            catch (Exception ex)
            {
                _logger.LogError("Error in UpdateRailCarDetailsForStorageOrder - " + ex.Message);
                return BadRequest();
            }
        }

        /// <summary>
        /// Endpoint to  Get-RailCarDetailsByContractId.
        /// </summary>
        /// <param name="Id">long</param>
        /// <returns>List of RailCarViewModel</returns>
        [HttpGet]
        [Route("GetRailCarDetailsByContractId/{Id}", Name = "GetRailCarDetailsByContractId")]
        public async Task<ActionResult<IList<RailCarViewModel>>> GetRailCarDetailsByContractId(long Id)
        {
            try
            {
                var railCarDetails = await _railCarService.GetRailCarDetailsByContractId(Id);
                return Ok(railCarDetails);
            }
            catch (Exception ex)
            {
                _logger.LogError("Error in GetRailCarDetailsByContractId - " + ex.Message);
                return BadRequest();
            }
        }

        /// <summary>
        /// Endpoint to  Get-RailCarDetails.
        /// </summary>
        /// <param name="railCarViewModel">RailCarViewModel</param>
        /// <returns>RailCarViewModel</returns>
        [HttpPost]
        [Route("GetRailCarDetails", Name = "GetRailCarDetails")]
        public async Task<ActionResult<RailCarViewModel>> GetRailCarDetails(RailCarViewModel railCarViewModel)
        {
            try
            {
                var railCarDetails = await _railCarService.GetRailCarDetails(railCarViewModel);
                return railCarDetails;
            }
            catch (Exception ex)
            {
                _logger.LogError("Error in GetRailCarDetails - " + ex.Message);
                return BadRequest();
            }
        }

    }
}
