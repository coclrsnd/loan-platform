import { AfterViewInit, ChangeDetectorRef, Component, ElementRef, Inject, OnDestroy, OnInit, ViewChild } from '@angular/core';
import { MatDialogRef, MAT_DIALOG_DATA } from '@angular/material/dialog';
import { FormArray, FormBuilder, FormControl, FormGroup, Validators } from '@angular/forms';
import { APP_CONSTANTS } from 'src/app/app-constants';
import { ApiService } from 'src/app/services/api.service';
import { AuthService } from 'src/app/services/auth.service';
import { ToastrService } from 'ngx-toastr';
import { BookNowService } from './book-now.service';
import { BookNow } from './booknow.model';
import { toInteger } from 'lodash';
import { StepperOrientation, StepperSelectionEvent, STEPPER_GLOBAL_OPTIONS } from '@angular/cdk/stepper';
import { Observable } from 'rxjs/internal/Observable';
import { BreakpointObserver } from '@angular/cdk/layout';
import { map } from 'rxjs/operators';
import { DateValidators } from 'src/app/shared/directives/validatorDate';
import { Subject } from 'rxjs/internal/Subject';
import { AttachmentModel } from '../rider-details/attachments-list/attachmentModel';
import { AttachmentService } from '../rider-details/attachments-list/attachmentService';
import { ConfirmDialogService } from 'src/app/shared/components/confirm-dialog/confirm-dialog.service';
import { OpportunityAttachmentModel, OpportunityModel, OpportunityRailcarDetailsModel } from './opportunity.model';
import { SharedService } from 'src/app/shared/shared.service';
import { RailCarTypeService } from '../rail-car-type/railCarTypeService';
import { LEContentService } from '../le-content/leContentService';
import { DatePipe } from '@angular/common';
import { StoragefacilityModel } from './storage-facility-model';
import { MatStepper } from '@angular/material/stepper';

@Component({
  selector: 'app-book-now',
  templateUrl: './book-now.component.html',
  styleUrls: ['./book-now.component.scss'],
  providers: [
    {
      provide: STEPPER_GLOBAL_OPTIONS,
      useValue: { showError: true },
    },
  ]
})
export class BookNowComponent implements OnInit, AfterViewInit, OnDestroy {
  @ViewChild('stepper') stepper: MatStepper;
  public storagePackageForm: FormGroup;
  public featuresForm: FormGroup;
  public reservedSpacesForm: FormGroup;
  public features: FormArray;
  public reservedSpaces: FormArray;
  public dilogueData: any;
  public hazmatTF = APP_CONSTANTS.hazmatTF;
  public todaysDate: Date = new Date();
  public userEmail: string = APP_CONSTANTS.emptyString;
  public userName: string = APP_CONSTANTS.emptyString;
  public defaultSelectedValueForDropdownlist: number = 0;
  public CarType: any;
  public LandE: any;
  public currentIndex = 0;
  public isFirstFormSubmitted: boolean = false;
  public isSecondFormSubmitted: boolean = false;
  public isThirdFormSubmitted: boolean = false;
  public selectedFiles: any;
  public attachmentModel = new AttachmentModel;
  public isViewMode: boolean = false;
  public addAttachmentSubject: Subject<void> = new Subject<void>();
  public columnsToDisplay = ['Name', 'CreatedTime', 'action'];
  public isUpload: boolean = false;
  public displayedColumns = ['LandE', 'Commodity', 'Hazmat', 'CarType', 'NumberOfSpaces', 'RailCarId', 'action'];
  public resSpaceColumns = ['ReservedSpaces', 'EffectiveDate', 'ExpirationDate', 'action'];
  public fieldsToCheckDefaultValues = ['CarType', 'LandE', 'Hazmat', 'Commodity'];
  public fieldsToCheckForChangedOrNot = {
    'LandE': APP_CONSTANTS.defaultNumberValue,
    'Commodity': APP_CONSTANTS.emptyString,
    'Hazmat': APP_CONSTANTS.defaultNumberValue,
    'CarType': APP_CONSTANTS.defaultNumberValue,
    'ExpectedNumberOfCars': APP_CONSTANTS.null,
    'RailCarIds': APP_CONSTANTS.emptyString
  };
  public fieldToSetMandatory = ['CarType', 'LandE', 'Hazmat', 'Commodity'];
  public dataSource: any;
  public dataSourceAttachment: any;
  public dataSourceAttachmentModel: any = [];
  public dataAttachmentviewModel: any = [];
  public reservedSpacedataModel: any = [];
  public attachmentList: OpportunityAttachmentModel[] = [];
  public isEditingRailcar: boolean = false;
  public isEditingReservedSpace: boolean = false;
  public opportunityModel: OpportunityModel;
  public railCar: OpportunityRailcarDetailsModel;
  public reservedSpacedataSource: any;
  public reservedSpaceEditRowId: number;
  public storagefacility: StoragefacilityModel = new StoragefacilityModel()
  public addReservedSpace: boolean = false;
  public OrderNumber: string = '';
  public featuresModel: any;
  public defaultDateTimeFormat = APP_CONSTANTS.DefaultDateTimeFormat;
  public todayDate: Date = new Date();
  public showFile: boolean = true;
  public isRailCarMandatory: boolean = false;
  public reservedSpacesFormValidation: boolean = false
  public selectedStepIndex: number = 0;
  public reservedSpacesEditValue: any;
  firstFormGroup = this.formBuilder.group({
    LastContained: [APP_CONSTANTS.emptyString],
    SDS: [APP_CONSTANTS.emptyString],
    StartDate: [APP_CONSTANTS.null, Validators.required],
    EndDate: [APP_CONSTANTS.null, Validators.required],
    Hazardous: [APP_CONSTANTS.false],
    CarIdsKnown: ['true'],
  }, {
    validator: Validators.compose([
      DateValidators.dateLessThan('StartDate', 'EndDate', { 'expiryIssues': true })
    ])
  });
  railCarForm = this.formBuilder.group({
    ExpectedNumberOfCars: [
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
    CarType: [APP_CONSTANTS.defaultNumberValue],
    LandE: [APP_CONSTANTS.defaultNumberValue],
    Commodity: [APP_CONSTANTS.emptyString],
    Hazmat: [APP_CONSTANTS.defaultNumberValue],
    RailCarIds: [APP_CONSTANTS.emptyString]
  });
  secondFormGroup = this.formBuilder.group({
    Features: [APP_CONSTANTS.defaultNumberValue],
    Comments: [APP_CONSTANTS.emptyString]
  });
  thirdFormGroup = this.formBuilder.group({
    thirdCtrl: [''],
  });
  frmData: FormData;

  isEditable = true;
  public storageInfo: any = [];
  public isAddReservedSpaces: boolean = false;
  stepperOrientation: Observable<StepperOrientation>;
  constructor(@Inject(MAT_DIALOG_DATA) private data: any,
    breakpointObserver: BreakpointObserver,
    private el: ElementRef,
    public cd: ChangeDetectorRef,
    private dialogService: ConfirmDialogService,
    public attachmentService: AttachmentService,
    private datePipe: DatePipe,
    private dialogRef: MatDialogRef<BookNowComponent>, public formBuilder: FormBuilder,
    protected authService: AuthService,
    private toastr: ToastrService,
    private bookNowService: BookNowService,
    private sharedService: SharedService,
    public railCarTypeService: RailCarTypeService,
    public leContentService: LEContentService) {
    this.stepperOrientation = breakpointObserver
      .observe('(min-width: 800px)')
      .pipe(map(({ matches }) => (matches ? 'horizontal' : 'vertical')));
    this.getRailCarTypeList();
    this.getLEContentList();
    this.createInitialFeaturesFormArray();
  }
  public addFacility() {
    return this.formBuilder.group({
      FeatureId: new FormControl(0),
      Id: new FormControl(0),
      Comments: new FormControl(''),
      IsActive: new FormControl(),
      FeatureName: new FormControl(''),
      OpportunityId: new FormControl(this.opportunityModel?.Id)
    });
  }

  public addReservedSpaces() {
    this.addReservedSpace = false;
    this.reservedSpacesForm = this.formBuilder.group({
      ReservedSpaces: [
        APP_CONSTANTS.emptyString,
        {
          validators: [
            Validators.required,
            Validators.maxLength(9),
            Validators.pattern(/^[0-9]*$/),
            Validators.min(0),
            Validators.max(999999),
          ],
          updateOn: 'change',
          asyncValidators: [],
        },
      ],
      EffectiveDate: [APP_CONSTANTS.null],
      ExpirationDate: [APP_CONSTANTS.null]
    }, {
      validator: Validators.compose([
        DateValidators.dateLessThan('EffectiveDate', 'ExpirationDate', {
          expiryIssue: true,
        }),
      ]),
    });
  }

  ngOnInit(): void {
    this.dilogueData = this.data;
    this.storagefacility.FacilityName = this.data?.facility?.Name;
    this.storagefacility.DailyStorageRate = this.data?.facility?.DailyStorageRate;
    this.storagefacility.Interchanges = this.data?.facility?.Interchanges
    this.storagefacility.Currency = this.data?.facility?.CurrencyCode;
    this.authService.getUserId();
    this.userEmail = ApiService.EmailId;
    this.userName = ApiService.Name;
    this.buildStoragePackage();
    this.storageInfo = this.data;
    this.storageInfo.UserName = this.userName;
    this.storageInfo.currentIndex = APP_CONSTANTS.defaultNumberValue;
    this.createFacilityForm();

    this.railCarForm.valueChanges.subscribe(() => { this.checkForRailCarFormChange() })
  }

  checkForRailCarFormChange(): void {
    const changed = this.checkForFieldChange(this.railCarForm, this.fieldsToCheckForChangedOrNot);
    if (changed) {
      if (!this.isRailCarMandatory) {
        this.isRailCarMandatory = true;
        this.setRequiredValidation(this.fieldToSetMandatory, this.railCarForm, this.fieldsToCheckForChangedOrNot, true);
      }
    }
    else {
      if (this.isRailCarMandatory) {
        this.isRailCarMandatory = false;
        this.setRequiredValidation(this.fieldToSetMandatory, this.railCarForm, this.fieldsToCheckForChangedOrNot, false);
      }
    }
  }

  ngAfterViewInit() {
    this.stepper._getIndicatorType = () => 'number';
  }

  ngOnDestroy(): void {
    this.dialogRef.close(true);
  }

  public getOpportunityDetails() {
    if (this.opportunityModel != undefined && this.opportunityModel.Id > 0) {
      this.bookNowService.GetOpportunityById(this.opportunityModel.Id).subscribe(result => {
        this.opportunityModel = result;
        this.firstFormGroup.patchValue({
          StartDate: this.sharedService.ConvertToDatePickerDate(this.opportunityModel.StartDate),
          EndDate: this.sharedService.ConvertToDatePickerDate(this.opportunityModel.EndDate)
        })
        this.dataSource = this.opportunityModel.OpportunityRailCars;
        this.dataSourceAttachmentModel = this.opportunityModel?.OpportunityAttachments;
        this.dataSourceAttachmentModel.forEach(element => {
          element.CreatedDate = this.datePipe.transform(element.CreatedDate, APP_CONSTANTS.StandardDateTimeFormat)
        });
        this.dataSourceAttachment = this.dataSourceAttachmentModel?.filter((m) => m.IsActive);
        this.dataAttachmentviewModel = this.dataSourceAttachment;
        this.dataSourceAttachment = [...this.dataSourceAttachment];
      })
    }
  }

  public createInitialFeaturesFormArray(): void {
    this.bookNowService.GetFeaturesById(this.data.facility.Id).subscribe(StorageFeatures => {
      StorageFeatures.forEach(element => {
        this.features = this.featuresForm.get('features') as FormArray;
        this.features.push(this.addFacility());
        this.features.controls[this.features.length - 1].patchValue(
          {
            FeatureId: element.Id,
            features: element.Name,
            FeatureName: element.Name,
            IsActive: false,
            Comments: '',
            OpportunityId: this.opportunityModel?.Id,
            Id: 0
          }
        );
      });
    });
  }

  public getFeaturesControls() {
    return (this.featuresForm.get('features') as FormArray).controls;
  }

  public createFacilityForm(): void {
    this.featuresForm = new FormGroup({
      features: new FormArray([])
    });
  }

  public buildStoragePackage(): void {
    this.storagePackageForm = this.formBuilder.group({
      FirstName: [APP_CONSTANTS.emptyString, Validators.required],
    });
  }

  public onConfirmClick(): void {
    this.dialogRef.close(true);
  }

  public onClose(): void {
    this.dialogRef.close(false);
  }

  /** To trigger when cancelled on opened dilogue
  * @method cancel
  */
  public cancel(stepper: MatStepper): void {
    if (stepper.selectedIndex === 3) {
      this.close(false);
      return;
    }
    const options = {
      title: 'Confirm Exit',
      message: `Any data entered will be lost. \n Are you sure you want to exit?`,
      cancelText: 'No',
      confirmText: 'Yes',
      reverseBtn: true,
    };
    this.dialogService.open(options);
    this.dialogService.confirmed().subscribe((confirmed) => {
      if (confirmed) {
        this.close(false);
      }
    });
  }

  /** To close opened dilogue
   * @method close
   * @param value - boolean true or false;
   */
  public close(value): void {
    this.dialogRef.close(value);
  }

  public onConfirm(): void {
    if (ApiService.CurrentRole.startsWith('Vendor')) {
      this.toastr.warning('Bookings is for Customers only.', 'Book');
    }
    let bookNow = new BookNow();
    bookNow.AvailableCars = this.data.facility.AvailableCars;
    bookNow.BookingDate = this.todaysDate;
    bookNow.Capacity = this.data.facility.Capacity;
    bookNow.DailyStorageRate = this.data.facility.DailyStorageRate;
    bookNow.StorageFacilityId = this.data.facility.Id;
    bookNow.UserId = toInteger(ApiService.UserId);
    this.bookNowService
      .BookNow(bookNow)
      .subscribe({
        next: () => {
          this.toastr.success('Your storage order has been placed.');
          this.dialogRef.close();
        },
        error: (error) => ({}),
      });
  }

  public onCarTypeSelectionChanged(event): void {
  }

  public onLoadedEmptyChange(event): void {
  }

  public upload(file: any): void {
  }

  public selectFile(event) {
    this.selectedFiles = (event.target as HTMLInputElement).files;
    if (this.selectedFiles.length > 0) {
      this.showFile = false;
    }
  }

  public onCarIdsKnownChange(event): void {
  }

  selectionChange(event: StepperSelectionEvent) {
    if (event.selectedIndex != 3) {
      this.getOpportunityDetails();
    }
    this.storageInfo.currentIndex = event.selectedIndex;
    this.storageInfo.firstFormGroup = this.firstFormGroup.getRawValue();
    this.storageInfo.thirdFormGroup = this.thirdFormGroup.getRawValue();
    this.storageInfo.featuresForm = this.featuresForm.getRawValue();
  }

  public SaveOpportunity(): void {
    this.isFirstFormSubmitted = true;
    // stop here if form is invalid
    if (this.firstFormGroup.invalid) {
      return;
    }
    this.bindOpportunityModel();
    this.opportunityModel.OpportunityAttachments = this.dataSourceAttachmentModel;
    this.bookNowService.
      SaveOppotunity(this.opportunityModel)
      .subscribe(result => {
        if (result.Id > 0) {
          this.opportunityModel.Id = result.Id;
          this.storagefacility.OpportunityId = result.Id;
          this.getOpportunityDetails();
          return;
        }
      })
  }

  public bindOpportunityModel(): void {

    if (this.opportunityModel === undefined) {
      this.opportunityModel = new OpportunityModel();
    }
    let opportunityModel = Object.assign(this.firstFormGroup.getRawValue());
    this.authService.getUserId();
    this.opportunityModel.StartDate = this.sharedService.ConvertToFormatedDate(opportunityModel.StartDate);
    this.opportunityModel.EndDate = this.sharedService.ConvertToFormatedDate(opportunityModel.EndDate);
    this.opportunityModel.FacilityId = this.storageInfo.facility.Id;
    this.opportunityModel.OrganizationId = parseInt(ApiService.OrganizationId);
    this.opportunityModel.VendorId = this.storageInfo.facility.VendorId;
    this.opportunityModel.BookingStatus = 1;
    this.storagefacility.AnticipatedStartDate = String(this.datePipe.transform(new Date(opportunityModel.StartDate), this.defaultDateTimeFormat));
    this.storagefacility.AnticipatedEndDate = String(this.datePipe.transform(new Date(opportunityModel.EndDate), this.defaultDateTimeFormat));
  }
  public addRailcar(): void {
    this.isRailCarMandatory = true;
    this.setRequiredValidation(this.fieldToSetMandatory, this.railCarForm, this.fieldsToCheckForChangedOrNot, true);
    this.railCarForm.markAllAsTouched();
    this.sharedService.ValidatSelectControl(this.fieldsToCheckDefaultValues, this.railCarForm);
    if (this.railCarForm.invalid) {
      return;
    }
    let isValid = this.onValidateCarId();
    if (!isValid) {
      this.toastr.error('Railcar invalid format.');
      return;
    }
    if (this.opportunityModel === undefined) {
      this.bindOpportunityModel();
    }

    let raiCarDetails = this.prepareRailCarObject();
    if (this.opportunityModel.OpportunityRailCars !== undefined && this.opportunityModel.OpportunityRailCars !== null && this.opportunityModel.OpportunityRailCars.length > 0) {
      this.opportunityModel.OpportunityRailCars.push(raiCarDetails);
    }
    else {
      this.opportunityModel.OpportunityRailCars = [];
      this.opportunityModel.OpportunityRailCars.push(raiCarDetails);
    }
    this.toastr.success("Railcar added successfully");
    if (!this.firstFormGroup.invalid) {
      this.SaveOpportunity()
    }
    else {
      this.updateDataGrid();
    }
    this.onCancelRailcar();
  }

  public updateRailcar(): void {
    this.railCarForm.markAllAsTouched();
    this.sharedService.ValidatSelectControl(this.fieldsToCheckDefaultValues, this.railCarForm);
    if (this.railCarForm.invalid) {
      return;
    }
    let isValid = this.onValidateCarId();
    if (!isValid) {
      this.toastr.error('Railcar invalid format.');
      return;
    }
    let raiCarDetails = this.prepareRailCarObject();
    raiCarDetails.Id = this.railCar.Id;
    const index = this.opportunityModel.OpportunityRailCars.findIndex(e => e.Id === this.railCar.Id);
    this.opportunityModel.OpportunityRailCars[index] = raiCarDetails;
    this.toastr.success("Railcar updated successfully");
    if (!this.firstFormGroup.invalid) {
      this.SaveOpportunity()
    }
    else {
      this.updateDataGrid();
    }
    this.onCancelRailcar();
  }

  public prepareRailCarObject(): OpportunityRailcarDetailsModel {
    let railCarModel = new OpportunityRailcarDetailsModel();
    railCarModel = this.railCarForm.getRawValue();
    railCarModel.IsHazmat = this.railCarForm.get("Hazmat")?.value;
    railCarModel.Hazmat = railCarModel.IsHazmat ? "Yes" : "No";
    railCarModel.Id = this.generateRandomNumber();
    railCarModel.LEId = this.railCarForm.get("LandE")?.value;
    railCarModel.CarTypeName = this.CarType.find(e => e.Id === railCarModel.CarType)?.Name;
    const railcarIds = this.prepareRailCarId(this.railCarForm.get("RailCarIds")?.value);
    if (this.sharedService.CheckIfEmptyOrNull(railcarIds)) {
      railCarModel.RailCarIds = railcarIds.toUpperCase();
    }
    if (railCarModel.LEId > 0) {
      const LandE = this.LandE.find(e => e.Id === railCarModel.LEId);
      if (LandE !== undefined && LandE != null) {
        railCarModel.LandE = LandE.Name;
      }
    }
    railCarModel.IsActive = true;
    return railCarModel;
  }

  public removeRailCar(item: any): void {
    const index = this.opportunityModel.OpportunityRailCars.findIndex(e => e.Id === item.Id);
    this.opportunityModel.OpportunityRailCars[index].IsActive = false;
    this.updateDataGrid();
    this.toastr.success("Railcar removed successfully");
  }

  public updateDataGrid(): void {
    if (this.opportunityModel.OpportunityRailCars != undefined) {
      this.dataSource = this.opportunityModel.OpportunityRailCars.filter(e => e.IsActive == true);
    }
  }
  public onUploadAttachment() {
    this.addAttachmentSubject.next();
  }
  public onHazmatSelectionChanged(event): void {
  }
  public onEditRailCar(element, railcarDiv: HTMLElement): void {
    railcarDiv.scrollIntoView();
    this.railCarForm.patchValue(element);
    this.railCarForm.get("LandE")?.patchValue(element.LEId);
    this.railCarForm.get("Hazmat")?.patchValue(element.IsHazmat);
    if (element.LEId === 2) {
      this.railCarForm.get("Hazmat")?.disable();
    }
    this.railCar = element;
    this.isEditingRailcar = true;
  }

  public downloadAttachment(attachmentModel) {
    this.attachmentService.DownloadAttachment(attachmentModel.FilePath, attachmentModel.Name).subscribe(
      fileData => {
        this.downloadFile(fileData, attachmentModel);
      });
  }

  private downloadFile = (data: Blob, attachmentModel: OpportunityAttachmentModel) => {
    const downloadedFile = new Blob([data], { type: data.type });
    const a = document.createElement('a');
    a.setAttribute('style', 'display:none;');
    document.body.appendChild(a);
    a.download = attachmentModel.Name;
    a.href = URL.createObjectURL(downloadedFile);
    a.target = '_blank';
    a.click();
    document.body.removeChild(a);
  }

  public openAttachmants(): void {
    this.isUpload = true;
  }

  public onChange(option): void {

    option.IsActive = !option.IsActive;
    if (option.IsActive) {
      option.controls.Comments.value = APP_CONSTANTS.emptyString;
    }
  }

  public onChangeReservedSpaces(event): void {
    this.isAddReservedSpaces = event.checked;
    if (event.checked) {
      this.addReservedSpaces();
    }
    this.removeReservedSpacesFormValidation();
  }
  public onConfirmationBox(element): void {
    const options = {
      title: 'Confirm Delete',
      message: `Are you sure you want to delete ${element.Name}?`,
      cancelText: 'No',
      confirmText: 'Yes',
      reverseBtn: true
    };
    this.dialogService.open(options);
    this.dialogService.confirmed().subscribe((confirmed) => {
      if (confirmed) {
        element.CreatedTime = new Date(element.CreatedTime);
        this.bookNowService.DeleteAttachment(element).subscribe(
          data => {
            if (data) {
              if (element.Id > 0) {
                let index = this.dataSourceAttachmentModel.indexOf(element);
                this.dataSourceAttachmentModel[index].IsActive = false;
              } else {
                let index = this.dataSourceAttachmentModel.indexOf(element);
                this.dataSourceAttachmentModel.splice(index, 1);
              }
              this.dataSourceAttachment = this.dataSourceAttachmentModel.filter((m) => m.IsActive);
              this.dataAttachmentviewModel = this.dataSourceAttachment;
              this.dataSourceAttachment = [...this.dataSourceAttachment];
              this.toastr.success("Attachment Deleted successfully.");
            }
          });
      }
    });
  }

  public onRemoveRailCar(element): void {
    const options = {
      title: 'Confirm Delete',
      message: `Are you sure you want to delete Railcar?`,
      cancelText: 'No',
      confirmText: 'Yes',
      reverseBtn: true
    };
    this.dialogService.open(options);
    this.dialogService.confirmed().subscribe((confirmed) => {
      if (confirmed) {
        this.removeRailCar(element);
      }
    });
  }
  public onCancelRailcar(): void {
    this.railCarForm.markAsUntouched();
    this.isEditingRailcar = false;
    this.isRailCarMandatory = false;
    this.railCarForm.patchValue({
      ExpectedNumberOfCars: APP_CONSTANTS.null,
      CarType: APP_CONSTANTS.defaultNumberValue,
      LandE: APP_CONSTANTS.defaultNumberValue,
      Commodity: APP_CONSTANTS.emptyString,
      Hazmat: APP_CONSTANTS.defaultNumberValue,
      RailCarIds: APP_CONSTANTS.emptyString
    });
    Object.keys(this.railCarForm.controls).forEach(key => {
      if (this.railCarForm.get(key)?.disabled)
        this.railCarForm.get(key)?.enable();
    });
  }

  public resetRailCarDetails(isEditMode: boolean): void {
    if (isEditMode) {
      this.resetRailcarDetailsOnEditMode();
    }
    else {
      this.onCancelRailcar();
    }
  }

  public resetRailcarDetailsOnEditMode() {
    this.railCarForm.patchValue(this.railCar);
    this.railCarForm.get("LandE")?.patchValue(this.railCar.LEId);
    this.railCarForm.get("Hazmat")?.patchValue(this.railCar.IsHazmat);
    if (this.railCar.LEId === 2) {
      this.railCarForm.get("Hazmat")?.disable();
    }
    else {
      this.railCarForm.get("Hazmat")?.enable();
    }
  }

  public onRemoveReservedSpacesForm(): void {
  }
  public onAddStorageSpace(): void {
    this.addReservedSpace = true;
    if (this.reservedSpacesForm != undefined && this.reservedSpacesForm?.dirty && this.reservedSpacesForm?.valid) {
      const updatedata = this.reservedSpacesForm.getRawValue();
      updatedata.RowId = this.reservedSpacedataSource == undefined ? 1 : this.reservedSpacedataSource.length + 1;
      this.reservedSpacedataModel.push(updatedata);
      this.reservedSpacedataSource = [...this.reservedSpacedataModel];
      this.addReservedSpace = false;
      this.reservedSpacesForm.reset();
      this.removeReservedSpacesFormValidation();
    }
  }

  public onCancelStorageSpace(): void {    
    this.addReservedSpace = false;
    if (this.reservedSpacesEditValue != undefined) {
      this.reservedSpacesForm.patchValue(this.reservedSpacesEditValue);
    } else {
      this.reservedSpacesForm.reset();
      this.removeReservedSpacesFormValidation();
    }    
  }

  public onEditReservedSpace(element, reservedSpaceDiv: HTMLElement): void {
    reservedSpaceDiv.scrollIntoView();
    this.reservedSpaceEditRowId = element.RowId;
    this.reservedSpacesForm.patchValue(element);
    this.reservedSpacesEditValue = element;
    this.isEditingReservedSpace = true;
    this.onChangeReservedSpacesRequired();
  }

  public onUpdateStorageSpace(): void {
    this.reservedSpacesForm.markAllAsTouched();
    if (this.reservedSpacesForm.valid) {
      this.isEditingReservedSpace = false;
      const updatedata = this.reservedSpacesForm.getRawValue();
      updatedata.RowId = this.reservedSpaceEditRowId;
      this.reservedSpacedataModel[this.reservedSpaceEditRowId - 1] = updatedata;
      this.reservedSpacedataSource = [...this.reservedSpacedataModel];
      this.reservedSpacesEditValue = undefined;
      this.reservedSpacesForm.reset();
      this.removeReservedSpacesFormValidation();
    }
  }

  public onResetStorageSpace(): void {
    this.reservedSpacesForm.patchValue({
      ReservedSpaces: APP_CONSTANTS.emptyString,
      EffectiveDate: APP_CONSTANTS.null,
      ExpirationDate: APP_CONSTANTS.null
    })
  }

  public onSubmitUploadForm(): void {
    if (!this.selectedFiles) {
      this.toastr.error("Please select file to upload.");
      return;
    }
    if (this.selectedFiles[0].size >= APP_CONSTANTS.MaxFileUploadSize) {
      this.toastr.error("Maximum file size limit is 5mb.");
      return;
    }
    if (!this.CheckValidExtension(this.selectedFiles[0])) {
      this.toastr.error("Incorrect file format. Allowed types " + APP_CONSTANTS.AllowedFileType.toString());
      this.selectedFiles = "";
      this.showFile = true;
      return;
    }
    let filechek = this.dataSourceAttachmentModel.filter((m) => m.Name == this.selectedFiles[0]?.name.toString());
    if (filechek.length > 0) {
      this.toastr.error("File is already exists.");
      return;
    }
    else {
      this.frmData = new FormData();
      this.frmData.append("File", this.selectedFiles[0]);
      this.frmData.append("VendorId", this.data.facility.VendorId);
      this.frmData.append("UserId", ApiService.UserId);
      this.frmData.append("FolderName", this.opportunityModel?.AgreementPath == undefined ? '' : this.opportunityModel?.AgreementPath);
      this.bookNowService.SaveAttachment(this.frmData).subscribe(
        data => {
          if (this.opportunityModel === undefined) {
            this.opportunityModel = new OpportunityModel();
          }
          if (data != null) {
            var _size = this.selectedFiles[0].size;
            var fSExt = new Array('Bytes', 'KB', 'MB', 'GB'),
              i = 0; while (_size > 900) { _size /= 1024; i++; }
            var exactSize = Math.round((Math.round(_size * 100) / 100)) + ' ' + fSExt[i];
            let uploadfile = {
              Name: this.selectedFiles[0]?.name.toString(),
              CreatedDate: this.datePipe.transform(new Date().toUTCString(), APP_CONSTANTS.StandardDateTimeFormat),
              Path: data?.Path,
              FolderName: data?.FolderName,
              RowId: this.dataSourceAttachmentModel == undefined ? 1 : this.dataSourceAttachmentModel.length + 1,
              Size: exactSize,
              IsActive: true,
              OpportunityId: this.opportunityModel?.Id
            }
            this.opportunityModel.AgreementPath = data?.FolderName;
            this.dataSourceAttachmentModel.push(uploadfile);
            this.dataSourceAttachment = this.dataSourceAttachmentModel.filter(m => m.IsActive);
            this.dataAttachmentviewModel = this.dataSourceAttachment;
            this.dataSourceAttachment = [...this.dataSourceAttachment];
            this.selectedFiles = "";
            this.showFile = true;
            this.toastr.success("Attachment added successfully.");
          }
        });
    }
  }

  public CheckValidExtension(file: any): boolean {
    let fileExtension = this.GetExtension(file.name);
    if (APP_CONSTANTS.AllowedFileType.indexOf(fileExtension.toLowerCase()) > -1) {
      return true;
    }
    return false;
  }

  public GetExtension(filename: string) {
    var parts = filename.split('.');
    return parts[parts.length - 1];
  }

  public generateRandomNumber(): any {
    const randomValue = new Uint32Array(1);
    self.crypto.getRandomValues(randomValue);
    return randomValue[0];
  }

  getRailCarTypeList() {
    this.railCarTypeService.GetRailCarTypeList().subscribe(
      (result) => {
        this.CarType = result;
      },
      (error) => {
      }
    );
  }

  onLandSelectionChanged(event: any): void {
    if (event.value === 2) {
      this.railCarForm.get("Hazmat")?.patchValue(false);
      this.railCarForm.get("Hazmat")?.disable();
    }
    else {
      this.railCarForm.get("Hazmat")?.enable();
      this.railCarForm.get("Hazmat")?.patchValue(APP_CONSTANTS.defaultNumberValue);
    }
  }

  getLEContentList() {
    this.leContentService.GetLEContentList().subscribe(
      (result) => {
        this.LandE = result;
      },
      (error) => {
      }
    );
  }
  public AddStorageAgreement() {

    if (this.reservedSpacesForm?.dirty) {
      this.onAddStorageSpace();
    }

    // Save Features
    let StoragefeatureModel = this.featuresForm.value.features;//.filter((m)=>m.IsActive);
    StoragefeatureModel.forEach((feature) => {
      feature.OpportunityId = this.opportunityModel?.Id;
    });
    var Storagefeature = StoragefeatureModel.filter((m) => (m.Id == 0 && m.IsActive == true) || m.Id > 0);
    if (Storagefeature != undefined && Storagefeature.length > 0) {
      this.bookNowService.SaveOpportunityFeatures(Storagefeature).subscribe(
        data => {
          Storagefeature = data;
          let index = 0;
          StoragefeatureModel.forEach(element => {
            var fileter = Storagefeature.find((m) => m.FeatureId == element.FeatureId);
            if (fileter?.Id != undefined) {
              element.Id = fileter.Id;
            }
            this.features = this.featuresForm.get('features') as FormArray;
            this.features.controls[index].patchValue(
              {
                IsActive: element.IsActive,
                Comments: element.Comments,
                OpportunityId: this.opportunityModel?.Id,
                Id: element.Id
              }
            );
            index++;
          });
          this.featuresModel = StoragefeatureModel;

        });
    }
    // Save reserved Space
    this.storagefacility.TotalNoReservedSpaces = 0;
    this.reservedSpacedataModel.forEach((ReservedSpace) => {
      ReservedSpace.EffectiveDate = this.datePipe.transform(new Date(ReservedSpace?.EffectiveDate), "yyyy-MM-dd") + "T00:00:00.00Z";
      ReservedSpace.ExpirationDate = this.datePipe.transform(new Date(ReservedSpace?.ExpirationDate), "yyyy-MM-dd") + "T00:00:00.00Z";
      ReservedSpace.OpportunityId = this.opportunityModel.Id;
      this.storagefacility.TotalNoReservedSpaces = this.storagefacility.TotalNoReservedSpaces + Number(ReservedSpace.ReservedSpaces);
    });
    if (this.storagefacility.TotalNoReservedSpaces === 0) { this.storagefacility.TotalNoReservedSpaces = APP_CONSTANTS.null; }
    if (this.reservedSpacedataModel.length > 0) {
      this.bookNowService.SaveReservedSpaces(this.reservedSpacedataModel).subscribe(
        data => {
          this.reservedSpacedataModel = data;
          this.reservedSpacedataSource = [...this.reservedSpacedataModel];
        })
    }
  }

  public onPlaceOrder(): void {
    this.opportunityModel.StartDate = this.sharedService.ConvertToFormatedDate(this.opportunityModel.StartDate);
    this.opportunityModel.EndDate = this.sharedService.ConvertToFormatedDate(this.opportunityModel.EndDate);
    this.opportunityModel.BookingDate = String(this.datePipe.transform(new Date().toUTCString(), APP_CONSTANTS.StandardDateTimeFormat))
    this.bookNowService.PlaceOrderOpportunity(this.opportunityModel).subscribe(
      result => {
        this.OrderNumber = String(result.Name);
        this.toastr.success('Order Placed Successfully.');
        //this.dialogRef.close();
      })
  }

  public onOrderSummaryDownload() {
    this.bookNowService.GetOpportunityById(this.opportunityModel.Id).subscribe(result => {
      this.opportunityModel = result
      this.bookNowService.OrderSummaryDownload(result.AgreementPath).subscribe((fileBlob) => {
        this.download(fileBlob, 'Order Summary.docx');
      },
        error => {
          this.toastr.error("Unable to Download Order Summary. Please contact administrator.");
        });
    });

  }

  public DownloadAttachment(element) {
    element.CreatedTime = new Date(element.CreatedTime)
    this.bookNowService.DownloadAttachment(element).subscribe(
      data => {
        this.download(data, element.Name);
      })
  }

  public download(data: Blob, Name: string) {
    const downloadedFile = new Blob([data], { type: data.type });
    const a = document.createElement('a');
    a.setAttribute('style', 'display:none;');
    document.body.appendChild(a);
    a.download = Name;
    a.href = URL.createObjectURL(downloadedFile);
    a.target = '_blank';
    a.click();
    document.body.removeChild(a);
  }

  public onReservedSpaceConfirmationBox(element) {
    const options = {
      title: 'Confirm Delete',
      message: `Are you sure you want to delete Reserved Space?`,
      cancelText: 'No',
      confirmText: 'Yes',
      reverseBtn: true
    };
    this.dialogService.open(options);
    this.dialogService.confirmed().subscribe((confirmed) => {
      if (confirmed) {
        if (element?.Id > 0) {
          this.bookNowService.DeleteReservedSpace(element?.Id).subscribe(
            data => {
              if (data) {
                const index = this.reservedSpacedataModel.indexOf(element);
                this.reservedSpacedataModel.splice(index, 1);
                this.reservedSpacedataSource = [...this.reservedSpacedataModel];
              }
            });
        } else {
          const index = this.reservedSpacedataModel.indexOf(element);
          this.reservedSpacedataModel.splice(index, 1);
          this.reservedSpacedataSource = [...this.reservedSpacedataModel];
        }
        this.toastr.success("Attachment Deleted successfully.");
      }
    });
  }

  public onValidateCarId(): boolean {
    const validateCarId = this.railCarForm.get('RailCarIds')?.value;
    if (validateCarId) {
      const railcarsList: Array<string> = validateCarId.split('\n');
      const regex = new RegExp(/(^[a-zA-Z]{2,4})\s?\-?((\d){1,6}$)/);
      const filtered = railcarsList.filter((item) => regex.exec(item));
      if (filtered.length != railcarsList.length) return false;
    }
    return true;
  }

  public triggerValidation(stepper?: MatStepper): void {
    this.firstFormGroup.markAllAsTouched();
    const changed = this.checkForFieldChange(this.railCarForm, this.fieldsToCheckForChangedOrNot);
    if (changed) {
      this.railCarForm.markAllAsTouched();
      this.sharedService.ValidatSelectControl(this.fieldsToCheckDefaultValues, this.railCarForm);
      let isValid = this.onValidateCarId();
      if (this.railCarForm.invalid || !isValid) {
        if (!isValid) {
          this.toastr.error('Railcar invalid format.');
        }
        stepper?.steps.first.select();
        return;
      }
      else {
        if (this.isEditingRailcar) {
          this.updateRailcar();
        }
        else {
          this.addRailcar();
        }
      }
    }
    else {
      this.isRailCarMandatory = false;
      this.setRequiredValidation(this.fieldToSetMandatory, this.railCarForm, this.fieldsToCheckForChangedOrNot, false);
      this.SaveOpportunity();
    }
  }

  public onUpperCase(event) {
    event.target.value = event.target.value.toUpperCase();
  }

  public onRemoveFile(event) {
    this.selectedFiles = "";
    this.showFile = true;
    event.stopPropagation();
    event.preventDefault();
  }
  public onChangeReservedSpacesRequired() {
    this.reservedSpacesFormValidation = true;
    this.reservedSpacesForm.get('ReservedSpaces')?.setValidators(Validators.required);
    this.reservedSpacesForm.get('EffectiveDate')?.setValidators(Validators.required);
    this.reservedSpacesForm.get('ExpirationDate')?.setValidators(Validators.required);
    this.reservedSpacesForm.get('ReservedSpaces')?.updateValueAndValidity();
    this.reservedSpacesForm.get('EffectiveDate')?.updateValueAndValidity();
    this.reservedSpacesForm.get('ExpirationDate')?.updateValueAndValidity();
  }

  public checkForFieldChange(form: FormGroup, fieldsToCheckForChangedOrNot: any): boolean {
    for (const field in fieldsToCheckForChangedOrNot) {
      const fieldValue = form.get(field.valueOf())?.value;
      if (this.sharedService.CheckIfEmptyOrNull(fieldValue) && fieldValue !== fieldsToCheckForChangedOrNot[field]) {
        return true;
      }
    }
    return false;
  }
  public setRequiredValidation(fields: any, form: FormGroup, defaultValue: any, setValidation: boolean): void {
    fields.forEach((key: string) => {
      const control = form.controls[key];
      if (setValidation) {
        control.setValidators(Validators.required);
      }
      else {
        control.removeValidators(Validators.required);
        control.markAsUntouched();
        control.reset();
        control.patchValue(defaultValue[key]);
      }
    });
  }
  public removeReservedSpacesFormValidation() {
    this.reservedSpacesFormValidation = false;
    this.reservedSpacesForm.get('ReservedSpaces')?.setValidators(null);
    this.reservedSpacesForm.get('ReservedSpaces')?.updateValueAndValidity();
    this.reservedSpacesForm.get('EffectiveDate')?.setValidators(null);
    this.reservedSpacesForm.get('EffectiveDate')?.updateValueAndValidity();
    this.reservedSpacesForm.get('ExpirationDate')?.setValidators(null);
    this.reservedSpacesForm.get('ExpirationDate')?.updateValueAndValidity();
  }

  public prepareRailCarId(railcarIDs: string): string {
    const railcarsList: Array<string> = railcarIDs.split('\n');
    const regex = new RegExp(/(^[a-zA-Z]{2,4})\s?\-?((\d){1,6}$)/);
    let formattedRailCarIds = '';
    let count = 0;
    railcarsList.filter((item) => {
      count++;
      const match = regex.exec(item)
      if (match) {
        const carInitial = match[1];
        let carNumber = "";
        if (match[2].length < 6) {
          var str = new Array(6 - match[2].length + 1).join('0');
          carNumber = str + match[2];
        }
        else {
          carNumber = match[2];
        }
        formattedRailCarIds = formattedRailCarIds + carInitial + carNumber;
        if (count < railcarsList.length) {
          formattedRailCarIds = formattedRailCarIds + '\n';
        }
      }
    });
    return formattedRailCarIds;
  }
}

