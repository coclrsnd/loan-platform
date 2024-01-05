import { CurrencyPipe, PercentPipe } from '@angular/common';
import {
  ChangeDetectorRef,
  Component,
  ElementRef,
  EventEmitter,
  Input,
  OnChanges,
  OnInit,
  Output,
  ViewChild
} from '@angular/core';
import {
  AbstractControl,
  FormGroup
} from '@angular/forms';
import { MatDialog } from '@angular/material/dialog';
import { TranslateService } from '@ngx-translate/core';
import {
  debounceTime,
  finalize,
  Observable,
  of,
  switchMap,
  tap,
} from 'rxjs';
import { APP_CONSTANTS } from 'src/app/app-constants';
import { VendorService } from 'src/app/search/vendor/vendor-service';
import { ApiService } from 'src/app/services/api.service';
import { AuthService } from 'src/app/services/auth.service';
import { MasterDataService } from 'src/app/services/master-data.service';
import { CountryModel } from '../../models/country-model.model';
import { OrganizationModel } from '../../models/organization-model.model';
import { RegionModel } from '../../models/region.model';
import { StateModel } from '../../models/state-model.model';
import { SharedService } from '../../shared.service';
import { OrganizationDialogComponent } from '../organization-dialog/organization-dialog.component';

@Component({
  selector: 'app-vendor-form',
  templateUrl: './vendor-form.component.html',
  styleUrls: ['./vendor-form.component.scss'],
})
export class VendorFormComponent implements OnInit, OnChanges {
  @Input() mode: string;
  @Input() isFromPage: string;
  @Input() isCreateUpdate: boolean;
  //@Output() vendorFormData: EventEmitter<any> = new EventEmitter();
  @Input() vendorForm: FormGroup;
  @Output() setVerifyEvent = new EventEmitter();
  public vendorDetailsForm: FormGroup;
  public submittedVendorDetails: boolean = false;
  public bsConfig = APP_CONSTANTS.bsConfig;
  public effDateValue: Date = new Date();
  public expDateValue: Date = new Date();
  public isInViewMode: boolean = false;
  public isRecordSaved: boolean = false;
  public CountryList: CountryModel[] = [];
  public StatesList: StateModel[] = [];
  public isSearching: boolean = false;
  public noResults: boolean = false;
  public organizationList: any;
  public OrganizationModel: OrganizationModel;
  public selectedOrganizationId: number = 0;
  public RegionsList: RegionModel[] = [];
  public defaultSelectedValueForDropdownlist = APP_CONSTANTS.emptyString;
  public currentUserRole: string = '';
  @ViewChild("Organization") inputOrganization: ElementRef;
  constructor(
    private cd: ChangeDetectorRef,
    private masterDataService: MasterDataService,
    private dialog: MatDialog,
    private translateService: TranslateService,
    private sharedService:SharedService,
    private currencyPipe: CurrencyPipe,
    private percentPipe: PercentPipe,
    private vendorService: VendorService,
    private authService: AuthService
  ) {}

  ngOnInit(): void {
    this.vendorDetailsForm = this.vendorForm;
      this.loadMasterData()
    if(this.mode === 'create'){
      this.loadOrganizations(this.vendorDetailsForm.get('Organization'));
    }
    this.authService.getUserId();
    this.currentUserRole = ApiService.CurrentRole.split('_')[0];
  }

  ngAfterViewInit() {
    if(this.mode === 'create'){
    this.inputOrganization.nativeElement.focus();
    }
  }

  ngOnChanges() {
    this.cd.detectChanges();
    if(this.mode=== 'edit'){
      this.vendorDetailsForm.controls["Organization"].disable();
    }
  }

  private loadMasterData(): void{
    this.sharedService.getCountryList().subscribe((response) => {
      this.CountryList = response;
    });
    if (this.mode !== 'create') {
     this.sharedService.getStatesList().subscribe((response) => {
       this.StatesList = response;
      });
      this.sharedService.getRegionsList().subscribe((response) => {
        this.RegionsList = response;
       });
    }
  }

  // convenience getter for easy access to form fields
  get vendorDetails() {
    return this.vendorDetailsForm.controls;
  }
  // Change Mode to update
  public onUpadate(): void {
    this.isInViewMode = !this.isInViewMode;
    this.isInViewMode ? (this.mode = 'Update') : (this.mode = 'View');
  }
  // // On form submit i.e. Save
  // public onSubmitVendorDetailsForm(): void {
  //   this.submittedVendorDetails = true;
  //   // stop here if form is invalid
  //   if (this.vendorDetailsForm.invalid) {
  //     return;
  //   }
  //   this.isRecordSaved = true;
  //   this.vendorFormData.emit(this.vendorDetailsForm.value);
  // }
  // // For Updating Record once saved
  // public onUpdateVendorDetailsForm(): void {
  //   if (this.vendorDetailsForm.invalid) {
  //     return;
  //   }
  //   this.vendorFormData.emit(this.vendorDetailsForm.value);
  // }
  public onResetVendorDetailsForm(): void {
    this.submittedVendorDetails = false;
    this.vendorDetailsForm.reset();
    this.vendorDetailsForm.updateValueAndValidity();
    this.vendorDetailsForm.markAsUntouched();
  }

  // /**To get all country list
  //  * @method getAllCountries
  //  */
  // public getAllCountries(): void {
  //   this.masterDataService.getCountryList().subscribe((result) => {
  //     this.CountryList = result;
  //   });
  // }

  /** On selected country value changed
   * @method onCountrySelectionChanged
   * @param selectedCountry - selected country
   */
  public onCountrySelectionChanged(selectedCountry): void {
    this.StatesList = [];
    this.RegionsList = [];
    this.vendorDetailsForm.patchValue({
      StateId: APP_CONSTANTS.emptyString,
      RegionId: APP_CONSTANTS.emptyString
    })
    this.getAllStatesAndRegions(selectedCountry.value);
  }

  /** Load all states on country selection changed
   * @method getAllStates
   * @param countryID - selected country ID
   */
  // public getAllStates(countryID: number): void {
  //   this.masterDataService
  //     .getStateListByCountryId(countryID)
  //     .subscribe((result) => {
  //       this.StatesList = result;
  //     });

  //     this.masterDataService.GetRegionByCountryID(countryID);
  // }

  /** Load all states and regions on country selection changed
   * @method getAllStatesAndRegions
   * @param countryID - selected country ID
   */
  public getAllStatesAndRegions(countryID: number): void {
    // let StateDataService =
    //   this.masterDataService.getStateListByCountryId(countryID);

    // let RegionDataService =
    //   this.masterDataService.GetRegionByCountryID(countryID);

    this.sharedService.getStatesList().subscribe((response) => {
      this.StatesList = response.filter((t) => t.CountryId == countryID.toString());
    });
      this.sharedService.getRegionsList().subscribe((response) => {
        this.RegionsList = response.filter((m)=>m.CountryId==countryID)});

    // forkJoin([StateDataService, RegionDataService]).subscribe((response) => {
    //   //this.StatesList = response[0];
    //   this.RegionsList = response[1];
    // });
  }

  /** Raised event when user select or change selected organization
   * @method onOrganizationChanged
   * @param event - change event
   */
  public onOrganizationChanged(event: any): void {
    this.setOrganizationValueOnSelection(
      event.option.value.Name,
      event.option.value.Id
    );
    //this.checkIfOrganizationExists(event.option.value.Name);
  }


  //  /** check if vendor/organization name is already exists or not
  //  * @method checkIfOrganizationIsExists
  //  */
  //   public checkIfOrganizationIsExists(): void {
  //     if(this.selectedOrganizationId > 0){
  //       let selectedOrganizationName = this.vendorDetailsForm.get('Organization')?.value;

  //       if(this.sharedService.CheckIfEmptyOrNull(selectedOrganizationName)!=''){

  //         this.vendorService.GetVendorListForAutoComplete(selectedOrganizationName).subscribe(response=> {
  //           let orgnameDetail=response.filter(t=>t.Organization.trim().toLowerCase() ===
  //           selectedOrganizationName.trim().toLocaleLowerCase());
  //           if(orgnameDetail!=null && orgnameDetail.length>0){
  //            this.vendorDetailsForm.controls["Organization"].setErrors({
  //             notUnique: true
  //            });

  //           // this.vendorDetailsForm.controls["Organization"].updateValueAndValidity();
  //           } else {
  //             this.vendorDetailsForm.controls['Organization'].setErrors({
  //               notUnique: false
  //             });
  //            // this.vendorDetailsForm.controls["Organization"].updateValueAndValidity();
  //           }
  //         })
  //       }
  //     }
  // }



  /** To load organizations on autocomplete (min 2 character required to enter)
   * @method loadOrganizations
   */
  public loadOrganizations(orgControl: AbstractControl | null): void {
    if (orgControl) {
      orgControl?.valueChanges
        .pipe(
          debounceTime(1000),
          tap(() => {
            this.organizationList = [];
          }),
          switchMap((value) =>
            this.filterOrg(value).pipe(
              finalize(() => {
                if (value.length > 1 && this.organizationList.length === 0) {
                  this.selectedOrganizationId = 0;
                  this.noResults = true;
                  this.vendorDetailsForm.patchValue({
                    OrganizationId: 0,
                  });
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
            this.organizationList = data;
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
      return of([]);
    }
  }

  openDialog(event): void {
    event.stopPropagation();
    const dialogRef = this.dialog.open(OrganizationDialogComponent, {
      data: {
        orgName: this.vendorDetailsForm.value.Organization,
        title: this.translateService.instant('common.vendor'),
      },
    });

    dialogRef.afterClosed().subscribe((resultModel: OrganizationModel) => {
      if (resultModel != undefined) {
        this.OrganizationModel = resultModel;
        this.setOrganizationValueOnSelection(resultModel.Name, resultModel.Id);
      } else {
        this.setOrganizationValueOnSelection('', 0);
      }
    });
  }

  private setOrganizationValueOnSelection(
    orgName: string,
    organizationId: number
  ): void {
    this.vendorDetailsForm.patchValue({
      Organization: orgName,
      OrganizationId: organizationId,
    });
    this.selectedOrganizationId = organizationId;
  }

  public onUpperCase(event) {
    event.target.value = this.sharedService.toUpperCase(event);
  }
  public onFocusNumber(element): void { // Correct Implementation
    const updateValue = element.target.value.replace(/[^0-9\.]+/g,"");
    element.target.value = updateValue;
  }
  public onBlurAmount(element) { // Correct Implimentation
     const formattedAmount = this.currencyPipe.transform(element.target.value, 'USD');
     element.target.value = formattedAmount;
  }
  public onBlurPercent(element): void {
    if (+element.target.value >= 0) {
      const formattedPercent = this.percentPipe.transform(+element.target.value/100,'1.1-2');
      element.target.value = formattedPercent ? formattedPercent : element.target.value;
    }
  }

  public onOrganizationBlur(event : any): void{
    setTimeout(() => {
      this.checkIfOrganizationExists(event.target.value);
    }, 200);
  }

   /** check if vendor/organization name is already exists or not
   * @method checkIfOrganizationExists
   */
    public checkIfOrganizationExists(selectedOrganizationName: string): void {
        if(this.sharedService.CheckIfEmptyOrNull(selectedOrganizationName) != '') {
            this.vendorService.GetVendorListForAutoComplete(selectedOrganizationName).subscribe(response=> {
              let orgnameDetail=response.filter(t=>t.Organization.trim().toLowerCase() ===
              selectedOrganizationName.trim().toLocaleLowerCase());
              if(orgnameDetail!=null && orgnameDetail.length>0){
               this.vendorDetailsForm.controls["Organization"].setErrors({
                'notUnique': true
               });
              } else {
                this.vendorDetailsForm.controls['Organization'].setErrors(null);
              }
            })
          }
        }
}
