import { SelectionModel } from '@angular/cdk/collections';
import { AfterViewInit, Component, OnInit, ViewChild } from '@angular/core';
import { AbstractControl, FormBuilder, FormGroup, Validators } from '@angular/forms';
import { MatTableDataSource } from '@angular/material/table';
import { APP_CONSTANTS } from 'src/app/app-constants';
import { RiderService } from './rider-service';
import { AuthService } from '../../services/auth.service';
import { RiderModel } from './RiderModel';
import { CurrencyService } from '../currency/currency-service';
import { StorageFeatureModel } from '../storagefeature/StoragefeatureModel';
import { StorageFeatureService } from '../storagefeature/storagefeature-service';
import { CurrencyModel } from '../currency/currency.model';
import { constant, result } from 'lodash';
import { SaveSearchModel } from 'src/app/shared/models/save-search.model';
import { SavedSearchService } from 'src/app/services/saved-search.service';
import { ApiService } from 'src/app/services/api.service';
import { ToastrService } from 'ngx-toastr';
import { Router } from '@angular/router';
import { DateValidators } from 'src/app/shared/directives/validatorDate';
import { StorageFacilityModel } from '../storage-facility/StorageFacilityModel';
import { debounceTime, finalize, Observable, of, switchMap, tap } from 'rxjs';
import { MasterDataService } from 'src/app/services/master-data.service';
import { StorageFacilityService } from '../storage-facility/storagefacility-service';
import { OrganizationModel } from 'src/app/shared/models/organization-model.model';
import { VendorService } from '../vendor/vendor-service';
import { VendorModel } from '../vendor/VendorModel';
import { CustomerModel } from '../customer/CustomerModel';
import { CustomerService } from '../customer/customer-service';
import { MatSort } from '@angular/material/sort';
import { LiveAnnouncer } from '@angular/cdk/a11y';
import { SharedService } from 'src/app/shared/shared.service';

@Component({
  selector: 'app-rider',
  templateUrl: './rider.component.html',
  styleUrls: ['./rider.component.scss'],
})
export class RiderComponent implements OnInit, AfterViewInit {
  @ViewChild(MatSort, { static: false }) sort: MatSort;
  public riderSearchForm: FormGroup;
  public submittedSearch: boolean = false;
  public effDateValue: Date = new Date();
  public expDateValue: Date = new Date();
  public isAdvanceSearch: boolean = false;
  public dataSource: any;
  public bsConfig = APP_CONSTANTS.bsConfig;
  public numInfo = APP_CONSTANTS.storageOrderInfo;
  public riderModel = new RiderModel();
  public currencyDetails: CurrencyModel[];
  public switchIn: any[];
  public switchOut: any[];
  public storageFeatureDetails: StorageFeatureModel[];
  public selectedValues: any[];
  selection = new SelectionModel(true, []); // For Grid selection
  savedSearch: SaveSearchModel;
  public isSearch: boolean = true;
  public loadContent: boolean = false;
  public storageOrderRibbonModel: any;
  public currentUserRole: string = '';
  public facilityList: StorageFacilityModel[] = [];
  defaultSelectedValueForDropdownlist: number = 0;
  public selectedStorageFacilityId: number = 0;
  public warningMessage: boolean = false;
  /* For Vendor/Organization Autocomplete */
  isSearching = false;
  noResults = false;
  orgList: any;
  public selectedVendorId: number = 0;
  /* End of Vendor/Organization Autocomplete */

  /* For Customer Autocomplete*/
  public customerList: any;
  public selectedCustomerId: number;
  /* End of Customer Autocomplete */

  /* For customer/vendor visibility*/
  isCustomer: boolean = false;
  isVendor: boolean = false;
  /* End of customer/vendor visibility */

  public defaultDateFormat= APP_CONSTANTS.DefaultDateTimeFormat;

  constructor(
    public formBuilder: FormBuilder,
    public riderService: RiderService,
    public currencyService: CurrencyService,
    public storageFeatureService: StorageFeatureService,
    private saveSearchService: SavedSearchService,
    public toastr: ToastrService,
    public router: Router,
    private vendorService: VendorService,
    private storageFacilityService: StorageFacilityService,
    public customerService: CustomerService,
    private _liveAnnouncer: LiveAnnouncer,
    private authService: AuthService,
    private sharedService: SharedService,
    private masterDataService: MasterDataService
  ) {
    //this.dataSource = new MatTableDataSource(APP_CONSTANTS.dataTable);
    this.getCurrencyList();
    this.getSwitchInSwitchOutList();
    this.getStorageFeatureList();
    this.LoadSavedSearchFilter();
  }
  displayedColumns: string[] = [
    'select',
    'Rider',
    'VendorName',
    'StorageFacilityName',
    'EffectiveDate',
    'ExpiryDate',
    'TotalCars',
    'SwitchIn',
    'SwitchOut',
  ];
  ngOnInit(): void {
    this.initilizeRiderSearchForm();
    this.setDataforCurrentRole();
  }

  ngAfterViewInit(): void {

  }

  // Initilize Rider Search form
  public initilizeRiderSearchForm(): void {
    this.riderSearchForm = this.formBuilder.group({
      VendorName: [APP_CONSTANTS.emptyString, Validators.pattern(/^[a-zA-Z0-9-&. ]*$/)],
      StorageFacilityName: [APP_CONSTANTS.emptyString, Validators.pattern(/^[a-zA-Z0-9-&. ]*$/)],
      CustomerName: [APP_CONSTANTS.emptyString, Validators.pattern(/^[a-zA-Z0-9-&. ]*$/)],
      Vendor: [APP_CONSTANTS.emptyString, Validators.pattern(/^[a-zA-Z0-9-&. ]*$/)],
      StorageFacilityId: [APP_CONSTANTS.emptyString],
      Rider: [APP_CONSTANTS.emptyString, [Validators.pattern(/^[a-zA-Z0-9-&. ]*$/)]],
      FormEffectiveDate: [APP_CONSTANTS.null],
      FormExpiryDate: [APP_CONSTANTS.null],
      Id: [APP_CONSTANTS.defaultNumberValue],
      TotalCars: [APP_CONSTANTS.defaultNumberValue],
      Hazmat: [APP_CONSTANTS.emptyString],
      SwitchIn: [APP_CONSTANTS.defaultNumberValue],
      SwitchOut: [APP_CONSTANTS.defaultNumberValue],
      IsDefault: [APP_CONSTANTS.false],
      CurrencyId: [APP_CONSTANTS.emptyString],
      StorageFeatureIds: [],
      SwitchInMin: [APP_CONSTANTS.emptyString],
      SwitchInMax: [APP_CONSTANTS.emptyString],
      SwitchOutMin: [APP_CONSTANTS.emptyString],
      SwitchOutMax: [APP_CONSTANTS.emptyString],
    }, { validator: Validators.compose([
      DateValidators.dateLessThan('FormEffectiveDate', 'FormExpiryDate', { 'dateIssue': true })
  ])});
    this.loadContent = true;
  }

  private LoadSavedSearchFilter(): void {
    const savedSearchData = window.history.state;
    if (savedSearchData && savedSearchData['SearchCriteria'] != undefined) {
      let searchCriteria = JSON.parse(savedSearchData['SearchCriteria']);
      if (
        searchCriteria.StorageFeatureIds != null ||
        searchCriteria.SwitchInMax != null ||
        searchCriteria.SwitchInMin != null ||
        searchCriteria.SwitchOutMax != null ||
        searchCriteria.SwitchOutMin != null ||
        searchCriteria.CurrencyId != null
      ) {
        this.isAdvanceSearch = true;
      }
      setTimeout(() => {
        this.riderSearchForm.patchValue(searchCriteria);
        this.onSubmitRiderSearchForm();
      }, 100);
    }
  }

  // convenience getter for easy access to form fields
  get riderSearchGetter() {
    return this.riderSearchForm.controls;
  }

  public onSubmitRiderSearchForm(): void {
    this.submittedSearch = true;
    // stop here if form is invalid
    if (this.riderSearchForm.invalid) {
      return;
    }
    const tempValue = this.riderSearchForm.value;
    this.riderSearchForm.patchValue({
      SwitchInMin: tempValue.SwitchInMax ? 0 : null,
      SwitchInMax: tempValue.SwitchInMax ? tempValue.SwitchInMax : this.defaultSelectedValueForDropdownlist,
      SwitchOutMin: tempValue.SwitchOutMax ? 0 : null,
      SwitchOutMax: tempValue.SwitchOutMax ? tempValue.SwitchOutMax : this.defaultSelectedValueForDropdownlist,
      CurrencyId: tempValue.CurrencyId ? tempValue.CurrencyId : this.defaultSelectedValueForDropdownlist,
    });
    this.riderModel = Object.assign(this.riderSearchForm.value);
    this.riderModel.IsDefault = false;
    this.riderModel.CustomerId= this.selectedCustomerId;
    this.riderModel.VendorId= this.selectedVendorId;
      this.riderModel.VendorName = this.riderSearchForm.value.Vendor;
      this.riderModel.EffectiveDate = this.sharedService.ConvertToFormatedDate(this.riderModel.FormEffectiveDate);
      this.riderModel.ExpiryDate = this.sharedService.ConvertToFormatedDate(this.riderModel.FormExpiryDate);
    this.riderModel.StorageFeatureIds = tempValue.StorageFeatureIds ? tempValue.StorageFeatureIds : null;

    this.riderService.GetStorageOrderDetails(this.riderModel).subscribe(
        (result) => {
          if(result.RiderModel!=null && result.RiderModel.length>0)
          {
            result.RiderModel.forEach(e=>{
              e.FormEffectiveDate=this.sharedService.ConvertToDatePickerDate(e.EffectiveDate),
              e.FormExpiryDate=this.sharedService.ConvertToDatePickerDate(e.ExpiryDate)
            });
            this.dataSource = new MatTableDataSource(result.RiderModel);
            this.dataSource.sort = this.sort;
          }
          else{
            this.dataSource = [];
          }
          if (result.StorageOrderRibbon) {
            this.storageOrderRibbonModel = Object.entries(result.StorageOrderRibbon);
          }
      },
      (error) => {}
    );
  }
  // Toggle Advance Search
  public toggleAdvanceSearch(): void {
    this.isAdvanceSearch = !this.isAdvanceSearch;
  }

  // For Table Events
  /** Whether the number of selected elements matches the total number of rows. */
  isAllSelected() {
    const numSelected = this.selection.selected.length;
    const numRows = this.dataSource.data.length;
    return numSelected === numRows;
  }

  /** Selects all rows if they are not all selected; otherwise clear selection. */
  masterToggle() {
    this.isAllSelected()
      ? this.selection.clear()
      : this.dataSource.data.forEach((row: any[]) =>
          this.selection.select(row)
        );
  }

  logSelection() {}

  private getGetStorageOrderDetails() {
    this.riderModel = new RiderModel();
    this.riderModel.IsDefault = true;
    this.riderService.GetStorageOrderDetails(this.riderModel).subscribe(
      (result) => {
        if(result.RiderModel!=null && result.RiderModel.length>0)
        {
          result.RiderModel.forEach(e=>{
            e.FormEffectiveDate=this.sharedService.ConvertToDatePickerDate(e.EffectiveDate),
            e.FormExpiryDate=this.sharedService.ConvertToDatePickerDate(e.ExpiryDate)
          });
          this.dataSource = new MatTableDataSource(result.RiderModel);
          this.dataSource.sort = this.sort;
        }
        else{
          this.dataSource = [];
        }
        this.storageOrderRibbonModel = Object.entries(result.StorageOrderRibbon);
      },
      (error) => {}
    );
  }

  private getCurrencyList() {
    this.currencyService.GetCurrencyList().subscribe(
      (result) => {
        this.currencyDetails = result;
        this.riderSearchForm.patchValue({
          CurrencyId: this.defaultSelectedValueForDropdownlist,
        });
      },
      (error) => {}
    );
  }

  private getSwitchInSwitchOutList() {
    this.masterDataService.GetSwitchInSwitchOutList().subscribe(
      (result) => {
        this.switchIn = result.SwitchIn;
        this.switchOut = result.SwitchOut;
        this.riderSearchForm.patchValue({
          SwitchInMax: this.defaultSelectedValueForDropdownlist,
          SwitchOutMax: this.defaultSelectedValueForDropdownlist,
        });
      },
      (error) => {}
    );
  }

  private getStorageFeatureList() {
    this.storageFeatureService.GetStorageFeaturesList().subscribe(
      (result) => {
        this.storageFeatureDetails = result;
      },
      (error) => {}
    );
  }

  public onFeaturesChange(): void {
    this.riderModel.StorageFeatureIds = this.selectedValues;
  }

  /**On Saved search button click
   * @method onRiderSavedSearchClick
   */
  public onRiderSavedSearchClick(searchFormGroupControl: any): void {
    this.savedSearch = new SaveSearchModel();
    this.savedSearch.Name =
      searchFormGroupControl.controls['NameYourSearch'].value;
    this.savedSearch.Id = 0;
    this.savedSearch.ScreenName = 'rider';
    this.savedSearch.SearchCriteria = this.getRiderFormData();
    this.savedSearch.SavedBy = +ApiService.UserId;
    this.savedSearch.ExpiryDate =
      searchFormGroupControl.controls['ExpiryDate'].value;
    this.savedSearch.EffectiveDate = new Date();
    this.savedSearch.NavigateUrl = '/search/rider';
    this.savedSearch.LastRun = new Date();
    this.saveSearchService.SaveSearch(this.savedSearch).subscribe((result) => {
      this.toastr.success('Search Saved Successfully.')
      this.isSearch = true;
      this.loadContent = true;
    });
  }

  /** To get Rider form data for saved search criteria
   * @method getRiderFormData
   * @return json object of current Rider form data
   */
  private getRiderFormData(): string {
    let riderFormData = this.riderSearchForm.getRawValue();
    return JSON.stringify(riderFormData);
  }

  /** On Click of button [Back to search] when user decline to save search
   * @method onBackToSearch
   */
  public onBackToSearchButtonClick(enableLoadSearchContent: any): void {
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

  public onResetSearch(): void {
    this.riderSearchForm.patchValue({
      CurrencyId: APP_CONSTANTS.defaultNumberValue,
      CustomerId: 0,
      CustomerName: APP_CONSTANTS.null,
      FormEffectiveDate: APP_CONSTANTS.null,
      FormExpiryDate: APP_CONSTANTS.null,
      Hazmat: APP_CONSTANTS.emptyString,
      Id: APP_CONSTANTS.defaultNumberValue,
      IsDefault: APP_CONSTANTS.false,
      Rider: APP_CONSTANTS.emptyString,
      StorageFacilityId: APP_CONSTANTS.defaultNumberValue,
      StorageFacilityName: APP_CONSTANTS.emptyString,
      StorageFeatureIds: APP_CONSTANTS.null,
      SwitchIn: APP_CONSTANTS.defaultNumberValue,
      SwitchInMax: APP_CONSTANTS.defaultNumberValue,
      SwitchInMin: APP_CONSTANTS.defaultNumberValue,
      SwitchOut: APP_CONSTANTS.defaultNumberValue,
      SwitchOutMax: APP_CONSTANTS.defaultNumberValue,
      SwitchOutMin: APP_CONSTANTS.defaultNumberValue,
      TotalCars: APP_CONSTANTS.defaultNumberValue,
      Vendor: APP_CONSTANTS.emptyString,
      VendorId: APP_CONSTANTS.defaultNumberValue,
      VendorName: APP_CONSTANTS.emptyString,
    });
    this.selectedCustomerId=0;
    this.selectedVendorId=0;
    this.setDataforCurrentRole();
    setTimeout(() => {
      this.onSubmitRiderSearchForm();
    }, 1000);
  }

  onUpdate() {
    if (this.selection.selected.length == 1) {
      const contractId = this.selection.selected[0]['Id'];
      this.router.navigate([
        '../search/rider/rider-details/edit/' + contractId,
      ]);
    } else {
      this.showSelectionWarning();
    }
  }

  onCopy() {
    if (this.selection.selected.length == 1) {
      const contractId = this.selection.selected[0]['Id'];
      this.router.navigate([
        '../search/rider/rider-details/copy/' + contractId,
      ]);
    } else {
      this.showSelectionWarning();
    }
  }

  onExpire() {
    if (this.selection.selected.length == 1) {
      const contractId = this.selection.selected[0]['Id'];
      this.riderService.ValidateAndExpire(contractId).subscribe(
        (result) => {
          this.selection = new SelectionModel(true, []);
          if (result == true) {
            this.onSubmitRiderSearchForm();
            this.toastr.success('Storage order expired successfully.');
          } else {
            this.toastr.error('Storage order has railcars under storage');
          }
        },
        (error) => {}
      );
    } else {
      this.showSelectionWarning();
    }
  }

  public showSelectionWarning(): void {
    this.warningMessage = true;
  }
  public onCloseWarning(): void {
    this.warningMessage = false;
  }

  /** To load organizations on autocomplete (min 2 character required to enter)
   * @method loadOrganizations
   */
  public loadOrganizations(orgControl: AbstractControl | null): void {
    if (orgControl) {
      orgControl?.valueChanges
        .pipe(
          debounceTime(500),
          tap(() => {
            this.orgList = [];
          }),
          switchMap((value) =>
            this.filterVendor(value).pipe(
              finalize(() => {
                if (value.length > 1 && this.orgList.length === 0) {
                  this.selectedVendorId = 0;
                  this.noResults = true;
                  this.clearStorageFacility();
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
            this.orgList = data;
          }
          // else{
          //   this.noResults=true;
          // }
        });
    }
  }

  /** To filter (when user start typing) and load Vendor/Organization from API based on user input
   * @method filterVendor
   * @param val - Vendor/Organization text entered by user
   */
  public filterVendor(val: string): Observable<VendorModel[]> {
    if (val != undefined && val.length > 1) {
      this.isSearching = true;
      return this.vendorService.GetVendorListForAutoComplete(val);
    } else {
      this.noResults = false;

      if (val.length == 0 && this.riderSearchForm.controls['Vendor'].dirty) {
        this.selectedVendorId = 0;
        this.clearStorageFacility();
        this.loadStorageFacilityList();
      }
      return of([]);
    }
  }

  /** Raised event when user select Vendor/Organization
   * @method onVendorSelection
   * @param event - change event
   */
  public onVendorSelection(event: any): void {
    this.setOrganizationValueOnSelection(
      event.option.value.Organization,
      event.option.value.Id
    );
    this.onVendorTextChanged();
  }

  /** Raised event when user change selected Vendor/Organization
   * @method onVendorChanged
   */
  public onVendorChanged(): void {
    this.onVendorTextChanged();
  }

  /** To Clear Previous selected Storage facility and interchange detail */
  public clearStorageFacility(): void {
    this.facilityList = [];
    this.selectedStorageFacilityId = this.defaultSelectedValueForDropdownlist;

    this.riderSearchForm.patchValue({
      StorageFacilityId: this.defaultSelectedValueForDropdownlist,
    });
  }

  /** when user select vendor from list */
  private onVendorTextChanged(): void {
    if (
      this.riderSearchForm.value.Vendor != undefined &&
      this.riderSearchForm.value.Vendor.length > 0
    ) {
      this.clearStorageFacility();
      if (this.selectedVendorId > 0) {
        this.loadStorageFacilityList();
      }
    }
  }

  /** set Organization name and Id into form
   * @method setOrganizationValueOnSelection
   * @param orgName - organization name to set
   * @param organizationId - organization id to set
   */
  private setOrganizationValueOnSelection(
    orgName: string,
    organizationId: number
  ): void {
    this.riderSearchForm.patchValue({
      Vendor: orgName,
    });
    this.selectedVendorId = organizationId;
  }

  /** To Load Storage facility dropdown list
   * @method loadStorageFacilityList
   */
  public loadStorageFacilityList(): void {
    this.selectedStorageFacilityId = 0;
    this.facilityList = [];
    if (this.selectedVendorId > 0) {
      this.storageFacilityService
      .getStorageFacilitiesByVendorId(this.selectedVendorId)
      .subscribe((response) => {
        response.forEach(e=>{
          e.FormEffectiveDate=this.sharedService.ConvertToDatePickerDate(e.EffectiveDate),
          e.FormExpiryDate=this.sharedService.ConvertToDatePickerDate(e.ExpiryDate)
        });
        this.facilityList = response;
        this.riderSearchForm.patchValue({
          StorageFacilityId: this.defaultSelectedValueForDropdownlist
        });
      });
    }
    else{
     this.loadAllStorageFacilities();
    }
  }

  loadAllStorageFacilities() {
    this.storageFacilityService
    .GetStorageFacilities(0)
    .subscribe((response) => {
      response.forEach(e=>{
        e.FormEffectiveDate=this.sharedService.ConvertToDatePickerDate(e.EffectiveDate),
        e.FormExpiryDate=this.sharedService.ConvertToDatePickerDate(e.ExpiryDate)
      });
      this.facilityList = response;
    });
    this.riderSearchForm.patchValue({
      StorageFacilityId: this.defaultSelectedValueForDropdownlist,
    });
  }

  public loadCustomers(): void {
    const customerControl = this.riderSearchForm.get('CustomerName');
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
                  this.selectedCustomerId = 0;
                  this.noResults = true;
                } else if (
                  value.length == 0 &&
                  this.customerList.length === 0
                ) {
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

  public filterCustomer(val: string): Observable<CustomerModel[]> {
    if (val != undefined && val.length > 1) {
      this.isSearching = true;
      return this.customerService.GetCustomers(val);
    } else {
      this.noResults = false;
      if ((val == APP_CONSTANTS.null ||
        val.length == 0) &&
        this.riderSearchForm.controls['CustomerName'].dirty
      ) {
        this.selectedCustomerId = 0;
      }
      return of([]);
    }
  }

  onCustomerChanged(event: any) {
    this.riderSearchForm.patchValue({
      CustomerName: event.option.value.Name,
    });
    this.selectedCustomerId = event.option.value.Id;
  }

  /** set Customer name and Id into form
   * @method setOrganizationValueOnSelection
   * @param orgName - organization name to set
   * @param organizationId - organization id to set
   */
  private setCustomerValueOnSelection(
    customerName: string,
    customerId: number
  ): void {
    this.riderSearchForm.patchValue({
      CustomerName: customerName,
    });
    this.selectedCustomerId = customerId;
  }

  setDataforCurrentRole() {
    this.authService.getUserId();
    this.currentUserRole = ApiService.CurrentRole.split('_')[0];
    this.riderSearchForm.patchValue({
      StorageFacilityId: this.defaultSelectedValueForDropdownlist,
      SwitchInMax: this.defaultSelectedValueForDropdownlist,
      SwitchOutMax: this.defaultSelectedValueForDropdownlist,
    });
    if (ApiService.CurrentRole.startsWith('Customer')) {
      this.isCustomer = true;
      this.isVendor = false;
      this.loadOrganizations(this.riderSearchForm.get('Vendor'));
      this.loadAllStorageFacilities();
      this.customerService
        .GetCustomerForUserId(+ApiService.UserId)
        .subscribe((result) => {
          this.setCustomerValueOnSelection(result.Name, result.Id);
          this.onSubmitRiderSearchForm();
        });
      this.riderSearchForm.get('CustomerName')?.disable();
    } else if (ApiService.CurrentRole.startsWith('Vendor')) {
      this.isCustomer = false;
      this.isVendor = true;
      this.loadCustomers();
      this.vendorService
        .GetVendorForUserId(+ApiService.UserId)
        .subscribe((result) => {
          this.setOrganizationValueOnSelection(result.Organization, result.Id);
          this.loadStorageFacilityList();
          this.onSubmitRiderSearchForm();
        });
      this.riderSearchForm.get('Vendor')?.disable();
    } else {
      this.loadOrganizations(this.riderSearchForm.get('Vendor'));
      this.loadCustomers();
      this.loadAllStorageFacilities();
      this.onSubmitRiderSearchForm();
    }
  }
}
