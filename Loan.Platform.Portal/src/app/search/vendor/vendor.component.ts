import {
  AfterViewInit,
  Component,
  OnDestroy,
  OnInit,
  ViewChild,
} from '@angular/core';
import {
  AbstractControl,
  FormBuilder,
  FormControl,
  FormGroup,
  Validators,
} from '@angular/forms';
import { MatPaginator } from '@angular/material/paginator';
import {
  debounceTime,
  finalize,
  forkJoin,
  Observable,
  of,
  switchMap,
  tap,
} from 'rxjs';
import { APP_CONSTANTS } from 'src/app/app-constants';
import {
  trigger,
  state,
  style,
  transition,
  animate,
} from '@angular/animations';
import { MatSort } from '@angular/material/sort';
import { OrganizationModel } from 'src/app/shared/models/organization-model.model';
import { MasterDataService } from 'src/app/services/master-data.service';
import { StorageFacilityService } from '../storage-facility/storagefacility-service';
import { StorageFacilityModel } from '../storage-facility/StorageFacilityModel';
import { StorageFacilityInterchangesModel } from '../../shared/models/storage-facility-interchanges.model';
import { VendorModel } from './VendorModel';
import { MatTableDataSource } from '@angular/material/table';
import { VendorFilterModel } from './vendor-filter.model';
import { VendorService } from './vendor-service';
import { CountryModel } from 'src/app/shared/models/country-model.model';
import { StateModel } from 'src/app/shared/models/state-model.model';
import { SharedService } from 'src/app/shared/shared.service';
import { SavedSearchService } from 'src/app/services/saved-search.service';
import { SaveSearchModel } from 'src/app/shared/models/save-search.model';
import { ApiService } from 'src/app/services/api.service';
import { VendorRibbon } from 'src/app/shared/models/vendor-ribbon.model';
import { ToastrService } from 'ngx-toastr';

export interface Element {
  imageUrl: string;
  name: string;
  position: number;
  weight: number;
  symbol: string;
}

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
      state('expanded', style({ height: 'auto', display: '' })),
      transition(
        'expanded <=> collapsed',
        animate('225ms cubic-bezier(0.4, 0.0, 0.2, 1)')
      ),
    ]),
  ],
})
export class VendorComponent implements OnInit, AfterViewInit, OnDestroy {
  @ViewChild('MatPaginator', { static: false }) paginator: MatPaginator;
  @ViewChild('sort', { static: false }) sort: MatSort;
  public numInfo = APP_CONSTANTS.vendorInfo;
  public dataSource: any;
  public vendorForm: FormGroup;
  public submittedSearch: boolean = false;
  public expandedElement: any;
  public displayedColumns = [
    'action',
    'Vendor',
    'Facility',
    'location',
    'Interchanges',
    'ContractedSpace',
    'CarsStored',
    'TotalAmount',
    'avg_monthly_cost',
    'avg_par_car_cost',
  ];
  public innerDisplayedColumns = [
    'selects',
    'Facility',
    'Location',
    'Interchanges',
    'ContractedSpace',
    'CarsStored',
    'TotalAmount',
    'AVGMonthlyCost',
    'AVGCarCost',
  ];

  public InterchangesList: StorageFacilityInterchangesModel[] = [];
  public CityList: string[] = [];
  public facilityList: StorageFacilityModel[] = [];

  public vendorDataSource: any = new MatTableDataSource<VendorModel>();
  filterModel: VendorFilterModel;

  /* For Vendor/Organization Autocomplete */
  isSearching = false;
  noResults = false;
  orgList: any;
  public selectedOrganizationId: number = 0;
  /* End of Vendor/Organization Autocomplete */

  vendorRibbonModel: any;

  /* For Storage facility Autocomplete */
  // isSearchingForSF = false;
  // noResultsForSF = false;
  // storageFacilityList: any;
  public selectedStorageFacilityId: number = 0;
  /* End of Vendor/Organization Autocomplete */

  defaultSelectedValueForDropdownlist: number = 0;
  public CountryList: CountryModel[] = [];
  public StatesList: StateModel[] = [];

  savedSearch: SaveSearchModel;
  public searchFormGroup: FormGroup;
  public isSearch: boolean = true;
  public loadContent: boolean = false;

  constructor(
    public formBuilder: FormBuilder,
    private masterDataService: MasterDataService,
    private storageFacilityService: StorageFacilityService,
    private vendorService: VendorService,
    private sharedService: SharedService,
    private saveSearchService: SavedSearchService,
    public toastr: ToastrService,
  ) {
    this.dataSource = APP_CONSTANTS.dataTable;
  }

  ngOnInit(): void {
    this.initializeVendorForm();
    this.loadOrganizations(this.vendorForm.get('Vendor'));
    // this.loadStorageFacilities(this.vendorForm.get('StorageFacility'));

    this.loadVendorCityList();
    this.LoadSavedSearchFilter();

    setTimeout(() => {
      this.loadMasterData()
    }, 1000);
    this.onSubmitVendorForm();
  }

  ngAfterViewInit(): void {
    this.dataSource.sort = this.sort;
    this.dataSource.paginator = this.paginator;
  }

  ngOnDestroy() {
    if (this.vendorDataSource) {
      this.vendorDataSource.disconnect();
    }
  }

  private loadMasterData(): void{
     this.sharedService.getCountryList().subscribe((response) => {
      this.CountryList = response;  
    });
  }

  /** Load search/saved-search filter.
   * @method LoadSavedSearchFilter
   */
  private LoadSavedSearchFilter() : void {
    const savedSearchData = window.history.state;
    if (savedSearchData && savedSearchData['SearchCriteria'] != undefined) {
      const searchCriteria = JSON.parse(savedSearchData['SearchCriteria']);

      // set value to global variable to load relevant data
      this.selectedOrganizationId = searchCriteria.OrganizationId;
      this.getAllStates(searchCriteria.CountryId);
      this.loadStorageFacilityList();
      this.selectedStorageFacilityId = searchCriteria.StorageFacilityId;
      this.loadInterchangeData();

      setTimeout(() => {
        this.vendorForm.patchValue(searchCriteria);
        this.onSubmitVendorForm();
      }, 100);
    }
    else{
      this.loadStorageFacilityList();
      this.loadInterchangeData();
    }
  }

  /** To Load vendor city list
   * @method loadVendorCityList
   */
  public loadVendorCityList(): void {
    this.masterDataService.GetVendorCityList().subscribe((result) => {
      this.CityList = result;
    });

    // let interchangeService = this.masterDataService.getInterchangeList(
    //   this.selectedOrganizationId,
    //   this.selectedStorageFacilityId
    // )
    //let countryList = this.masterDataService.getCountryList();

    // forkJoin([cityListService, interchangeService]).subscribe((result) => {
    //   this.CityList = result[0];
    //   //this.CountryList=result[2];
    // });
  }

  /** On country selection changed
   * @method onCountrySelectionChanged
   * @param selectedCountry - country selected by user
   */
      public onCountrySelectionChanged(selectedCountry): void {
        this.StatesList =[];
        if(selectedCountry.value>0){
          this.getAllStates(selectedCountry.value);
        }else{
          this.sharedService.resetField(this.vendorForm, 'StateId', 0);
          //this.StatesList = SharedService.StateList;
        }

      }

  /** Load all state whene user change country
   * @method getAllStates
   * @param countryID - selected country id
   */
  public getAllStates(countryID: number): void {
    this.sharedService.getStatesList().subscribe((response) => {
      this.StatesList =  response.filter((t)=>t.CountryId==countryID.toString());
      this.sharedService.resetField(this.vendorForm, 'StateId', 0);
    });
  }

  /** To Load interchange data
   * @method loadInterchangeData
   */
  public loadInterchangeData(): void {
    this.masterDataService
      .getInterchangeList(
        this.selectedOrganizationId,
        this.selectedStorageFacilityId
      )
      .subscribe((response) => {
        this.InterchangesList = response;
      });
  }

  // Initialize Vendor search form
  public initializeVendorForm(): void {
    this.vendorForm = this.formBuilder.group({
      Vendor: [APP_CONSTANTS.emptyString, Validators.pattern(/^[a-zA-Z0-9-&. ]*$/)],
      StorageFacilityId: [APP_CONSTANTS.defaultNumberValue],
      InterchangeId: [APP_CONSTANTS.defaultNumberValue],
      StateId: [APP_CONSTANTS.defaultNumberValue],
      CountryId: [APP_CONSTANTS.defaultNumberValue],
      City: new FormControl(this.CityList, Validators.pattern(/^[a-zA-Z0-9-&. ]*$/)),
    });
    this.loadContent = true;
  }
  public onReset(): void {
    this.vendorForm.patchValue({
      City: [],
      CountryId: APP_CONSTANTS.defaultNumberValue,
      InterchangeId: APP_CONSTANTS.defaultNumberValue,
      Organization: APP_CONSTANTS.emptyString,
      OrganizationId: APP_CONSTANTS.defaultNumberValue,
      StateId: APP_CONSTANTS.defaultNumberValue,
      StorageFacilityId: APP_CONSTANTS.defaultNumberValue,
      Vendor: APP_CONSTANTS.emptyString
    });
    this.onSubmitVendorForm();
    this.StatesList = [];
  }
  // On form submit
  public onSubmitVendorForm(): void {
    this.submittedSearch = true;
    this.bindFilterModel();
    this.vendorService
      .GetVendorsOnFilter(this.filterModel)
      .subscribe((response) => {
        this.vendorDataSource.data = [];
        if (response.VendorGridData != null) {
           response.VendorGridData.forEach((vendorData) => {
            vendorData.VendorChildData.forEach((facility: any)=> {
                facility.Interchanges = facility.Interchanges.split(',');
                facility.Location = facility.Location.split(',');
            });
        });
          this.vendorDataSource.data = response.VendorGridData;
          // this.totalRows = response.Pagination.TotalRecords;
          // this.isPaginationEnabled = true;
        }
        this.vendorRibbonModel = Object.entries(response.VendorRibbon);
        //else {
        // this.isPaginationEnabled = false;
        //}
      });
  }

  /** bind filter model from customer form data to pass it to API
   * @method bindFilterModel
   */
  public bindFilterModel(): void {
    this.filterModel = new VendorFilterModel();
    this.filterModel = Object.assign(this.vendorForm.getRawValue());
    this.filterModel.OrganizationId = this.selectedOrganizationId;
    this.filterModel.Organization = this.vendorForm.value.Vendor;

    // set pagination detail
    // this.paginationModel = new Pagination();
    // this.paginationModel.Index = this.currentPage;
    // this.paginationModel.Size = this.pageSize;
    // this.filterModel.Pagination = this.paginationModel;

    // set Sorting
    //this.filterModel.Sorting = this.sortingModel;
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
                  this.selectedOrganizationId = 0;
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

      if (val.length == 0 && this.vendorForm.controls['Vendor'].dirty) {
        this.selectedOrganizationId = 0;
        this.loadStorageFacilityList();
        this.loadInterchangeData();
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
      event.option.value.OrganizationId
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
    this.InterchangesList = [];
    this.selectedStorageFacilityId = this.defaultSelectedValueForDropdownlist;

    this.vendorForm.patchValue({
      StorageFacilityId: this.defaultSelectedValueForDropdownlist,
      InterchangeId: this.defaultSelectedValueForDropdownlist,
    });
  }

  /** when user select vendor from list */
  private onVendorTextChanged(): void {
    if (
      this.vendorForm.value.Vendor != undefined &&
      this.vendorForm.value.Vendor.length > 0
    ) {
      this.clearStorageFacility();
      if (this.selectedOrganizationId > 0) {
        this.loadStorageFacilityList();
        this.loadInterchangeData();
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
    this.vendorForm.patchValue({
      Vendor: orgName,
    });
    this.selectedOrganizationId = organizationId;
  }

  /** To Load Storage facility dropdown list
   * @method loadStorageFacilityList
   */
  public loadStorageFacilityList(): void {
    this.selectedStorageFacilityId = 0;
    this.facilityList = [];
    this.InterchangesList = [];
    this.storageFacilityService
      .GetStorageFacilities(this.selectedOrganizationId)
      .subscribe((response) => {
        this.facilityList = response;
      });
  }

  /** on change of Storage facility from drop-downlist
   * @method onStorageFacilitySelectionChanged
   * @param event: selected storage facility id.
   */
  public onStorageFacilitySelectionChanged(event: any): void {
    this.selectedStorageFacilityId = event.value;
    if (
      this.selectedOrganizationId > 0 &&
      this.vendorForm.value.Vendor != undefined &&
      this.vendorForm.value.Vendor != ''
    ) {
      this.clearAndBindInterchangeData();
    } else if (
      this.vendorForm.value.Vendor === undefined ||
      this.vendorForm.value.Vendor === ''
    ) {
      this.clearAndBindInterchangeData();
    }
  }

  /** Clear previously selected interchange detail */
  public clearAndBindInterchangeData(): void {
    this.vendorForm.patchValue({
      InterchangeId: this.defaultSelectedValueForDropdownlist,
    });
    this.InterchangesList = [];
    this.loadInterchangeData();
  }

  // /** To load Storage facilities on autocomplete (min 2 character required to enter)
  //  * @method loadStorageFacilities
  //  */
  // public loadStorageFacilities(
  //   storagefacilityControl: AbstractControl | null
  // ): void {
  //   if (storagefacilityControl) {
  //     storagefacilityControl?.valueChanges
  //       .pipe(
  //         debounceTime(500),
  //         tap(() => {
  //           this.storageFacilityList = [];
  //           this.selectedStorageFacilityId = 0;
  //         }),
  //         switchMap((value) =>
  //           this.filterStorageFacility(value).pipe(
  //             finalize(() => {
  //               if (value.length > 1 && this.storageFacilityList.length === 0) {
  //                 this.selectedStorageFacilityId = 0;
  //                 this.noResultsForSF = true;
  //               } else {
  //                 this.noResultsForSF = false;
  //               }
  //               this.isSearchingForSF = false;
  //             })
  //           )
  //         )
  //       )
  //       .subscribe((data: any) => {
  //         if (data != null && data.length > 0) {
  //           this.noResultsForSF = false;
  //           this.storageFacilityList = data;
  //         }
  //       });
  //   }
  // }

  // /** To filter (when user start typing) and load Storage facility from API based on user input
  //  * @method filterStorageFacility
  //  * @param val - Storage facility text entered by user
  //  */
  // public filterStorageFacility(
  //   val: string
  // ): Observable<StorageFacilityModel[]> {
  //   if (val != undefined && val.length > 1) {
  //     this.isSearchingForSF = true;
  //     if (
  //       this.vendorForm.value.Vendor == undefined ||
  //       this.vendorForm.value.Vendor == null ||
  //       this.vendorForm.value.Vendor == ''
  //     ) {
  //       this.selectedOrganizationId = 0;
  //     }
  //     return this.storageFacilityService.GetStorageFacilities(
  //       val,
  //       this.selectedOrganizationId
  //     );
  //   } else {
  //     this.noResultsForSF = false;
  //     return of([]);
  //   }
  // }

  // /** Raised event when user select or change selected Storage facility
  //  * @method onSelectedFacilityChanged
  //  * @param event - change event
  //  */
  // public onSelectedFacilityChanged(event: any): void {
  //   this.vendorForm.patchValue({
  //     StorageFacility: event.option.value.Name,
  //   });
  //   this.selectedStorageFacilityId = event.option.value.Id;
  //   this.loadInterchangeData();
  // }

   /**On Saved search button click
   * @method onVendorSavedSearchClick
   */
  public onVendorSavedSearchClick(searchFormGroupControl: any): void {
    this.savedSearch = new SaveSearchModel();
    this.savedSearch.Name =
      searchFormGroupControl.controls['NameYourSearch'].value;
    this.savedSearch.Id = 0;
    this.savedSearch.ScreenName = 'vendor';
    this.savedSearch.SearchCriteria = this.getVendorFormData();
    this.savedSearch.SavedBy = +ApiService.UserId;
    this.savedSearch.ExpiryDate =
    searchFormGroupControl.controls['ExpiryDate'].value;
    this.savedSearch.EffectiveDate = new Date();
    this.savedSearch.NavigateUrl = '/search/vendor';
    this.savedSearch.LastRun = new Date();
    this.saveSearchService.SaveSearch(this.savedSearch).subscribe((result) => {
      this.toastr.success('Search Saved Successfully.')
      this.isSearch = true;
      this.loadContent = true;
    });
  }

   /** To get vendor form data for saved search criteria
   * @method getVendorFormData
   * @return json object of current vendor form data
   */
  private getVendorFormData(): string {
    let vendorFormData = this.vendorForm.getRawValue();
    vendorFormData.OrganizationId = this.selectedOrganizationId;
    return JSON.stringify(vendorFormData);
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
}
