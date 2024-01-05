import { Component, OnInit } from '@angular/core';
import { FormArray, FormBuilder, FormGroup, Validators } from '@angular/forms';
import { ActivatedRoute } from '@angular/router';
import { APP_CONSTANTS } from 'src/app/app-constants';
import { ChangeDetectorRef } from '@angular/core';
import { MatTableDataSource } from '@angular/material/table';
import { TranslateService } from '@ngx-translate/core';
import { VendorService } from '../vendor/vendor-service';
import { ToastrService } from 'ngx-toastr';
import { SharedService } from 'src/app/shared/shared.service';
import { VendorModel } from '../vendor/VendorModel';
import { ConfirmDialogService } from 'src/app/shared/components/confirm-dialog/confirm-dialog.service';
import { InterchangeLocations } from 'src/app/shared/models/interchange-locations.model';
import { StorageFacilityModel } from '../storage-facility/StorageFacilityModel';
import { StorageFacilityRatesModel } from '../storage-facility-rates/storage-facility-rates.model';
import { StorageFacilityInterchangesModel } from 'src/app/shared/models/storage-facility-interchanges.model';
import { StorageFeatureModel } from '../storagefeature/StoragefeatureModel';
import { DateValidators,NumValidators } from 'src/app/shared/directives/validatorDate';
import { AuthService } from 'src/app/services/auth.service';
import { ApiService } from 'src/app/services/api.service';
import { PercentPipe } from '@angular/common';

@Component({
  selector: 'app-vendor-details',
  templateUrl: './vendor-details.component.html',
  styleUrls: ['./vendor-details.component.scss'],
})
export class VendorDetailsComponent implements OnInit {
  public pageTitle: string = '';
  public mode: string = '';
  public isViewMode: boolean = false;
  public isEditMode: boolean = false;
  public vendorDetailsForm: FormGroup;
  public Features: FormGroup;
  public newFacilityDetailsForm: FormGroup;
  public submittedVendorDetails: boolean = false;
  public bsConfig = APP_CONSTANTS.bsConfig;
  public effDateValue: Date = new Date();
  public expDateValue: Date = new Date();
  public isFromPage: string = APP_CONSTANTS.searchVendorDetails;
  public isRatesDataAvailable: boolean = true;
  public isStorageFacilityOpen: boolean = false;
  public isCreateUpdate: boolean = false;
  public copyOfVendorFormData = undefined;
  public reFrameTable: boolean = true;
  public isAddEnabled: boolean = false;
  public isUpdateEnabled: boolean = true;
  public isAddUpdate: boolean = false;
  public nestedDisplay: boolean = false;
  public vendorData: any;
  public showAddCancel: boolean = false;
  // For Table expand collapse code Start
  data: any[] = APP_CONSTANTS.USERS;
  public currentUserRole: string = '';
  dataSource: MatTableDataSource<any>;
  columnsToDisplay = [
    'expand',
    'Facility',
    'Location',
    'Interchange',
    'AvailableSpace',
    'PrimaryContact',
    'PrimaryEmail',
    'Delete',
  ];
  innerDisplayedColumns = ['expand', 'Rates', 'EffectiveDate', 'ExpiryDate'];
  innerInnerDisplayedColumns = ['comment', 'commentStatus'];
  public convertToPercentage = ['PercentageMargin'];
  expandedElement: any | null;
  isNestedFacilityAvailable: boolean = false;
  public vendorModel = new VendorModel();
  // For Table expand collapse code End
  public currentVendorId: number = 0;
  public deletedInterchangeList: StorageFacilityInterchangesModel[] = [];
  public deletedInterchangeLocations: InterchangeLocations[] = [];
  public deletedRatesList: StorageFacilityRatesModel[] = [];
  public deletedStorageFacility: any[] = [];
  public deletedFeatureIds: any[] = [];
  public persistPreviousData: any;
  public updateButtonEnable:boolean = false;
  constructor(
    public route: ActivatedRoute,
    public translate: TranslateService,
    public formBuilder: FormBuilder,
    public cd: ChangeDetectorRef,
    private vendorService: VendorService,
    public toastr: ToastrService,
    private dialogService: ConfirmDialogService,
    private sharedService: SharedService,
    private authService: AuthService,
    private percentPipe: PercentPipe
  ) {}

  ngOnInit(): void {
    this.route.params.subscribe((params: any) => {
      this.mode = params.mode;
      this.currentVendorId = params.id;
    });
    this.authService.getUserId();
    this.currentUserRole = ApiService.CurrentRole.split('_')[0];
    this.checkModeData();
    this.initializeVendorDetailsForm();
    this.getVendorDataFromServer();
  }

  /** To check current form mode and act accordingly
   * @method checkModeData
   */
  public checkModeData(): void {
    switch (this.mode) {
      case APP_CONSTANTS.create:
        this.isEditMode = false;
        this.isViewMode = false;
        this.pageTitle = this.translate.instant('common.on-board');
        break;
      case APP_CONSTANTS.edit:
        this.isEditMode = true;
        this.isViewMode = false;
        this.pageTitle = this.translate.instant('common.update');
        break;
      case APP_CONSTANTS.view:
        this.isEditMode = false;
        this.isViewMode = true;
        this.pageTitle = this.translate.instant('common.view');
        this.isCreateUpdate = true;
        break;
    }
  }

  /** Change Mode to update
   * @method onUpdate
   */
  public onUpdate(): void {
    this.mode = APP_CONSTANTS.edit;
    this.isAddUpdate = true;
    this.checkModeData();
    this.isCreateUpdate = false;
  }

  /** Initilize Vendor Details form
   * @method initilizeVendorDetailsForm
   */
  public initializeVendorDetailsForm(): void {
    this.vendorDetailsForm = this.formBuilder.group({
      ContactPersonName: [APP_CONSTANTS.emptyString, [Validators.required, Validators.pattern(/^[a-zA-Z0-9 ]*$/)]],
      PrimaryContactNo: [APP_CONSTANTS.emptyString, [Validators.required, Validators.pattern(/^[0-9 +()-]*$/)]],
      PrimaryContactEmail: [APP_CONSTANTS.emptyString, [Validators.required, Validators.email]],
      SecondaryContactNo: [APP_CONSTANTS.emptyString, [Validators.pattern(/^[0-9 +()-]*$/)]],
      SecondaryContactEmail: [APP_CONSTANTS.emptyString, Validators.email],
      Address: [APP_CONSTANTS.emptyString],
      CountryId: [APP_CONSTANTS.emptyString],
      StateId: [APP_CONSTANTS.emptyString],
      City: [APP_CONSTANTS.emptyString, Validators.pattern(/^[a-zA-Z0-9-&. ]*$/)],
      ZipCode: [APP_CONSTANTS.emptyString, Validators.pattern(/^[a-zA-Z0-9 ]*$/)],
      Organization: [APP_CONSTANTS.emptyString, [Validators.required, Validators.pattern(/^[a-zA-Z0-9-&. ]*$/)]],
      OrganizationId: [APP_CONSTANTS.defaultNumberValue],
      Region: [APP_CONSTANTS.emptyString],
      Subsidary: [APP_CONSTANTS.emptyString],
      FormEffectiveDate: [APP_CONSTANTS.null, Validators.required],
      FormExpiryDate: [APP_CONSTANTS.null, Validators.required],
      Website: [APP_CONSTANTS.emptyString],
      Description: [APP_CONSTANTS.emptyString],
      RegionId: [APP_CONSTANTS.emptyString],
      PercentageMargin: [APP_CONSTANTS.emptyString, {
        validators:[Validators.required,
                    Validators.min(0),
                    Validators.max(100)],
        updateOn: 'change',
        asyncValidators: []
      }
        ],
      StorageFacilities: this.formBuilder.array([]),
    }, { validator: Validators.compose([
      DateValidators.dateLessThan('FormEffectiveDate', 'FormExpiryDate', { 'expiryIssue': true })
  ])});
  }

  /** Storage Facility Details form initilization
   * @method addStorageFacility
   * @returns FormGroup
   */
  public addStorageFacility(): FormGroup {
    return this.formBuilder.group({
      Name: [APP_CONSTANTS.emptyString, [Validators.required, Validators.pattern(/^[a-zA-Z0-9-&. ]*$/)]],
      Mark: [APP_CONSTANTS.emptyString, [Validators.required]],
      StationName: [{value: APP_CONSTANTS.emptyString, disabled: APP_CONSTANTS.true}],
      Lat: [{value: APP_CONSTANTS.emptyString, disabled: APP_CONSTANTS.true}],
      Long: [{value: APP_CONSTANTS.emptyString, disabled: APP_CONSTANTS.true}],
      Capacity: [APP_CONSTANTS.emptyString, [Validators.required, Validators.pattern(/^[0-9]*$/)]],
      AvailableCars: [APP_CONSTANTS.emptyString, [Validators.required, Validators.pattern(/^[0-9]*$/)]],
      Rating: [APP_CONSTANTS.defaultNumberValue],
      PrimaryContactNumber: [APP_CONSTANTS.emptyString, [Validators.required, Validators.pattern(/^[0-9 +()-]*$/)]],
      PrimaryEmail: [APP_CONSTANTS.emptyString, [Validators.required, Validators.email]],
      SecondaryContactNumber: [APP_CONSTANTS.emptyString, [Validators.pattern(/^[0-9 +()-]*$/)]],
      SecondaryEmail: [APP_CONSTANTS.emptyString, Validators.email],
      FormEffectiveDate: [APP_CONSTANTS.emptyString, Validators.required],
      FormExpiryDate: [APP_CONSTANTS.emptyString, Validators.required],
      Address: [APP_CONSTANTS.emptyString],
      ZipCode: [APP_CONSTANTS.emptyString, Validators.pattern(/^[a-zA-Z0-9 ]*$/)],
      CountryId: [APP_CONSTANTS.emptyString, Validators.required],
      StateId: [APP_CONSTANTS.emptyString, Validators.required],
      RegionId: [APP_CONSTANTS.emptyString,Validators.required],
      City: [APP_CONSTANTS.emptyString, [Validators.pattern(/^[a-zA-Z0-9-&. ]*$/), Validators.required]],
      SPLC: [APP_CONSTANTS.emptyString, [Validators.pattern(/^[0-9]*$/)]],
      Priority: [APP_CONSTANTS.emptyString],
      StorageFacilityRates: this.formBuilder.array([]),
      StorageFacilityInterchanges: this.formBuilder.array([]),
      StorageFeatures: [APP_CONSTANTS.emptyString],
      VendorId: [APP_CONSTANTS.defaultNumberValue],
      Id: [APP_CONSTANTS.defaultNumberValue],
      IsTrimbleVerified:[false],
    }, { validator: Validators.compose([
      DateValidators.dateLessThan('FormEffectiveDate', 'FormExpiryDate', { 'expiryIssue' : true }),
      NumValidators.numLessThan('AvailableCars', 'Capacity', { 'capacityIssue' : true })

  ])});
  }

  /** Initialize Rates Details form
   * @method initializeRatesForm
   * @returns FormGroup
   */
  public initializeRatesForm(): FormGroup {
    return this.formBuilder.group({
      Id: [APP_CONSTANTS.defaultNumberValue],
      StorageFacilityId: [APP_CONSTANTS.defaultNumberValue],
      Rate: [APP_CONSTANTS.emptyString],
      CurrencyId: [APP_CONSTANTS.emptyString, Validators.required],
      //PercentageMargin: [APP_CONSTANTS.emptyString, Validators.required],
      DailyStorageRate: [APP_CONSTANTS.null, {
        validators:[
                    Validators.required,
                    Validators.maxLength(9),
                    Validators.min(0),
                    Validators.max(999999)],
        updateOn: 'change',
        asyncValidators: []
      }],
      SwitchIn: [APP_CONSTANTS.null, {
        validators:[
                    Validators.maxLength(9),
                    Validators.min(0),
                    Validators.max(999999)],
        updateOn: 'change',
        asyncValidators: []
      }],
      SwitchOut: [APP_CONSTANTS.null, {
        validators:[
                    Validators.maxLength(9),
                    Validators.min(0),
                    Validators.max(999999)],
        updateOn: 'change',
        asyncValidators: []
      }],
      SwitchingRate: [APP_CONSTANTS.null, {
        validators:[
                    Validators.maxLength(9),
                    Validators.min(0),
                    Validators.max(999999)],
        updateOn: 'change',
        asyncValidators: []
      }],
      SpecialSwitchingRate: [APP_CONSTANTS.null, {
        validators:[
                    Validators.maxLength(9),
                    Validators.min(0),
                    Validators.max(999999)],
        updateOn: 'change',
        asyncValidators: []
      }],
      HazmatSwitchInRate: [APP_CONSTANTS.null, {
        validators:[
                    Validators.maxLength(9),
                    Validators.min(0),
                    Validators.max(999999)],
        updateOn: 'change',
        asyncValidators: []
      }],
      HazmatSwitchOutRate: [APP_CONSTANTS.null, {
        validators:[
                    Validators.maxLength(9),
                    Validators.min(0),
                    Validators.max(999999)],
        updateOn: 'change',
        asyncValidators: []
      }],
      LoadedSwitchInRate: [APP_CONSTANTS.null, {
        validators:[
                    Validators.maxLength(9),
                    Validators.min(0),
                    Validators.max(999999)],
        updateOn: 'change',
        asyncValidators: []
      }],
      LoadedSwitchOutRate: [APP_CONSTANTS.null, {
        validators:[
                    Validators.maxLength(9),
                    Validators.min(0),
                    Validators.max(999999)],
        updateOn: 'change',
        asyncValidators: []
      }],
      CherryPickingRate: [APP_CONSTANTS.null, {
        validators:[
                    Validators.maxLength(9),
                    Validators.min(0),
                    Validators.max(999999)],
        updateOn: 'change',
        asyncValidators: []
      }],
      FormEffectiveDate: [APP_CONSTANTS.null, Validators.required],
      FormExpiryDate: [APP_CONSTANTS.null, Validators.required],
      ReservationRate: [APP_CONSTANTS.null, {
        validators:[
                    Validators.maxLength(9),
                    Validators.min(0),
                    Validators.max(999999)],
        updateOn: 'change',
        asyncValidators: []
      }],
    }, { validator: Validators.compose([
      DateValidators.dateLessThan('FormEffectiveDate', 'FormExpiryDate', { 'expiryIssue': true })
  ])});
  }

  public initializeInterchangesForm(): FormGroup {
    return this.formBuilder.group({
      Id: [APP_CONSTANTS.defaultNumberValue],
      StorageFacilityId: [APP_CONSTANTS.defaultNumberValue],
      RailRoadId: [APP_CONSTANTS.defaultNumberValue, [Validators.required]],
      RailRoadName: [APP_CONSTANTS.emptyString, [Validators.required]],
      MarkCode: [APP_CONSTANTS.emptyString, [Validators.required]],
      GrossRailRoadCapacity: [APP_CONSTANTS.emptyString],
      // R260: [APP_CONSTANTS.emptyString, [Validators.required]],
      // FSAC: [APP_CONSTANTS.emptyString, [Validators.required]],
      UnitId: [APP_CONSTANTS.defaultNumberValue],
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
      // StationName: [{value: APP_CONSTANTS.emptyString, disabled: APP_CONSTANTS.true}],
      SPLC: [APP_CONSTANTS.emptyString, [Validators.required, Validators.pattern(/^[0-9]*$/)]],
      Lat: [{value: APP_CONSTANTS.emptyString, disabled: APP_CONSTANTS.true}],
      Long: [{value: APP_CONSTANTS.emptyString, disabled: APP_CONSTANTS.true}],
      Description: [APP_CONSTANTS.emptyString],
      R260: [APP_CONSTANTS.emptyString],
      FSAC: [APP_CONSTANTS.emptyString],
    });
  }

  /** Storage Facility Details form initilization
   * @method storageFacilityDetailsArray
   * @returns FormArray
   */
  get storageFacilityDetailsArray(): FormArray {
    return this.vendorDetailsForm.get('StorageFacilities') as FormArray;
  }

  /** Storage Facility Details form initialization
   * @method saveRates
   * @returns event - click event for saving rate
   */
  public saveRates(event: any): void {}

  /** Storage Facility Details form initilization
   * @method onAddStorageFacility
   * @returns event - click event for adding new facility
   */
  public onAddStorageFacility(event): void {
    if (event) {
      this.isStorageFacilityOpen = true;
      let storageFacility = this.vendorDetailsForm.get(
        'StorageFacilities'
      ) as FormArray;
      this.storageFacilityDetailsArray.push(this.addStorageFacility());
      let storageFacilityRates = (
        this.vendorDetailsForm.get('StorageFacilities') as FormArray
      )
        ?.at(this.storageFacilityDetailsArray.length - 1)
        .get('StorageFacilityRates') as FormArray;
      let storageFacilityInterchange = (
        this.vendorDetailsForm.get('StorageFacilities') as FormArray
      )
        ?.at(this.storageFacilityDetailsArray.length - 1)
        .get('StorageFacilityInterchanges') as FormArray;
      // this.addStorageFacilityRatesControls(data.StorageFacilityRates, index);
      storageFacilityRates.push(this.initializeRatesForm());
      storageFacilityInterchange.push(this.initializeInterchangesForm());
      (
        storageFacilityInterchange
          .at(0)
          .get('InterchangeLocations') as FormArray
      ).push(this.initilizeLocationDetailsForm());
      this.showAddCancel = true;
      this.isAddEnabled = true;
      this.isUpdateEnabled = false;
    }
  }

  /** To get Vendor data to update from server
   * @method getVendorDataFromServer
   */
  public getVendorDataFromServer(): void {
    this.vendorService
      .GetVendorDetails(this.currentVendorId)
      .subscribe((result) => {
        const transformData = result;
       result.FormEffectiveDate=this.sharedService.ConvertToDatePickerDate(result.EffectiveDate);
       result.FormExpiryDate=this.sharedService.ConvertToDatePickerDate(result.ExpiryDate);
       transformData.StorageFacilities.forEach((control) => {
          let updateSelectedFeature = control.StorageFeatures.map((x) => x.Id);
          control.StorageFeatures = updateSelectedFeature;
           // date conversion
           control.FormEffectiveDate=this.sharedService.ConvertToDatePickerDate(control.EffectiveDate);
           control.FormExpiryDate=this.sharedService.ConvertToDatePickerDate(control.ExpiryDate);

           control.StorageFacilityRates.forEach((ratesData)=>{
          // date conversion
          ratesData.FormEffectiveDate=this.sharedService.ConvertToDatePickerDate(ratesData.EffectiveDate);
          ratesData.FormExpiryDate=this.sharedService.ConvertToDatePickerDate(ratesData.ExpiryDate);
           })
        });

        this.vendorData = transformData;
        // //(this.vendorDetailsForm.get("StorageFacilities") as FormGroup).("StorageFacilitiesDetails", new FormControl(this.vendorData.StorageFacilities))
        this.vendorData.StorageFacilities.forEach((response, index) => {
          this.storageFacilityDetailsArray.push(this.addStorageFacility());

          this.storageFacilityDetailsArray.controls[index].patchValue(response);
          //this.addFeaturesControls(data.StorageFeatures, index);
          this.addStorageFacilityInterchangesControls(
            response.StorageFacilityInterchanges,
            index
          );
          this.addStorageFacilityRatesControls(
            response.StorageFacilityRates,
            index
          );
        });
        this.vendorDetailsForm.patchValue(this.vendorData);
        this.getAndSetDefaultValue(result);
        this.convertToPercentage.forEach(key => {
          if ((this.vendorDetailsForm.get(key)?.value) && this.vendorDetailsForm.get(key)?.value !== APP_CONSTANTS.null) {
            const formattedPercent = this.percentPipe.transform(this.vendorDetailsForm.get(key)?.value / 100, '1.1-2');
            this.vendorDetailsForm.get(key)?.patchValue(formattedPercent);
          }
        });
        this.persistPreviousData = this.vendorData;
        this.isNestedFacilityAvailable = true;
      });
  }

  /** used to reset default value After getting data from server
   * @method getAndSetDefaultValue
   */
  private getAndSetDefaultValue(response: VendorModel): void {
     if(response.CountryId == null) {
      this.vendorDetailsForm.patchValue({
        CountryId: APP_CONSTANTS.emptyString,
        StateId: APP_CONSTANTS.emptyString,
        RegionId: APP_CONSTANTS.emptyString
      })
     }
     else if(response.StateId == null && response.RegionId == null){
      this.vendorDetailsForm.patchValue({
        StateId: APP_CONSTANTS.emptyString,
        RegionId: APP_CONSTANTS.emptyString
      })
     }
     else if(response.StateId == null){
      this.vendorDetailsForm.patchValue({
        StateId: APP_CONSTANTS.emptyString,
        RegionId: APP_CONSTANTS.emptyString
      })
     }
     else if(response.RegionId == null){
      this.vendorDetailsForm.patchValue({
        RegionId: APP_CONSTANTS.emptyString
      })
     }
  }

  /** Trigger when add
   * @method onAdd
   */
  public onAdd(): void {
    this.vendorDetailsForm.markAllAsTouched();
    if (this.vendorDetailsForm.invalid) {
      return;
    }
    this.isStorageFacilityOpen = false;
    // this.isRatesDataAvailable = true;
    this.isAddEnabled = false;
    this.isUpdateEnabled = true;
    this.reFrameTable = !this.reFrameTable;
  }

  /** To add features for respective facility based on index
   * @method addFeaturesControls
   * @param - featuresControls - object of type FormGroup
   * @param - index - current index for iteration
   */
  public addFeaturesControls(featuresControls, index): void {
    // let totalFeatures = Object.keys(featuresControls);
    // let Features = (this.vendorDetailsForm.get('StorageFacilities') as FormArray)?.at(index).get('StorageFeatures') as FormGroup;
    // if (totalFeatures && this.vendorDetailsForm) {
    //   featuresControls.forEach(control=>{
    //     Features?.addControl(control.Id, new FormControl(true))
    //    })
    // }
  }

  /** To add storage facility for respective facility based on index
   * @method addStorageFacilityInterchangesControls
   * @param - StorageFacilityInterchanges - object of type FormArray
   * @param - index - current index for iteration
   */
  public addStorageFacilityInterchangesControls(
    StorageFacilityInterchanges,
    index
  ): void {
    let totalStorageFacilityInterchanges = Object.keys(
      StorageFacilityInterchanges
    );
    let storageFacilityInterchanges = (
      this.vendorDetailsForm.get('StorageFacilities') as FormArray
    )
      ?.at(index)
      .get('StorageFacilityInterchanges') as FormArray;
    if (StorageFacilityInterchanges && this.vendorDetailsForm) {
      StorageFacilityInterchanges.forEach((control, index) => {
        storageFacilityInterchanges.push(this.initializeInterchangesForm());
        control.InterchangeLocations.forEach((control) => {
          (
            storageFacilityInterchanges
              .at(index)
              .get('InterchangeLocations') as FormArray
          ).push(this.initilizeLocationDetailsForm());
        });
       storageFacilityInterchanges.controls[index].patchValue(control);
      });
    }
  }

  /** To add storage Interchange for respective facility based on index
   * @method addStorageFacilityRatesControls
   * @param - storageFacilityRatesControls - object of type FormGroup
   * @param - index - current index for iteration
   */
  public addStorageFacilityRatesControls(
    storageFacilityRatesControls,
    index
  ): void {
    let totalStorageFacilityRates = Object.keys(storageFacilityRatesControls);
    let storageFacilityRates = (
      this.vendorDetailsForm.get('StorageFacilities') as FormArray
    )
      ?.at(index)
      .get('StorageFacilityRates') as FormArray;
    if (storageFacilityRatesControls && this.vendorDetailsForm) {
      storageFacilityRatesControls.forEach((control, index) => {
        storageFacilityRates.push(this.initializeRatesForm());
        storageFacilityRates.controls[index].patchValue(control);
      });
    }
  }

  /** On Delete storage facility Interchange
   * @method onDeleteInterchange
   * @param - deletedInterchange -data of the deleted storage facility Interchange
   */
  public onDeleteInterchange(deletedInterchange: any): void {
    this.deletedInterchangeList.push(deletedInterchange);
  }

  /** On Delete storage facility rate
   * @method onDeleteRate
   * @param - deletedRateDetail -data of the deleted storage facility rate
   */
  public onDeleteRate(deletedRateDetail: any): void {
    this.deletedRatesList.push(deletedRateDetail);
  }

  /** On delete storage facility interchange location
   * @method onDeleteLocation
   * @param - deletedLocation -data of the deleted storage facility Interchange location
   */
  onDeleteLocation(deletedLocation: any): void {
    this.deletedInterchangeLocations.push(
      deletedLocation as InterchangeLocations
    );
  }

  /** To trigger on update vendor
   * @method onUpdateVendor
   */
  public onUpdateVendor(): void {
    if(!this.updateButtonEnable) {
    this.updateButtonEnable = true;
    this.vendorDetailsForm.markAllAsTouched();
    if (this.vendorDetailsForm.invalid) {
      this.updateButtonEnable = false;
      return;
    }
    this.vendorModel = Object.assign(this.vendorDetailsForm.getRawValue());

    this.vendorModel.CountryId = this.sharedService.CheckIsEmpty(
      this.vendorModel.CountryId
    );
    this.vendorModel.StateId = this.sharedService.CheckIsEmpty(
      this.vendorModel.StateId
    );
    this.vendorModel.RegionId = this.sharedService.CheckIsEmpty(
      this.vendorModel.RegionId
    );
    this.vendorModel.Id = this.currentVendorId;
    this.vendorModel.PrimaryContactNo = this.sharedService.CheckIfEmptyOrNull(this.vendorModel.PrimaryContactNo);
    this.vendorModel.SecondaryContactNo = this.sharedService.CheckIfEmptyOrNull(this.vendorModel.SecondaryContactNo);
    this.vendorModel.EffectiveDate = this.sharedService.ConvertToFormatedDate(this.vendorModel.FormEffectiveDate);
    this.vendorModel.ExpiryDate = this.sharedService.ConvertToFormatedDate(this.vendorModel.FormExpiryDate);
    this.vendorModel.ZipCode = this.vendorModel.ZipCode ? this.vendorModel.ZipCode.toUpperCase() : this.vendorModel.ZipCode;

    // remove % from PercentageMargin
    this.vendorModel.PercentageMargin=this.sharedService.CheckDecimalIsEmpty(this.vendorModel.PercentageMargin);

    this.deletedInterchangeLocations.forEach(function (e) {
      e.IsActive = false;
    });

    if (
      this.vendorModel.StorageFacilities != undefined &&
      this.vendorModel.StorageFacilities.length > 0
    ) {
      this.vendorModel.StorageFacilities.forEach((storageFacility) => {
        storageFacility.PrimaryContactNumber=this.sharedService.CheckIfEmptyOrNull(storageFacility.PrimaryContactNumber);
        storageFacility.SecondaryContactNumber=this.sharedService.CheckIfEmptyOrNull(storageFacility.SecondaryContactNumber);
        storageFacility.SPLC=this.sharedService.CheckIfEmptyOrNull(storageFacility.SPLC);
        storageFacility.Lat=this.sharedService.CheckIfEmptyOrNull(storageFacility.Lat);
        storageFacility.Long=this.sharedService.CheckIfEmptyOrNull(storageFacility.Long);
        storageFacility.ZipCode = storageFacility.ZipCode ? storageFacility.ZipCode.toUpperCase() : storageFacility.ZipCode;
        storageFacility.Capacity = this.sharedService.CheckIsEmpty(
          storageFacility.Capacity
        );
        storageFacility.AvailableCars = this.sharedService.CheckIsEmpty(
          storageFacility.AvailableCars
        );
        storageFacility.Rating = this.sharedService.CheckIsEmpty(
          storageFacility.Rating
        );
        storageFacility.Priority = this.sharedService.CheckIsEmpty(
          storageFacility.Priority
        );
        storageFacility.CountryId = this.sharedService.CheckIsEmpty(
          storageFacility.CountryId
        );
        storageFacility.StateId = this.sharedService.CheckIsEmpty(
          storageFacility.StateId
        );
        storageFacility.RegionId = this.sharedService.CheckIsEmpty(
          storageFacility.RegionId
        );
        storageFacility.VendorId = this.sharedService.CheckIsEmpty(
          storageFacility.VendorId
        );
        storageFacility.Id = this.sharedService.CheckIsEmpty(
          storageFacility.Id
        );
        storageFacility.EffectiveDate = this.sharedService.ConvertToFormatedDate(storageFacility.FormEffectiveDate);
        storageFacility.ExpiryDate = this.sharedService.ConvertToFormatedDate(storageFacility.FormExpiryDate);

        storageFacility.Description = '';

        this.updateInterchangeLocationStatus(storageFacility);
        this.updateStorageFacilityRates(storageFacility);
        this.updateInterchangeStatus(storageFacility);

        // set storage features list for selected facility

        if (
          storageFacility.StorageFeatures.length == 0 ||
          storageFacility.StorageFeatures == undefined
        ) {
          storageFacility.StorageFeatures = [];
        }
          storageFacility.StorageFeatures =
            this.getStorageFeaturesWithStatus(storageFacility);

      });
      this.isViewMode = true;
      this.isAddUpdate = false;
      this.mode = APP_CONSTANTS.view;
      this.checkModeData();
    }

    this.vendorService.SaveVendorDetails(this.vendorModel).subscribe(
      (result) => {
        let res = result;
        this.toastr.success('Vendor saved successfully.');
        this.updateButtonEnable = false;
        this.isAddEnabled= false;
        this.isUpdateEnabled= true;
        this.isStorageFacilityOpen = false;
        this.initializeVendorDetailsForm();
        this.isNestedFacilityAvailable = false;
        this.getVendorDataFromServer();
      },
      (error) => {
        this.toastr.error(
          'Failed to save vendor detail. Please contact administrator.'
        );
        this.updateButtonEnable = false;
      }
    );
  }
  }

  /** get storage features with their active/deactive status
   * @method getStorageFeaturesWithStatus
   * @param - storageFacility -StorageFacilityModel detail
   * @return - storagefeatureModel - newly bind storage features
   */
  private getStorageFeaturesWithStatus(
    currentStorageFacility: StorageFacilityModel
  ): StorageFeatureModel[] {
    let newSelectedFeatures: StorageFeatureModel[] = [];

    let selectedFeatures = currentStorageFacility.StorageFeatures;
    let StorageFeatures;
    this.sharedService.getStorageFeatures().subscribe((response) => {
      StorageFeatures = response;
    });
      selectedFeatures.forEach((featureData) => {
        let featuresDetail = StorageFeatures.filter((t) => t.Id == featureData)?.[0];
      if (featuresDetail != undefined) {
        //featuresDetail.IsActive = true;
        newSelectedFeatures.push(featuresDetail);
      }
    });

    // Set IsActive=false to all un-checked storage features
    this.deletedFeatureIds = [];
    this.vendorData.StorageFacilities.filter(
      (t) => t.Id == currentStorageFacility.Id
    ).forEach((element) => {
      element.StorageFeatures.filter(
        (t) => !currentStorageFacility.StorageFeatures.includes(t)
      ).forEach((featureData) => {
        if (
          newSelectedFeatures.filter((t) => t.Id == featureData).length == 0
        ) {
          this.deletedFeatureIds.push(featureData);
        }
      });
    });

    if (this.deletedFeatureIds.length > 0) {
      this.deletedFeatureIds.forEach((featureData) => {
        let featuresDetail = StorageFeatures.filter((t) => t.Id == featureData)?.[0];
        if (featuresDetail != undefined) {
          featuresDetail.IsActive = false;
          newSelectedFeatures.push(featuresDetail);
        }
      });
    }
    // End to set IsActive=false to all un-checked storafe features
    return newSelectedFeatures;
  }

  /** update storage facility interchange
   * @method updateInterchangeStatus
   * @param - storageFacility -StorageFacilityModel detail
   */
  private updateInterchangeStatus(storageFacility: StorageFacilityModel): void {
    // Set Interchange locations IsActive Status
    if (
      storageFacility.StorageFacilityInterchanges != undefined &&
      storageFacility.StorageFacilityInterchanges.length > 0
    ) {
      storageFacility.StorageFacilityInterchanges.forEach((interchangeData) => {
        interchangeData.IsActive = true;
        interchangeData.GrossRailRoadCapacity=this.sharedService.CheckIsEmpty(interchangeData.GrossRailRoadCapacity);
        interchangeData.StorageFacilityId = storageFacility.Id;
      });

      this.deletedInterchangeList.forEach((deletedInterchangeData) => {
        deletedInterchangeData.IsActive = false;
        deletedInterchangeData.GrossRailRoadCapacity=this.sharedService.CheckIsEmpty(deletedInterchangeData.GrossRailRoadCapacity);

        deletedInterchangeData.InterchangeLocations.forEach(
          (deletedLocation) => {
            deletedLocation.IsActive = false;
            this.setInterchangeLocationValue(deletedLocation);
            //this.deletedInterchangeLocations.push(deletedLocation);
          }
        );
        storageFacility.StorageFacilityInterchanges.push(
          deletedInterchangeData
        );
      });
    }
  }

  /** Update storage facility interchange location
   * @method UpdateInterchangeLocationStatus
   * @param - storageFacility -StorageFacilityModel detail
   */
  private updateInterchangeLocationStatus(
    storageFacility: StorageFacilityModel
  ): void {
    // Set Interchange locations IsActive Status
    if (
      storageFacility.StorageFacilityInterchanges != undefined &&
      storageFacility.StorageFacilityInterchanges.length > 0
    ) {
      storageFacility.StorageFacilityInterchanges.forEach((interchangeData) => {
        interchangeData.InterchangeLocations.forEach((locationData) => {
          locationData.IsActive = true;
          this.setInterchangeLocationValue(locationData);
        });

        let deletedLocationData = this.deletedInterchangeLocations.filter(
          (t) => t.InterchangeId == interchangeData.Id
        );
        if (deletedLocationData != null && deletedLocationData.length > 0) {
          deletedLocationData.forEach((interchangeLocationData) => {
            interchangeLocationData.IsActive = false;
            this.setInterchangeLocationValue(interchangeLocationData);
            interchangeData.InterchangeLocations.push(interchangeLocationData);
          });
        }
      });
    }
    // End of Set Interchange locations IsActive Status
  }
  setInterchangeLocationValue(locationData: InterchangeLocations) {
    locationData.SPLC = this.sharedService.CheckIfEmptyOrNull(locationData.SPLC);
    locationData.R260 = this.sharedService.CheckIfEmptyOrNull(locationData.R260);
    locationData.FSAC = this.sharedService.CheckIfEmptyOrNull(locationData.FSAC);
    locationData.Lat = this.sharedService.CheckIfEmptyOrNull(locationData.Lat);
    locationData.Long = this.sharedService.CheckIfEmptyOrNull(locationData.Long);
  }

  /** On delete storage facility rate
   * @method updateStorageFacilityRates
   * @param - storageFacility -StorageFacilityModel detail
   */
  private updateStorageFacilityRates(storageFacility: StorageFacilityModel) {
    if (
      storageFacility.StorageFacilityRates != undefined &&
      storageFacility.StorageFacilityRates.length > 0
    ) {
      storageFacility.StorageFacilityRates.forEach((storageFacilityRate) => {
        this.setStorageFacilityRate(storageFacilityRate);
        storageFacilityRate.IsActive = true;
      });

      let storageFacilityRatesData = this.deletedRatesList.filter(
        (t) => t.StorageFacilityId == storageFacility.Id
      );
      if (
        storageFacilityRatesData != null &&
        storageFacilityRatesData.length > 0
      ) {
        storageFacilityRatesData.forEach((sfRate) => {
          this.setStorageFacilityRate(sfRate);
          sfRate.IsActive = false;
          storageFacility.StorageFacilityRates.push(sfRate);
        });
      }
    }
  }

  private setStorageFacilityRate(storageFacilityRate: StorageFacilityRatesModel) {

        // storageFacilityRate.CurrencyId=storageFacilityRate.CurrencyId;
        // storageFacilityRate.StorageFacilityId=storageFacilityRate.StorageFacilityId;
        // storageFacilityRate.Id=1;
        //storageFacilityRate.PercentageMargin=this.sharedService.CheckDecimalIsEmpty(storageFacilityRate.PercentageMargin.toString());

        storageFacilityRate.DailyStorageRate =
          this.sharedService.CheckDecimalIsEmpty(
            storageFacilityRate.DailyStorageRate
          );
        storageFacilityRate.SwitchIn = this.sharedService.CheckDecimalIsEmpty(
          storageFacilityRate.SwitchIn
        );
        storageFacilityRate.SwitchOut = this.sharedService.CheckDecimalIsEmpty(
          storageFacilityRate.SwitchOut
        );
        storageFacilityRate.SwitchingRate =
          this.sharedService.CheckDecimalIsEmpty(
            storageFacilityRate.SwitchingRate
          );
        storageFacilityRate.SpecialSwitchingRate =
          this.sharedService.CheckDecimalIsEmpty(
            storageFacilityRate.SpecialSwitchingRate
          );
        storageFacilityRate.HazmatSwitchInRate =
          this.sharedService.CheckDecimalIsEmpty(
            storageFacilityRate.HazmatSwitchInRate
          );
        storageFacilityRate.HazmatSwitchOutRate =
          this.sharedService.CheckDecimalIsEmpty(
            storageFacilityRate.HazmatSwitchOutRate
          );
        storageFacilityRate.LoadedSwitchInRate =
          this.sharedService.CheckDecimalIsEmpty(
            storageFacilityRate.LoadedSwitchInRate
          );
        storageFacilityRate.LoadedSwitchOutRate =
          this.sharedService.CheckDecimalIsEmpty(
            storageFacilityRate.LoadedSwitchOutRate
          );
        storageFacilityRate.CherryPickingRate =
          this.sharedService.CheckDecimalIsEmpty(
            storageFacilityRate.CherryPickingRate
          );
        storageFacilityRate.ReservationRate =
          this.sharedService.CheckDecimalIsEmpty(
            storageFacilityRate.ReservationRate
          );
        storageFacilityRate.EffectiveDate =
                this.sharedService.ConvertToFormatedDate(storageFacilityRate.FormEffectiveDate);
        storageFacilityRate.ExpiryDate =
                this.sharedService.ConvertToFormatedDate(storageFacilityRate.FormExpiryDate);
  }

  public onRemoveStorageFacility(facilityIndex) {
    const options = {
      title: 'Warning',
      message: `Are you sure you want to delete Storage Facility ${
        facilityIndex + 1
      }?`,
      cancelText: 'No',
      confirmText: 'Yes',
    };
    this.dialogService.open(options);
    this.dialogService.confirmed().subscribe((confirmed) => {
      if (confirmed) {
        const control = this.vendorDetailsForm.controls[
          'StorageFacilities'
        ] as FormArray;
        if (
          control.at(facilityIndex).value.Id != null &&
          control.at(facilityIndex).value.Id > 0
        ) {
          this.deletedStorageFacility.push(control.at(facilityIndex).value.Id);
        }
        control.removeAt(facilityIndex);
        this.reFrameTable = !this.reFrameTable;
      }
    });
  }

  /** On cancel button click while updating vendor detail
   * @method onCancelButtonClick
   */
     public onCancelButtonClick(): void {
      const options = {
        title: 'Warning',
        message: `Do you really want to cancel changes?`,
        cancelText: 'No',
        confirmText: 'Yes',
      };
      this.dialogService.open(options);
      this.dialogService.confirmed().subscribe((confirmed) => {
        if (confirmed) {
          this.isStorageFacilityOpen = false;
          this.initializeVendorDetailsForm();
          this.isNestedFacilityAvailable = false;
          this.getVendorDataFromServer();
          this.vendorDetailsForm.patchValue(this.persistPreviousData);
          this.isViewMode = true;
          this.isAddUpdate = false;
          this.mode = APP_CONSTANTS.view;
          this.checkModeData();
        }
      });
    }

    /** On reset button click while updating vendor detail
   * @method onResetButtonClick
   */
     public onResetButtonClick(): void {
      const options = {
        title: 'Warning',
        message: `Do you really want to discard changes?`,
        cancelText: 'No',
        confirmText: 'Yes',
      };
      this.dialogService.open(options);
      this.dialogService.confirmed().subscribe((confirmed) => {
        if (confirmed) {
          this.isAddEnabled= false;
          this.isUpdateEnabled= true;
          this.isStorageFacilityOpen = false;
          this.initializeVendorDetailsForm();
          this.isNestedFacilityAvailable = false;
          this.getVendorDataFromServer();
         // this.vendorDetailsForm.patchValue(this.persistPreviousData);
        }
      });
    }
}
