import {
  Component,
  EventEmitter,
  Input,
  OnInit,
  Output,
  OnChanges,
  SimpleChanges,
  ChangeDetectorRef,
  ElementRef,
  ViewChild,
} from '@angular/core';
import {
  FormBuilder,
  FormGroup,
  Validators,
  FormArray,
  AbstractControl,
} from '@angular/forms';
import { APP_CONSTANTS } from 'src/app/app-constants';
import { StorageFeatureModel } from '../../../search/storagefeature/StoragefeatureModel';
import { DateValidators, NumValidators } from '../../directives/validatorDate';
import { CountryModel } from '../../models/country-model.model';
import { GeocodeStation } from '../../models/geocode-station.model';
import { RegionModel } from '../../models/region.model';
import { StateModel } from '../../models/state-model.model';
import { SharedService } from '../../shared.service';
import { ConfirmDialogService } from '../confirm-dialog/confirm-dialog.service';

import { debounceTime, switchMap, tap, finalize } from 'rxjs/operators';
import { Observable, of } from 'rxjs';
import { MasterDataService } from 'src/app/services/master-data.service';
import { ActivatedRoute} from '@angular/router';

@Component({
  selector: 'app-storage-facility-details',
  templateUrl: './storage-facility-details.component.html',
  styleUrls: ['./storage-facility-details.component.scss'],
})
export class StorageFacilityDetailsComponent implements OnInit, OnChanges {
  @Output() saveRates: EventEmitter<any> = new EventEmitter();
  @Output() deletedRate: EventEmitter<any> = new EventEmitter();
  @Output() deletedLocation: EventEmitter<any> = new EventEmitter();
  @Output() deletedInterchange: EventEmitter<any> = new EventEmitter();
  @Input() isFromPage: string = '';
  @Input() vendorFormData: any;
  @Input() availableRates: any;
  @Input() facilityDetailsForm; // Complete Facility details form as input
  @Input() nestedDisplay; // Identify if this component is in nested facility details
  @Input() isLastAllowed; // If last rates details needs to be shown
  @Input() isAllowedFromNestedDisplayRate; // If allowed to show from nested view for Rate
  @Input() isAllowedFromNestedDisplayInterchange; // If allowed to show from nested view for Interchange
  @Input() currentIndex: number;
  @Input() allStorageFacilityList: FormArray;
  public storageFacilityDetailsForm: FormGroup;
  //public StorageFeatures: FormControl; // Formgroup declearation for available Features for facility
  public submittedstorageFacilityDetails: boolean = false;
  public showRatesForm: boolean = false;
  public isRatesAvailable: boolean = false;
  public isRatesFormShown: boolean = true;
  public isInterchangeFormShown: boolean = true;
  public isSetRatesProcessOngoing: boolean = false;
  public isInterchangeProcessOngoing: boolean = false;
  public isSaveRateBtnEnabled: boolean = true;
  public isSaveInterchangeBtnEnabled: boolean = true;
  public parentComponentName: string = APP_CONSTANTS.StorageFacilityDetailsComponent;
    // public isLastAllowed: boolean = true;
  public featureList: StorageFeatureModel[];
  // public featureList = APP_CONSTANTS.fFeatureList;
  public copyOfRatesForm: any;
  public effDateValue: Date = new Date();
  public expDateValue: Date = new Date();
  public configuration: any;
  public getRateList: any;
  public isShowRatesTable: boolean = false;
  public isShowInterchangesTable: boolean = false;
  public CountryList: CountryModel[] = [];
  public StatesList: StateModel[] = [];
  public RegionList: RegionModel[] = [];
  public AllRegionList: RegionModel[] = [];
  public GeoCodeDetails: GeocodeStation[] = [];
  public noResults: boolean = false;
  public isSearching: boolean = false;
  public selectedFacilityStateCode: string = '';
  public defaultSelectedValueForDropdownlist = APP_CONSTANTS.emptyString;
  public oldvalue:string='';

  @ViewChild("facilityName") inputFacilityName: ElementRef;
  constructor(
    public formBuilder: FormBuilder,
    private cd: ChangeDetectorRef,
    private dialogService: ConfirmDialogService,
    private sharedService: SharedService,
    private masterDataService: MasterDataService,
    public route: ActivatedRoute,
    ) {}

  ngOnInit(): void {
    this.storageFacilityDetailsForm = this.facilityDetailsForm;
    //this.getAllCountries();
    //this.getAllRegions();
    //this.GetandCreateFeatures();
    this.enableDisableSections();
    this.setInitialRateAndInterchange();
      this.loadMasterData();
    this.loadCityList(this.storageFacilityDetailsForm.get('City'));
    this.setStateCode();
  }
  ngAfterViewInit() {
    this.route.params.subscribe((params: any) => {
     if((this.vendorFormData != undefined && this.sharedService.CheckIfEmptyOrNull(this.vendorFormData.controls.Organization.value) != '') || (params?.id > 0))
      {
      this.inputFacilityName.nativeElement.focus();
      }
    });
    }
  ngOnChanges(changes: SimpleChanges): void {
    this.cd.detectChanges();
    const isDataToCopy = changes['vendorFormData']?.currentValue;
    this.isVendorFacilityCommon(isDataToCopy);
  }

  private loadMasterData(): void{
     this.sharedService.getCountryList().subscribe((response) => {
      this.CountryList = response;
    });
    if(this.storageFacilityDetailsForm.value!=undefined && this.storageFacilityDetailsForm.value.CountryId > 0) {
       this.sharedService.getStatesList().subscribe((response) => {
        this.StatesList = response.filter((t) => t.CountryId == this.storageFacilityDetailsForm.value.CountryId.toString())});
        this.sharedService.getRegionsList().subscribe((response)=>{ this.RegionList=response});
    }
     this.sharedService.getStorageFeatures().subscribe((response)=>{this.featureList=response;});
  }

  private setStateCode(): void {
    if (
      this.sharedService.CheckIfEmptyOrNull(
        this.storageFacilityDetailsForm.get('StateId')?.value
      ) != ''
    ) {
      this.onStateSelectionChanged(
        this.storageFacilityDetailsForm.get('StateId')
      );
    }
  }

  /** Initilize Rates Details form
   * @method initilizeRatesForm
   * @returns FormGroup
   */
  public initilizeRatesForm(): FormGroup {
    return this.formBuilder.group(
      {
        Rate: [APP_CONSTANTS.emptyString],
        CurrencyId: [APP_CONSTANTS.emptyString, Validators.required],
        //PercentageMargin: [APP_CONSTANTS.emptyString, Validators.required],
        DailyStorageRate: [
          APP_CONSTANTS.null,
          {
            validators: [
              Validators.required,
              Validators.maxLength(9),
              Validators.min(0),
              Validators.max(999999),
            ],
            updateOn: 'change',
            asyncValidators: [],
          },
        ],
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
        HazmatSwitchInRate: [
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
        HazmatSwitchOutRate: [
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
        LoadedSwitchInRate: [
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
        LoadedSwitchOutRate: [
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
        FormEffectiveDate: [APP_CONSTANTS.null, Validators.required],
        FormExpiryDate: [APP_CONSTANTS.null, Validators.required],
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
      },
      {
        validator: Validators.compose([
          DateValidators.dateLessThan('FormEffectiveDate', 'FormExpiryDate', { expiryIssue : true}),
          NumValidators.numLessThan('AvailableCars', 'Capacity', { capacityIssue : true })
        ]),
      }
    );
  }

  /** Initilize Interchange Details form
   * @method initilizeInterchangeForm
   * @returns FormGroup
   */
  public initilizeInterchangeForm(): FormGroup {
    return this.formBuilder.group({
      Id: [APP_CONSTANTS.defaultNumberValue],
      StorageFacilityId: [APP_CONSTANTS.defaultNumberValue],
      RailRoadId: [APP_CONSTANTS.defaultNumberValue, [Validators.required]],
      RailRoadName: [APP_CONSTANTS.emptyString, [Validators.required]],
      MarkCode: [APP_CONSTANTS.emptyString, [Validators.required]],
      GrossRailRoadCapacity: [APP_CONSTANTS.emptyString],
      UnitId: [APP_CONSTANTS.defaultNumberValue],
      // R260: [APP_CONSTANTS.emptyString, [Validators.required]],
      // FSAC: [APP_CONSTANTS.emptyString, [Validators.required]],
      InterchangeLocations: this.formBuilder.array([]),
    });
  }

  /** Initilize Location Details form
   * @method initilizeLocationDetailsForm
   * @returns FormGroup
   */
  public initilizeLocationDetailsForm(): FormGroup {
    return this.formBuilder.group({
      Id: [APP_CONSTANTS.defaultNumberValue],
      InterchangeId: [APP_CONSTANTS.defaultNumberValue],
      CountryId: [APP_CONSTANTS.emptyString, [Validators.required]],
      StateId: [APP_CONSTANTS.emptyString, [Validators.required]],
      City: [APP_CONSTANTS.emptyString, [Validators.required, Validators.pattern(/^[a-zA-Z0-9-&. ]*$/)]],
      SPLC: [APP_CONSTANTS.emptyString, [Validators.required, Validators.pattern(/^[0-9]*$/)]],
      // StationName: [{value: APP_CONSTANTS.emptyString, disabled: APP_CONSTANTS.true}],
      Lat: [{ value: APP_CONSTANTS.emptyString, disabled: APP_CONSTANTS.true }],
      Long: [
        { value: APP_CONSTANTS.emptyString, disabled: APP_CONSTANTS.true },
      ],
      Description: [APP_CONSTANTS.emptyString],
      R260: [APP_CONSTANTS.emptyString],
      FSAC: [APP_CONSTANTS.emptyString],
    });
  }

  // convenience getter for easy access to storage facility form fields
  get storageFacilityDetails() {
    return this.storageFacilityDetailsForm.controls;
  }

  // convenience getter for easy access to rates form fields
  get getRatesForm() {
    return this.storageFacilityDetailsForm.controls[
      'StorageFacilityRates'
    ] as FormArray;
  }

  // convenience getter for easy access to Interchanges form fields
  get getInterchangesForm() {
    return this.storageFacilityDetailsForm.controls[
      'StorageFacilityInterchanges'
    ] as FormArray;
  }

  /** To set Initial Rates based on opened from which page and with check of nesting
   * @method setInitialRates
   */
  public setInitialRateAndInterchange(): void {
    const pageName = this.isFromPage;
    const controlStorageFacilityRates = this.storageFacilityDetailsForm
      .controls['StorageFacilityRates'] as FormArray;
    const controlInterchangeDetails = this.storageFacilityDetailsForm.controls[
      'StorageFacilityInterchanges'
    ] as FormArray;
    const isArray = Array.isArray(this.storageFacilityDetailsForm.controls);
    switch (pageName) {
      case APP_CONSTANTS.onBoardVendor:
        {
          if (!isArray && !this.nestedDisplay) {
            controlStorageFacilityRates.push(this.initilizeRatesForm());
            controlInterchangeDetails.push(this.initilizeInterchangeForm());
            (
              controlInterchangeDetails.controls[0].get(
                'InterchangeLocations'
              ) as FormArray
            ).push(this.initilizeLocationDetailsForm());
            this.saveRates.emit(this.storageFacilityDetailsForm);
          }
        }
        break;
      case APP_CONSTANTS.searchVendorDetails:
        {
          this.isLastAllowed = true;
          this.isRatesFormShown = true;
          this.isInterchangeFormShown = true;
          // this.availableRates.RatesDetails.filteredData.forEach((element, i) => {
          //    control.push(this.initilizeRatesForm());
          //    control.controls[i].patchValue(element);
          // });
          this.saveRates.emit(this.storageFacilityDetailsForm); // doughtful line
        }
        break;
    }
  }

  /** Add rates to the list
   * @method onSaveRates
   * @param event - click event on save rates
   */
  public onSaveRates(event: any): void {
    // Logic to be enabled after complete development
    this.submittedstorageFacilityDetails = true;
    this.storageFacilityDetailsForm.markAllAsTouched();
    if (this.storageFacilityDetailsForm.invalid) {
      return;
    }
    this.isRatesFormShown = false;
    this.isShowRatesTable = true;
    this.isSetRatesProcessOngoing = false;
    this.configuration = this.generateRandomNumber();
  }

  /** Add rates to the list
   * @method onSaveInterchanges
   * @param event - click event on save interchange
   */
  public onSaveInterchanges(event: any): void {
    // Logic to be enabled after complete development
    this.submittedstorageFacilityDetails = true;
    if (this.storageFacilityDetailsForm.controls['StorageFacilityInterchanges'].invalid) {
      return;
    }
    this.isInterchangeFormShown = false;
    this.isShowInterchangesTable = true;
    this.isInterchangeProcessOngoing = false;
    this.configuration = this.generateRandomNumber();
  }

  /** Remove rates to the list once added
   * @method onRemoveRates
   * @param i - Index of rate which needs to be removed from array
   */
  public onRemoveRates(i: number): void {
    const options = {
      title: 'Warning',
      message: `Are you sure you want to delete Rate ${i + 1}?`,
      cancelText: 'No',
      confirmText: 'Yes',
    };
    this.dialogService.open(options);
    this.dialogService.confirmed().subscribe((confirmed) => {
      if (confirmed) {
        const control = this.storageFacilityDetailsForm.controls[
          'StorageFacilityRates'
        ] as FormArray;

        // Save deleted rate detail
        if (control.value[i]?.Id != undefined && control.value[i]?.Id > 0) {
          this.deletedRate.emit(control.value[i]);
        }
        // end of save deleted rate detail

        control.removeAt(i);
        this.isRatesFormShown = false;
        this.isSetRatesProcessOngoing = false;
        this.configuration = this.generateRandomNumber();
      }
    });
  }

  /** Remove interchanges to the list once added
   * @method onRemoveInterchanges
   * @param i - Index of interchange which needs to be removed from array
   */
  public onRemoveInterchanges(i: number): void {
    const options = {
      title: 'Warning',
      message: `Are you sure you want to delete Interchange ${i + 1}?`,
      cancelText: 'No',
      confirmText: 'Yes'
    };
    this.dialogService.open(options);
    this.dialogService.confirmed().subscribe((confirmed) => {
      if (confirmed) {
        const control = this.storageFacilityDetailsForm.controls[
          'StorageFacilityInterchanges'
        ] as FormArray;

        // Save deleted interchange detail
        if (control.value[i]?.Id != undefined && control.value[i]?.Id > 0) {
          this.deletedInterchange.emit(control.value[i]);
        }
        // end of save deleted interchange detail

        control.removeAt(i);
        this.isInterchangeFormShown = false;
        this.isInterchangeProcessOngoing = false;
        this.configuration = this.generateRandomNumber();
      }
    });
  }

  /** To get Current Rates Form
   * @method getCurrentRatesForm
   * @param i - Index of selected rate form from array
   * @returns - Rate Details List at perticular index
   */
  public getCurrentRatesForm(i: number): any {
    const rateDetailsList = this.storageFacilityDetailsForm.get(
      'StorageFacilityRates'
    ) as FormArray;
    return rateDetailsList.at(i);
  }

  /** To get Rate Details Controls to generate rates form list
   * @method getRatesDetailsControls
   * @return - controls of Rate Details Form
   */
  public getRatesDetailsControls(): any {
    return (
      this.storageFacilityDetailsForm.get('StorageFacilityRates') as FormArray
    ).controls;
  }

  /** To get Interchange Details Controls to generate interchange list
   * @method getInterchangeDetailsControls
   * @return - controls of Interchange Details Form
   */
  public getInterchangeDetailsControls(): any {
    return (
      this.storageFacilityDetailsForm.get(
        'StorageFacilityInterchanges'
      ) as FormArray
    ).controls;
  }

  /** To execute at form submission
   * @method onSubmitstorageFacilityDetailsForm
   * @return - if invalid form or go to server logic
   */
  public onSubmitstorageFacilityDetailsForm(): void {
    this.submittedstorageFacilityDetails = true;
    this.checkIfFacilityNameIsExist(-1);
    // stop here if form is invalid
    if (this.storageFacilityDetailsForm.invalid) {
      return;
    }
  }

  /** To enable disable sections based on page name.
   * @method enableDisableSections
   */
  public enableDisableSections(): void {
    const pageName = this.isFromPage;
    switch (pageName) {
      case APP_CONSTANTS.onBoardVendor:
        {
          this.showRatesForm = true;
        }
        break;
      case APP_CONSTANTS.searchVendorDetails:
        {
        }
        break;
    }
  }

  /** To enable disable sections based on page name.
   * @method isVendorFacilityCommon
   * @param isDataToCopy - flag to see if storage facility and vendor are same.
   */
  public isVendorFacilityCommon(isDataToCopy: any): void {
    if (
      this.storageFacilityDetailsForm &&
      this.isFromPage === APP_CONSTANTS.onBoardVendor
    ) {
        if(isDataToCopy){
          this.sharedService.getRegionsList().subscribe((response)=>{this.RegionList=response});;
          this.storageFacilityDetailsForm.patchValue(isDataToCopy.getRawValue())
        }
        else{
          this.storageFacilityDetailsForm.reset();
          this.storageFacilityDetailsForm.patchValue({
            CountryId: APP_CONSTANTS.emptyString,
            StateId: APP_CONSTANTS.emptyString,
            RegionId: APP_CONSTANTS.emptyString
          });
        }

      if (isDataToCopy != undefined) {
        // Set value to Field which field name is not match
        this.storageFacilityDetailsForm.patchValue({
          PrimaryContactNumber: this.sharedService.CheckIfEmptyOrNull(
            isDataToCopy.value.PrimaryContactNo
          ),
          SecondaryContactNumber: isDataToCopy.value.SecondaryContactNo,
          PrimaryEmail: isDataToCopy.value.PrimaryContactEmail,
          SecondaryEmail: isDataToCopy.value.SecondaryContactEmail,
          City: APP_CONSTANTS.emptyString,
        });

      if(this.sharedService.CheckIsEmpty(isDataToCopy.value.StateId)!=null){
        this.getAllStates(isDataToCopy.value.CountryId);
        this.SetStateCodeOnStateChanged(isDataToCopy.value.StateId);
      }
      else if(this.sharedService.CheckIsEmpty(isDataToCopy.value.CountryId)!=null){
        this.getAllStates(isDataToCopy.value.CountryId);
        this.setRegionByCountry(isDataToCopy.value.CountryId);
      }
    }
    }
  }

  /** To get Current Rates Form
   * @method setRates
   * @param event - received from event emitter conveying new rate needs to be set
   */
  public setRates(event): void {
    const control = this.storageFacilityDetailsForm.controls[
      'StorageFacilityRates'
    ] as FormArray;
    control.push(this.initilizeRatesForm());
    this.configuration = this.generateRandomNumber();
    this.isRatesFormShown = true;
    if (this.nestedDisplay) {
      this.isAllowedFromNestedDisplayRate = true;
    }
  }

  /** To open New Interchanges Form
   * @method onAddInterchanges
   * @param event - received from event emitter conveying new rate needs to be set
   */
  public onAddInterchanges(): void {
    const control = this.storageFacilityDetailsForm.controls[
      'StorageFacilityInterchanges'
    ] as FormArray;
    control.push(this.initilizeInterchangeForm());
    (
      control.controls[control.controls.length - 1].get(
        'InterchangeLocations'
      ) as FormArray
    ).push(this.initilizeLocationDetailsForm());
    this.configuration = this.generateRandomNumber();
    this.isInterchangeFormShown = true;
    if (this.nestedDisplay) {
      this.isAllowedFromNestedDisplayInterchange = true;
    }
  }

  // /** To create control with available features for facility
  //  * @method GetandCreateFeatures
  //  */
  // public GetandCreateFeatures(): void {
  //   this.storageFeatureService.GetStorageFeaturesList().subscribe((result) => {
  //     this.featureList = result;
  //   });
  // }

  // /**To get all country list
  //    * @method getAllCountries
  //    */
  //  private getAllCountries(): void {
  //   this.masterDataService.getCountryList().subscribe((result) => {
  //     this.CountryList = result;
  //   });
  // }

  /** On selected country value changed
   * @method onCountrySelectionChanged
   * @param selectedCountry - selected country
   */
  public onCountrySelectionChanged(selectedCountry): void {
    this.selectedFacilityStateCode = '';
    this.StatesList =[];
    this.RegionList =[];
    this.storageFacilityDetailsForm.patchValue({
      City: '',
      SPLC: '',
      Lat: '',
      Long: '',
      IsTrimbleVerified: false,
      StateId: APP_CONSTANTS.emptyString,
      RegionId: APP_CONSTANTS.emptyString
    });
    this.getAllStates(selectedCountry.value);
    this.setRegionByCountry(selectedCountry.value);
  }

  /** Load all states on country selection changed
   * @method getAllStates
   * @param countryID - selected country ID
   */
  public getAllStates(countryID: number): void {
    //let stateMasterData;//= JSON.parse(JSON.stringify();
    this.sharedService.getStatesList().subscribe((response)=>{
      //stateMasterData=response
      this.StatesList=response.filter((t) => t.CountryId == countryID.toString())
    });
   // this.StatesList = stateMasterData.filter(
   //   (t) => t.CountryId == countryID.toString()
    //);

    // this.masterDataService
    //   .getStateListByCountryId(countryID)
    //   .subscribe((result) => {
    //     this.StatesList = result;
    //   });
  }

  /** On selected state value changed
   * @method onStateSelectionChanged
   * @param selectedState - selected state
   */
  public onStateSelectionChanged(selectedState: any): void {
    this.SetStateCodeOnStateChanged(selectedState.value);
  }

  /** Set State Code on State selection changed
   * @method SetStateCodeOnStateChanged
   * @param selectedStateId - selected state
   */
  public SetStateCodeOnStateChanged(selectedStateId: any): void {
    this.GeoCodeDetails = [];
    if (
      this.sharedService.CheckIfEmptyOrNull(selectedStateId) !=
      APP_CONSTANTS.emptyString
    ) {

      this.sharedService.getStatesList().subscribe((response) => {
        this.selectedFacilityStateCode = response.filter((t)=>t.Id==selectedStateId.toString())[0]?.Code;

      });
     // let stateMasterData = JSON.parse(JSON.stringify(this.sharedService.getStatesList()));
     // this.selectedFacilityStateCode = stateMasterData.filter(
      //  (t) => t.Id == selectedStateId.toString()
   //   )[0]?.Code;

    }
  }

  public onStationSelection(event: any) {

    if(event.option?.value.trim()!='')
    {
    this.setStationDetail(event.option.value.trim());
    }
   }

  public OnStationSelectionChanged(event: any) {
    if(event.target?.value.trim()!='')
    {
    this.setStationDetail(event.target.value.trim());
    }
  }

  private setStationDetail(selectedStationName: string): void {
    let selectedStationsList = JSON.parse(JSON.stringify(this.GeoCodeDetails));
    let geoCodeData = selectedStationsList.filter(
      (t) => t.StationName == selectedStationName
    )[0];
    if (geoCodeData != undefined && geoCodeData != null) {
      this.disableFieldOnStationSelection();
      this.storageFacilityDetailsForm.patchValue({
        City: selectedStationName,
        SPLC: geoCodeData.SPLC,
        Lat: geoCodeData.Latitude,
        Long: geoCodeData.Longitude,
        IsTrimbleVerified: true,
      });
    } else {
      this.enableFieldOnStationSelection();
      this.storageFacilityDetailsForm.patchValue({
        City: selectedStationName,
        SPLC: APP_CONSTANTS.emptyString,
        Lat: APP_CONSTANTS.emptyString,
        Long: APP_CONSTANTS.emptyString,
        IsTrimbleVerified: false,
      });
    }
  }

  private disableFieldOnStationSelection(): void {
    this.storageFacilityDetailsForm.controls['Lat']?.disable();
    this.storageFacilityDetailsForm.controls['Long']?.disable();
  }

  private enableFieldOnStationSelection(): void {
    this.storageFacilityDetailsForm.controls['Lat']?.enable();
    this.storageFacilityDetailsForm.controls['Long']?.enable();
  }

  /** Identify if set Rates process still going on
   * @method isSetRatesProcess
   * @param event - true or false from rates form component
   */
  public isSetRatesProcess(event): void {
    this.isSetRatesProcessOngoing = event;
  }

  /** Identify if Add Interchange process still going on
   * @method isAddInterchangeProcess
   * @param event - true or false from Interchange form component
   */
  public isAddInterchangeProcess(event): void {
    this.isInterchangeProcessOngoing = event;
  }

  // /**To get all region list
  //  * @method getAllRegions
  //  */
  // private getAllRegions(): void {
  //   this.masterDataService.getregionList().subscribe((result) => {
  //     this.AllRegionList = result;
  //   });
  // }

  /**To get all region list by country
   * @method setRegionByCountry
   * @param countryID - It will be id of country
   */
  private setRegionByCountry(countryID: number): void {

    this.sharedService.getRegionsList().subscribe((response) => {this.RegionList=response.filter((t)=>t.CountryId==countryID)});
      //this.RegionsList = response.filter((t) => t.CountryId == countryID)});
    //this.RegionList = this.sharedService.getRegionsList().filter((t) => t.CountryId == countryID ); }
    }
  /**To add location inside a Interchange
   * @method onAddLocation
   * @param index - index to add location
   */
  public onAddLocation(index) {
    const controlInterchangeDetails = this.storageFacilityDetailsForm.controls[
      'StorageFacilityInterchanges'
    ] as FormArray;
    (
      controlInterchangeDetails.controls[index].get(
        'InterchangeLocations'
      ) as FormArray
    ).push(this.initilizeLocationDetailsForm());
  }

  /**To remove location inside a Interchange
   * @method onRemoveLocation
   * @param LocationIndex - index to remove location
   * @param InterchangeIndex - index of interchange to whom location belongs
   */
  public onRemoveLocation(deleteLocation) {
    const InterchangeIndex = deleteLocation.InterchangeIndex;
    const LocationIndex = deleteLocation.LocationIndex;
    let locationList = (
      this.storageFacilityDetailsForm.get(
        'StorageFacilityInterchanges'
      ) as FormArray
    )
      ?.at(InterchangeIndex)
      .get('InterchangeLocations') as FormArray;
    if (
      locationList.value[LocationIndex]?.Id != undefined &&
      locationList.value[LocationIndex]?.Id > 0
    ) {
      this.deletedLocation.emit(locationList.value[LocationIndex]);
    }
    locationList.removeAt(LocationIndex);
  }

  public onUpperCase(event) {
    event.target.value = this.sharedService.toUpperCase(event);
  }

  /** To load Geocode stations on autocomplete (min 4 character required to enter)
   * @method loadCityList
   */
  public loadCityList(orgControl: AbstractControl | null): void {
    if (orgControl) {
      orgControl?.valueChanges
        .pipe(
          debounceTime(500),
          tap(() => {
            //this.GeoCodeDetails = [];
          }),
          switchMap((value) =>
            this.filterGeoCodeStations(value).pipe(
              finalize(() => {
                if (value.length > 1 && this.GeoCodeDetails.length === 0) {
                  this.noResults = true;
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
            this.GeoCodeDetails = data;
          }
        });
    }
  }

  /** To filter (when user start typing) and load Geocode stations from API based on user input
   * @method filterGeoCodeStations
   * @param val - entered city text
   */
  public filterGeoCodeStations(cityText: any): Observable<GeocodeStation[]> {
    let geoCodesList = JSON.parse(JSON.stringify(this.GeoCodeDetails));
    if (
      this.sharedService.CheckIfEmptyOrNull(cityText) != '' &&
      cityText.length > APP_CONSTANTS.SPLCAutoCompleteMinCharLength
    ) {
      this.isSearching = true;
      if (this.selectedFacilityStateCode != ''&& cityText!=this.oldvalue) {
         this.oldvalue = cityText;
        return this.masterDataService.GetGeoCodeStationDetail(
          cityText,
          this.selectedFacilityStateCode,
          APP_CONSTANTS.emptyString
          //this.storageFacilityDetailsForm.get('Mark')?.value
        );
      }
      return of(geoCodesList);

    } else {
      this.noResults = false;
      // if (geoCodesList.length > 0) {
      //   return of(geoCodesList);
      // }
      return of([]);
    }
  }

  // private getCityText(inputText: string): string {
  //   if (this.sharedService.CheckIfEmptyOrNull(inputText) != '') {
  //     if (inputText.indexOf(',') > -1) {
  //       return inputText.split(',')[0].toString();
  //     } else if (inputText.indexOf('-') > -1) {
  //       return inputText.split('-')[0].toString();
  //     } else {
  //       return inputText;
  //     }
  //   }
  //   return '';
  // }


  public onFacilityNameChanged(currentIndex: number): void {
    this.checkIfFacilityNameIsExist(currentIndex);
  }

  public generateRandomNumber(): any {
    const randomValue = new Uint32Array(1);
    self.crypto.getRandomValues(randomValue);
    return randomValue[0];
  }

  /** Check whether newly added facility name is already exist or not
   * @method checkIfFacilityNameIsExist
   * @param currentIndex: current index of record
   */
  private checkIfFacilityNameIsExist(currentIndex: number): void {
    //this.isValidFacilityName = true;
    if (
      this.allStorageFacilityList != undefined &&
      this.allStorageFacilityList != null &&
      this.allStorageFacilityList.length > 1
    ) {
      for (let i = 0; i < this.allStorageFacilityList.value.length; i++) {
        if (currentIndex != i) {
          let facilityData = this.allStorageFacilityList.value[i];
          let currentFacilityName =
            this.storageFacilityDetailsForm.get('Name')?.value;
          let currentSFId = this.storageFacilityDetailsForm.get('Id')?.value;
          if (currentSFId != undefined && currentSFId > 0) {
            if (
              this.sharedService.CheckIfEmptyOrNull(currentFacilityName) !=
                APP_CONSTANTS.emptyString &&
              facilityData.Id != currentSFId &&
              facilityData.Name.trim().toLowerCase() ===
                currentFacilityName.trim().toLowerCase()
            ) {
              //this.isValidFacilityName = false;
              this.storageFacilityDetailsForm.controls['Name'].setErrors({
                notUnique: true,
              });
            }
          } else {
            if (
              this.sharedService.CheckIfEmptyOrNull(currentFacilityName) !=
                APP_CONSTANTS.emptyString &&
              facilityData.Name.trim().toLowerCase() ===
                currentFacilityName.trim().toLowerCase()
            ) {
             // this.isValidFacilityName = false;
              this.storageFacilityDetailsForm.controls['Name'].setErrors({
                notUnique: true,
              });
            }
          }
        }
      }
    }
  }
}
