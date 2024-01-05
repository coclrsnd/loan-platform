import { Component, OnInit, ViewChild, OnDestroy } from '@angular/core';
import { FormBuilder, FormControl, FormGroup, Validators } from '@angular/forms';
import { MatSort } from '@angular/material/sort';
import { MatTableDataSource } from '@angular/material/table';
import { APP_CONSTANTS } from 'src/app/app-constants';
import { MatPaginator, PageEvent } from '@angular/material/paginator';
import { CustomerService } from './customer-service';
import { CustomerModel } from './CustomerModel';
import { MasterDataService } from 'src/app/services/master-data.service';
import { CountryModel } from 'src/app/shared/models/country-model.model';
import { StateModel } from 'src/app/shared/models/state-model.model';
import {
  debounceTime,
  finalize,
  forkJoin,
  Observable,
  of,
  switchMap,
  tap,
  map
} from 'rxjs';
import { OrganizationModel } from 'src/app/shared/models/organization-model.model';
import { CustomerFilterModel } from './customer-filter.model';
import { SharedService } from 'src/app/shared/shared.service';
import { Pagination } from 'src/app/shared/models/pagination.model';
import { Sorting } from 'src/app/shared/models/sorting.model';
import { SaveSearchModel } from 'src/app/shared/models/save-search.model';
import { ApiService } from 'src/app/services/api.service';
import { SavedSearchService } from 'src/app/services/saved-search.service';
import { ActivatedRoute, Router } from '@angular/router';
import { CustomerRibbon } from 'src/app/shared/models/customer-ribbon.model';
import { ToastrService } from 'ngx-toastr';

@Component({
  selector: 'app-customer',
  templateUrl: './customer.component.html',
  styleUrls: ['./customer.component.scss'],
})
export class CustomerComponent implements OnInit, OnDestroy {
  @ViewChild(MatSort, { static: false }) sort: MatSort;
  @ViewChild('paginator', { static: false }) paginator: MatPaginator;
  public customerForm: FormGroup;
  public searchFormGroup: FormGroup;
  public submittedSearch: boolean = false;
  public customerDataSource: any = new MatTableDataSource<CustomerModel>();
  public numInfo = APP_CONSTANTS.customerInfo;
  public organisationDetails = APP_CONSTANTS.organisationDetails;

  // For Paginator
  totalRows: number = 0;
  pageSize: number = 10;
  currentPage: number = 0;
  public pageSizeOptions = [10, 15, 20, 50];
  isPaginationEnabled: boolean = false;
  // End Paginator

  public displayedColumns: string[] = [
    'Customer',
    'Location',
    'PrimaryContact',
    'PrimaryEmail',
  ];

  public CountryList: CountryModel[] = [];
  public StatesList: StateModel[] = [];
  public CityList: string[] = [];
  public selectedOrganizationId: number = 0;
  isSearching = false;
  noResults = false;
  orgList: any;
  filterModel: CustomerFilterModel;
  paginationModel: Pagination;
  sortingModel: Sorting;
  savedSearch : SaveSearchModel;
  customerRibbonModel: any;
  public isSearch: boolean = true;
  public loadContent: boolean = false;
  defaultSelectedValueForDropdownlist:number=0;

  constructor(
    public formBuilder: FormBuilder,
    private customerService: CustomerService,
    private masterDataService: MasterDataService,
    private sharedService: SharedService,
    private saveSearchService: SavedSearchService,
    public router: Router,
    public toastr: ToastrService,
  ) {
  }

  ngOnInit(): void {
    this.initilizecustomerForm();
    this.loadSearchMasterData();
    this.loadOrganizations();
    this.setDefaultSorting();
    this.LoadSavedSearchFilter();
    this.loadCustomerSearchResult();
  }

  LoadSavedSearchFilter(){
    const savedSearchData = window.history.state;
    if(savedSearchData  && savedSearchData['SearchCriteria'] != undefined){
      const searchCriteria = JSON.parse((savedSearchData['SearchCriteria']));
      this.getAllStates(searchCriteria.CountryId);
      setTimeout(() => {
        this.customerForm.patchValue(searchCriteria);
        this.onSearchCustomerClick();
      }, 100);
    }
  }


  ngOnDestroy() {
    if (this.customerDataSource) {
      this.customerDataSource.disconnect();
    }
  }

  /** To load country and city dropdownlist on search
   * @method loadSearchMasterData
   */
  public loadSearchMasterData(): void {
    // let countryList = this.masterDataService.getCountryList();
    // let cityList = this.masterDataService.GetCustomersCityList();

    // forkJoin([countryList, cityList]).subscribe((result) => {
    //   this.CountryList = result[0];
    //   this.CityList = result[1];
    // });
      this.loadMasterData();
    this.loadCityList();
  }

  private loadMasterData(): void{
    this.sharedService.getCountryList().subscribe((response) => {
      this.CountryList = response;
    });
     }

  /** Init customer search form
   * @method initilizecustomerForm
   */
  public initilizecustomerForm(): void {
    this.customerForm = this.formBuilder.group({
      StateId: [APP_CONSTANTS.defaultNumberValue],
      CountryId: [APP_CONSTANTS.defaultNumberValue],
      Organization: [APP_CONSTANTS.emptyString, Validators.pattern(/^[a-zA-Z0-9-&. ]*$/)],
      CityName: new FormControl(this.CityList),
    });
    this.loadContent = true;
  }

  /** To load city list on search filter
   * @method loadCityList
   */
  private loadCityList(): void{
    this.masterDataService.GetCustomersCityList().subscribe((response) => {
      if(response!=undefined && response!=null){
        this.CityList = response;
      }
      else{
        this.CityList=[];
      }
    });
  }

  /** To load organizations on autocomplete (min 2 character required to enter)
   * @method loadOrganizations
   */
  public loadOrganizations(): void {
    const orgControl = this.customerForm.get('Organization');
    if (orgControl) {
      orgControl?.valueChanges
        .pipe(
          debounceTime(1000),
          tap(() => {
            this.orgList = [];
            this.selectedOrganizationId = -1;
          }),
          switchMap((value) =>
            this.filterOrg(value).pipe(
              finalize(() => {
                if (value.length > 1 && this.orgList.length === 0) {
                  this.selectedOrganizationId = -1;
                  this.noResults = true;
                } else if (value.length == 0 && this.orgList.length === 0) {
                  this.selectedOrganizationId = 0;
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
            this.orgList = data;
          }
          // else{
          //   this.noResults=true;
          // }
        });
    }
  }

  /** To filter and load organization from API based on user input
   * @method filterOrg
   * @param val - organization text entered by user
   */
  public filterOrg(val: string): Observable<OrganizationModel[]> {
    if (val != undefined && val.length > 1) {
      this.isSearching = true;
      return this.masterDataService.GetAllOrganizationsList(val);
    } else {
      this.noResults = false;
      this.selectedOrganizationId = -1;
      return of([]);
    }
  }

  /** Raised event when user select or change selected organization
   * @method onOrganizationChanged
   * @param event - change event
   */
  public onOrganizationChanged(event: any): void {
    this.customerForm.patchValue({
      Organization: event.option.value.Name,
    });
    this.selectedOrganizationId = event.option.value.Id;
  }

  /** click on customer search button
   * @method onSearchCustomerClick
   */
  public onSearchCustomerClick(): void {

    this.submittedSearch = true;
    // stop here if form is invalid
    if (this.customerForm.invalid) {
      return;
    }
    this.currentPage = 0;
    this.loadCustomerSearchResult();
  }

  /** load customer search result using API
   * @method loadCustomerSearchResult
   */
  public loadCustomerSearchResult(): void {
    this.bindFilterModel();

    this.customerService
      .GetCustomersListOnSearch(this.filterModel)
      .subscribe((result) => {
        this.customerDataSource.data = [];
        if (result.CustomerModel != null) {
          this.customerDataSource.data = result.CustomerModel;
          this.totalRows = result.Pagination.TotalRecords;
          this.isPaginationEnabled = true;
        } else {
          this.isPaginationEnabled = false;
        }
        this.customerRibbonModel = Object.entries(result.CustomerRibbon);
      });
  }

  /** bind filter model from customer form data to pass it to API
   * @method bindFilterModel
   */
  public bindFilterModel(): void {
    this.filterModel = new CustomerFilterModel();
    this.filterModel = Object.assign(this.customerForm.getRawValue());
    this.filterModel.OrganizationId = this.selectedOrganizationId;

    // set pagination detail
    this.paginationModel = new Pagination();
    this.paginationModel.Index = this.currentPage;
    this.paginationModel.Size = this.pageSize;
    this.filterModel.Pagination = this.paginationModel;

    // set Sorting
    this.filterModel.Sorting = this.sortingModel;
  }

  /** On country selection changed
   * @method onCountrySelectionChanged
   * @param selectedCountry - country selected by user
   */
  public onCountrySelectionChanged(selectedCountry): void {
    this.StatesList = [];
    if (selectedCountry.value > 0) {
      this.getAllStates(selectedCountry.value);
    } else {
      this.sharedService.resetField(this.customerForm, 'StateId', 0);
      //this.StatesList = SharedService.StateList;
    }
  }

  /** Load all state whene user change country
   * @method getAllStates
   * @param countryID - selected country id
   */
  public getAllStates(countryID: number): void {

    this.sharedService.getStatesList().subscribe((response) => {
      this.StatesList = response.filter((t)=>t.CountryId==countryID.toString());
      this.sharedService.resetField(this.customerForm, 'StateId', 0);
    });
  }

  /** Load all state whene user change country
   * @method pageChanged
   * @param event - page selection change event
   */
  pageChanged(event: PageEvent): void {
    this.pageSize = event.pageSize;
    this.currentPage = event.pageIndex;
    this.loadCustomerSearchResult();
  }

  /** on click of sorting icon of any column
   * @method onSorting
   * @param event - mat-sort event. activate when user click on row for sorting
   */
  public onSorting(event: any): void {
    this.sortingModel = new Sorting();
    this.sortingModel.SortByColumnName = this.getSortingColumnName(
      event.active
    );
    this.sortingModel.SortBy = event.direction;
    this.loadCustomerSearchResult();
  }

  /** Set default column on which sorting is done
   * @method setDefaultSorting
   */
  private setDefaultSorting(): void {
    this.sortingModel = new Sorting();
    this.sortingModel.SortByColumnName = 'cst.ModifiedTime';
    this.sortingModel.SortBy = 'desc';
  }

  /** on click of sorting icon of any column
   * @method getSortingColumnName
   * @param columnName - displayed column name
   * @return string- return correct column
   */
  private getSortingColumnName(columnName: string): string {
    switch (columnName) {
      case 'Customer':
        return 'Organization';
      default:
        return columnName.trim();
    }
  }

  onSavedSearchCustomerClick(searchFormGroupControl:any){
    this.savedSearch = new SaveSearchModel();
    this.savedSearch.Name=searchFormGroupControl.controls['NameYourSearch'].value;
    this.savedSearch.Id=0;
    this.savedSearch.ScreenName='customer';
    this.savedSearch.SearchCriteria=JSON.stringify(this.customerForm.getRawValue());
    this.savedSearch.SavedBy= +ApiService.UserId;
    this.savedSearch.ExpiryDate= searchFormGroupControl.controls['ExpiryDate'].value;
    this.savedSearch.EffectiveDate=new Date();
    this.savedSearch.NavigateUrl='/search/customer';
    this.savedSearch.LastRun=new Date();
    this.saveSearchService.SaveSearch(this.savedSearch).subscribe(result=>{
      this.toastr.success('Search Saved Successfully.')
      this.isSearch = true;
      this.loadContent = true;
    });
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

public onResetSearch(): void {
  // this.customerForm.reset();
   //this.loadSearchMasterData();
    // this.loadOrganizations();
    // this.setDefaultSorting();
   //  this.LoadSavedSearchFilter();
   this.customerForm.patchValue({
     CountryId: this.defaultSelectedValueForDropdownlist,
     StateId: this.defaultSelectedValueForDropdownlist,
     Organization: APP_CONSTANTS.emptyString,
     CityName: [],
   });
   for (let control in this.customerForm.controls) {
     this.customerForm.controls[control].setErrors(null);
   }

   this.loadCustomerSearchResult();
   this.StatesList = [];
 }
}
