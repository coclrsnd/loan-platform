import { animate, state, style, transition, trigger } from '@angular/animations';
import { SelectionModel } from '@angular/cdk/collections';
import { CurrencyPipe, DatePipe } from '@angular/common';
import { AfterViewInit, Component, DoCheck, ElementRef, EventEmitter, Input, KeyValueDiffer, KeyValueDiffers, OnInit, Output, ViewChild } from '@angular/core';
import { FormArray, FormBuilder, FormGroup, Validators } from '@angular/forms';
import { MatInput } from '@angular/material/input';
import { MatSort } from '@angular/material/sort';
import { ToastrService } from 'ngx-toastr';
import {
  debounceTime,
  finalize,
  Observable,
  of,
  switchMap,
  tap,
} from 'rxjs';
import { APP_CONSTANTS } from 'src/app/app-constants';
import { ConfirmDialogService } from 'src/app/shared/components/confirm-dialog/confirm-dialog.service';
import { DateValidators } from 'src/app/shared/directives/validatorDate';
import { SharedService } from 'src/app/shared/shared.service';
import { LEContentService } from '../../le-content/leContentService';
import { RailCarTypeService } from '../../rail-car-type/railCarTypeService';
import { RiderService } from '../../rider/rider-service';
import { RiderModel } from '../../rider/RiderModel';
import { ContractRailCarChargesModel } from './contractrailcarcharges.model';
import { railCarModel } from './railCarModel';
import { RailCarService } from './railCarService';

@Component({
  selector: 'app-rail-car-details-tab',
  templateUrl: './rail-car-details-tab.component.html',
  styleUrls: ['./rail-car-details-tab.component.scss'],
  animations: [
    trigger('detailExpand', [
      state('collapsed', style({height: '0px', minHeight: '0'})),
      state('expanded', style({height: '*'})),
      transition('expanded <=> collapsed', animate('225ms cubic-bezier(0.4, 0.0, 0.2, 1)')),
    ]),
  ],
})
export class RailCarDetailsTabComponent
  implements OnInit, DoCheck, AfterViewInit
{
  @ViewChild(MatSort, { static: false }) sort: MatSort;
  @ViewChild(MatInput, { static: false }) input: MatInput;
  @Input() optionsConfig;
  @Input() riderModelData;
  @Input() isFromPage: string = '';
  @Input() mode;
  @Input() currentUserRole;
  @Input() SearchFilterModel: any;
  @Output() onCarsUpdated = new EventEmitter<any>();
  @Output() updatedRibbonModel = new EventEmitter<any>();
  @Output() updateHistoryList = new EventEmitter<boolean>();
  public expandedElements: any[] = [];
  public riderDetailsTabForm: FormGroup;
  public railCarModel = new railCarModel();
  //public selectedRailCarTypeId: any;
  //public selectedLEId: any;
  public riderDetailsRowAddForm: FormGroup;
  public railCarTypesList: any;
  public leContentList: any;
  public submittedDetails: boolean = false;
  public isAddCars: boolean = false;
  public isUpload: boolean = false;
  public isDuplicate: boolean = false;
  public isUpdate: boolean = false;
  public warningMessage: boolean = false;
  public submittedForm: boolean = false;
  public currentlyActiveActivity: string = '';
  public objDiffers: Array<KeyValueDiffer<string, any>>;
  public selectedFiles: any;
  //public dataSource = new MatTableDataSource<any>(APP_CONSTANTS.railCarDetails);
  public dataSource: any;
  public sortedData: any[];
  public columnsToDisplay: any[];
  public columnsToDisplayInDetails = ['Amount', 'Title', 'Date'];
  public selection = new SelectionModel<any>(true, []);
  public expandedElement: any | null;
  public isDynamicValidatorApplied = false;
  public disableFieldsForCustomer = ['FormArrivalDate', 'FormDepartureDate'];
  public hazmatTF = APP_CONSTANTS.hazmatTF;
  public todaysDate: Date = new Date();
  storageOrderList: any;
  isSearching = false;
  noResults = false;
  public railCarRibbonModel : any;

  public selectedStorageOrderId: number = 0;

  public defaultDateFormat= APP_CONSTANTS.DefaultDateTimeFormat;
  public deletedRailCarCharges:ContractRailCarChargesModel[]=[];
  public isAddRailCarChargesButtonVisible:boolean = true;
  public isSSRValidationEnabled: boolean = false;

  constructor(
    public formBuilder: FormBuilder,
    public differs: KeyValueDiffers,
    public datepipe: DatePipe,
    public railCarTypeService: RailCarTypeService,
    public leContentService: LEContentService,
    public railCarService: RailCarService,
    public toastr: ToastrService,
    public riderService: RiderService,
    private sharedService: SharedService,
    private currencyPipe: CurrencyPipe,
    private dialogService: ConfirmDialogService,
    private el: ElementRef
  ) {
    if (this.dataSource) {
      this.sortedData = this.dataSource.filteredData.slice();
    }
    this.selection.changed.subscribe((item) => {
      if (this.selection?.selected.length && this.warningMessage === true) {
        this.warningMessage = false;
      }
    });
  }

  ngOnInit(): void {
    this.initializeRiderDetailsTabForm();

    this.objDiffers = new Array<KeyValueDiffer<string, any>>();
    this.optionsConfig.forEach((elt) => {
      this.objDiffers[elt] = this.differs.find(elt).create();
    });
    if (this.isFromPage == APP_CONSTANTS.storageOrder) {
      if (this.currentUserRole === APP_CONSTANTS.Customer) {
        this.onDisableFields(this.riderDetailsTabForm.controls, this.disableFieldsForCustomer);
      }
      this.columnsToDisplay = [
        'select',
        'CarId',
        'CarTypeName',
        'LEName',
        'LEContents',
        'BolDate',
        'ArrivalDate',
        'DepartureDate',
        'Fleet',
        'Notes',
        'Details'
      ];
      if (this.riderModelData.Id && this.mode !== APP_CONSTANTS.copy) {
        this.railCarService
          .GetRailCarDetailsByContractId(this.riderModelData.Id)
          .subscribe(
            (railCarDetails) => {
              this.dataSource = railCarDetails;
            },
            (error) => {
            }
          );
      }
    } else {
      this.columnsToDisplay = [
        'select',
        'StorageOrder',
        'CarId',
        'CarTypeName',
        'LEName',
        'LEContents',
        'BolDate',
        'ArrivalDate',
        'DepartureDate',
        'Fleet',
        'Notes',
        'Details'
      ];
      this.getRailCarDetails();
      this.loadStorageOrders();
    }
    this.getRailCarTypeList();
    this.getLEContentList();
  }

  public loadStorageOrders(): void {
    const storageOrderControl = this.riderDetailsTabForm.get('StorageOrder');
    if (storageOrderControl) {
      storageOrderControl?.valueChanges
        .pipe(
          debounceTime(1000),
          tap(() => {
            this.storageOrderList = [];
            this.selectedStorageOrderId = -1;
          }),
          switchMap((value) =>
            this.filterStorageOrder(value).pipe(
              finalize(() => {
                if (value.length > 1 && this.storageOrderList.length === 0) {
                  this.selectedStorageOrderId = -1;
                  this.noResults = true;
                } else if (
                  value.length == 0 &&
                  this.storageOrderList.length === 0
                ) {
                  this.selectedStorageOrderId = 0;
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
            this.storageOrderList = data;
          }
          // else{
          //   this.noResults=true;
          // }
        });
    }
  }

  public filterStorageOrder(val: string): Observable<RiderModel[]> {
    if (val != undefined && val.length > 1) {
      this.isSearching = true;
      return this.riderService.GetStorageOrderList(val);
    } else {
      this.noResults = false;
      this.selectedStorageOrderId = -1;
      return of([]);
    }
  }

  public onStorageOrderChanged(event: any): void {
    this.riderDetailsTabForm.patchValue({
      StorageOrder: event.option.value.Rider,
    });
    this.selectedStorageOrderId = event.option.value.Id;
    this.riderModelData.Id = event.option.value.Id;
    this.riderModelData.CustomerId = event.option.value.CustomerId;
  }

  getRailCarTypeList() {
    this.railCarTypeService.GetRailCarTypeList().subscribe(
      (result) => {
        this.railCarTypesList = result;
      },
      (error) => {
      }
    );
  }

  getLEContentList() {
    this.leContentService.GetLEContentList().subscribe(
      (result) => {
        this.leContentList = result;
      },
      (error) => {
      }
    );
  }

  ngDoCheck() {
    this.optionsConfig.forEach((elt) => {
      var objDiffer = this.objDiffers[elt];
      var objChanges = objDiffer.diff(elt);
      if (objChanges) {
        objChanges.forEachChangedItem((elt) => {
          this.closeAllActivity();
          this.currentlyActiveActivity = elt.key;
          switch (elt.key) {
            case APP_CONSTANTS.addCars:
              this.onAddCars();
              break;
            case APP_CONSTANTS.upload:
              this.onUploadRow();
              break;
            case APP_CONSTANTS.duplicate:
              this.onDuplicateRow();
              break;
            case APP_CONSTANTS.update:
              this.onUpdateRow();
              break;
          }
        });
      }
    });
  }

  ngAfterViewInit(): void {
    if (this.dataSource) {
      this.dataSource.sort = this.sort;
      // this.dataSource.paginator = this.paginator;
      // this.dataSource.paginator?._changePageSize(400)
    }
  }

  // Initilize Rider Details Tab form
  public initializeRiderDetailsTabForm(): void {
    this.riderDetailsTabForm = this.formBuilder.group(
      {
        StorageOrder: [
          APP_CONSTANTS.emptyString,
          Validators.pattern(/^[a-zA-Z0-9-&. ]*$/),
        ],
        CarNumber: [APP_CONSTANTS.emptyString],
        LandE: [APP_CONSTANTS.null],
        CarId: [
          { value: APP_CONSTANTS.emptyString, disabled: false },
          [Validators.required],
        ],
        CarType: [APP_CONSTANTS.emptyString, Validators.required],
        LEContents: [
          APP_CONSTANTS.emptyString,
          Validators.pattern(/^[a-zA-Z0-9 ]*$/),
        ],
        FormBolDate: [APP_CONSTANTS.null],
        FormArrivalDate: [APP_CONSTANTS.null],
        FormDepartureDate: [APP_CONSTANTS.null],
        Notes: [APP_CONSTANTS.emptyString],
        Fleet: [APP_CONSTANTS.emptyString],
        Hazmat: [APP_CONSTANTS.emptyString],
        RailCarSwitching: this.formBuilder.array([]),
      },
      {
        validator: Validators.compose([
          DateValidators.dateLessThan('FormArrivalDate', 'FormDepartureDate', {
            'departureIssue': true,
          }),
        ]),
      }
    );
    this.loadChargeForm();
  }

    // convenience getter for easy access to Location form fields
    get getSwitchingDetailsForm() {
       return (this.riderDetailsTabForm.get('RailCarSwitching') as FormArray).controls;
    }

  public onRemoveSwitching(index): void {
    let deletedChargeFormData=((this.riderDetailsTabForm.controls['RailCarSwitching']) as FormArray).at(index)?.value;
      let contractCharges=new ContractRailCarChargesModel();
      contractCharges.Amount=this.sharedService.ConvertToDecimal(deletedChargeFormData.SpecialSwitchingRate);
      contractCharges.Title=deletedChargeFormData.SpecialSwitchingTitle;
      contractCharges.Date=this.sharedService.ConvertToFormatedDate(deletedChargeFormData.FormSpecialSwitchingDate);
      contractCharges.Id=deletedChargeFormData.Id;
      contractCharges.IsActive=APP_CONSTANTS.false;
      this.deletedRailCarCharges.push(contractCharges);

    const control = this.riderDetailsTabForm.controls[
      'RailCarSwitching'
    ] as FormArray;
    control.removeAt(index);

  }

  private loadChargeForm(): void{
    if(this.currentUserRole !== APP_CONSTANTS.Customer){
    (this.riderDetailsTabForm.get('RailCarSwitching') as FormArray).push(this.initializeRailCarSwitchingForm());
    }
  }

  public onAddSwitchingForm(index): void {
    if(this.currentUserRole !== APP_CONSTANTS.Customer){
      if(this.riderDetailsTabForm.controls['RailCarSwitching']?.valid) {
        this.isSSRValidationEnabled=false;
        (this.riderDetailsTabForm.get('RailCarSwitching') as FormArray).push(this.initializeRailCarSwitchingForm());
        this.setFocusOnSSR();
      } else {
        this.isSSRValidationEnabled=true;
      }
    }
  }

  private setFocusOnSSR(): void{
    setTimeout(()=> {
      const focusOnControl = this.el.nativeElement.querySelectorAll('[formcontrolname="' + 'SpecialSwitchingRate' + '"]');
      const focusToControl = focusOnControl[focusOnControl.length-1];
      focusToControl.focus();
     }, 100);
  }

  public initializeRailCarSwitchingForm(): FormGroup {
    return this.formBuilder.group({
      SpecialSwitchingRate: [
        APP_CONSTANTS.null,
        {
          validators: [
            Validators.maxLength(9),
            Validators.min(-999999),
            Validators.max(999999)
          ],
          updateOn: 'change',
          asyncValidators: [],
        },
      ],
      SpecialSwitchingTitle: [APP_CONSTANTS.emptyString],
      FormSpecialSwitchingDate: [APP_CONSTANTS.null],
      Id: [APP_CONSTANTS.defaultNumberValue],
      IsActive: [APP_CONSTANTS.true]
    });
  }

  // convenience getter for easy access to form fields
  get riderDetailsGetter() {
    return this.riderDetailsTabForm.controls;
  }

  getRailCarDetails() {
    this.railCarModel = this.SearchFilterModel;
    this.railCarModel.IsDefault = APP_CONSTANTS.true;

    this.railCarService.GetRailCarDetails(this.railCarModel).subscribe(
      (railCarDetails) => {
        if (railCarDetails.RailCarList != null && railCarDetails.RailCarList.length > 0) {
          railCarDetails.RailCarList.forEach(e => {
            e.FormArrivalDate = this.sharedService.ConvertToDatePickerDate(e.ArrivalDate),
              e.FormBolDate = this.sharedService.ConvertToDatePickerDate(e.BolDate),
              e.FormDepartureDate = this.sharedService.ConvertToDatePickerDate(e.DepartureDate)
              e.ContractRailCarCharge.forEach(e => {
                e.FormSpecialSwitchingDate =  this.sharedService.ConvertToDatePickerDate(e.Date)
              })
          });
          this.dataSource = railCarDetails.RailCarList;
        }
        else {
          this.dataSource = [];
        }
        this.updatedRibbonModel.emit(railCarDetails.RailCarRibbon);
      },
      (error) => {
      }
    );
  }

  public onSubmitForm(): void {
    this.submittedDetails = true;
    // stop here if form is invalid
    if (this.riderDetailsTabForm.invalid) {
      return;
    }
    const formData = this.riderDetailsTabForm.getRawValue();
    let formattedObj = this.formatFormData(formData);
    switch (this.currentlyActiveActivity) {
      case APP_CONSTANTS.addCars:
        this.SaveRailCars(formattedObj);
        break;
      case APP_CONSTANTS.upload:
        this.onUploadRow();
        break;
      case APP_CONSTANTS.duplicate:
        this.SaveRailCars(formattedObj);
        break;
      case APP_CONSTANTS.update:
        let contractRailCarMappingId =
          this.railCarModel.ContractRailCarMappingId;
        let railCarId = this.railCarModel.RailCarId;
        let createdTime = this.railCarModel.CreatedTime;
        let carsStored = this.railCarModel.CarsStored;
        let isUnderStorage = this.railCarModel.IsUnderStorage;
        this.railCarModel = Object.assign(
          this.riderDetailsTabForm.getRawValue()
        );
        this.railCarModel.RailCarTypeId = this.riderDetailsTabForm.controls[
          'CarType'
        ]?.value
          ? this.riderDetailsTabForm.controls['CarType'].value
          : null;

          this.railCarModel.Id=railCarId;
        this.railCarModel.LEId =
          this.riderDetailsTabForm.controls['LandE'].value;
        this.railCarModel.ContractId = this.riderModelData.Id;
        this.railCarModel.CustomerId = this.riderModelData.CustomerId;
        this.railCarModel.RailCarId = railCarId;
        this.railCarModel.ContractRailCarMappingId = contractRailCarMappingId;
        this.railCarModel.CreatedTime = createdTime;
        this.railCarModel.CarsStored = carsStored;
        this.railCarModel.IsUnderStorage = isUnderStorage;

        this.railCarModel.BolDate = this.sharedService.ConvertToFormatedDate(this.railCarModel.FormBolDate);
        this.railCarModel.ArrivalDate =this.sharedService.ConvertToFormatedDate(this.railCarModel.FormArrivalDate);
        this.railCarModel.DepartureDate = this.sharedService.ConvertToFormatedDate(this.railCarModel.FormDepartureDate);
        this.railCarModel.IsHazmatCar=this.getHazmatVal(this.riderDetailsTabForm.controls['Hazmat'].value);

        let contractRailCarCharges= this.riderDetailsTabForm.controls['RailCarSwitching'].value;
        if(this.isValidSpecialChargeDetail(contractRailCarCharges)){
          this.railCarModel.ContractRailCarCharge=[];
          contractRailCarCharges.forEach(charges=> {
            if(this.sharedService.CheckDecimalIsEmpty(charges.SpecialSwitchingRate) != null ||
            charges.Id > 0) {
              let contractCharges=new ContractRailCarChargesModel();
              contractCharges.Id=charges.Id;
              contractCharges.IsActive=charges.IsActive;
              contractCharges.Amount=this.sharedService.ConvertToDecimal(charges.SpecialSwitchingRate);
              contractCharges.Title=charges.SpecialSwitchingTitle;
              contractCharges.Date=this.sharedService.ConvertToFormatedDate(charges.FormSpecialSwitchingDate);
              this.railCarModel.ContractRailCarCharge.push(contractCharges);
            }
          })

          if(this.deletedRailCarCharges!=null && this.deletedRailCarCharges.length>0){
            this.deletedRailCarCharges.forEach(deletedRecord=>{
              this.railCarModel.ContractRailCarCharge.push(deletedRecord);
            })
          }
        this.railCarService
          .UpdateRailCarDetailsForStorageOrder(this.railCarModel)
          .subscribe(
            (result) => {
              if (result.IsSaved) {
                this.toastr.success('Railcar details updated.');
                if (this.isFromPage == APP_CONSTANTS.storageOrder) {
                  this.railCarService
                    .GetRailCarDetailsByContractId(this.railCarModel.ContractId)
                    .subscribe(
                      (railCarDetails) => {
                        this.dataSource = railCarDetails;
                        this.onCarsUpdated.emit(railCarDetails[0].CarsStored);
                        this.updateHistoryList.emit(true);
                      },
                      (error) => {
                      }
                    );
                } else {
                  this.getRailCarDetails();
                }
                this.selection.clear();
                this.riderDetailsTabForm.reset();
                this.submittedDetails = false;
                this.closeAllActivity();
              } else {
                this.toastr.error(
                  'Railcar details not updated, railcar is already under storage.'
                );
              }
            },
            (error) => {
            }
          );
        }
    }
  }

  SaveRailCars(formattedObj: any) {
    const railCarIds = formattedObj.CarId
      ? formattedObj.CarId.toUpperCase().split('\n')
      : formattedObj.CarId.toUpperCase();
    this.railCarModel = Object.assign(this.riderDetailsTabForm.getRawValue());
    this.railCarModel.RailCarTypeId = this.riderDetailsTabForm.controls[
      'CarType'
    ]?.value
      ? this.riderDetailsTabForm.controls['CarType'].value
      : null;
    this.railCarModel.LEId = this.riderDetailsTabForm.controls['LandE'].value;
    this.railCarModel.ContractId = this.riderModelData.Id;
    this.railCarModel.CustomerId = this.riderModelData.CustomerId;
    this.railCarModel.CarIds = railCarIds;
    this.railCarModel.IsHazmatCar= this.getHazmatVal(this.riderDetailsTabForm.controls['Hazmat'].value);

    this.railCarModel.BolDate = this.sharedService.ConvertToFormatedDate(this.railCarModel.FormBolDate);
    this.railCarModel.ArrivalDate =this.sharedService.ConvertToFormatedDate(this.railCarModel.FormArrivalDate);
    this.railCarModel.DepartureDate = this.sharedService.ConvertToFormatedDate(this.railCarModel.FormDepartureDate);

    let contractRailCarCharges= this.riderDetailsTabForm.controls['RailCarSwitching'].value;
    if(this.isValidSpecialChargeDetail(contractRailCarCharges)) {
      this.railCarModel.ContractRailCarCharge=[];
      contractRailCarCharges.forEach(charges=>{
        if(this.sharedService.CheckDecimalIsEmpty(charges.SpecialSwitchingRate) != null) {
        let contractCharges=new ContractRailCarChargesModel();
        contractCharges.Amount=this.sharedService.ConvertToDecimal(charges.SpecialSwitchingRate);
        contractCharges.Title=charges.SpecialSwitchingTitle;
        contractCharges.Date=this.sharedService.ConvertToFormatedDate(charges.FormSpecialSwitchingDate);
        contractCharges.Id=0;
        contractCharges.IsActive=charges.IsActive;
        this.railCarModel.ContractRailCarCharge.push(contractCharges);
        }
      })

    let isValid = this.onValidateCarId();
    if (!isValid) {
      this.toastr.error('Railcar invalid format.');
    } else {
      this.railCarService
        .SaveRailCarDetailsForStorageOrder(this.railCarModel)
        .subscribe(
          (result) => {
            if (result.IsSaved) {
              this.toastr.success('Railcar details saved.');
              if (this.isFromPage == APP_CONSTANTS.storageOrder) {
                this.railCarService
                  .GetRailCarDetailsByContractId(this.railCarModel.ContractId)
                  .subscribe(
                    (railCarDetails) => {
                      this.dataSource = railCarDetails;
                      this.onCarsUpdated.emit(railCarDetails[0].CarsStored);
                      this.updateHistoryList.emit(true);
                    },
                    (error) => {
                    }
                  );
              } else {
                this.getRailCarDetails();
              }
              this.selection.clear();
              this.riderDetailsTabForm.reset();
              this.submittedDetails = false;
              this.closeAllActivity();
            } else {
              if (result.InvalidCars?.length > 0 && result.IsDuplicate) {
                this.toastr.error(
                  'Railcar details not saved.' +
                  ' Car(s): ' +
                    result.InvalidCars.toString() +
                    ' already exists for this Storage Order.'
                );
              } else if (
                result.InvalidCars?.length > 0 &&
                !result.IsDuplicate
              ) {
                this.toastr.error(
                  'Railcar details not saved.' +
                    ' Car(s): ' +
                    result.InvalidCars.toString() +
                    ' are currently under Storage.'
                );
              } else if (result.IsDuplicate) {
                this.toastr.error('Railcar not saved, duplicate Car(s): ');
              } else {
                this.toastr.error('Railcar details not saved.');
              }
            }
          },
          (error) => {
          }
        );
    }
    }
  }

  private isValidSpecialChargeDetail(contractRailCarCharges:any): boolean {
    let isValid=true;
    contractRailCarCharges.forEach(charges=> {
      if(this.sharedService.CheckIfEmptyOrNull(charges.SpecialSwitchingRate)!=='' ||
      this.sharedService.CheckIfEmptyOrNull(charges.SpecialSwitchingTitle)!=='' ||
      this.sharedService.CheckIfEmptyOrNull(charges.FormSpecialSwitchingDate)!=='') {
          if(this.sharedService.CheckIfEmptyOrNull(charges.SpecialSwitchingRate) === '' ||
          this.sharedService.CheckIfEmptyOrNull(charges.SpecialSwitchingTitle) === '' ||
          this.sharedService.CheckIfEmptyOrNull(charges.FormSpecialSwitchingDate) === '') {
            isValid = false;
          }

      }
  });
  return isValid;
}

  public onReset(): void {
    const options = {
      title: 'Warning',
      message: `Do you really want to discard changes?`,
      cancelText: 'No',
      confirmText: 'Yes',
    };
    this.dialogService.open(options);
    this.dialogService.confirmed().subscribe((confirmed) => {
      if (confirmed) {
          // this.riderDetailsTabForm.reset();
          this.riderDetailsTabForm.patchValue({
            StorageOrder: APP_CONSTANTS.emptyString,
            CarNumber: APP_CONSTANTS.emptyString,
            LandE: APP_CONSTANTS.null,
            CarId: APP_CONSTANTS.emptyString,
            CarType: APP_CONSTANTS.emptyString,
            FormBolDate: APP_CONSTANTS.null,
            FormArrivalDate: APP_CONSTANTS.null,
            FormDepartureDate: APP_CONSTANTS.null,
            Notes: APP_CONSTANTS.emptyString,
            Fleet: APP_CONSTANTS.emptyString,
            LEContents: APP_CONSTANTS.emptyString
          });
          this.removeDynamicValidations();
          this.submittedDetails = false;
          if (this.currentlyActiveActivity === APP_CONSTANTS.update) {
            this.onUpdateRow();
          }
        }
    });
  }

  public onAddCars(): void {
    this.isAddCars = true;
    this.riderDetailsTabForm.controls['CarId'].enable();
    this.riderDetailsTabForm.controls['CarType'].enable();
    this.riderDetailsTabForm.controls['StorageOrder'].enable();
    this.initializeRiderDetailsTabForm();
    this.removeDynamicValidations();
    this.loadStorageOrders();
    this.setDynamicValidations();
    this.onDisableFields(this.riderDetailsTabForm.controls, this.disableFieldsForCustomer);
  }

  public onUploadRow(): void {
    this.isUpload = true;
  }

  public setDynamicValidations(): void {
    const formControl = this.riderDetailsTabForm;
    formControl.get('FormArrivalDate')?.valueChanges.subscribe(value => {
      if (value) {
        this.addArrivalDateValidation(value);
      }
    });

  }

  public addArrivalDateValidation(value): void {
    const formControl = this.riderDetailsTabForm;
    this.isDynamicValidatorApplied = true;
    formControl.get('LandE')?.setValidators(Validators.required);
    formControl.get('LandE')?.updateValueAndValidity();
    formControl.get('Hazmat')?.setValidators(Validators.required);
    formControl.get('Hazmat')?.updateValueAndValidity();
  }

  public removeDynamicValidations(): void {
    this.removeArrivalDateValidation();
  }

  public removeArrivalDateValidation(): void {
    const formControl = this.riderDetailsTabForm;
    this.isDynamicValidatorApplied = false;
    formControl.get('LandE')?.setValidators(null);
    formControl.get('LandE')?.updateValueAndValidity();
    formControl.get('Hazmat')?.setValidators(null);
    formControl.get('Hazmat')?.updateValueAndValidity();
  }

  public onRateChange(index:number): void {
    this.verifyChargesValidation(index);
  }

  public onTitleChanged(index:number): void {
    this.verifyChargesValidation(index);
  }

  public onSpecialChargeDateChanged(index:number): void {
    this.verifyChargesValidation(index);
  }

  private verifyChargesValidation(index:number): void {
    let element = (this.riderDetailsTabForm.controls['RailCarSwitching'] as FormArray).controls[index];

    if(this.sharedService.CheckIfEmptyOrNull(element.get('SpecialSwitchingRate')?.value)!='')
    {
      element.get('SpecialSwitchingTitle')?.setValidators(Validators.required);
      element.get('SpecialSwitchingTitle')?.updateValueAndValidity();
      element.get('FormSpecialSwitchingDate')?.setValidators(Validators.required);
      element.get('FormSpecialSwitchingDate')?.updateValueAndValidity();
    }
   else if(this.sharedService.CheckIfEmptyOrNull(element.get('SpecialSwitchingTitle')?.value)!='')
    {
      element.get('SpecialSwitchingRate')?.setValidators(Validators.required);
      element.get('SpecialSwitchingRate')?.updateValueAndValidity();
      element.get('FormSpecialSwitchingDate')?.setValidators(Validators.required);
      element.get('FormSpecialSwitchingDate')?.updateValueAndValidity();
    }
    else if(this.sharedService.CheckIfEmptyOrNull(element.get('FormSpecialSwitchingDate')?.value)!=''){
        element.get('SpecialSwitchingRate')?.setValidators(Validators.required);
        element.get('SpecialSwitchingRate')?.updateValueAndValidity();
        element.get('SpecialSwitchingTitle')?.setValidators(Validators.required);
        element.get('SpecialSwitchingTitle')?.updateValueAndValidity();
      }
    else{
      element.get('SpecialSwitchingRate')?.setValidators(null);
      element.get('SpecialSwitchingRate')?.updateValueAndValidity();
        element.get('SpecialSwitchingTitle')?.setValidators(null);
        element.get('SpecialSwitchingTitle')?.updateValueAndValidity();
        element.get('FormSpecialSwitchingDate')?.setValidators(null);
        element.get('FormSpecialSwitchingDate')?.updateValueAndValidity();
      }
  }

  public onDuplicateRow(): void {
    if (this.selection?.selected.length) {
      this.isDuplicate = true;
      let carToDuplicate = Object.assign({}, this.selection?.selected[0]);
      let formattedObj = this.formatDateData(carToDuplicate);
      this.riderDetailsTabForm.patchValue(formattedObj);
      this.riderDetailsTabForm.controls['CarId'].enable();
      this.riderDetailsTabForm.controls['CarType'].enable();
      this.riderDetailsTabForm.controls['StorageOrder'].enable();
      this.riderDetailsTabForm.patchValue({
        CarType: carToDuplicate.RailCarTypeId,
        LandE: carToDuplicate.LEId,
        StorageOrder: carToDuplicate.StorageOrder,
        FormArrivalDate: APP_CONSTANTS.null,
        FormDepartureDate: APP_CONSTANTS.null,
        FormBolDate: APP_CONSTANTS.null
      });
      this.setHazmatVal(carToDuplicate.IsHazmatCar);
      this.riderModelData.Id = carToDuplicate.ContractId;
      this.riderModelData.CustomerId = carToDuplicate.CustomerId;
      this.setDynamicValidations();
      this.removeDynamicValidations();
      this.riderDetailsTabForm.controls['RailCarSwitching']= new FormArray([]);
      if(this.currentUserRole !== APP_CONSTANTS.Customer) {
        (this.riderDetailsTabForm.get('RailCarSwitching') as FormArray).push(this.initializeRailCarSwitchingForm());
      }
    } else {
      this.showSelectionWarning();
    }
  }

  public onUpdateRow(): void {
    if (this.selection?.selected.length) {
      this.removeDynamicValidations();
      this.isUpdate = true;
      let carToUpdate = Object.assign({}, this.selection?.selected[0]);
      let formattedObj = this.formatDateData(carToUpdate);
      this.riderDetailsTabForm.reset();
      this.riderDetailsTabForm.patchValue(formattedObj);
      this.riderDetailsTabForm.controls['CarId'].disable();
      this.riderDetailsTabForm.controls['CarType'].disable();
      this.riderDetailsTabForm.controls['StorageOrder'].disable();
      this.riderDetailsTabForm.patchValue({
        CarType: carToUpdate.RailCarTypeId,
        LandE: carToUpdate.LEId,
        StorageOrder: carToUpdate.StorageOrder,
        FormArrivalDate: this.sharedService.ConvertToDatePickerDate(carToUpdate.ArrivalDate),
        FormDepartureDate: this.sharedService.ConvertToDatePickerDate(carToUpdate.DepartureDate),
        FormBolDate: this.sharedService.ConvertToDatePickerDate(carToUpdate.BolDate)
      });

      this.railCarModel.Id=carToUpdate.Id;
      this.railCarModel.ContractRailCarMappingId =
        carToUpdate.ContractRailCarMappingId;
      this.railCarModel.RailCarId = carToUpdate.Id;
      this.railCarModel.CreatedTime = carToUpdate.CreatedTime;
      this.railCarModel.CarsStored = carToUpdate.CarsStored;
      this.railCarModel.IsUnderStorage = carToUpdate.IsUnderStorage;
      this.riderModelData.Id = carToUpdate.ContractId;
      this.riderModelData.CustomerId = carToUpdate.CustomerId;
      this.setDynamicValidations();
      this.riderDetailsTabForm.controls['RailCarSwitching']= new FormArray([]);
      if(formattedObj != null && formattedObj.ContractRailCarCharge != null &&
        formattedObj.ContractRailCarCharge.length > 0) {
          let i=0;
          formattedObj.ContractRailCarCharge.forEach(chargeData => {
            (this.riderDetailsTabForm.get('RailCarSwitching') as FormArray).push(this.initializeRailCarSwitchingForm());

            ((this.riderDetailsTabForm.controls['RailCarSwitching']) as FormArray).at(i).patchValue({
              Id: chargeData.Id,
              IsActive: APP_CONSTANTS.true,
              SpecialSwitchingRate: this.currencyPipe.transform(chargeData.Amount, 'USD'),
              SpecialSwitchingTitle: chargeData.Title,
              FormSpecialSwitchingDate: this.sharedService.ConvertToDatePickerDate(chargeData.Date)
            });
            i++;
          });
      }
      else {
        (this.riderDetailsTabForm.get('RailCarSwitching') as FormArray).push(this.initializeRailCarSwitchingForm());
      }
      this.setHazmatVal(formattedObj.IsHazmatCar);
      this.onDisableFields(this.riderDetailsTabForm.controls, this.disableFieldsForCustomer);
      this.disableSpecialSwitchingRate();
      //this.selectedLEId = carToUpdate.LEId;
      //this.selectedRailCarTypeId = carToUpdate.RailCarTypeId;
    } else {
      this.showSelectionWarning();
    }
  }

  private disableSpecialSwitchingRate():void {
    this.isAddRailCarChargesButtonVisible = true;
    if(this.currentUserRole === APP_CONSTANTS.Customer){
    this.riderDetailsTabForm.get('RailCarSwitching')?.disable();
    this.isAddRailCarChargesButtonVisible = false;
    }
  }

  public onSubmitUploadForm(): void {
    this.isUpload = false;
  }

  public selectFile(event) {
    this.selectedFiles = (event.target as HTMLInputElement).files;
  }

  public closeAllActivity(): void {
    this.isAddCars = false;
    this.isUpload = false;
    this.isDuplicate = false;
    this.isUpdate = false;
    this.submittedDetails = false;
  }

  public formatFormData(formData): any {
    let newRowData = formData;
    newRowData.BolDate = newRowData.BolDate
      ? this.datepipe.transform(newRowData.BolDate, 'MM/dd/yyyy')
      : '';
    newRowData.ArrivalDate = newRowData.ArrivalDate
      ? this.datepipe.transform(newRowData.ArrivalDate, 'MM/dd/yyyy')
      : '';
    newRowData.DepartureDate = newRowData.DepartureDate
      ? this.datepipe.transform(newRowData.DepartureDate, 'MM/dd/yyyy')
      : '';
    return newRowData;
  }

  public formatDateData(formData): any {
    let newRowData = formData;
    newRowData.BolDate = newRowData.BolDate
      ? new Date(newRowData.BolDate)
      : null;
    newRowData.ArrivalDate = newRowData.ArrivalDate
      ? new Date(newRowData.ArrivalDate)
      : null;
    newRowData.DepartureDate = newRowData.DepartureDate
      ? new Date(newRowData.DepartureDate)
      : null;
    return newRowData;
  }

  public insertDataInTable(formattedObj): any {
    this.dataSource.filteredData.push(formattedObj);
    this.dataSource._updateChangeSubscription();
  }

  public updateDataInTable(formattedObj): any {
    // Update logic here
    this.dataSource.filteredData.push(formattedObj);
    this.dataSource._updateChangeSubscription();
  }

  public showSelectionWarning(): void {
    this.warningMessage = true;
  }
  public onCloseWarning(): void {
    this.warningMessage = false;
  }

  public onValidateCarId(): boolean {
    const validateCarId = this.riderDetailsTabForm.get('CarId')?.value;
    if (validateCarId) {
      const railcarsList: Array<string> = validateCarId.split('\n');
      const regex = new RegExp(/(^[a-zA-Z]{2,4})\s?\-?((\d){1,6}$)/);
      const filtered = railcarsList.filter((item) => regex.exec(item));
      if (filtered.length != railcarsList.length) return false;
    }
    return true;
  }

  public onCloseForm(): void {
    this.closeAllActivity();
  }
  public onDisableFields(form, fields): void {
    if (this.currentUserRole === APP_CONSTANTS.Customer) {
      fields.forEach(key => {
        form[key].disable();
      });
    }
  }
  public onFocusNumber(element): void {
    // Correct Implementation
    const updateValue = element.target.value.replace(/[^0-9\.-]+/g, '');
    element.target.value = updateValue;
  }
  public onBlurAmount(element) {
    // Correct Implimentation
    const formattedAmount = this.currencyPipe.transform(
      element.target.value,
      'USD'
    );
    element.target.value = formattedAmount;
  }

    /**To check is current row in expanded state
   * @method isExpanded
   * @param row - currently selected row
   */
     public isExpanded(row: any): string {
      const index = this.expandedElements.findIndex((x) => x.Name == row.Name);
      if (index !== -1) {
        row.isExpanded = true;
        return 'expanded';
      }
      row.isExpanded = false;
      return 'collapsed';
    }

    public clearDate(): void {
      this.riderDetailsTabForm.patchValue({
        FormArrivalDate: APP_CONSTANTS.null
      });
    }

    private setHazmatVal(isHazmat:boolean): void{
      if(isHazmat){
        this.riderDetailsTabForm.patchValue({
          Hazmat:APP_CONSTANTS.true
        })
      }else{
        this.riderDetailsTabForm.patchValue({
          Hazmat:APP_CONSTANTS.false
        })
      }
    }


    private getHazmatVal(hazmatVal:string): boolean {
      if(this.sharedService.CheckIfEmptyOrNull(hazmatVal) !== APP_CONSTANTS.emptyString && hazmatVal) {
        return APP_CONSTANTS.true;
      } else {
        return APP_CONSTANTS.false;
      }
    }

    public onUpperCase(event) {
      event.target.value = event.target.value.toUpperCase();
    }
}
