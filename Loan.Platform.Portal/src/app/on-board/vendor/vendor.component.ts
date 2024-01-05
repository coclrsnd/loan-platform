import { TranslateService } from '@ngx-translate/core';
import { Component, OnInit } from '@angular/core';
import { AbstractControl, AsyncValidatorFn, FormArray, FormBuilder, FormGroup, Validators } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import { APP_CONSTANTS } from 'src/app/app-constants';
import {
  ViewChild,
  ViewChildren,
  QueryList,
  ChangeDetectorRef,
} from '@angular/core';
import {
  animate,
  state,
  style,
  transition,
  trigger,
} from '@angular/animations';
import { MatSort } from '@angular/material/sort';
import { VendorModel } from 'src/app/search/vendor/VendorModel';
import { VendorService } from 'src/app/search/vendor/vendor-service';
import { ToastrService } from 'ngx-toastr';
import { SharedService } from 'src/app/shared/shared.service';
import { ConfirmDialogService } from 'src/app/shared/components/confirm-dialog/confirm-dialog.service';
import { DateValidators,NumValidators } from 'src/app/shared/directives/validatorDate';
import { AuthService } from 'src/app/services/auth.service';
import { ApiService } from 'src/app/services/api.service';
import { map, of } from 'rxjs';
import { MasterDataService } from 'src/app/services/master-data.service';
import { StorageFeatureModel } from 'src/app/search/storagefeature/StoragefeatureModel';

@Component({
  selector: 'app-vendor',
  templateUrl: './vendor.component.html',
  styleUrls: ['./vendor.component.scss'],
  animations: [
    trigger('detailExpand', [
      state(
        'collapsed',
        style({ height: '0px', minHeight: '0', display: 'none' })
      ),
      state('expanded', style({ height: 'auto', display: 'block' })),
      transition(
        'expanded <=> collapsed',
        animate('225ms cubic-bezier(0.4, 0.0, 0.2, 1)')
      ),
    ]),
  ],
})
export class VendorComponent implements OnInit {
  // For Table expand collapse code Start
  @ViewChild('outerSort', { static: true }) sort: MatSort;
  @ViewChildren('innerSort') innerSort: QueryList<MatSort>;
  public mode: string = '';
  public isInViewMode: boolean = false;
  public bsConfig = APP_CONSTANTS.bsConfig;
  public effDateValue: Date = new Date();
  public expDateValue: Date = new Date();
  public isStorageFacilityOpen: boolean = true;
  public isRatesDataAvailable: boolean = false;
  public showAddCancel: boolean = false;
  public isVendorFormDataReceived: boolean = false;
  public isFromPage = APP_CONSTANTS.onBoardVendor;
  public vendorFormData: any;
  public copyOfVendorFormData: any;
  public isVendorToFacilityCopied: boolean = false;
  public pageTitle: string = '';
  public isViewMode: boolean = false;
  public isEditMode: boolean = false;
  public isCreateUpdate: boolean = false;
  public reFrameTable: boolean = true;
  public isLastAllowed: boolean = true;
  public nestedDisplay: boolean = false;
  public isAddEnabled: boolean = true;
  public isOnboardEnabled: boolean = false;
  public isStorageFacilityEnabled: boolean = false;
  public finalFormData: any;
  public vendorDetailsForm: FormGroup;
  public facilityDetailsForm: FormArray;
  public columnsToDisplay = [
    'expand',
    'FacilityName',
    'Location',
    'Interchange',
    'AvailableSpace',
    'PrimaryContact',
    'PrimaryEmail',
    'Delete',
  ];
  public innerDisplayedColumns = [
    'expand',
    'Rates',
    'EffectiveDate',
    'ExpiryDate',
  ];
  public dataSourceInner = APP_CONSTANTS.singleRateRecord;
  public innerInnerDisplayedColumns = ['comment', 'commentStatus'];
  public expandedElements: any[] = [];
  public vendorModel = new VendorModel();
  public featuresList: StorageFeatureModel[] = [];
  public onboardVendorEnable: boolean = false;
  public facilityEnable: boolean = false;

  constructor(
    public route: ActivatedRoute,
    public formBuilder: FormBuilder,
    public cd: ChangeDetectorRef,
    public translate: TranslateService,
    private vendorService: VendorService,
    public toastr: ToastrService,
    private sharedService: SharedService,
    private dialogService: ConfirmDialogService,
    private router: Router,
    private authService: AuthService,
    private masterDataService: MasterDataService
  ) {}

  ngOnInit(): void {
    this.route.params.subscribe((params: any) => {
      this.mode = params.mode;
    });
    this.authService.getUserId();
    if(ApiService.CurrentRole.startsWith('Vendor')){
      this.vendorService.GetVendorForUserId(+ApiService.UserId).subscribe(
        data =>{
          if(data.Id>0){
            this.router.navigate(['../search/vendor/vendor-details/view/'+data.Id  ]);
          }
        });
    }
    else{

      this.checkModeData();
      this.initializeVendorDetailsForm();
    }
    this.loadStorageFeatures();
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
      Organization: [APP_CONSTANTS.emptyString,
      {
          validators: [
            Validators.required,
            Validators.maxLength(50),
            Validators.pattern(/^[a-zA-Z0-9-&. ]*$/)
          ],
          asyncValidators: [], // [this.checkIfOrganizationIsExists()],
      }],
      OrganizationId: [APP_CONSTANTS.defaultNumberValue],
      Region: [APP_CONSTANTS.emptyString],
      RegionId: [APP_CONSTANTS.emptyString],
      PercentageMargin: [APP_CONSTANTS.emptyString, {
        validators:[Validators.required,
                    Validators.min(0),
                    Validators.max(100)],
        updateOn: 'change',
        asyncValidators: []
      }
        ],
      FormEffectiveDate: [APP_CONSTANTS.null, Validators.required],
      FormExpiryDate: [APP_CONSTANTS.null, Validators.required],
      Website: [APP_CONSTANTS.emptyString],
      Description: [APP_CONSTANTS.emptyString],
      StorageFacilities: this.formBuilder.array([this.addStorageFacility()]),
    }, { validator: Validators.compose([
      DateValidators.dateLessThan('FormEffectiveDate', 'FormExpiryDate', { 'expiryIssue': true })
  ])});
  }

  /** Load Storage Features list
   * @method loadStorageFeatures
   */
  public loadStorageFeatures(): void {
    this.sharedService.getStorageFeatures().subscribe((response) => {
      this.featuresList=response
    });
  }

  /** Get Storage Facility Details Array
   * @method storageFacilityDetailsArray
   */
  get storageFacilityDetailsArray() {
    return this.vendorDetailsForm.get('StorageFacilities') as FormArray;
  }

  /** Add  Storage Facility Details form definition
   * @method addStorageFacility
   * @returns FormGroup
   */
  public addStorageFacility(): FormGroup {
    return this.formBuilder.group({
      Name: [APP_CONSTANTS.emptyString, [Validators.required, Validators.pattern(/^[a-zA-Z0-9-&. ]*$/)]],
      SPLC: [APP_CONSTANTS.emptyString, [Validators.pattern(/^[0-9]*$/)]],
      Mark: [APP_CONSTANTS.emptyString, [Validators.required, Validators.pattern(/^[a-zA-Z0-9 ]*$/)]],
      // StationName: [{value: APP_CONSTANTS.emptyString, disabled: APP_CONSTANTS.true}],
      Lat: [{value: APP_CONSTANTS.emptyString, disabled: APP_CONSTANTS.true}],
      Long: [{value: APP_CONSTANTS.emptyString, disabled: APP_CONSTANTS.true}],
      Capacity: [APP_CONSTANTS.emptyString, [Validators.required, Validators.pattern(/^[0-9]*$/)]],
      AvailableCars: [APP_CONSTANTS.emptyString, [Validators.required, Validators.pattern(/^[0-9]*$/)]],
      Rating: [APP_CONSTANTS.defaultNumberValue],
      PrimaryContactNumber: [APP_CONSTANTS.emptyString, [Validators.required, Validators.pattern(/^[0-9 +()-]*$/)]],
      PrimaryEmail: [APP_CONSTANTS.emptyString, [Validators.required, Validators.email]],
      SecondaryContactNumber: [APP_CONSTANTS.emptyString, [Validators.pattern(/^[0-9 +()-]*$/)]],
      SecondaryEmail: [APP_CONSTANTS.emptyString, Validators.email],
      FormEffectiveDate: [APP_CONSTANTS.null, Validators.required],
      FormExpiryDate: [APP_CONSTANTS.null, Validators.required],
      Address: [APP_CONSTANTS.emptyString],
      ZipCode: [APP_CONSTANTS.emptyString, Validators.pattern(/^[a-zA-Z0-9 ]*$/)],
      CountryId: [APP_CONSTANTS.emptyString, Validators.required],
      StateId: [APP_CONSTANTS.emptyString, Validators.required],
      RegionId: [APP_CONSTANTS.emptyString, Validators.required],
      City: [APP_CONSTANTS.emptyString, [Validators.required, Validators.pattern(/^[a-zA-Z0-9-&. ]*$/)]],
      Priority: [APP_CONSTANTS.emptyString],
      StorageFeatures: [APP_CONSTANTS.emptyString],
      StorageFacilityRates: this.formBuilder.array([]),
      StorageFacilityInterchanges: this.formBuilder.array([]),
      IsTrimbleVerified:[false]
      // StorageFeatures: this.formBuilder.group([]),
    }, { validator: Validators.compose([
      DateValidators.dateLessThan('FormEffectiveDate', 'FormExpiryDate', { 'expiryIssue': true }),
      NumValidators.numLessThan('AvailableCars', 'Capacity', { 'capacityIssue': true })
  ])});
  }

  /** Add  Storage Facility Details form definition
   * @method onRemoveStorageFacility
   * @param facilityIndex - index of facility which needs to be deleted
   */
  public onRemoveStorageFacility(facilityIndex): void {
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
        control.removeAt(facilityIndex);
        this.reFrameTable = !this.reFrameTable;
      }
    });
  }

  /** Set value for mode in component
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
        this.pageTitle = this.translate.instant('common.update');
        break;
    }
  }

  /** To open storage facility when clicked on + storage facility button
   * @method openStorageFacility
   */
  public openStorageFacility(): void {
    this.storageFacilityDetailsArray.push(this.addStorageFacility());
    this.isStorageFacilityOpen = true;
    this.isAddEnabled = true;
    this.isOnboardEnabled = false;
    this.isStorageFacilityEnabled = false;
      }

  /** To save rates when clicked on Save Rates
   * @method saveRates
   * @param event - click event
   */
  public saveRates(event: any): void {
    if (event) {
      setTimeout(() => {
        this.showAddCancel = true;
      }, 0);
      this.finalFormData = event;
    }
  }

  ///** To emit and add data in main form when received data from component app-vendor-form
  // * @method onReceiveVendorFormData
  // * @param formData - form data
  // */

  //public onReceiveVendorFormData(formData: any): void {
  //  this.isVendorFormDataReceived = true;
  //  this.isCreateUpdate = true;
  //  this.mode = APP_CONSTANTS.view;
  //  this.vendorFormData = formData;
  //}

  /** To copy Vendor facility data in app-storage-facility-details component
   * @method copyVendorToFacility
   * @param status - click event on checkbox
   */
  public copyVendorToFacility(status: any) {
    status.checked
      ? (this.copyOfVendorFormData = this.vendorDetailsForm)
      : (this.copyOfVendorFormData = undefined);
  }

  /** Trigger when update
   * @method onUpadate
   */
  public onUpadate(): void {
    this.mode = APP_CONSTANTS.edit;
    this.isCreateUpdate = false;
  }

   /** on organization selection raised event to verify selected organization name
   * @method checkIfOrganizationIsExists
   */
    checkIfOrganizationIsExists(): AsyncValidatorFn {
      return (control: AbstractControl) => {
        if(this.mode.toLocaleLowerCase() !== 'create'){
            return of();
        }

      let selectedOrganizationName= control.value;
      return this.vendorService.GetVendorListForAutoComplete(selectedOrganizationName)
       .pipe(
          map(response =>{
            let orgnameDetail=response.filter(t=>t.Organization.trim().toLowerCase() ===
            selectedOrganizationName.trim().toLocaleLowerCase());
            return (orgnameDetail!=null && orgnameDetail.length>0)?
            { 'notUnique' : true } : null;
          })
        )
      }
    }

  /** Trigger when add
   * @method onAdd
   */
  public onAdd(): void {

    // stop here if form is invalid Logic to be implemented after development
    if (!this.facilityEnable) {
      this.facilityEnable = true;
      this.verifyOrganizationIsExists();
      this.facilityEnable = false;
    }
  }

  /** check if vendor/organization name is already exists or not
   * @method verifyOrganizationIsExists
   */
   public verifyOrganizationIsExists(): void {
    let selectedOrganizationName = this.vendorDetailsForm.get('Organization')?.value;
    if(this.sharedService.CheckIfEmptyOrNull(selectedOrganizationName) != '') {
      this.vendorService.GetVendorListForAutoComplete(selectedOrganizationName).subscribe(response=> {
        let orgnameDetail=response.filter(t=>t.Organization.trim().toLowerCase() ===
        selectedOrganizationName.trim().toLocaleLowerCase());
        if(orgnameDetail!=null && orgnameDetail.length>0){
         this.vendorDetailsForm.controls["Organization"].setErrors({
          'notUnique': true
         });
         this.vendorDetailsForm.markAllAsTouched();
          if (this.vendorDetailsForm.invalid) {
            return;
          };
        } else {
          this.vendorDetailsForm.controls['Organization'].setErrors(null);
          this.addFormData();
        }
      })
    }
    else{
      this.addFormData();
    }
  }

  private addFormData(): void{
    this.vendorDetailsForm.markAllAsTouched();
    if (this.vendorDetailsForm.invalid) {
      return;
    }
    this.isStorageFacilityOpen = false;
    this.isRatesDataAvailable = true;
    this.isAddEnabled = false;
    this.isOnboardEnabled = true;
    this.isStorageFacilityEnabled = true;
    this.reFrameTable = !this.reFrameTable;
  }

  /** Trigger when onboard
   * @method onOnboard
   */
  public onOnboard(): void {
    if (this.vendorDetailsForm.invalid) {
      return;
    };
    if (!this.onboardVendorEnable) {
      this.onboardVendorEnable = true;
      this.vendorModel = Object.assign(this.vendorDetailsForm.getRawValue());

      // remove % from PercentageMargin
      this.vendorModel.PercentageMargin = this.sharedService.CheckDecimalIsEmpty(this.vendorModel.PercentageMargin);

      this.verifyAndResetOrganization(this.vendorModel);
      this.onboardVendorEnable = false;
    }
  }

   /** Trigger when onboard
   * @method verifyAndResetOrganization
   */
  private verifyAndResetOrganization(vendorModel: VendorModel): void {
    this.masterDataService.GetAllOrganizationsList(vendorModel.Organization).subscribe(response=>{
      if(response!=null && response.length>0){
        if(response[0].Id!=this.vendorModel.OrganizationId){
          this.vendorModel.OrganizationId=response[0].Id;
        }
      }
      this.onboardNewNendor();
    })
  }

   /** Trigger when onboard
   * @method onboardNewNendor
   */
  private onboardNewNendor() : void
  {
    if (this.vendorModel.OrganizationId > 0)
    {
      this.vendorModel.Id = 0;
      this.vendorModel.PrimaryContactNo=this.sharedService.CheckIfEmptyOrNull(this.vendorModel.PrimaryContactNo);
      this.vendorModel.SecondaryContactNo=this.sharedService.CheckIfEmptyOrNull(this.vendorModel.SecondaryContactNo);
      this.vendorModel.CountryId = this.sharedService.CheckIsEmpty(
        this.vendorDetailsForm.value.CountryId
      );
      this.vendorModel.StateId = this.sharedService.CheckIsEmpty(
        this.vendorDetailsForm.value.StateId
      );
      this.vendorModel.RegionId = this.sharedService.CheckIsEmpty(
        this.vendorDetailsForm.value.RegionId
      );
      this.vendorModel.EffectiveDate = this.sharedService.ConvertToFormatedDate(this.vendorModel.FormEffectiveDate);
      this.vendorModel.ExpiryDate = this.sharedService.ConvertToFormatedDate(this.vendorModel.FormExpiryDate);
      this.vendorModel.ZipCode = this.vendorModel.ZipCode ? this.vendorModel.ZipCode.toUpperCase() : this.vendorModel.ZipCode;
      if (
        this.vendorModel.StorageFacilities != undefined &&
        this.vendorModel.StorageFacilities.length > 0
      ) {
        this.vendorModel.StorageFacilities.forEach((storageFacility) => {
          storageFacility.Capacity = this.sharedService.CheckIsEmpty(storageFacility.Capacity);
          storageFacility.AvailableCars = this.sharedService.CheckIsEmpty(storageFacility.AvailableCars);
          storageFacility.Rating = this.sharedService.CheckIsEmpty(storageFacility.Rating);
          storageFacility.Priority = this.sharedService.CheckIsEmpty(storageFacility.Priority);
          storageFacility.CountryId = this.sharedService.CheckIsEmpty(storageFacility.CountryId);
          storageFacility.StateId = this.sharedService.CheckIsEmpty(storageFacility.StateId);
          storageFacility.RegionId = this.sharedService.CheckIsEmpty(storageFacility.RegionId);
          storageFacility.PrimaryContactNumber=this.sharedService.CheckIfEmptyOrNull(storageFacility.PrimaryContactNumber);
          storageFacility.SecondaryContactNumber=this.sharedService.CheckIfEmptyOrNull(storageFacility.SecondaryContactNumber);
          storageFacility.SPLC=this.sharedService.CheckIfEmptyOrNull(storageFacility.SPLC);
          storageFacility.Lat=this.sharedService.CheckIfEmptyOrNull(storageFacility.Lat);
          storageFacility.Long=this.sharedService.CheckIfEmptyOrNull(storageFacility.Long);
          storageFacility.EffectiveDate = this.sharedService.ConvertToFormatedDate(storageFacility.FormEffectiveDate);
          storageFacility.ExpiryDate = this.sharedService.ConvertToFormatedDate(storageFacility.FormExpiryDate);
          storageFacility.ZipCode = storageFacility.ZipCode ? storageFacility.ZipCode.toUpperCase() : storageFacility.ZipCode;
          storageFacility.VendorId = 0;
          storageFacility.Id = 0;
          storageFacility.Description = '';
          if (storageFacility.StorageFeatures.length == 0 ||
            storageFacility.StorageFeatures == undefined)
          {
            storageFacility.StorageFeatures = [];
          }
          // set storage features list for selected facility
        else {
            let selectedFeatures = storageFacility.StorageFeatures;
            storageFacility.StorageFeatures = [];
            selectedFeatures.forEach((featureData) => {
              storageFacility.StorageFeatures.push(
                 this.featuresList.filter(
                  (t) => t.Id == featureData
                )[0]
              )
            });
          }
          storageFacility.StorageFacilityInterchanges.forEach((interchanges) => {
            interchanges.Id = 0;
            interchanges.StorageFacilityId = 0;
            interchanges.Name = '';
            interchanges.GrossRailRoadCapacity=this.sharedService.CheckIsEmpty(interchanges.GrossRailRoadCapacity);

            interchanges.InterchangeLocations.forEach((locationData)=>{
              locationData.SPLC=this.sharedService.CheckIfEmptyOrNull(locationData.SPLC);
              locationData.R260=this.sharedService.CheckIfEmptyOrNull(locationData.R260);
              locationData.FSAC=this.sharedService.CheckIfEmptyOrNull(locationData.FSAC);
              locationData.Lat=this.sharedService.CheckIfEmptyOrNull(locationData.Lat);
              locationData.Long=this.sharedService.CheckIfEmptyOrNull(locationData.Long);
            })
          });

          if (
            storageFacility.StorageFacilityRates != undefined &&
            storageFacility.StorageFacilityRates.length > 0
          ) {
            storageFacility.StorageFacilityRates.forEach(
              (storageFacilityRate) => {
                // storageFacilityRate.CurrencyId = 1;
                storageFacilityRate.StorageFacilityId = 1;
                storageFacilityRate.Id = 0;
                // storageFacilityRate.PercentageMargin =
                //   this.sharedService.CheckDecimalIsEmpty(
                //     storageFacilityRate.PercentageMargin.toString()
                //   );

                storageFacilityRate.DailyStorageRate =
                  this.sharedService.CheckDecimalIsEmpty(storageFacilityRate.DailyStorageRate);
                storageFacilityRate.SwitchIn =
                  this.sharedService.CheckDecimalIsEmpty(storageFacilityRate.SwitchIn);
                storageFacilityRate.SwitchOut =
                  this.sharedService.CheckDecimalIsEmpty(storageFacilityRate.SwitchOut);
                storageFacilityRate.SwitchingRate =
                  this.sharedService.CheckDecimalIsEmpty(storageFacilityRate.SwitchingRate);
                storageFacilityRate.SpecialSwitchingRate =
                  this.sharedService.CheckDecimalIsEmpty(storageFacilityRate.SpecialSwitchingRate);
                storageFacilityRate.HazmatSwitchInRate =
                  this.sharedService.CheckDecimalIsEmpty(storageFacilityRate.HazmatSwitchInRate);
                storageFacilityRate.HazmatSwitchOutRate =
                  this.sharedService.CheckDecimalIsEmpty(storageFacilityRate.HazmatSwitchOutRate);
                storageFacilityRate.LoadedSwitchInRate =
                  this.sharedService.CheckDecimalIsEmpty(storageFacilityRate.LoadedSwitchInRate);
                storageFacilityRate.LoadedSwitchOutRate =
                  this.sharedService.CheckDecimalIsEmpty(storageFacilityRate.LoadedSwitchOutRate );
                storageFacilityRate.CherryPickingRate =
                  this.sharedService.CheckDecimalIsEmpty(storageFacilityRate.CherryPickingRate);
                storageFacilityRate.ReservationRate =
                  this.sharedService.CheckDecimalIsEmpty(storageFacilityRate.ReservationRate);
                storageFacilityRate.EffectiveDate =
                  this.sharedService.ConvertToFormatedDate(storageFacilityRate.FormEffectiveDate);
                storageFacilityRate.ExpiryDate =
                  this.sharedService.ConvertToFormatedDate(storageFacilityRate.FormExpiryDate);
              }
            );
          }
        });
      }

      this.vendorService.SaveVendorDetails(this.vendorModel).subscribe(
        (result) => {
          //let res = result;
          this.toastr.success('Vendor saved successfully.');
          this.router.navigate(['/search/vendor']);
        },
        (error) => {
          this.toastr.error('Error while saving Vendor details.');
        }
      );
    }
    else{
      this.toastr.error('Please select valid Vendor name.');
    }
  }

  public onResetButtonClick() : void{
    const options = {
      title: 'Warning',
      message: `Do you really want to discard changes?`,
      cancelText: 'No',
      confirmText: 'Yes',
    };
    this.dialogService.open(options);
    this.dialogService.confirmed().subscribe((confirmed) => {
      if (confirmed) {
        this.vendorDetailsForm.patchValue({
          StateId: APP_CONSTANTS.emptyString,
          RegionId: APP_CONSTANTS.emptyString,
          CountryId:APP_CONSTANTS.emptyString,
        });
        let StorageFacilities= (this.vendorDetailsForm.get('StorageFacilities') as FormArray).controls;
        StorageFacilities.forEach((control) => {
          control.patchValue({
            StateId: APP_CONSTANTS.emptyString,
            RegionId: APP_CONSTANTS.emptyString,
            CountryId:APP_CONSTANTS.emptyString,
          });

          let InterchangeData= (control.get('StorageFacilityInterchanges') as FormArray).controls;
          InterchangeData.forEach((interchnageControl) =>
           {
            interchnageControl.patchValue({
              StateId: APP_CONSTANTS.emptyString,
              RegionId: APP_CONSTANTS.emptyString,
              CountryId:APP_CONSTANTS.emptyString,
            });

          let InterchangeLocationData= (interchnageControl.get('InterchangeLocations') as FormArray).controls;
            InterchangeLocationData.forEach((locationControl) =>
             {
             locationControl.patchValue({
             StateId: APP_CONSTANTS.emptyString,
              CountryId:APP_CONSTANTS.emptyString,
            });
          });
        });
        });
        this.isOnboardEnabled= false;
        this.isAddEnabled= true;
      }
    });
  }
}
