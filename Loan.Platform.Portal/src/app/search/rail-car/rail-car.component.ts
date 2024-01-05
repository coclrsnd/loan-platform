import {
  Component,
  OnInit,
  ViewChild,
} from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { APP_CONSTANTS } from 'src/app/app-constants';
import { LEContentService } from '../le-content/leContentService';
import { RailCarTypeService } from '../rail-car-type/railCarTypeService';
import { RailCarService } from '../rider-details/rail-car-details-tab/railCarService';
import { RiderModel } from '../rider/RiderModel';
import {
  debounceTime,
  finalize,
  Observable,
  of,
  switchMap,
  tap,
} from 'rxjs';
import { RiderService } from '../rider/rider-service';
import { railCarModel } from '../rider-details/rail-car-details-tab/railCarModel';
import { RailCarDetailsTabComponent } from '../rider-details/rail-car-details-tab/rail-car-details-tab.component';
import { SharedService } from 'src/app/shared/shared.service';
import { DateValidators } from 'src/app/shared/directives/validatorDate';
import { SaveSearchModel } from 'src/app/shared/models/save-search.model';
import { SavedSearchService } from 'src/app/services/saved-search.service';
import { ApiService } from 'src/app/services/api.service';
import { ToastrService } from 'ngx-toastr';
import { AuthService } from 'src/app/services/auth.service';
@Component({
  selector: 'app-rail-car',
  templateUrl: './rail-car.component.html',
  styleUrls: ['./rail-car.component.scss'],
})
export class RailCarComponent implements OnInit {
  public isFromPage: string = APP_CONSTANTS.searchRailCars;
  public optionsConfig = [
    {
      addCars: false,
      upload: false,
      duplicate: false,
      update: false,
    },
  ];
  public isViewMode: boolean = false;
  public isEditMode: boolean = false;
  public riderModel = new RiderModel();
  public railCarForm: FormGroup;
  public currencyDetails = APP_CONSTANTS.statusDetails;
  public isAdvanceSearch: boolean = false;
  public submittedSearch: boolean = false;
  public railCarTypesList: any;
  public leContentList: any;
  public currentUserRole: string = '';
  storageOrderList: any;
  isSearching = false;
  noResults = false;
  public selectedStorageOrderId: number = 0;
  defaultSelectedValueForDropdownlist: number = 0;
  ContractId: any;
  public railCarModel = new railCarModel();
  public numInfo = APP_CONSTANTS.railcarInfo;
  @ViewChild(RailCarDetailsTabComponent) railCarDetailsTab;

  savedSearch: SaveSearchModel;
  public isSearch: boolean = true;
  public loadContent: boolean = false;
  public railCarRibbonModel: any;

  constructor(
    public formBuilder: FormBuilder,
    public leContentService: LEContentService,
    public railCarTypeService: RailCarTypeService,
    public riderService: RiderService,
    public railCarService: RailCarService,
    private saveSearchService: SavedSearchService,
    public sharedService: SharedService,
    public toastr: ToastrService,
    private authService: AuthService
  ) {}

  ngOnInit(): void {
    this.authService.getUserId();
    this.currentUserRole = ApiService.CurrentRole.split('_')[0];
    this.initilizeRailCarForm();
    this.loadStorageOrders();
    this.getRailCarTypeList();
    this.getLEContentList();
    this.LoadSavedSearchFilter();
  }

  private LoadSavedSearchFilter(): void {
    const savedSearchData = window.history.state;
    if (savedSearchData && savedSearchData['SearchCriteria'] != undefined) {
      let searchCriteria = JSON.parse(savedSearchData['SearchCriteria']);
      if (
        searchCriteria.BolDate != null ||
        searchCriteria.LEContents != '' ||
        searchCriteria.Fleet != '' ||
        searchCriteria.LandE != ''
      ) {
        this.isAdvanceSearch = true;
      }

      this.railCarModel.IsDefault = false;
      this.railCarModel.StorageOrderId = this.ContractId =
        searchCriteria.StorageOrderId > 0
          ? searchCriteria.StorageOrderId
          : null;
      this.railCarModel.RailCarTypeId = searchCriteria.CarType;
      this.railCarModel.LEId = searchCriteria.LandE;

      setTimeout(() => {
        this.railCarForm.patchValue(searchCriteria);
        this.onSubmitRailCarForm();
      }, 100);
    }
  }

  public onDownloadTemplate(): void {
    let link = document.createElement("a");
    link.download = "railcar-details-template";
    link.href = "assets/download/railcar-details-template.xlsx";
    link.click();
  }

  getRailCarTypeList() {
    this.railCarTypeService.GetRailCarTypeList().subscribe(
      (result) => {
        this.railCarTypesList = result;
        this.railCarForm.patchValue({
          CarType: this.defaultSelectedValueForDropdownlist,
        });
      },
      (error) => {
      }
    );
  }

  getLEContentList() {
    this.leContentService.GetLEContentList().subscribe(
      (result) => {
        this.leContentList = result;
        this.railCarForm.patchValue({
          LandE: this.defaultSelectedValueForDropdownlist,
        });
      },
      (error) => {
      }
    );
  }

  public onCloseOtherDropdown(dropdownId) {}

  public eventUpdate(eventName) {
    this.optionsConfig[0][eventName] = !this.optionsConfig[0][eventName];
  }

  public getRibbonDataFromChild(data)
  {
    this.railCarRibbonModel = Object.entries(data);
  }

  // Initilize Rider Search form
  public initilizeRailCarForm(): void {
    this.railCarForm = this.formBuilder.group({
      StorageOrder: [APP_CONSTANTS.emptyString, Validators.pattern(/^[a-zA-Z0-9-&. ]*$/)],
      CarId: [APP_CONSTANTS.emptyString, Validators.pattern(/^[a-zA-Z0-9- ]*$/)],
      CarType: [APP_CONSTANTS.emptyString],
      FormArrivalDate: [APP_CONSTANTS.null],
      FormDepartureDate: [APP_CONSTANTS.null],
      FormBolDate: [APP_CONSTANTS.null],
      LandE: [APP_CONSTANTS.emptyString],
      LEContents: [APP_CONSTANTS.emptyString, Validators.pattern(/^[a-zA-Z0-9 ]*$/)],
      Fleet: [APP_CONSTANTS.emptyString]
    }, { validator: Validators.compose([
      DateValidators.dateLessThan('FormArrivalDate', 'FormDepartureDate', { 'departureIssue': true })
  ])});

    this.loadContent = true;
  }

  public loadStorageOrders(): void {
    const storageOrderControl = this.railCarForm.get('StorageOrder');
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
    this.railCarForm.patchValue({
      StorageOrder: event.option.value.Rider,
    });
    this.selectedStorageOrderId = event.option.value.Id;
    this.ContractId = event.option.value.Id;
  }

  // convenience getter for easy access to form fields
  get railCarGetter() { return this.railCarForm.controls; }

  // Toggle Advance Search
  public toggleAdvanceSearch(): void {
    this.isAdvanceSearch = !this.isAdvanceSearch;
  }

  public onSubmitRailCarForm(): void {
    this.submittedSearch = true;
    // stop here if form is invalid
    if (this.railCarForm.invalid) {
      return;
    }
    const tempValue = this.railCarForm.value;
    //this.railCarForm.patchValue(
    //  {
    //    LandE: tempValue.LandE ? tempValue.LandE : null,
    //    CarType: tempValue.CarType ? tempValue.CarType : null,
    //  }
    //)

    this.railCarModel = Object.assign(this.railCarForm.value);
    this.railCarModel.IsDefault = false;
    this.railCarModel.StorageOrderId =
      this.ContractId > 0 ? this.ContractId : this.railCarForm.value.StorageOrder != APP_CONSTANTS.emptyString ? 0 : APP_CONSTANTS.null;
    this.railCarModel.RailCarTypeId = this.railCarForm.controls['CarType'].value
      ? this.railCarForm.controls['CarType'].value
      : null;
    this.railCarModel.LEId = this.railCarForm.controls['LandE'].value
      ? this.railCarForm.controls['LandE'].value
      : null;

      this.railCarModel.ArrivalDate = this.sharedService.ConvertToFormatedDate(this.railCarModel.FormArrivalDate);
      this.railCarModel.DepartureDate = this.sharedService.ConvertToFormatedDate(this.railCarModel.FormDepartureDate);

    this.railCarService.GetRailCarDetails(this.railCarModel).subscribe(
      (railCarDetails) => {
        if (railCarDetails.RailCarList != null) {
        //this.railCarDetailsTab.dataSource = railCarDetails;
            railCarDetails.RailCarList.forEach(e => {
                e.FormArrivalDate = this.sharedService.ConvertToDatePickerDate(e.ArrivalDate),
                    e.FormBolDate = this.sharedService.ConvertToDatePickerDate(e.BolDate),
                    e.FormDepartureDate = this.sharedService.ConvertToDatePickerDate(e.DepartureDate)
            });

          this.railCarDetailsTab.dataSource = railCarDetails.RailCarList;
       }
       else{
        this.railCarDetailsTab.dataSource = [];
       }
       this.railCarRibbonModel = Object.entries(railCarDetails.RailCarRibbon);
      },
      (error) => {
      }
    );
  }

  /**On Saved search button click
   * @method onRailCarSavedSearchClick
   */
  public onRailCarSavedSearchClick(searchFormGroupControl:any): void {
    this.savedSearch = new SaveSearchModel();
    this.savedSearch.Name =
    searchFormGroupControl.controls['NameYourSearch'].value;
    this.savedSearch.Id = 0;
    this.savedSearch.ScreenName = 'railcar';
    this.savedSearch.SearchCriteria = this.getRailCarFormData();
    this.savedSearch.SavedBy = +ApiService.UserId;
    this.savedSearch.ExpiryDate =
    searchFormGroupControl.controls['ExpiryDate'].value;
    this.savedSearch.EffectiveDate = new Date();
    this.savedSearch.NavigateUrl = '/search/railcar';
    this.savedSearch.LastRun = new Date();
    this.saveSearchService.SaveSearch(this.savedSearch).subscribe((result) => {
      this.toastr.success('Search Saved Successfully.')
      this.isSearch = true;
      this.loadContent = true;
    });
  }

  /** To get railcar form data for saved search criteria
   * @method getRailCarFormData
   * @return json object of current RailCar form data
   */
  private getRailCarFormData(): string {
    let railCarFormData = this.railCarForm.getRawValue();
    railCarFormData.StorageOrderId = this.ContractId;
    return JSON.stringify(railCarFormData);
  }

  /** On Click of button [Back to search] when user decline to save search
   * @method onBackToSearch
   */
  public onBackToSearchButtonClick(enableLoadSearchContent:any): void {
    this.isSearch = true;
    this.loadContent = enableLoadSearchContent;
  }

  /** On Save Search button click
   * @method onSaveSearch
   */
  public onSaveSearch(): void {
    // if (this.railCarForm.invalid) {
    //   this.railCarForm.markAllAsTouched();
    //   return;
    // }
    this.isSearch = false;
    this.loadContent = false;
  }
  public onUpperCase(event) {
    event.target.value = this.sharedService.toUpperCase(event);
  }
  public onResetSearch(): void {
    this.railCarForm.patchValue({
      FormArrivalDate: APP_CONSTANTS.null,
      FormBolDate: APP_CONSTANTS.null,
      CarId: APP_CONSTANTS.emptyString,
      CarType: this.defaultSelectedValueForDropdownlist,
      FormDepartureDate: APP_CONSTANTS.null,
      Fleet: APP_CONSTANTS.emptyString,
      IsDefault: APP_CONSTANTS.false,
      LEContents: APP_CONSTANTS.emptyString,
      LEId: APP_CONSTANTS.null,
      LandE: this.defaultSelectedValueForDropdownlist,
      RailCarTypeId: APP_CONSTANTS.null,
      StorageOrder: APP_CONSTANTS.emptyString,
      StorageOrderId: APP_CONSTANTS.null
    });
    this.ContractId = 0;
    this.onSubmitRailCarForm();
  }
}
