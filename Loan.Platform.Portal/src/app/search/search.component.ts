import { Options } from '@angular-slider/ngx-slider';
import { HttpClient } from '@angular/common/http';
import { Component, OnDestroy, OnInit, ViewChild } from '@angular/core';
import {
    FormBuilder,
    FormControl,
    FormGroup,
    Validators
} from '@angular/forms';
import { ToastrService } from 'ngx-toastr';
import { Observable } from 'rxjs/internal/Observable';
import { of } from 'rxjs/internal/observable/of';
import {
    debounceTime,
    delay,
    distinctUntilChanged,
    map,
    startWith,
    switchMap
} from 'rxjs/operators';
import { DateValidators } from '../shared/directives/validatorDate';
import { SharedService } from '../shared/shared.service';
import { APP_CONSTANTS } from './../app-constants';
import { SearchMapService } from './search-map/search-map.service';
import { MatDialog } from '@angular/material/dialog';
import { BookNowComponent } from './book-now/book-now.component';

import { StorageFacilitySearchModel } from './search-map/StorageFacilitySearchModel';
import { StorageFeatureService } from './storagefeature/storagefeature-service';
import { StorageFeatureModel } from './storagefeature/StoragefeatureModel';
import { environment } from 'src/environments/environment';
@Component({
  selector: 'app-search',
  templateUrl: './search.component.html',
  styleUrls: ['./search.component.scss'],
})
export class SearchComponent implements OnInit, OnDestroy {
  @ViewChild('multiSelect') multiSelect: any;
  @ViewChild('multiFeature') multiFeature: any;
  @ViewChild('drawer', { static: false }) drawer: any;
  minValue: number = 200;
  maxValue: number = 500;
  options: Options = {
    floor: 0,
    ceil: 1100,
    step: 250,
    disabled: false,
    showTicks: true,
    draggableRange: true,
    showTicksValues: false,
    stepsArray: [
      { value: 200, legend: '200 mi' },
      { value: 500, legend: '500 mi' },
      { value: 750, legend: '750 mi' },
      { value: 1000, legend: '1000 mi' },
      { value: 1010, legend: '> 1000 mi' },
    ],
  };
  public selectedValues: any = [];
  public selectedFeatures: any = [];
  public formGroup: FormGroup;
  public filterForm: FormGroup;
  public searchFormGroup: FormGroup;
  public filterFormGroup: FormGroup;
  public loadContent: boolean = false;
  public searchResult: boolean = true;
  public filterResult: boolean = false;
  public data = APP_CONSTANTS.list;
  public designRailcarType = APP_CONSTANTS.designRailcarType;
  public designFromCity = APP_CONSTANTS.designRailcarType;
  public designToCity = APP_CONSTANTS.designRailcarType;
  public unitedState = APP_CONSTANTS.unitedState;
  public canadianState = APP_CONSTANTS.canadianState;
  public searchResults: any;
  public contractTypes = APP_CONSTANTS.contractType;
  public favourities = APP_CONSTANTS.favourities;
  public dailyRates = APP_CONSTANTS.dailyRates;
  public switchingFees = APP_CONSTANTS.switchingFees;
  public features:StorageFeatureModel[] = [];
  public settings = {};
  public submittedSearch = false;
  public enableMultiCity: boolean = true;
  public isAdvanceSearch: boolean = false;
  public upadateMap: any;
  public routeList = APP_CONSTANTS.list;
  public fromCity$: Observable<any> | undefined;
  public toCity$: Observable<any> | undefined;
  public isSearch: boolean = true;
  public math = Math;
  public number = Number;
  public railwayList = APP_CONSTANTS.list;
  public selectedRailRoadColor: string = '';
  public isSearching: boolean = false;
  public noResults: boolean = false;
  public fromCityRRStations: Array<any> = [];
  public toCityRRStations: Array<any> = [];
  public fromCityRailroads: string[] = [];
  public toCityRailroads: string[] = [];
  public originDestinationRailroads: string[] = [];
  public storageFacilitySearchModel = new StorageFacilitySearchModel();
  public dataSource: any;
  public defaultSelectedValueForDropdownlist:number = 0;
  public isLayerLoading: boolean = false;
  public showContinuousMessage: boolean = false;
  private apiKey: string = environment.authToken;

  constructor(
    public formBuilder: FormBuilder,
    public http: HttpClient,
    private dialog: MatDialog,
    public mapService: SearchMapService,
    private storageFeatureService: StorageFeatureService,
    public toastr: ToastrService,
    private sharedService:SharedService,
    private dialogRef: MatDialog
  ) {}

  ngOnInit(): void {
    this.initilizeSearchForm();
    this.initilizeAutocomplete();
    this.handleValidators();
    this.loadFeaturesMasterData();
    this.setFilterForm();
  }

  ngOnDestroy(): void {
    this.dialogRef.closeAll();
  }

   /** To load country and city dropdownlist on search
   * @method loadFeaturesMasterData
   */
    public loadFeaturesMasterData(): void {
      this.storageFeatureService.GetStorageFeaturesList().subscribe((result) => {
        this.features = result;
      });

        //this.features = features;
    }
  // Initilize Search form
  public initilizeSearchForm(): void {
    this.formGroup = this.formBuilder.group({
      RailRoad: [APP_CONSTANTS.emptyString],
      RailcarType: [APP_CONSTANTS.emptyString],
      RailCarRoads: [APP_CONSTANTS.emptyString],
      NoOfRailcars: [APP_CONSTANTS.emptyString],
      RegionOrMultiCity: [APP_CONSTANTS.emptyString],
      Region: [APP_CONSTANTS.defaultNumberValue],
      enableMultiCity: [APP_CONSTANTS.true],
      FromCity: [APP_CONSTANTS.emptyString],
      ToCity: [APP_CONSTANTS.emptyString],
      EffectiveDate: [APP_CONSTANTS.null],
      ExpiryDate: [APP_CONSTANTS.null],
      name: [APP_CONSTANTS.emptyString],
      DailyRate: [APP_CONSTANTS.emptyString],
      SwitchingFee: [APP_CONSTANTS.emptyString],
      Features: [APP_CONSTANTS.emptyString],
      Distance: [APP_CONSTANTS.emptyString],
    }, { validator: Validators.compose([
      DateValidators.dateLessThan('EffectiveDate', 'ExpiryDate', { 'expiryIssue': true })
  ])});
    this.loadContent = true;
  }

  // Initilize Search form
  public initilizeSaveSearchForm(): void {
    this.searchFormGroup = this.formBuilder.group({
      NameYourSearch: [APP_CONSTANTS.emptyString],
      ExpiryDate: [APP_CONSTANTS.null],
    });
  }

  public setFilterForm(): void {
    this.filterForm = this.formBuilder.group({});
    this.createDynamicControls();
  }

  public createDynamicControls(): void {
    const railwayList = this.railwayList;
    const contractTypes = this.contractTypes;
    const favourities = this.favourities;
    if (railwayList.length) {
      railwayList.forEach((control: any) => {
        this.filterForm.addControl(
          control.points,
          new FormControl(control.checked)
        );
      });
    }
    if (contractTypes.length) {
      contractTypes.forEach((control: any) => {
        this.filterForm.addControl(
          control.controlName,
          new FormControl(control.checked)
        );
      });
    }
    if (favourities.length) {
      favourities.forEach((control: any) => {
        this.filterForm.addControl(
          control.id,
          new FormControl(control.checked)
        );
      });
    }
  }

  public onSaveSearch(): void {
    if (this.formGroup.invalid) {
      // this.formGroup.markAllAsTouched();
      return;
    }
    this.initilizeSaveSearchForm();
    this.isSearch = false;
    this.loadContent = false;
  }

  public onSaveSearchScreen(): void {
    this.isSearch = true;
    this.loadContent = true;
  }

  public onBackToSearch(): void {
    this.isSearch = true;
    this.loadContent = true;
  }

  public displayCityState(option): string {
    return option?.Address
      ? option.Address.City + ', ' + option.Address.State
      : '';
  }

  public initilizeAutocomplete(): void {
    this.fromCity$ = this.formGroup.get('FromCity')?.valueChanges.pipe(
      debounceTime(1000),
      startWith(null),
      switchMap((value) => {
        if (typeof value === 'string'  && value !=="") {
          return this.http
            .get(
              'https://singlesearch.alk.com/NA/api/search?query=' +
                value +
                '&includeOnly=City&maxResults=20&authToken='+ this.apiKey
            )
            .pipe(
              delay(500),
              distinctUntilChanged(),
              map((response) => {
                let filteredFromCity = response['Locations'].filter((thing, i, arr) => arr.findIndex(t => (t.Address.City +','+ t.Address.State) === (thing.Address.City +','+ thing.Address.State)) === i);
                return filteredFromCity.filter((place) =>
                  place.ShortString.toUpperCase().includes(value.toUpperCase())
                );
              })
            );
        }
        return of([]);
      })
    );

    this.toCity$ = this.formGroup.get('ToCity')?.valueChanges.pipe(
      debounceTime(1000),
      startWith(null),
      switchMap((value) => {
        if (typeof value === 'string' && value !=="") {
          return this.http
            .get(
              'https://singlesearch.alk.com/NA/api/search?query=' +
                value +
                '&includeOnly=City&maxResults=20&authToken='+ this.apiKey
            )
            .pipe(
              delay(500),
              distinctUntilChanged(),
              map((response) => {
                let filteredToCity = response['Locations'].filter((thing, i, arr) => arr.findIndex(t => (t.Address.City +','+ t.Address.State) === (thing.Address.City +','+ thing.Address.State)) === i);
                return filteredToCity.filter((place) =>
                  place.ShortString.toUpperCase().includes(value.toUpperCase())
                );
              })
            );
        }
        return of([]);
      })
    );
  }

  /** Raised event when user select or change selected city
   * @method onFromCitySelected
   * @param event - change event
   */

  onFromCitySelected(event: any): void {
    if (typeof event.option.value === 'object') {
      this.originDestinationRailroads = [];
      let apiURL =
        'https://pcmrail.alk.com/REST/v28.0/Service.svc/geocode/Station?format=StationState&name=' +
        event.option.value.Address.City +
        ', ' +
        event.option.value.Address.State +
        '&authToken='+ this.apiKey;
      this.http.get(apiURL).subscribe(
        (response) => {
          this.fromCityRRStations = response['GeocodeInfos'].map((stn) => ({
            railroad: stn.Railroad?.toUpperCase(),
            station: stn,
          }));
          this.fromCityRailroads = response['GeocodeInfos'].map((stn) => {
            return stn.Railroad.toUpperCase();
          }) as string[];
          this.toastr.info(
            'Geocode railroads(s) at origin: ' + this.fromCityRailroads
          );
          this.originDestinationRailroads = this.fromCityRailroads
            .filter((value) => this.toCityRailroads.includes(value))
            .filter((value, index, self) => self.indexOf(value) === index);
        }
      );
    }
  }

  onToCitySelected(event: any): void {
    if (typeof event.option.value === 'object') {
      this.originDestinationRailroads = [];
      let apiURL =
        'https://pcmrail.alk.com/REST/v28.0/Service.svc/geocode/Station?format=StationState&name=' +
        event.option.value.Address.City +
        ', ' +
        event.option.value.Address.State +
        '&authToken='+ this.apiKey;
      this.http.get(apiURL).subscribe(
        (response) => {
          this.toCityRRStations = response['GeocodeInfos'].map((stn) => ({
            railroad: stn.Railroad?.toUpperCase(),
            station: stn,
          }));
          this.toCityRailroads = response['GeocodeInfos'].map((stn) => {
            return stn.Railroad.toUpperCase();
          });
          this.toastr.info('Geocode Railroad(s) at destination: ' + this.toCityRailroads);
          this.originDestinationRailroads = this.fromCityRailroads
            .filter((value) => this.toCityRailroads.includes(value))
            .filter((value, index, self) => self.indexOf(value) === index);
        }
      );
    }
  }

  // convenience getter for easy access to form fields
  get search() {
    return this.formGroup.controls;
  }

  public searchMap() {
    this.submittedSearch = true;
    if (!this.enableMultiCity) {
      const currentRegion = this.formGroup.get('Region')?.value;
      if (currentRegion === APP_CONSTANTS.defaultNumberValue) {
        this.formGroup.patchValue({
          Region: ''
        })
      }
    }
    if (this.formGroup.invalid) {
      return;
    }
    this.searchResult = true;
    this.filterResult = false;
    // this.formGroup.markAllAsTouched();
    this.drawer.open();
    if (this.filterForm) {
      this.filterForm.reset();
    }
    this.upadateMap = '';
    this.searchResults = null;
    this.mapService.removeRoutePath();
    this.mapService.removeStorageFacilities();
    this.selectedRailRoadColor = '#1a335f';
    if (!this.enableMultiCity) {
      this.storageFacilitySearchModel = new StorageFacilitySearchModel();
      this.storageFacilitySearchModel.IsMulticityEnable = false;
      this.storageFacilitySearchModel.RegionId = this.formGroup.value.Region;
    } else {
      this.storageFacilitySearchModel = new StorageFacilitySearchModel();
      this.storageFacilitySearchModel.IsMulticityEnable = true;
      let originStation = this.fromCityRRStations.filter(
        (e) => e['railroad'] === this.selectedValues
      );
      let destinationStation = this.toCityRRStations.filter(
        (e) => e['railroad'] === this.selectedValues
      );
      if( JSON.stringify(originStation[0].station) ===  JSON.stringify(destinationStation[0].station))
      {
        this.toastr.error('From and To city are same');
        return;
      }
      //const FromCityAddress = this.formGroup.value.FromCity.Address;
      //const ToCityAddress = this.formGroup.value.ToCity.Address;
      const RailroadName = this.formGroup.value.RailRoad;
      this.storageFacilitySearchModel.Origin = originStation[0].station;
      //FromCityAddress.City + ', ' + FromCityAddress.State;
      this.storageFacilitySearchModel.Destination =
        destinationStation[0].station;
      // ToCityAddress.City + ', ' + ToCityAddress.State;
      this.storageFacilitySearchModel.RailRoads = RailroadName;
    }
    this.storageFacilitySearchModel.EffectiveDate = this.formGroup.value.EffectiveDate;
    this.storageFacilitySearchModel.ExpiryDate = this.formGroup.value.ExpiryDate;
    this.storageFacilitySearchModel.DailyRate =  this.sharedService.CheckIsEmpty(this.formGroup.value?.DailyRate);
    this.storageFacilitySearchModel.SwitchingFee = this.sharedService.CheckIsEmpty(this.formGroup.value?.SwitchingFee)
    this.storageFacilitySearchModel.Features = this.formGroup.value.Features ? this.formGroup.value.Features : new Array<StorageFeatureModel>();
    this.mapService
      .SearchStorageFacility(this.storageFacilitySearchModel)
      .subscribe(
        (result) => {
          this.dataSource = result;
          if (this.dataSource != undefined && this.dataSource.Status == 200) {
            if (
              this.dataSource.OriginDestinationRoutePath != null &&
              this.dataSource.OriginDestinationRoutePath !=
                APP_CONSTANTS.emptyString &&
              this.storageFacilitySearchModel.IsMulticityEnable
            ) {
              this.upadateMap = this.dataSource.OriginDestinationRoutePath;
            }
            if (this.dataSource.StorageFacilityMapPoints != null) {
              this.mapService.addGeoLocationData(
                this.dataSource.StorageFacilityMapPoints,
                this.dataSource.StorageFacilityViewModels
              );
              if (
                this.dataSource.StorageFacilityViewModels != null &&
                this.dataSource.StorageFacilityViewModels.length > 0
              ) {
                this.searchResults = this.dataSource.StorageFacilityViewModels;
                let storageResultCount = `${this.dataSource.StorageFacilityViewModels.length} Storage facilities found`;
                this.toastr.success(storageResultCount);
              } else {
                this.mapService.removeStorageFacilities();
                this.toastr.info(
                  'No Storage facilities available, please contact administrator.'
                );
              }
            }
          }
          else
          {
            this.toastr.error(this.dataSource.ResponseMessage);
          }
        },
        (_error) => {});

    //   if(this.enableMultiCity){
    //   const FromCityAddress = this.formGroup.value.FromCity.Address;
    //   const ToCityAddress = this.formGroup.value.ToCity.Address;
    //   const RailroadName = this.formGroup.value.RailRoad;
    //   debugger;
    //   var color = Math.floor(0x1000000 * Math.random()).toString(16);
    //   this.selectedRailRoadColor = '#1a335f';//'#' + ('000000' + color).slice(-6);

    //   if (FromCityAddress && ToCityAddress && RailroadName) {
    //     const payload = {
    //       'stops':[{
    //         'Format':'StationState',
    //         'Name':FromCityAddress.City + ' ' + FromCityAddress.State,
    //         'Railroad':RailroadName},
    //         {'Format':'StationState',
    //          'Name':ToCityAddress.City + ' ' + ToCityAddress.State,
    //          'Railroad':RailroadName}],
    //       'options':{'routingPreference':'Practical','distUnit':'Miles'}};
    //     this.http.post('https://pcmrail.alk.com/REST/v23.1/Service.svc/route/path?authToken='+ this.apiKey, payload).subscribe(res=> {
    //           if (res) {
    //             this.upadateMap = res;
    //           }
    //         }, error => {
    //           this.mapService.removeRoutePath();
    //           this.toastr.error(error.error.ErrorDetails.substring(error.error.ErrorDetails.indexOf(":") + 1));
    //       });
    //   }
    // }
    // else
    // {
    //   debugger;
    //   const regionId = this.formGroup.value.Region + 1;
    //   if (true) {
    //     this.upadateMap = {
    //       "type": "Feature",
    //       "geometry": {
    //           "type": "MultiLineString",
    //           "coordinates": [
    //               [
    //                   [
    //                       -123.084568,
    //                       49.283194
    //                   ]
    //                 ]
    //               ]
    //             }
    //           };
    //   }
    // }
  }

  public resetSearchForm(): void {
    this.submittedSearch = false;
    this.upadateMap = '';
    this.searchResults = null;
    this.searchResult = false;
    this.filterResult = false;
    this.drawer.close();
    setTimeout(() => {
      window.dispatchEvent(new Event('resize'));
    }, 100);
    this.mapService.removeRoutePath();
    this.mapService.removeStorageFacilities();
    const isMultiCityEnabled = this.enableMultiCity;
    if (isMultiCityEnabled) {
      this.formGroup.patchValue({
        FromCity: [APP_CONSTANTS.emptyString],
        ToCity: [APP_CONSTANTS.emptyString],
        RailRoad: [APP_CONSTANTS.emptyString],
      });
      this.originDestinationRailroads = [];
    } else {
      this.formGroup.patchValue({
        Region: APP_CONSTANTS.defaultNumberValue
      });
    }
    this.resetFilters();
  }
  public resetFilters(): void {
    this.filterForm.patchValue({
      'BNSFRRPoints': false,
      'CNRRPoints': false,
      'CPRSRRPoints': false,
      'CSXTRRPoints': false,
      'KCSRRPoints': false,
      'NSRRPoints': false,
      'UPRRPoints': false
  });
  this.showContinuousMessage = false;
  }
  public onChangeEvent(e: any) {
    this.submittedSearch = false;
    this.upadateMap = '';
    this.searchResults = null;
    this.searchResult = false;
    this.filterResult = false;
    this.drawer.close();
    this.mapService.removeRoutePath();
    this.mapService.removeStorageFacilities();
    const enableMultiCity = e.checked;
    this.formGroup.patchValue({
      enableMultiCity: enableMultiCity,
      RailRoad: [APP_CONSTANTS.emptyString],
      Region: APP_CONSTANTS.defaultNumberValue
    });
    Object.keys(this.formGroup.controls).forEach(key => {
      this.formGroup.get(key)?.setErrors(null);
    });
    this.resetFilters();
    this.enableMultiCity = enableMultiCity;
    this.handleValidators();
  }

  public handleValidators(): void {
    const groupMulticityValidators = this.formGroup.controls;
    if (!this.enableMultiCity) {
      groupMulticityValidators['FromCity'].clearValidators();
      groupMulticityValidators['FromCity'].updateValueAndValidity();
      groupMulticityValidators['ToCity'].clearValidators();
      groupMulticityValidators['ToCity'].updateValueAndValidity();
      groupMulticityValidators['RailRoad'].clearValidators();
      groupMulticityValidators['RailRoad'].updateValueAndValidity();
      //Set for Region
      groupMulticityValidators['Region'].setValidators(Validators.required);
      groupMulticityValidators['Region'].updateValueAndValidity();
    } else {
      groupMulticityValidators['FromCity'].setValidators(Validators.required);
      groupMulticityValidators['FromCity'].updateValueAndValidity();
      groupMulticityValidators['ToCity'].setValidators(Validators.required);
      groupMulticityValidators['ToCity'].updateValueAndValidity();
      groupMulticityValidators['RailRoad'].setValidators(Validators.required);
      groupMulticityValidators['RailRoad'].updateValueAndValidity();
      // clear region
      groupMulticityValidators['Region'].clearValidators();
      groupMulticityValidators['Region'].updateValueAndValidity();
    }
  }

  public interChangeValues() {
    const fromCity = this.fromCityRRStations;
    const toCity = this.toCityRRStations;
    this.fromCityRRStations = toCity;
    this.toCityRRStations = fromCity;
    const getFromCity = this.formGroup.value['FromCity'];
    const getToCity = this.formGroup.value['ToCity'];
    this.formGroup.patchValue({
      FromCity: getToCity,
      ToCity: getFromCity,
    });
  }
  public onOpenCloseDrawer(): void {
    this.drawer.toggle();
    setTimeout(() => {
      window.dispatchEvent(new Event('resize'));
    }, 100);
  }
  // Toggle Advance Search
  public toggleAdvanceSearch(): void {
    this.isAdvanceSearch = !this.isAdvanceSearch;
  }

  public toggleVisibility(event, unit): void {
    if (event.checked) {
      unit.isLayerLoading = true;
      setTimeout(() => {
        unit.isLayerLoading = false;
      }, 5000);
    } else {
      unit.isLayerLoading = false;
    }
    if (!this.showContinuousMessage) {
      this.showContinuousMessage = true;
    }
    this.mapService.mapRailRoadLayer(event, unit);
  }

  public onFilterTrigger(): void {
    this.searchResult = false;
    this.filterResult = true;
    this.drawer.open();

  }
  public onSearchResult(): void {
    this.searchResult = true;
    this.filterResult = false;
    this.drawer.open();
  }

    public onApplyFilter(): any {
    }
    public onBookNow(facilityDetails): void {
      const dialogRef = this.dialog.open(BookNowComponent, {
        disableClose: true,
        data:{
          title: 'Book',
          facility: facilityDetails
        }
      });
    }

  public onDailyRateSelected(): void {
  }
  public onSwitchingFeeSelected(): void {
  }


  // public onGetStarRating(getRating): any {
  //   const ratingHTML = this.sanitizer.bypassSecurityTrustHtml(`<mat-icon class="mat-icon notranslate material-icons mat-icon-no-color">star</mat-icon>
  //   <mat-icon class="mat-icon notranslate material-icons mat-icon-no-color">star_half</mat-icon>
  //   <mat-icon class="mat-icon notranslate material-icons mat-icon-no-color">star_border</mat-icon>
  //   `);
  //   return ratingHTML;
  // }

  public onOut(): void {
  }
}
