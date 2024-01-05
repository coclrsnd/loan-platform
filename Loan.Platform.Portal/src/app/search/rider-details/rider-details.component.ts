import { ActivatedRoute, Router } from '@angular/router';
import { Component, OnInit, PipeTransform, ViewChild } from '@angular/core';
import { FormBuilder, FormControl, FormGroup, Validators } from '@angular/forms';
import { APP_CONSTANTS } from 'src/app/app-constants';
import { MatAccordion } from '@angular/material/expansion';
import { SelectionModel } from '@angular/cdk/collections';
import { animate, state, style, transition, trigger } from '@angular/animations';
import { MatTableDataSource } from '@angular/material/table';
import { Observable } from 'rxjs/internal/Observable';
import { debounceTime, finalize, map, switchMap, tap } from 'rxjs/operators';
import { of } from 'rxjs/internal/observable/of';
import { VendorService } from '../vendor/vendor-service';
import { CustomerService } from '../customer/customer-service';
import { StorageFacilityModel } from '../storage-facility/StorageFacilityModel';
import { StorageFacilityService } from '../storage-facility/storagefacility-service';
import { StorageFeatureModel } from '../storagefeature/StoragefeatureModel';
import { StorageFeatureService } from '../storagefeature/storagefeature-service';
import { ContractTypeService } from '../contract-type/contracttype-service';
import { CurrencyService } from '../currency/currency-service';
import { RiderModel } from '../rider/RiderModel';
import { RiderService } from '../rider/rider-service';
import { ToastrService } from 'ngx-toastr';
import { Subject } from 'rxjs/internal/Subject';
import { DateValidators, NumValidators } from 'src/app/shared/directives/validatorDate';
import { CurrencyPipe, PercentPipe } from '@angular/common';
import { CustomerModel } from '../customer/CustomerModel';
import { VendorModel } from '../vendor/VendorModel';
import { ApiService } from 'src/app/services/api.service';
import { AuthService } from 'src/app/services/auth.service';
import { SharedService } from 'src/app/shared/shared.service';
import { ConfirmDialogService } from 'src/app/shared/components/confirm-dialog/confirm-dialog.service';
import { ContractRateTypeModel } from 'src/app/shared/models/contractratetype.model';
import { ContractRate } from '../rider/contractrate.model';

@Component({
  selector: 'app-rider-details',
  templateUrl: './rider-details.component.html',
  styleUrls: ['./rider-details.component.scss'],
  animations: [
    trigger('detailExpand', [
      state('collapsed, void', style({ height: '0px' })),
      state('expanded', style({ height: '*' })),
      transition(
        'expanded <=> collapsed',
        animate('225ms cubic-bezier(0.4, 0.0, 0.2, 1)')
      ),
      transition(
        'expanded <=> void',
        animate('225ms cubic-bezier(0.4, 0.0, 0.2, 1)')
      ),
    ]),
  ],
})
export class RiderDetailsComponent implements OnInit {
  public isFromPage: string = APP_CONSTANTS.storageOrder;
  @ViewChild(MatAccordion) accordion: MatAccordion;
  @ViewChild('dropdown1', { static: false }) dropdown1: any;
  @ViewChild('dropdown2', { static: false }) dropdown2: any;
  //public selectedStorageFacility: any;
  public selectedContractType: any;
  public selectedCurrency: any;
  public selectedBrokerage = 0;
  public mode: string = '';
  public StorageOrderId: number;
  public riderDetailsForm: FormGroup;
  public submittedDetails: boolean = false;
  public isViewMode: boolean = false;
  public isEditMode: boolean = false;
  public isCopyMode: boolean = false;
  public expandonClick: boolean = true;
  public featureList: StorageFeatureModel[];
  public selectedFeatureList: StorageFeatureModel[];
  public filteredVendor: Observable<{ VendorModel }[]>;
  public filteredCustomer: Observable<{ CustomerModel }[]>;
  public vendorList: any;
  public customerList: any;
  public vendor;
  public customer;
  public storageFacilityList: StorageFacilityModel[];
  public loadFeatures: boolean = false;
  public allowAdd: boolean = false;
  public statusDetails: any;
  public contractTypeList: any;
  public currencyList: any;
  public brokerageType = APP_CONSTANTS.brokerageType;
  public riderModel = new RiderModel();
  public selectedVendorId: number;
  public selectedCustomerId: number;
  public selectedStorageFacilityId: number;
  public selectedFeatureIds: number[];
  public createdTime: Date;
  public isRequiredResSpace: boolean = false;
  public contractId: number;
  public reservedSpacesGreaterThanTotalCars: boolean = false;
  public optionsConfig = [{
    'addCars': false, 'upload': false, 'duplicate': false, 'update': false
  }];
  public convertToCurrency = ['DailyStorageRate', 'SwitchIn', 'SwitchOut',
  'SwitchingRate', 'SpecialSwitchingRate', 'HazmatSurcharge',
  'LoadedSurcharge', 'CherryPickingRate', 'ReservationRate'];
  public convertToCurrencyAdvancedSwitchingRates = ['StandardSwitchIn',
  'StandardSwitchOut',
  'HazmatSwitchIn',
  'HazmatSwitchOut',
  'LoadedSwitchIn',
  'LoadedSwitchOut'
  ];
  public convertToPercentage = ['PercentageRate', 'BookingFee', 'ListingFee'];
  public disableForVendor = ['ListingFee'];
  public disableForCustomer = ['BookingFee'];
  public isUploadAttachment: boolean = false;
  public addAttachmentSubject: Subject<void> = new Subject<void>();
  public addNoteSubject: Subject<void> = new Subject<void>();
  public isFlatRate: boolean = false;
  public currentUserRole: string = '';
  public commonDisableFields = [
    'VendorName',
    'CustomerName',
    'StorageFacilityName',
    'CurrencyName',
    'ContractTypeName',
  ];
  public flatRateFields = [
    'BookingFee',
    'CherryPickingRate',
    'DailyStorageRate',
    'HazmatSurcharge',
    'ListingFee',
    'LoadedSurcharge',
    'ReservationRate',
    'SpecialSwitchingRate',
    'SwitchIn',
    'SwitchOut',
    'SwitchingRate'
  ];
  public percentageRateFields = [
    'BookingFee',
    'CherryPickingRate',
    'DailyStorageRate',
    'HazmatSurcharge',
    'ListingFee',
    'LoadedSurcharge',
    'ReservationRate',
    'SpecialSwitchingRate',
    'SwitchIn',
    'SwitchOut',
    'SwitchingRate'
  ];
  public disableCustomerFields = [
    'ContractTypeName',
    'ReservedSpaces',
    'FormEffectiveDate',
    'FormExpiryDate',
    'CurrencyName',
    'Description',
    'TotalCars',
    'StorageFeatures',
  ];
  public disableAdvancedSwitchingRateFields = [
    'StandardSwitchIn',
    'StandardSwitchOut',
    "HazmatSwitchIn",
    "HazmatSwitchOut",
    "LoadedSwitchIn",
    "LoadedSwitchOut",
    "IsAdvancedHazmatSwitchingEnabled",
    "IsAdvancedLoadedSwitchingEnabled"
  ];
  public configuration: any;
  // Railcar Details Table
  dataSource = new MatTableDataSource<any>(APP_CONSTANTS.dataTable);
  selection = new SelectionModel<any>(true, []);
  columnsToDisplay = ['select', 'name', 'weight', 'symbol', 'position'];
  expandedElement: any | null;
  isSearching = false;
  noResults = false;
  customerRateId: number = 0;
  vendorCostId: number = 0;
  percentageRateId: number = 0;
  contractTypeId: number = 0;
  isTakeOrPay: boolean = false;
  RateTypes: ContractRateTypeModel[] = [];
  public listOfFieldsExcludedFromResetOnCreateForVendor = [
    'Rider',
    'ListingFee',
    'VendorName',
    'IsFlatRateContract',
  ];
  public listOfFieldsExcludedFromResetOnUpdateForVendor = [
    'Rider',
    'ListingFee',
    'VendorName',
    'StorageFacilityName',
    'CustomerName',
    'Location',
    'ReservedSpaces',
    'CarsStored',
    'CurrencyName',
    'IsFlatRateContract',
    'ContractTypeName',
  ];
  public listOfFieldsExcludedFromResetOnUpdateForAdmin = [
    'Rider',
    'VendorName',
    'StorageFacilityName',
    'CustomerName',
    'Location',
    'ReservedSpaces',
    'CarsStored',
    'CurrencyName',
    'IsFlatRateContract',
    'ContractTypeName',
  ];
  public listOfFieldsExcludedFromResetOnCreateForAdmin = ['IsFlatRateContract'];

  public isAdvancedSwitchingRatesEnabled: boolean = false;
  public isFlatRateVendorCostAdvancedHazmatSwitchingEnabled: boolean = false;
  public isFlatRateVendorCostAdvancedLoadedSwitchingEnabled: boolean = false;
  public isFlatRateCustomerRateAdvancedHazmatSwitchingEnabled: boolean = false;
  public isFlatRateCustomerRateAdvancedLoadedSwitchingEnabled: boolean = false;
  public isPercentageRateAdvancedHazmatSwitchingEnabled: boolean = false;
  public isPercentageRateAdvancedLoadedSwitchingEnabled: boolean = false;

  constructor(
    public route: ActivatedRoute,
    public formBuilder: FormBuilder,
    public vendorService: VendorService,
    public customerService: CustomerService,
    public storageFacilityService: StorageFacilityService,
    public storageFeatureService: StorageFeatureService,
    public contractTypeService: ContractTypeService,
    public currencyService: CurrencyService,
    public riderService: RiderService,
    public toastr: ToastrService,
    private currencyPipe: CurrencyPipe,
    private percentPipe: PercentPipe,
    private router: Router,
    private dialogService: ConfirmDialogService,
    private authService: AuthService,
    private sharedService: SharedService
  ) {}

  ngOnInit(): void {
    this.selectedFeatureIds = [];
    this.route.params.subscribe((params: any) => {
      this.mode = params.mode;
      this.StorageOrderId = params.id;
      this.riderModel.Id = this.StorageOrderId;
    });
    this.authService.getUserId();
    this.currentUserRole = ApiService.CurrentRole.split('_')[0];
    this.initilizeRiderDetailsForm();
    this.getContractTypeList();
    this.getContractRateTypes();
    this.getCurrencyList();
    this.setAutoComplete();
  }

  getStorageOrderDetailsById(Id: number) {
    this.riderService.GetStorageOrderDetailsById(Id).subscribe(
      (result) => {
        if (result) {
          this.riderDetailsForm.patchValue(result);

          let contractType = this.contractTypeList.find(
            (m) => m.Id == result.ContractTypeId
          )?.Name;
          if (contractType.toLowerCase() === APP_CONSTANTS.contractTypeReserve.toLowerCase())
          {
            this.contractTypeId = result.ContractTypeId;
            const reserveSpaceField =this.riderDetailsForm.controls['ReservedSpaces'];
            reserveSpaceField.enable();
            this.isRequiredResSpace = true;
          }

          if(contractType.toLowerCase().startsWith((APP_CONSTANTS.TakeOrPay.toLowerCase()))) {
            this.isTakeOrPay = true;
          }

          if (result.IsAdvancedSwitchingRatesEnabled === APP_CONSTANTS.true) {
            this.isAdvancedSwitchingRatesEnabled = true;
          }

          if (result.IsFlatRateContract === APP_CONSTANTS.true) {
            this.isFlatRate = true;
          }
          //IsFlatRateContract
          this.sharedService.transformFieldValues(
            this.convertToCurrency,
            this.riderDetailsForm,
            this.currencyPipe
          );
          this.sharedService.transformFieldValues(
            this.convertToPercentage,
            this.riderDetailsForm,
            this.percentPipe
          );
          if (this.mode === APP_CONSTANTS.copy) {
            this.riderDetailsForm.patchValue({
              Rider: APP_CONSTANTS.null,
              CarsStored: APP_CONSTANTS.null,
            });
            this.manageSwitchInOutOnAdvanceSwitchingEnable(this.isAdvancedSwitchingRatesEnabled);
          }
          if (this.mode === APP_CONSTANTS.edit) {
            this.manageSwitchInOutOnAdvanceSwitchingEnable(this.isAdvancedSwitchingRatesEnabled);
          }
          this.riderModel.CustomerId = result.CustomerId;
          this.riderModel.StorageFacilityName = result.StorageFacilityName;
          this.selectedCurrency = result.CurrencyId;

          this.getStorageFacilitiesByVendorId(result.VendorId);
          this.selectedStorageFacilityId = result.StorageFacilityId;
          //ContractTypeName
          // this.riderDetailsForm.patchValue({
          //   ContractTypeName: result.ContractTypeId
          // });
          this.riderDetailsForm.patchValue({
            FormEffectiveDate: this.sharedService.ConvertToDatePickerDate(
              result.EffectiveDate
            ),
            FormExpiryDate: this.sharedService.ConvertToDatePickerDate(
              result.ExpiryDate
            ),
            ContractTypeName: result.ContractTypeId,
            StorageFacilityName: result.StorageFacilityId,
            CurrencyName: result.CurrencyId,
          });
          this.selectedFeatureList = result.storageFeatureViewModels;
          if (this.selectedFeatureList != undefined) {
            this.riderDetailsForm.patchValue({
              StorageFeatures: this.selectedFeatureList.map(({ Id }) => Id),
            });
          }
          // this.selectedContractType = result.ContractTypeId;
          this.selectedCustomerId = result.CustomerId;
          this.selectedVendorId = result.VendorId;
          this.getSelectedFeatures(result);

          if (this.isFlatRate) {
            this.customerRateId =
              result.CustomerRate !== null ? result.CustomerRate.Id : 0;
            this.vendorCostId =
              result.VendorCost !== null ? result.VendorCost.Id : 0;
          } else {
            this.percentageRateId =
              result.PercentageRate !== null ? result.PercentageRate.Id : 0;
          }
          this.setAdvancedSwitchingRate(result);
          this.submittedDetails = false;
        }
      },
      (error) => {}
    );
  }

  setAdvancedSwitchingRate(result: any): void {
    const custFlatRateFormControl = (this.riderDetailsForm.get('CustomerRate') as FormGroup)?.controls;
    const vendorFlatRateFormControl = (this.riderDetailsForm.get('VendorCost') as FormGroup)?.controls;
    const percentageRateFormControl = (this.riderDetailsForm.get('PercentageRate') as FormGroup)?.controls;

    if (this.isFlatRate) {
      custFlatRateFormControl['AdvancedSwitchingRates'].patchValue({
        StandardSwitchIn: result.CustomerRate.StandardSwitchIn,
        StandardSwitchOut: result.CustomerRate.StandardSwitchOut,
        HazmatSwitchIn: result.CustomerRate.HazmatSwitchIn,
        HazmatSwitchOut: result.CustomerRate.HazmatSwitchOut,
        LoadedSwitchIn: result.CustomerRate.LoadedSwitchIn,
        LoadedSwitchOut: result.CustomerRate.LoadedSwitchOut,
        IsAdvancedHazmatSwitchingEnabled: result.CustomerRate.IsAdvancedHazmatSwitchingEnabled,
        IsAdvancedLoadedSwitchingEnabled: result.CustomerRate.IsAdvancedLoadedSwitchingEnabled,
      });
      this.isFlatRateCustomerRateAdvancedHazmatSwitchingEnabled =
        result.CustomerRate.IsAdvancedHazmatSwitchingEnabled;
      this.isFlatRateCustomerRateAdvancedLoadedSwitchingEnabled =
        result.CustomerRate.IsAdvancedLoadedSwitchingEnabled;

      vendorFlatRateFormControl['AdvancedSwitchingRates'].patchValue({
        StandardSwitchIn: result.VendorCost.StandardSwitchIn,
        StandardSwitchOut: result.VendorCost.StandardSwitchOut,
        HazmatSwitchIn: result.VendorCost.HazmatSwitchIn,
        HazmatSwitchOut: result.VendorCost.HazmatSwitchOut,
        LoadedSwitchIn: result.VendorCost.LoadedSwitchIn,
        LoadedSwitchOut: result.VendorCost.LoadedSwitchOut,
        IsAdvancedHazmatSwitchingEnabled: result.VendorCost.IsAdvancedHazmatSwitchingEnabled,
        IsAdvancedLoadedSwitchingEnabled: result.VendorCost.IsAdvancedLoadedSwitchingEnabled,
      });

      this.isFlatRateVendorCostAdvancedHazmatSwitchingEnabled =
        result.VendorCost.IsAdvancedHazmatSwitchingEnabled;
      this.isFlatRateVendorCostAdvancedLoadedSwitchingEnabled =
        result.VendorCost.IsAdvancedLoadedSwitchingEnabled;

      this.sharedService.transformFieldValues(
        this.convertToCurrencyAdvancedSwitchingRates,
        this.riderDetailsForm.get('CustomerRate') as FormGroup,
        this.currencyPipe
      );
      this.sharedService.transformFieldValues(
        this.convertToCurrencyAdvancedSwitchingRates,
        this.riderDetailsForm.get('VendorCost') as FormGroup,
        this.currencyPipe
      );

    } else {
      percentageRateFormControl['AdvancedSwitchingRates'].patchValue({
        StandardSwitchIn: result.PercentageRate.StandardSwitchIn,
        StandardSwitchOut: result.PercentageRate.StandardSwitchOut,
        HazmatSwitchIn: result.PercentageRate.HazmatSwitchIn,
        HazmatSwitchOut: result.PercentageRate.HazmatSwitchOut,
        LoadedSwitchIn: result.PercentageRate.LoadedSwitchIn,
        LoadedSwitchOut: result.PercentageRate.LoadedSwitchOut,
        IsAdvancedHazmatSwitchingEnabled: result.PercentageRate.IsAdvancedHazmatSwitchingEnabled,
        IsAdvancedLoadedSwitchingEnabled: result.PercentageRate.IsAdvancedLoadedSwitchingEnabled,
      });

      this.isPercentageRateAdvancedHazmatSwitchingEnabled =
        result.PercentageRate.IsAdvancedHazmatSwitchingEnabled;
      this.isPercentageRateAdvancedLoadedSwitchingEnabled =
        result.PercentageRate.IsAdvancedLoadedSwitchingEnabled;

      this.sharedService.transformFieldValues(
        this.convertToCurrencyAdvancedSwitchingRates,
        this.riderDetailsForm.get('PercentageRate') as FormGroup,
        this.currencyPipe
      );
    }
  }

  getCurrencyList() {
    this.sharedService.getCurrencyList().subscribe(result => {
        this.currencyList = result;
    }, error => {

    });
  }
  getContractTypeList() {
    this.contractTypeService.GetContractTypeList().subscribe(result => {
        this.contractTypeList = result;
        this.checkModeData();
    }, error => {

    });
  }

  // Get all contract rate types master data
  getContractRateTypes(): void {
     this.sharedService.getContractRateTypes().subscribe((response)=>{
      this.RateTypes=response;
    });
  }

  public setAutoComplete(): void {
    this.loadVendors();
    this.loadCustomers();
  }

  public loadVendors(): void {
    this.authService.getUserId();
    if (
      this.mode == APP_CONSTANTS.create &&
      ApiService.CurrentRole.startsWith('Vendor')
    ) {
      this.vendorService
        .GetVendorForUserId(+ApiService.UserId)
        .subscribe((result) => {
          this.setVendorValueOnSelection(result.Organization, result.Id);
          this.getPercentageMarginByVendor(result.Id);
        });
      this.riderDetailsForm.get('VendorName')?.disable();
    }
    else{
      const vendorControl = this.riderDetailsForm.get('VendorName');
      if (vendorControl) {
        vendorControl?.valueChanges
          .pipe(
            debounceTime(1000),
            tap(() => {
              this.vendorList = [];
            }),
            switchMap((value) =>
              this.filterVendor(value).pipe(
                finalize(() => {
                  if (value.length > 1 && this.vendorList.length === 0) {
                    this.noResults = true;
                  } else if (value.length == 0 && this.vendorList.length === 0) {
                    this.noResults = false;
                  } else {
                    this.noResults = false;
                  }
                  this.isSearching = false;
                })
              )
            )
          )
          .subscribe((data: any) => {
            if (data != null && data.length > 0) {
              this.noResults = false;
              this.vendorList = data;
            }
            // else{
            //   this.noResults=true;
            // }
          });
      }
    }
  }

  /** set Organization name and Id into form
   * @method setVendorValueOnSelection
   * @param orgName - organization name to set
   * @param organizationId - organization id to set
   */
  private setVendorValueOnSelection(
    orgName: string,
    organizationId: number
  ): void {
    this.riderDetailsForm.patchValue({
      VendorName: orgName,
    });
    this.selectedVendorId = organizationId;
    this.getStorageFacilitiesByVendorId(this.selectedVendorId);
    this.selectedFeatureIds = [];
    this.featureList = [];
    this.createFeatureControls();
  }

  public filterVendor(val: string): Observable<VendorModel[]> {
    if (val != undefined && val.length > 1) {
      this.isSearching = true;
      return this.vendorService.GetVendorListForAutoComplete(val);
    } else {
    this.riderDetailsForm.get('PercentageRate')?.patchValue({
      ListingFee: null
    })
      this.noResults = false;
      return of([]);
    }
  }

  public onVendorChanged(event: any): void {
    this.riderDetailsForm.patchValue({
      VendorName: event.option.value.Organization
    });
    this.selectedVendorId = event.option.value.Id;
    this.getStorageFacilitiesByVendorId(event.option.value.Id);
    this.selectedFeatureIds = [];
    this.featureList = [];
    this.createFeatureControls();
    if (
      this.StorageOrderId === undefined &&
      this.currentUserRole !== APP_CONSTANTS.Vendor &&
      this.currentUserRole !== APP_CONSTANTS.Customer
    ) {
      this.getPercentageMarginByVendor(event.option.value.Id);
    }
  }

  public loadCustomers(): void {
    this.authService.getUserId();
    if (
      this.mode == APP_CONSTANTS.create &&
      ApiService.CurrentRole.startsWith('Customer')
    ) {
      this.customerService
        .GetCustomerForUserId(+ApiService.UserId)
        .subscribe((result) => {
          this.riderDetailsForm.patchValue({
            CustomerName: result.Name,
          });
          this.selectedCustomerId = result.Id;
          this.getPercentageMarginByCustomer(result.Id);
        });
      this.riderDetailsForm.get('CustomerName')?.disable();
    }
    else{
      const customerControl = this.riderDetailsForm.get('CustomerName');
      if (customerControl) {
        customerControl?.valueChanges
          .pipe(
            debounceTime(1000),
            tap(() => {
              this.customerList = [];
            }),
            switchMap((value) =>
              this.filterCustomer(value).pipe(
                finalize(() => {
                  if (value.length > 1 && this.customerList.length === 0) {
                    this.noResults = true;
                    this.riderDetailsForm.get('PercentageRate')?.patchValue({
                      BookingFee: null
                    })
                  } else if (value.length == 0 && this.customerList.length === 0) {
                    this.riderDetailsForm.get('PercentageRate')?.patchValue({
                      BookingFee: null
                    })
                    this.noResults = false;
                  } else {
                    this.noResults = false;
                  }
                  this.isSearching = false;
                })
              )
            )
          )
          .subscribe((data: any) => {
            if (data != null && data.length > 0) {
              this.noResults = false;
              this.customerList = data;
            }
            // else{
            //   this.noResults=true;
            // }
          });
      }
    }
  }

  getPercentageMarginByVendor(vendorId: number) {
    this.contractId =
      this.StorageOrderId === undefined ? 0 : this.StorageOrderId;
    this.vendorService
      .GetPercentageMarginForVendor(this.contractId, vendorId)
      .subscribe(
        (result) => {
          this.riderDetailsForm.get('PercentageRate')?.patchValue({
            ListingFee: this.sharedService.onValueConversionToPercentage(result.toString())
          })
        },
        (error) => {}
      );
  }

  getPercentageMarginByCustomer(customerId: number) {
    this.contractId =
      this.StorageOrderId === undefined ? 0 : this.StorageOrderId;
    this.customerService
      .GetPercentageMarginForCustomer(this.contractId, customerId)
      .subscribe(
        (result) => {
          this.riderDetailsForm.get('PercentageRate')?.patchValue({
            BookingFee: this.sharedService.onValueConversionToPercentage(result.toString())
          })
        },
        (error) => {}
      );
  }

  public filterCustomer(val: string): Observable<CustomerModel[]> {
    if (val != undefined && val.length > 1) {
      this.isSearching = true;
      return this.customerService.GetCustomers(val);
    } else {
      this.noResults = false;
      return of([]);
    }
  }

  onCustomerChanged(event: any) {
    this.riderDetailsForm.patchValue({
      CustomerName: event.option.value.Name
    });
    this.selectedCustomerId = event.option.value.Id;
    if (
      this.StorageOrderId === undefined &&
      this.currentUserRole !== APP_CONSTANTS.Vendor &&
      this.currentUserRole !== APP_CONSTANTS.Customer
    ) {
      this.getPercentageMarginByCustomer(this.selectedCustomerId);
    }
  }

  getStorageFacilitiesByVendorId(vendorId: number) {
    this.storageFacilityService.getStorageFacilitiesByVendorId(vendorId).subscribe(result => {
      result.forEach(e=>{
        e.FormEffectiveDate=this.sharedService.ConvertToDatePickerDate(e.EffectiveDate),
        e.FormExpiryDate=this.sharedService.ConvertToDatePickerDate(e.ExpiryDate)
          });
          this.storageFacilityList = result;
    }, error => {
    });
  }

  // Initilize Rider Details form
  public initilizeRiderDetailsForm(): void {
      this.riderDetailsForm = this.formBuilder.group({
        Rider: [{value: APP_CONSTANTS.null,disabled :true }],
        VendorName: [APP_CONSTANTS.emptyString, [Validators.required, Validators.pattern(/^[a-zA-Z0-9-&. ]*$/)]],
        StorageFacilityName: [APP_CONSTANTS.null, Validators.required],
        FormEffectiveDate: [APP_CONSTANTS.null, Validators.required],
        FormExpiryDate: [APP_CONSTANTS.null, Validators.required],
        TotalCars: [APP_CONSTANTS.emptyString, [Validators.required, Validators.pattern(/^[0-9]*$/)]],
        CurrencyName: [APP_CONSTANTS.emptyString, Validators.required],
        IsFlatRateContract: [APP_CONSTANTS.false, Validators.required],
        IsAdvancedSwitchingRatesEnabled: [APP_CONSTANTS.false],
        CustomerName: [
          APP_CONSTANTS.emptyString,
          [Validators.required, Validators.pattern(/^[a-zA-Z0-9-&. ]*$/)],
        ],
        ContractTypeName: [APP_CONSTANTS.emptyString, Validators.required],
        ReservedSpaces: [
          { value: APP_CONSTANTS.emptyString, disabled: APP_CONSTANTS.true },
          [Validators.pattern(/^[0-9]*$/)],
        ],
        Location: [{ value: APP_CONSTANTS.emptyString, disabled: true }],
        Description: [APP_CONSTANTS.emptyString],
        StorageFeatures: [APP_CONSTANTS.emptyString],
        CarsStored: [
          { value: APP_CONSTANTS.null, disabled: true },
          Validators.pattern(/^[0-9]*$/),
        ],
        CustomerRate: this.commonForm(),
        VendorCost: this.commonForm(),
        PercentageRate: this.commonForm(),
      },
      {
        validator: Validators.compose([
          DateValidators.dateLessThan('FormEffectiveDate', 'FormExpiryDate', {
            expiryIssue: true,
          }),
          NumValidators.numLessThan('ReservedSpaces', 'TotalCars', {
            reservedSpacesIssue: true,
          }),
        ]),
      }
    );
  }

  public commonForm(): FormGroup {
    return this.formBuilder.group({
      SwitchIn: [
        APP_CONSTANTS.null,
        {
          validators: [
            Validators.maxLength(9),
            Validators.min(0),
            Validators.max(999999),
          ],
          updateOn: 'change',
          asyncValidators: [],
        },
      ],
      SwitchOut: [
        APP_CONSTANTS.null,
        {
          validators: [
            Validators.maxLength(9),
            Validators.min(0),
            Validators.max(999999),
          ],
          updateOn: 'change',
          asyncValidators: [],
        },
      ],
      SwitchingRate: [
        APP_CONSTANTS.null,
        {
          validators: [
            Validators.maxLength(9),
            Validators.min(0),
            Validators.max(999999),
          ],
          updateOn: 'change',
          asyncValidators: [],
        },
      ],
      SpecialSwitchingRate: [
        APP_CONSTANTS.null,
        {
          validators: [
            Validators.maxLength(9),
            Validators.min(0),
            Validators.max(999999),
          ],
          updateOn: 'change',
          asyncValidators: [],
        },
      ],
      DailyStorageRate: [
        APP_CONSTANTS.null,
        {
          validators: [
            //Validators.required,
            Validators.maxLength(9),
            Validators.min(1),
            Validators.max(999999),
          ],
          updateOn: 'change',
          asyncValidators: [],
        },
      ],
      HazmatSurcharge: [
        APP_CONSTANTS.null,
        {
          validators: [
            Validators.maxLength(9),
            Validators.min(0),
            Validators.max(999999),
          ],
          updateOn: 'change',
          asyncValidators: [],
        },
      ],
      LoadedSurcharge: [
        APP_CONSTANTS.null,
        {
          validators: [
            Validators.maxLength(9),
            Validators.min(0),
            Validators.max(999999),
          ],
          updateOn: 'change',
          asyncValidators: [],
        },
      ],
      CherryPickingRate: [
        APP_CONSTANTS.null,
        {
          validators: [
            Validators.maxLength(9),
            Validators.min(0),
            Validators.max(999999),
          ],
          updateOn: 'change',
          asyncValidators: [],
        },
      ],
      ReservationRate: [
        APP_CONSTANTS.null,
        {
          validators: [
            Validators.maxLength(9),
            Validators.min(0),
            Validators.max(999999),
          ],
          updateOn: 'change',
          asyncValidators: [],
        },
      ],
      ListingFee: [
        APP_CONSTANTS.null,
        {
          validators: [
            //Validators.required,
            Validators.min(0),
            Validators.max(100),
          ],
          updateOn: 'change',
          asyncValidators: [],
        },
      ],
      BookingFee: [
        APP_CONSTANTS.null,
        {
          validators: [
            //Validators.required,
            Validators.min(0),
            Validators.max(100),
          ],
          updateOn: 'change',
          asyncValidators: [],
        },
      ],
      AdvancedSwitchingRates: this.advancedSwitchingRateForm(),
    });
  }

  public advancedSwitchingRateForm(): FormGroup {
    return this.formBuilder.group({
      StandardSwitchIn: [
        APP_CONSTANTS.null,
        {
          validators: [
            Validators.maxLength(9),
            Validators.min(0),
            Validators.max(999999),
          ],
          updateOn: 'change',
          asyncValidators: [],
        },
      ],
      StandardSwitchOut: [
        APP_CONSTANTS.null,
        {
          validators: [
            Validators.maxLength(9),
            Validators.min(0),
            Validators.max(999999),
          ],
          updateOn: 'change',
          asyncValidators: [],
        },
      ],
      HazmatSwitchIn: [
        APP_CONSTANTS.null,
        {
          validators: [
            Validators.maxLength(9),
            Validators.min(0),
            Validators.max(999999),
          ],
          updateOn: 'change',
          asyncValidators: [],
        },
      ],
      HazmatSwitchOut: [
        APP_CONSTANTS.null,
        {
          validators: [
            Validators.maxLength(9),
            Validators.min(0),
            Validators.max(999999),
          ],
          updateOn: 'change',
          asyncValidators: [],
        },
      ],
      LoadedSwitchIn: [
        APP_CONSTANTS.null,
        {
          validators: [
            Validators.maxLength(9),
            Validators.min(0),
            Validators.max(999999),
          ],
          updateOn: 'change',
          asyncValidators: [],
        },
      ],
      LoadedSwitchOut: [
        APP_CONSTANTS.null,
        {
          validators: [
            Validators.maxLength(9),
            Validators.min(0),
            Validators.max(999999),
          ],
          updateOn: 'change',
          asyncValidators: [],
        },
      ],
      IsAdvancedHazmatSwitchingEnabled: [APP_CONSTANTS.false],
      IsAdvancedLoadedSwitchingEnabled: [APP_CONSTANTS.false]
    });
  }

  // convenience getter for easy access to form fields
  get riderDetailsGetter() {
    return this.riderDetailsForm.controls;
  }

  // Check mode and apply settings respectively
  public checkModeData(): void {
    switch (this.mode) {
      case APP_CONSTANTS.create:
        this.isEditMode = false;
        this.isViewMode = false;
        this.isCopyMode = false;
        this.setDefaultDisable();
        this.setPercentOnCreateByVendor();
        break;
      case APP_CONSTANTS.edit:
        this.isEditMode = true;
        this.isViewMode = false;
        this.isCopyMode = false;
        this.enableDisableFieldsBasedOnModeInUpdate();
        break;
      case APP_CONSTANTS.view:
        this.isEditMode = false;
        this.isViewMode = true;
        this.isCopyMode = false;
        break;
      case APP_CONSTANTS.copy:
        this.isEditMode = false;
        this.isViewMode = false;
        this.isCopyMode = true;
        this.setDefaultDisable();
        break;
    }
    if (
      this.mode === APP_CONSTANTS.edit ||
      this.mode === APP_CONSTANTS.view ||
      this.mode === APP_CONSTANTS.copy
    ) {
      this.getStorageOrderDetailsById(this.StorageOrderId);
    }
  }

  public setDefaultDisable(): void {
    const percentageRate = (
      this.riderDetailsForm.get('PercentageRate') as FormGroup
    )?.controls;
    const riderForm = this.riderDetailsForm.controls;
    switch (this.currentUserRole) {
      case APP_CONSTANTS.Customer:
        this.onDisableFields(percentageRate, this.disableForCustomer);
        this.onDisableFields(riderForm, this.disableCustomerFields);
        break;
      case APP_CONSTANTS.Vendor:
        this.onDisableFields(percentageRate, this.disableForVendor);
        break;
    }
  }

  // On updating View Mode enable Enable Edit Mode
  public onUpdate(): void {
    this.mode = APP_CONSTANTS.edit;
    this.isEditMode = true;
    this.isViewMode = false;
    this.isCopyMode = false;
    this.manageSwitchInOutOnAdvanceSwitchingEnable(this.isAdvancedSwitchingRatesEnabled);
    this.enableDisableFieldsBasedOnModeInUpdate();
  }

  public enableDisableFieldsBasedOnModeInUpdate(): void {
    const riderForm = this.riderDetailsForm.controls;
    const custFlatRate = (
      this.riderDetailsForm.get('CustomerRate') as FormGroup
    )?.controls;
    const vendorFlatRate = (
      this.riderDetailsForm.get('VendorCost') as FormGroup
    )?.controls;
    const percentageRate = (
      this.riderDetailsForm.get('PercentageRate') as FormGroup
    )?.controls;
    switch (this.currentUserRole) {
      case APP_CONSTANTS.SuperAdmin:
        {
          this.onDisableFields(riderForm, this.commonDisableFields);
        }
        break;
      case APP_CONSTANTS.Admin:
        {
          this.onDisableFields(riderForm, this.commonDisableFields);
        }
        break;
      case APP_CONSTANTS.Vendor:
        {
          this.onDisableFields(riderForm, this.commonDisableFields);
          this.onDisableFields(custFlatRate, this.flatRateFields);
          this.onDisableFields(vendorFlatRate, this.flatRateFields);
          this.onDisableFields(percentageRate, this.disableForVendor);
          // disabled advanced switching rate detail
          this.onDisableFields((percentageRate['AdvancedSwitchingRates'] as FormGroup)?.controls, this.disableAdvancedSwitchingRateFields);
          this.onDisableFields((vendorFlatRate['AdvancedSwitchingRates'] as FormGroup)?.controls, this.disableAdvancedSwitchingRateFields);
        }
        break;
      case APP_CONSTANTS.Customer:
        {
          this.onDisableFields(riderForm, this.commonDisableFields);
          this.onDisableFields(custFlatRate, this.flatRateFields);
          this.onDisableFields(vendorFlatRate, this.flatRateFields);
          this.onDisableFields(percentageRate, this.percentageRateFields);
          this.onDisableFields(percentageRate, this.disableForCustomer);
          this.onDisableFields(riderForm, this.disableCustomerFields);
          // disabled advanced switching rate detail
          this.onDisableFields((percentageRate['AdvancedSwitchingRates'] as FormGroup)?.controls, this.disableAdvancedSwitchingRateFields);
          this.onDisableFields((custFlatRate['AdvancedSwitchingRates'] as FormGroup)?.controls, this.disableAdvancedSwitchingRateFields);
        }
        break;
    }
  }

  public onDisableFields(form, fields): void {
    fields.forEach((key) => {
      form[key].disable();
    });
  }

  public openAllAccordians(): void {
    this.accordion.openAll();
  }

  // Railcar Details Table
  isAllSelected() {
    const numSelected = this.selection.selected.length;
    const numRows = this.dataSource.data.length;
    return numSelected === numRows;
  }
  masterToggle() {
    if (this.isAllSelected()) {
      this.selection.clear();
    } else {
      this.dataSource.data.forEach((row: any) => this.selection.select(row));
    }
  }

  displayField(field?: string): string {
    return field ? field : '';
  }
  private filter(value: string | any, filterOn): Observable<any[]> {
    const val = (typeof value === 'string') ? value : value.Name;
    if (val) {
      return filterOn.pipe(map((cos: any[]) => {
          return cos.filter((co: any) => {
          return (co.Name.toLowerCase().search((typeof val === 'string') ? val.toLowerCase() : (<any>val).Name.toLowerCase()) !== -1)
          });
      }));
    } else {
      return filterOn;
    }
  }

  public onfeatureSelected(event, feature): void {
    if (event.checked) {
      this.selectedFeatureIds.push(feature.Id)
    }
    else {
      let index: number = this.selectedFeatureIds.findIndex(a => a === feature.Id);

      if (index != -1) {
        this.selectedFeatureIds.splice(index, 1);
      }
    }
  }

  public onStorageFacilityChange(event): void {
    this.selectedFeatureIds = [];
    this.featureList = [];
    this.getStorageFeaturesByFacilityId(event.value);
    this.selectedStorageFacilityId = event.value;
  }

  getStorageFeaturesByFacilityId(facilityId: number) {
    this.storageFeatureService
      .GetStorageFeaturesByFacilityId(facilityId)
      .subscribe(
        (result) => {
          this.featureList = result;
          this.createFeatureControls();
          this.riderDetailsForm.patchValue({
            Location: this.storageFacilityList.find(
              (facility) => facility.Id == facilityId
            )?.City,
          });
          this.loadFeatures = true;
        },
        (error) => {}
      );
  }

  getSelectedFeatures(riderModel: RiderModel) {
    this.storageFeatureService
      .GetStorageFeaturesByFacilityId(riderModel.StorageFacilityId)
      .subscribe(
        (result) => {
          this.featureList = result;
          if (this.featureList.length && riderModel.storageFeatureViewModels) {
            this.featureList.forEach((control: any) => {
              riderModel.storageFeatureViewModels.forEach(
                (selectedcontrol: any) => {
                  if (control.Id === selectedcontrol.Id) {
                    // If featurelist control name is equal to received rider details facility control then
                    control.checked = true;
                    this.selectedFeatureIds.push(selectedcontrol.Id);
                  }
                }
              );
            });
          }
          this.createFeatureControls();
          this.loadFeatures = true;
        },
        (error) => {}
      );
  }

  public createFeatureControls(): void {
    const featureList = this.featureList;
    if (featureList.length) {
      featureList.forEach((control: any) => {
        this.riderDetailsForm.addControl(
          control.Name,
          new FormControl(control.checked)
        );
      });
    }
  }
  getIsAdvancedHazmatSwitchingEnabled(data: any, rateType: any): void {
    if (this.isFlatRate) {
      if (rateType === 'CustomerRate') {
        this.isFlatRateCustomerRateAdvancedHazmatSwitchingEnabled = data;
      } else {
        this.isFlatRateVendorCostAdvancedHazmatSwitchingEnabled = data;
      }
    } else {
      this.isPercentageRateAdvancedHazmatSwitchingEnabled = data;
    }
  }

  public getIsAdvancedLoadedSwitchingEnabled(data: any, rateType: string): void {
    if (this.isFlatRate) {
      if (rateType.toLocaleLowerCase() === 'customerrate') {
        this.isFlatRateCustomerRateAdvancedLoadedSwitchingEnabled = data;
      }
      else if (rateType.toLocaleLowerCase() === 'percentagerate') {
        this.isPercentageRateAdvancedLoadedSwitchingEnabled = data;
      }
      else {
        this.isFlatRateVendorCostAdvancedLoadedSwitchingEnabled = data;
      }
    }
    else {
      this.isPercentageRateAdvancedLoadedSwitchingEnabled = data;
    }
  }

  private prepareAdvancedSwitchingRates(): void {
    if (this.isFlatRate) {
      let advancedSwitchingRateCustomerRate =
        this.riderDetailsForm.getRawValue().CustomerRate.AdvancedSwitchingRates;

      this.riderModel.CustomerRate.StandardSwitchIn =
        this.sharedService.CheckDecimalIsEmpty(advancedSwitchingRateCustomerRate.StandardSwitchIn);
      this.riderModel.CustomerRate.StandardSwitchOut =
        this.sharedService.CheckDecimalIsEmpty(advancedSwitchingRateCustomerRate.StandardSwitchOut);
      this.riderModel.CustomerRate.HazmatSwitchIn =
        this.sharedService.CheckDecimalIsEmpty(advancedSwitchingRateCustomerRate.HazmatSwitchIn);
      this.riderModel.CustomerRate.HazmatSwitchOut =
        this.sharedService.CheckDecimalIsEmpty(advancedSwitchingRateCustomerRate.HazmatSwitchOut);
      this.riderModel.CustomerRate.LoadedSwitchIn =
        this.sharedService.CheckDecimalIsEmpty(advancedSwitchingRateCustomerRate.LoadedSwitchIn);
      this.riderModel.CustomerRate.LoadedSwitchOut =
        this.sharedService.CheckDecimalIsEmpty(advancedSwitchingRateCustomerRate.LoadedSwitchOut);
      this.riderModel.CustomerRate.IsAdvancedHazmatSwitchingEnabled =
       this.isFlatRateCustomerRateAdvancedHazmatSwitchingEnabled;
      this.riderModel.CustomerRate.IsAdvancedLoadedSwitchingEnabled =
       this.isFlatRateCustomerRateAdvancedLoadedSwitchingEnabled;

      let advancedSwitchingRateVendorCost =
        this.riderDetailsForm.getRawValue().VendorCost.AdvancedSwitchingRates;

      this.riderModel.VendorCost.StandardSwitchIn =
        this.sharedService.CheckDecimalIsEmpty(advancedSwitchingRateVendorCost.StandardSwitchIn);
      this.riderModel.VendorCost.StandardSwitchOut =
        this.sharedService.CheckDecimalIsEmpty(advancedSwitchingRateVendorCost.StandardSwitchOut);
      this.riderModel.VendorCost.HazmatSwitchIn =
        this.sharedService.CheckDecimalIsEmpty(advancedSwitchingRateVendorCost.HazmatSwitchIn);
      this.riderModel.VendorCost.HazmatSwitchOut =
        this.sharedService.CheckDecimalIsEmpty(advancedSwitchingRateVendorCost.HazmatSwitchOut);
      this.riderModel.VendorCost.LoadedSwitchIn =
        this.sharedService.CheckDecimalIsEmpty(advancedSwitchingRateVendorCost.LoadedSwitchIn);
      this.riderModel.VendorCost.LoadedSwitchOut =
        this.sharedService.CheckDecimalIsEmpty(advancedSwitchingRateVendorCost.LoadedSwitchOut);
      this.riderModel.VendorCost.IsAdvancedHazmatSwitchingEnabled =
        this.isFlatRateVendorCostAdvancedHazmatSwitchingEnabled;
      this.riderModel.VendorCost.IsAdvancedLoadedSwitchingEnabled =
        this.isFlatRateVendorCostAdvancedLoadedSwitchingEnabled;

    } else {
      let advanceSwitchingPercentageRate =
      this.riderDetailsForm.getRawValue().PercentageRate.AdvancedSwitchingRates;

      this.riderModel.PercentageRate.StandardSwitchIn =
        this.sharedService.CheckDecimalIsEmpty(advanceSwitchingPercentageRate.StandardSwitchIn);
      this.riderModel.PercentageRate.StandardSwitchOut =
        this.sharedService.CheckDecimalIsEmpty(advanceSwitchingPercentageRate.StandardSwitchOut);
      this.riderModel.PercentageRate.HazmatSwitchIn =
        this.sharedService.CheckDecimalIsEmpty(advanceSwitchingPercentageRate.HazmatSwitchIn);
      this.riderModel.PercentageRate.HazmatSwitchOut =
        this.sharedService.CheckDecimalIsEmpty(advanceSwitchingPercentageRate.HazmatSwitchOut);
      this.riderModel.PercentageRate.LoadedSwitchIn =
        this.sharedService.CheckDecimalIsEmpty(advanceSwitchingPercentageRate.LoadedSwitchIn);
      this.riderModel.PercentageRate.LoadedSwitchOut =
        this.sharedService.CheckDecimalIsEmpty(advanceSwitchingPercentageRate.LoadedSwitchOut);
      this.riderModel.PercentageRate.IsAdvancedHazmatSwitchingEnabled =
        this.isPercentageRateAdvancedHazmatSwitchingEnabled;
      this.riderModel.PercentageRate.IsAdvancedLoadedSwitchingEnabled =
        this.isPercentageRateAdvancedLoadedSwitchingEnabled;
    }
  }

  // On form submit
  public onSubmitRiderDetailsForm(): void {
    this.submittedDetails = true;
    const reserveSpaceField = this.riderDetailsForm.controls['ReservedSpaces'];
    if (
      reserveSpaceField.enabled &&
      (reserveSpaceField.value === '' ||
        reserveSpaceField.value === null ||
        reserveSpaceField.value === undefined)
    ) {
      reserveSpaceField.markAsTouched();
      reserveSpaceField.setErrors({
        notUnique: true,
      });
      return;
    }
    // stop here if form is invalid
    if (this.riderDetailsForm.invalid) {
      return;
    }

    this.riderModel = Object.assign(this.riderDetailsForm.getRawValue());

    this.riderModel.Id = 0;
    this.riderModel.IsFlatRateContract = this.isFlatRate;
    this.riderModel.IsAdvancedSwitchingRatesEnabled = this.isAdvancedSwitchingRatesEnabled;
    this.riderModel.EffectiveDate = this.sharedService.ConvertToFormatedDate(
      this.riderModel.FormEffectiveDate
    );

    this.riderModel.ExpiryDate = this.sharedService.ConvertToFormatedDate(
      this.riderModel.FormExpiryDate
    );
    this.riderModel.PercentageRate = this.PrepareContractRateObject(
      this.riderModel.PercentageRate
    );
    this.riderModel.VendorCost = this.PrepareContractRateObject(
      this.riderModel.VendorCost
    );
    this.riderModel.CustomerRate = this.PrepareContractRateObject(
      this.riderModel.CustomerRate
    );
    this.riderModel.ReservedSpaces = this.sharedService.CheckIsEmpty(
      this.riderDetailsForm.controls['ReservedSpaces']?.value
    );

    this.riderModel.VendorId = this.selectedVendorId;
    this.riderModel.StorageFacilityId = this.selectedStorageFacilityId;
    this.riderModel.StorageFacilityName =
      this.selectedStorageFacilityId.toString();
    this.riderModel.CustomerId = this.selectedCustomerId;
    this.riderModel.CurrencyId =
      this.riderDetailsForm.controls['CurrencyName'].value;
    this.riderModel.CurrencyName =
      this.riderDetailsForm.controls['CurrencyName'].value.toString();
    this.riderModel.ContractTypeId =
      this.riderDetailsForm.controls['ContractTypeName'].value;
    this.riderModel.ContractTypeName =
      this.riderDetailsForm.controls['ContractTypeName'].value.toString();
    //this.riderModel.Rider = this.riderDetailsForm.controls['OrderNo'].value;
    this.riderModel.StorageFeatureIds = this.selectedFeatureIds;
    this.riderModel.storageFeatureViewModels = this.selectedFeatureList;

    this.setContractRateTypes();

    if (this.isAdvancedSwitchingRatesEnabled) {
      this.prepareAdvancedSwitchingRates();
    }
    this.riderModel.CarsStored = 0;
    const riderModel = JSON.parse(JSON.stringify(this.riderModel));
    this.riderService.SaveStorageOrder(riderModel).subscribe(result => {
        // let res = result;
        // this.riderModel.Id = result.Id;
        // this.StorageOrderId = this.riderModel.Id;
        // this.riderModel.Rider = result.Rider;
        // this.riderDetailsForm.patchValue({
        //   Rider: result.Rider
        // });
        this.toastr.success('Storage Order saved successfully.');

        // if (this.mode === APP_CONSTANTS.create || this.mode === APP_CONSTANTS.copy) {
        //   this.allowAdd = true;
        // }
        // this.mode = APP_CONSTANTS.view;
        // this.isEditMode = false;
        // this.isViewMode = true;
        // this.isCopyMode = false;
        // this.checkModeData();
        this.updateHistoryList(true);
      },
      (error) => {},
      () => {
        if (
          this.mode === APP_CONSTANTS.create ||
          this.mode === APP_CONSTANTS.copy
        ) {
          this.router.navigate(['/search/rider']);
        } else {
          if (this.StorageOrderId > 0) {
            this.router.navigate([
              '../search/rider/rider-details/view/' + this.StorageOrderId,
            ]);
          }
        }
      }
    );
  }

  public onUpdateRiderDetailsForm(): void {
    this.submittedDetails = true;
    // stop here if form is invalid
    const reserveSpaceField = this.riderDetailsForm.controls['ReservedSpaces'];
    if (
      reserveSpaceField.enabled &&
      this.sharedService.CheckIfEmptyOrNull(reserveSpaceField.value) === ''
    ) {
      reserveSpaceField.markAsTouched();
      reserveSpaceField.setErrors({
        notUnique: true,
      });
      return;
    }
    if (this.riderDetailsForm.invalid) {
      return;
    }
    this.riderModel = Object.assign(this.riderDetailsForm.getRawValue());

    this.riderModel.ReservedSpaces = this.sharedService.CheckIsEmpty(
      this.riderDetailsForm.controls['ReservedSpaces']?.value
    );

    this.riderModel.Id = this.StorageOrderId;
    this.riderModel.VendorId = this.selectedVendorId;
    this.riderModel.IsFlatRateContract = this.isFlatRate;
    this.riderModel.IsAdvancedSwitchingRatesEnabled = this.isAdvancedSwitchingRatesEnabled;

    this.riderModel.StorageFacilityId = this.selectedStorageFacilityId;
    this.riderModel.StorageFacilityName =
      this.riderModel.StorageFacilityName.toString();
    this.riderModel.CustomerId = this.selectedCustomerId;
    this.riderModel.CurrencyId =
      this.riderDetailsForm.controls['CurrencyName'].value;
    this.riderModel.CurrencyName =
      this.riderDetailsForm.controls['CurrencyName'].value.toString();
    this.riderModel.ContractTypeId =
      this.riderDetailsForm.controls['ContractTypeName'].value;
    this.riderModel.ContractTypeName =
      this.riderDetailsForm.controls['ContractTypeName'].value.toString();

    //this.riderModel.Rider = this.riderDetailsForm.controls['OrderNo'].value;
    this.riderModel.StorageFeatureIds = this.selectedFeatureIds;
    this.riderModel.EffectiveDate = this.sharedService.ConvertToFormatedDate(
      this.riderModel.FormEffectiveDate
    );
    this.riderModel.ExpiryDate = this.sharedService.ConvertToFormatedDate(
      this.riderModel.FormExpiryDate
    );

    this.riderModel.CustomerRate.Id = this.customerRateId;
    this.riderModel.VendorCost.Id = this.vendorCostId;
    this.riderModel.PercentageRate.Id = this.percentageRateId;
    this.riderModel.PercentageRate = this.PrepareContractRateObject(
      this.riderModel.PercentageRate
    );
    this.riderModel.VendorCost = this.PrepareContractRateObject(
      this.riderModel.VendorCost
    );
    this.riderModel.CustomerRate = this.PrepareContractRateObject(
      this.riderModel.CustomerRate
    );
    this.riderModel.storageFeatureViewModels = this.selectedFeatureList;

    this.setContractRateTypes();
    if (this.isAdvancedSwitchingRatesEnabled) {
      this.prepareAdvancedSwitchingRates();
    }
    const riderModel = JSON.parse(JSON.stringify(this.riderModel));
    this.riderService.SaveStorageOrder(riderModel).subscribe(
      (result) => {
        let res = result;
        this.toastr.success('Storage Order detail updated successfully.');
        this.mode = APP_CONSTANTS.update;
        this.isEditMode = false;
        this.isViewMode = true;
        this.isCopyMode = false;
        this.getStorageOrderDetailsById(this.StorageOrderId);
        this.updateHistoryList(true);
      },
      (error) => {}
    );
  }

  // set master contract rate type value
  private setContractRateTypes(): void {
    this.riderModel.CustomerRate.RateTypeId = this.RateTypes.filter((t) =>
      t.Name.trim().toLocaleLowerCase().includes('customer')
    )?.[0].Id;
    this.riderModel.VendorCost.RateTypeId = this.RateTypes.filter((t) =>
      t.Name.trim().toLocaleLowerCase().includes('vendor')
    )?.[0].Id;
    this.riderModel.PercentageRate.RateTypeId = this.RateTypes.filter((t) =>
      t.Name.trim().toLocaleLowerCase().includes('percentage')
    )?.[0].Id;
  }

  onCarsUpdated(carsStored) {
    this.riderModel.CarsStored = carsStored;
    this.riderDetailsForm.patchValue({
      CarsStored: carsStored,
    });
  }

  public onFormReset(): void {
    const options = {
      title: 'Warning',
      message: `Do you really want to discard changes?`,
      cancelText: 'No',
      confirmText: 'Yes',
    };
    this.dialogService.open(options);
    this.dialogService.confirmed().subscribe((confirmed) => {
      if (confirmed) {
        this.submittedDetails = false;
        if (
          this.mode === APP_CONSTANTS.create ||
          this.mode === APP_CONSTANTS.copy
        ) {
          if (this.currentUserRole == APP_CONSTANTS.Vendor) {
            this.resetFormByExcludingSpecifidFields(
              this.listOfFieldsExcludedFromResetOnCreateForVendor,
              this.riderDetailsForm
            );
          } else {
            this.resetFormByExcludingSpecifidFields(
              this.listOfFieldsExcludedFromResetOnCreateForAdmin,
              this.riderDetailsForm
            );
          }
          this.isTakeOrPay = false;
          this.onresetAdvancedSwitchingRates();

        } else if (this.mode === APP_CONSTANTS.edit) {
          if (this.currentUserRole == APP_CONSTANTS.Vendor) {
            this.resetFormByExcludingSpecifidFields(
              this.listOfFieldsExcludedFromResetOnUpdateForVendor,
              this.riderDetailsForm
            );
          } else {
            this.resetFormByExcludingSpecifidFields(
              this.listOfFieldsExcludedFromResetOnUpdateForAdmin,
              this.riderDetailsForm
            );
          }
          this.getStorageOrderDetailsById(this.StorageOrderId);
          this.onresetAdvancedSwitchingRates();
          this.enableDisableFieldsBasedOnModeInUpdate();
        }
      }
    });
  }

  private onresetAdvancedSwitchingRates(): void {
    // reset Advanced Switching rates
    if(this.sharedService.CheckIfEmptyOrNull(
      this.riderDetailsForm.controls['IsAdvancedSwitchingRatesEnabled']?.value) === APP_CONSTANTS.emptyString) {
      this.riderDetailsForm.controls['IsAdvancedSwitchingRatesEnabled'].patchValue(false);
    }
    this.isAdvancedSwitchingRatesEnabled=
    (this.riderDetailsForm.controls['IsAdvancedSwitchingRatesEnabled']?.value);

    this.manageSwitchInOutOnAdvanceSwitchingEnable(
      this.riderDetailsForm.controls['IsAdvancedSwitchingRatesEnabled']?.value);
  }

  public resetFormByExcludingSpecifidFields(fields, form: FormGroup): void {
    Object.keys(form.controls).forEach((key: string) => {
      const control = form.controls[key];
      if (control instanceof FormGroup) {
        this.resetFormByExcludingSpecifidFields(fields, control);
      } else {
        if (!fields.find(e => e == key)) {
          control.reset();
        }
      }
    });
  }

  public onDownloadTemplate(): void {
    let link = document.createElement('a');
    link.download = 'railcar-details-template';
    link.href = 'assets/download/railcar-details-template.xlsx';
    link.click();
  }

  public eventUpdate(eventName) {
    this.expandonClick = true;
    if (this.mode === APP_CONSTANTS.create && this.allowAdd || this.mode === APP_CONSTANTS.copy && this.allowAdd) {
      this.optionsConfig[0][eventName] = !this.optionsConfig[0][eventName];
    } else if (this.mode === APP_CONSTANTS.create || this.mode === APP_CONSTANTS.copy) {
      this.toastr.error('Please save Storage Order and continue.');
    } else if (this.mode !== APP_CONSTANTS.create || this.mode !== APP_CONSTANTS.copy) {
      this.optionsConfig[0][eventName] = !this.optionsConfig[0][eventName];
    }
  }
  public onCloseOtherDropdown(dropdownId) {}

  public onUploadAttachment() {
    this.addAttachmentSubject.next();
  }
  public onAddNotes() {
    this.addNoteSubject.next();
  }
  public onFocusNumber(element): void {
    // Correct Implementation
    const updateValue = element.target.value.replace(/[^0-9\.]+/g, '');
    element.target.value = updateValue;
  }
  public onBlurAmount(element) { // Correct Implimentation
     const formattedAmount = this.currencyPipe.transform(element.target.value, 'USD');
    element.target.value = formattedAmount;
  }
  public onBlurPercent(element): void {
    if (+element.target.value >= 0) {
      const formattedPercent = this.percentPipe.transform(+element.target.value/100,'1.1-2');
      element.target.value = formattedPercent ? formattedPercent : element.target.value;
    }
  }
  public onChangeEvent(event): void {
    const currentInfo = this.isFlatRate ? 'Flat Rate' : 'Percentage Margin';
    this.valadationEnableDisable();
    if (
      (this.riderDetailsForm.get('PercentageRate')?.touched &&
        !this.isFlatRate) ||
      ((this.riderDetailsForm.get('CustomerRate')?.touched ||
        this.riderDetailsForm.get('VendorCost')?.touched) &&
        this.isFlatRate)
    ) {
      const options = {
        title: 'Warning',
        message: `Your ${currentInfo} information will be lost. Do you want to proceed?`,
        cancelText: 'No',
        confirmText: 'Yes',
      };
      this.dialogService.open(options);
      this.dialogService.confirmed().subscribe((confirmed) => {
        if (this.isFlatRate === APP_CONSTANTS.false) {
          if (confirmed) {
            event.source.checked = true;
            this.isFlatRate = true;
            this.riderDetailsForm.get('PercentageRate')?.reset();
            this.riderDetailsForm
              .get('PercentageRate')
              ?.updateValueAndValidity();
          this.manageSwitchInOutOnAdvanceSwitchingEnable(this.isAdvancedSwitchingRatesEnabled);
          } else {
            event.source.checked = false;
            this.isFlatRate = false;
          }
        } else {
          if (confirmed) {
            event.source.checked = false;
            this.isFlatRate = false;
            this.riderDetailsForm.get('CustomerRate')?.reset();
            this.riderDetailsForm.get('VendorCost')?.reset();
            this.riderDetailsForm.get('CustomerRate')?.updateValueAndValidity();
            this.riderDetailsForm.get('VendorCost')?.updateValueAndValidity();
            // set Advanced switching rate checkbox
            this.manageSwitchInOutOnAdvanceSwitchingEnable(this.isAdvancedSwitchingRatesEnabled);
          } else {
            event.source.checked = true;
            this.isFlatRate = true;
          }
        }
      });
    } else {
      this.isFlatRate = event.checked;
      this.manageSwitchInOutOnAdvanceSwitchingEnable(this.isAdvancedSwitchingRatesEnabled);
    }
    this.setAdvancedSwitchingValidation(this.isAdvancedSwitchingRatesEnabled);
  }

  public valadationEnableDisable(): void {}

  public setPercentOnCreateByVendor(): void {
    if (
      this.mode === APP_CONSTANTS.create &&
      this.currentUserRole === 'Vendor'
    ) {
      this.isFlatRate = false;
    }
  }
  public onContractTypeChange(event): void {
    const reserveSpaceField = this.riderDetailsForm.controls['ReservedSpaces'];
    const custFlatRateHazmatSurcharge = (this.riderDetailsForm.get('CustomerRate') as FormGroup)?.controls['HazmatSurcharge'];
    const vendorFlatRateHazmatSurcharge = (this.riderDetailsForm.get('VendorCost') as FormGroup)?.controls['HazmatSurcharge'];
    const percentageRateHazmatSurcharge = (this.riderDetailsForm.get('PercentageRate') as FormGroup)?.controls['HazmatSurcharge'];
    const custFlatRateLoadedSurcharge = (this.riderDetailsForm.get('CustomerRate') as FormGroup)?.controls['LoadedSurcharge'];
    const vendorFlatRateLoadedSurcharge = (this.riderDetailsForm.get('VendorCost') as FormGroup)?.controls['LoadedSurcharge'];
    const percentageRateLoadedSurcharge = (this.riderDetailsForm.get('PercentageRate') as FormGroup)?.controls['LoadedSurcharge'];
    reserveSpaceField.markAsUntouched();
    let contractType = this.contractTypeList.find(
      (m) => m.Id == event.value
    ).Name;
    if (
      contractType.toLowerCase() ===
      APP_CONSTANTS.contractTypeReserve.toLowerCase()
    ) {
      this.contractTypeId = event.value;
      reserveSpaceField.enable();
      this.isRequiredResSpace = true;
    } else {
      reserveSpaceField.disable();
      reserveSpaceField.reset();
      this.isRequiredResSpace = false;
    }


    if(contractType.toLowerCase().startsWith((APP_CONSTANTS.TakeOrPay.toLowerCase()))) {
      this.isTakeOrPay = true;
      if(this.isFlatRate)
      {
        vendorFlatRateHazmatSurcharge.reset();
        custFlatRateHazmatSurcharge.reset();
        vendorFlatRateLoadedSurcharge.reset();
        custFlatRateLoadedSurcharge.reset();
      }
      else{
        percentageRateHazmatSurcharge.reset();
        percentageRateLoadedSurcharge.reset();
      }
    }
    else {
      this.isTakeOrPay = false;
    }
  }
  public updateHistoryList(event): void {
    this.configuration = this.generateRandomNumber();
  }

  public onChangeOfSOFeatures(event: any, feature: StorageFeatureModel) {
    if (
      this.selectedFeatureList === undefined ||
      this.selectedFeatureList === null
    ) {
      this.selectedFeatureList = [];
      this.selectedFeatureList.push(feature);
    } else {
      if (!this.selectedFeatureList.find((e) => e.Id == feature.Id)) {
        this.selectedFeatureList.push(feature);
      } else {
        this.selectedFeatureList.forEach((e) => {
          if (e.Id == feature.Id) {
            e.IsActive = event.source._selected;
          }
        });
      }
    }
  }

  /** Prepares the Proper ContactRate Object which we want to pass to API. (removed any unwanted charecte)
   * @method PrepareContractRateObject
   * @param contractRate The object of ContractRate class on which we want to prepare propertied for proper values.
   */
  public PrepareContractRateObject(contractRate: ContractRate): ContractRate {
    if (contractRate !== undefined && contractRate !== null) {
      contractRate.ListingFee = this.sharedService.CheckDecimalIsEmpty(
        contractRate.ListingFee
      );
      contractRate.BookingFee = this.sharedService.CheckDecimalIsEmpty(
        contractRate.BookingFee
      );
      contractRate.SwitchIn = this.sharedService.CheckDecimalIsEmpty(
        contractRate.SwitchIn
      );
      contractRate.SwitchOut = this.sharedService.CheckDecimalIsEmpty(
        contractRate.SwitchOut
      );
      contractRate.SpecialSwitchingRate =
        this.sharedService.CheckDecimalIsEmpty(
          contractRate.SpecialSwitchingRate
        );
      contractRate.DailyStorageRate = this.sharedService.CheckDecimalIsEmpty(
        contractRate.DailyStorageRate
      );
      contractRate.SwitchingRate = this.sharedService.CheckDecimalIsEmpty(
        contractRate.SwitchingRate
      );
      contractRate.HazmatSurcharge = this.sharedService.CheckDecimalIsEmpty(
        contractRate.HazmatSurcharge
      );
      contractRate.LoadedSurcharge = this.sharedService.CheckDecimalIsEmpty(
        contractRate.LoadedSurcharge
      );
      contractRate.CherryPickingRate = this.sharedService.CheckDecimalIsEmpty(
        contractRate.CherryPickingRate
      );
      contractRate.ReservationRate = this.sharedService.CheckDecimalIsEmpty(
        contractRate.ReservationRate
      );
      contractRate.HazmatSwitchIn = this.sharedService.CheckDecimalIsEmpty(
        contractRate.HazmatSwitchIn
      );
      contractRate.HazmatSwitchOut = this.sharedService.CheckDecimalIsEmpty(
        contractRate.HazmatSwitchOut
      );
      contractRate.LoadedSwitchIn = this.sharedService.CheckDecimalIsEmpty(
        contractRate.LoadedSwitchIn
      );
      contractRate.LoadedSwitchOut = this.sharedService.CheckDecimalIsEmpty(
        contractRate.LoadedSwitchOut
      );
    }
    return contractRate;
  }

  public generateRandomNumber(): any {
    const randomValue = new Uint32Array(1);
    self.crypto.getRandomValues(randomValue);
    return randomValue[0];
  }
  /** On check-uncheck of Advanced Switching Rate
   * @method AdvancedSwitchingRatesChanged
   * @param advancedSwitchRateEvent - click event on checkbox
   */
  public AdvancedSwitchingRatesChanged(advancedSwitchRateEvent: any) {
    if (advancedSwitchRateEvent.checked) {
      this.isAdvancedSwitchingRatesEnabled = true;
    } else {
      this.isAdvancedSwitchingRatesEnabled = false;
    }
    this.manageSwitchInOutOnAdvanceSwitchingEnable(
      advancedSwitchRateEvent.checked
    );
  }

  private manageSwitchInOutOnAdvanceSwitchingEnable(
    isAdvancedSwitchingEnabled: boolean
  ) {
    const custFlatRate = (
      this.riderDetailsForm.get('CustomerRate') as FormGroup
    )?.controls;
    const vendorFlatRate = (
      this.riderDetailsForm.get('VendorCost') as FormGroup
    )?.controls;
    const percentageRate = (
      this.riderDetailsForm.get('PercentageRate') as FormGroup
    )?.controls;

   // let advancedSwitchingPercentageRateControl=(percentageRate['AdvancedSwitchingRates'] as FormGroup)?.controls;

    if (!this.isFlatRate && isAdvancedSwitchingEnabled) {
      percentageRate['SwitchIn'].disable();
      percentageRate['SwitchOut'].disable();
      percentageRate['SwitchIn'].patchValue(null);
      percentageRate['SwitchOut'].patchValue(null);
      //this.setValidations(advancedSwitchingPercentageRateControl,['StandardSwitchIn','StandardSwitchOut']);
    }
    else if (!this.isFlatRate && !isAdvancedSwitchingEnabled) {
      percentageRate['SwitchIn'].enable();
      percentageRate['SwitchOut'].enable();
      //this.resetValidations(advancedSwitchingPercentageRateControl,['StandardSwitchIn','StandardSwitchOut']);
    }
    else if (this.isFlatRate && isAdvancedSwitchingEnabled) {
      custFlatRate['SwitchIn'].patchValue(null);
      custFlatRate['SwitchOut'].patchValue(null);
      vendorFlatRate['SwitchIn'].patchValue(null);
      vendorFlatRate['SwitchOut'].patchValue(null);

      custFlatRate['SwitchIn'].disable();
      custFlatRate['SwitchOut'].disable();
      vendorFlatRate['SwitchIn'].disable();
      vendorFlatRate['SwitchOut'].disable();

      // set advanced switching rate
      // let advancedSwitchingcustFlatRateControl=
      // (custFlatRate['AdvancedSwitchingRates'] as FormGroup)?.controls;
      // this.setValidations(advancedSwitchingcustFlatRateControl,['StandardSwitchIn','StandardSwitchOut']);

      // let advancedSwitchingvendorFlatRateControl=
      // (vendorFlatRate['AdvancedSwitchingRates'] as FormGroup)?.controls;
      // this.setValidations(advancedSwitchingvendorFlatRateControl,['StandardSwitchIn','StandardSwitchOut']);

    }
    else if (this.isFlatRate && !isAdvancedSwitchingEnabled) {
      custFlatRate['SwitchIn'].enable();
      custFlatRate['SwitchOut'].enable();
      vendorFlatRate['SwitchIn'].enable();
      vendorFlatRate['SwitchOut'].enable();
    }
    this.setAdvancedSwitchingValidation(isAdvancedSwitchingEnabled);
  }

  private setAdvancedSwitchingValidation(isAdvancedSwitchingEnabled: boolean): void {
    let advancedSwitchingcustFlatRateControl=
      ((this.riderDetailsForm.get('CustomerRate') as FormGroup)?.controls['AdvancedSwitchingRates'] as FormGroup)?.controls;

    let advancedSwitchingvendorFlatRateControl=
      ((this.riderDetailsForm.get('VendorCost') as FormGroup)?.controls['AdvancedSwitchingRates'] as FormGroup)?.controls;

    let advancedSwitchingPercentageRateControl=
    ((this.riderDetailsForm.get('PercentageRate') as FormGroup)?.controls['AdvancedSwitchingRates'] as FormGroup)?.controls;

    if (!this.isFlatRate && isAdvancedSwitchingEnabled) {
      this.setValidations(advancedSwitchingPercentageRateControl,
        ['StandardSwitchIn','StandardSwitchOut']);
      this.resetAdvancedSwitchingRatesValidation(advancedSwitchingcustFlatRateControl);
      this.resetAdvancedSwitchingRatesValidation(advancedSwitchingvendorFlatRateControl);
    }
    else if (!this.isFlatRate && !isAdvancedSwitchingEnabled) {
      this.resetAdvancedSwitchingRatesValidation(advancedSwitchingPercentageRateControl);
    }
    else if (this.isFlatRate && isAdvancedSwitchingEnabled) {
      this.setValidations(advancedSwitchingcustFlatRateControl,
        ['StandardSwitchIn','StandardSwitchOut']);
      this.setValidations(advancedSwitchingvendorFlatRateControl,
        ['StandardSwitchIn','StandardSwitchOut']);
      this.resetAdvancedSwitchingRatesValidation(advancedSwitchingPercentageRateControl);
    }
    else if (this.isFlatRate && !isAdvancedSwitchingEnabled) {
      this.resetAdvancedSwitchingRatesValidation(advancedSwitchingcustFlatRateControl);
      this.resetAdvancedSwitchingRatesValidation(advancedSwitchingvendorFlatRateControl);
    }
    else {
      this.resetAdvancedSwitchingRatesValidation(advancedSwitchingPercentageRateControl);
      this.resetAdvancedSwitchingRatesValidation(advancedSwitchingcustFlatRateControl);
      this.resetAdvancedSwitchingRatesValidation(advancedSwitchingvendorFlatRateControl);
    }
  }

  private resetAdvancedSwitchingRatesValidation(formControlName:any): void{
    this.resetValidations(formControlName
      ,['StandardSwitchIn',
      'StandardSwitchOut',
      'HazmatSwitchIn',
      'HazmatSwitchOut',
      'LoadedSwitchIn',
      'LoadedSwitchOut']);
      formControlName['IsAdvancedHazmatSwitchingEnabled'].patchValue(false);
      formControlName['IsAdvancedLoadedSwitchingEnabled'].patchValue(false);
  }

  private setValidations(formGroupName:any, formFields:any): void {
    formFields.forEach((key) => {
      formGroupName[key].setValidators(Validators.required);
      formGroupName[key].updateValueAndValidity();
    });
  }

  private resetValidations(formGroupName:any, formFields:any): void {
    formFields.forEach((key) => {
      formGroupName[key].setValidators(null);
      formGroupName[key].updateValueAndValidity();
      formGroupName[key].patchValue(null);
    });
  }
}

