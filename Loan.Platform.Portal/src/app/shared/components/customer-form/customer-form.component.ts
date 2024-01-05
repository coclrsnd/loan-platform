import { Component, Input, OnInit } from '@angular/core';
import {
  AbstractControl,
  AsyncValidatorFn,
  FormBuilder,
  FormGroup,
  Validators,
} from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import { TranslateService } from '@ngx-translate/core';
import { ToastrService } from 'ngx-toastr';
import { debounceTime, finalize, map, Observable, of, switchMap, tap } from 'rxjs';
import { APP_CONSTANTS } from 'src/app/app-constants';
import { CustomerService } from 'src/app/search/customer/customer-service';
import { CustomerModel } from 'src/app/search/customer/CustomerModel';
import { MasterDataService } from 'src/app/services/master-data.service';
import { CountryModel } from '../../models/country-model.model';
import { OrganizationModel } from '../../models/organization-model.model';
import { StateModel } from '../../models/state-model.model';
import { MatDialog } from '@angular/material/dialog';
import { OrganizationDialogComponent } from '../organization-dialog/organization-dialog.component';
import { SharedService } from '../../shared.service';
import { DateValidators } from '../../directives/validatorDate';
import { AuthService } from 'src/app/services/auth.service';
import { ApiService } from 'src/app/services/api.service';
import { ConfirmDialogService } from '../confirm-dialog/confirm-dialog.service';
import { PercentPipe } from '@angular/common';

@Component({
  selector: 'app-customer-form',
  templateUrl: './customer-form.component.html',
  styleUrls: ['./customer-form.component.scss'],
})
export class CustomerFormComponent implements OnInit {
  @Input() isFromPage;
  public onBoardCustomerForm: FormGroup;
  public submittedonBoardCustomer: boolean = false;
  public bsConfig = APP_CONSTANTS.bsConfig;
  public effDateValue: Date = new Date();
  public expDateValue: Date = new Date();
  public currentUserRole: string = '';
  public pageTitle: string = '';
  public mode: string = '';
  public id: number = 0;
  public isViewMode: boolean = false;
  public isEditMode: boolean = false;
  public isCreateUpdate: boolean = false;

  public CountryList: CountryModel[];
  public StatesList: StateModel[] = [];

  public customerModel: CustomerModel = new CustomerModel();
  public selectedOrganizationId: number = 0;
  public isSearching: boolean = false;
  public noResults: boolean = false;
  public organizationList: any;
  public OrganizationModel: OrganizationModel;
  public persistData: any;
  public defaultSelectedValueForDropdownlist: string = APP_CONSTANTS.emptyString;

  constructor(
    private formBuilder: FormBuilder,
    private route: ActivatedRoute,
    private translateService: TranslateService,
    private masterDataService: MasterDataService,
    private customerService: CustomerService,
    private router: Router,
    private toastr: ToastrService,
    private dialog: MatDialog,
    private sharedService: SharedService,
    private authService: AuthService,
    private dialogService: ConfirmDialogService,
    private percentPipe: PercentPipe
  ) {}

  ngOnInit(): void {
    this.initializeCustomerDetailsForm();
    //this.getAllCountries();
    this.route.params.subscribe((params: any) => {
      this.mode = params.mode;
      this.id = params.id;
    });
    this.authService.getUserId();
    this.currentUserRole = ApiService.CurrentRole.split('_')[0];
    if(ApiService.CurrentRole.startsWith('Customer')){
      this.customerService.GetCustomerForUserId(+ApiService.UserId).subscribe(
        data =>{
          if( data.Id > 0 ) {
            this.router.navigate(['../../search/customer/customer-details/view/'+data.Id  ]);
          }
        });
    }

    this.checkModeData();
    //this.sharedService.loadMasterData();
    this.loadOrganizations(this.onBoardCustomerForm.get('OrganizationName'));
    this.loadMasterData();
  }

  private loadMasterData(): void{
    this.sharedService.getCountryList().subscribe((response) => {
      this.CountryList = response;
    });

  }

  /** Initialize on-board customer form
   * @method initializeCustomerDetailsForm
   */
  public initializeCustomerDetailsForm(): void {
    this.onBoardCustomerForm = this.formBuilder.group(
      {
        Name: [APP_CONSTANTS.emptyString, Validators.required],
        PrimaryContactNo: [APP_CONSTANTS.emptyString, [Validators.required, Validators.pattern(/^[0-9 +()-]*$/)]],
        PrimaryContactEmail: [APP_CONSTANTS.emptyString, [Validators.required, Validators.email]],
        SecondaryContactNo: [APP_CONSTANTS.emptyString, [Validators.pattern(/^[0-9 +()-]*$/)]],
        SecondaryContactEmail: [APP_CONSTANTS.emptyString, Validators.email],
        Address: [APP_CONSTANTS.emptyString],
        ZipCode: [APP_CONSTANTS.emptyString, Validators.pattern(/^[a-zA-Z0-9 ]*$/)],
        City: [APP_CONSTANTS.emptyString, Validators.pattern(/^[a-zA-Z0-9-&. ]*$/)],
        StateId: [APP_CONSTANTS.emptyString],
        CountryId: [APP_CONSTANTS.emptyString],
        /* Organization name is customer name */
        OrganizationName: [APP_CONSTANTS.emptyString,
        {
          validators: [
            Validators.required,
            Validators.maxLength(50),
            Validators.pattern(/^[a-zA-Z0-9-&. ]*$/)
          ],
           asyncValidators:[] //[this.checkOrganizationDetail()]
        }],
        Subsidary: [APP_CONSTANTS.emptyString],
        EffectiveDate: [APP_CONSTANTS.null, Validators.required],
        ExpiryDate: [APP_CONSTANTS.null, Validators.required],
        Website: [APP_CONSTANTS.emptyString],
        Description: [APP_CONSTANTS.emptyString],
        PercentageMargin: [APP_CONSTANTS.emptyString, {
          validators:[Validators.required,
                      Validators.min(0),
                      Validators.max(100)],
          updateOn: 'change',
          asyncValidators: []
        }
          ],
      },
      {
        validator: Validators.compose([
          DateValidators.dateIsLessThan('EffectiveDate', 'ExpiryDate', {
            expiryIssue: true,
          }),
        ]),
      }
    );
  }

  /** Get Current form-control
   * @method onBoardCustomer
   */
  get onBoardCustomer() {
    return this.onBoardCustomerForm.controls;
  }

  /** On click on submit on-board customer button
   * @method onSubmitonBoardCustomerForm
   */
  public onSubmitonBoardCustomerForm(): void {
    this.submittedonBoardCustomer = true;
    // stop here if form is invalid
    this.verifyOrganizationDetail();
  }


  private bindModel(): void {
    this.customerModel = Object.assign(this.onBoardCustomerForm.getRawValue());
    this.customerModel.EffectiveDate = this.sharedService.ConvertToFormatedDate(this.customerModel.EffectiveDate);
    this.customerModel.ExpiryDate = this.sharedService.ConvertToFormatedDate(this.customerModel.ExpiryDate);

    this.customerModel.CountryId = this.sharedService.CheckIsEmpty(
      this.onBoardCustomerForm.value.CountryId
    );
    this.customerModel.StateId = this.sharedService.CheckIsEmpty(
      this.onBoardCustomerForm.value.StateId
    );
    this.customerModel.ZipCode = this.customerModel.ZipCode ? this.customerModel.ZipCode.toUpperCase() : this.customerModel.ZipCode;
    this.customerModel.OrganizationId = this.selectedOrganizationId;
    this.customerModel.PrimaryContactNo =
      this.customerModel.PrimaryContactNo.toString();
    this.customerModel.SecondaryContactNo =
      this.customerModel.SecondaryContactNo != null
        ? this.customerModel.SecondaryContactNo.toString()
        : '';
    this.customerModel.PercentageMargin=this.sharedService.CheckDecimalIsEmpty(this.customerModel.PercentageMargin);
  }

  /** To check different mode
   * @method checkModeData
   */
  public checkModeData(): void {
    switch (this.mode) {
      case APP_CONSTANTS.create:
        this.isEditMode = false;
        this.isViewMode = false;
        this.pageTitle = this.translateService.instant('common.on-board');
        break;
      case APP_CONSTANTS.edit:
        this.isEditMode = true;
        this.isViewMode = false;
        this.pageTitle = this.translateService.instant('common.update');
        break;
      case APP_CONSTANTS.view:
        this.isEditMode = false;
        this.isViewMode = true;
        this.pageTitle = this.translateService.instant('common.view');
        this.isCreateUpdate = true;
        this.loadCustomersData();
        break;
    }
  }

  /** on update mode
   * @method onUpadate
   */
  public onUpadate(): void {
    this.mode = APP_CONSTANTS.edit;
    this.checkModeData();
    this.isCreateUpdate = false;
    this.disableIfEditMode();
  }

  /** on update customer form data
   * @method onUpdateCustomerForm
   */
  public onUpdateCustomerForm(): void {
    this.submittedonBoardCustomer = true;
    // stop here if form is invalid
    if (this.onBoardCustomerForm.invalid) {
      return;
    }
    if (this.selectedOrganizationId > 0) {
      this.mode = APP_CONSTANTS.view;
      this.checkModeData();
      this.isCreateUpdate = true;

      this.submittedonBoardCustomer = true;

      this.bindModel();
      //set id to model
      this.customerModel.Id = this.id;

      this.customerService.UpdateCustomer(this.customerModel).subscribe(
        (response) => {
          this.toastr.success('The information was updated successfully.');
          this.loadCustomersData();
        },
        (error) => {
          this.toastr.error('Failed to update customer detail.');
        }
      );
    } else {
      this.toastr.error('Select valid organization.');
    }
  }

  /** on reset form
   * @method onReset
   */
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
        this.submittedonBoardCustomer = false;
        if(this.persistData != undefined) {
          this.onBoardCustomerForm.patchValue(this.persistData);
        }
       else {
        this.StatesList=[];
        this.onBoardCustomerForm.reset();
        this.onBoardCustomerForm.patchValue({
          CountryId: this.defaultSelectedValueForDropdownlist,
          StateId: this.defaultSelectedValueForDropdownlist
        });
       }
       this.onBoardCustomerForm.controls['OrganizationName'].setErrors(null);
        //this.onBoardCustomerForm.reset();
      }
    });


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
    this.getAllStates(selectedCountry.value);
  }

  /** Load all states on country selection changed
   * @method getAllStates
   * @param countryID - selected country ID
   */
  public getAllStates(countryID: number): void {
    this.onBoardCustomerForm.patchValue({
      StateId: APP_CONSTANTS.emptyString
     });
    if (countryID > 0) {
      this.sharedService.getStatesList().subscribe((response) => {
        this.StatesList = response.filter((t)=>t.CountryId==countryID.toString());;
      });
    } else {
      this.StatesList = [];
    }
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
    //this.checkOrganizationDetail();
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
            this.organizationList = [];
          }),
          switchMap((value) =>
            this.filterOrg(value).pipe(
              finalize(() => {
                if (value.length > 1 && this.organizationList.length === 0) {
                  this.selectedOrganizationId = 0;
                  this.noResults = true;
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

  /** To open organization dialog box
   * @method openDialog
   */
  public openDialog(): void {
    const dialogRef = this.dialog.open(OrganizationDialogComponent, {
      data: {
        orgName: this.onBoardCustomerForm.value.OrganizationName,
        title: this.translateService.instant('common.customer'),
      },
    });

    dialogRef.afterClosed().subscribe((resultModel: OrganizationModel) => {
      if (resultModel != undefined) {
        this.OrganizationModel = resultModel;
        this.setOrganizationValueOnSelection(resultModel.Name, resultModel.Id);
      }
      else {
        this.setOrganizationValueOnSelection('', 0);
      }
    });
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
    this.onBoardCustomerForm.patchValue({
      OrganizationName: orgName,
    });
    this.selectedOrganizationId = organizationId;
  }

  /** Load customers data on view/edit
   * @method loadCustomersData
   */
  loadCustomersData(): void {
    this.customerService.GetCustomerByID(this.id).subscribe((response: any) => {
      this.getAllStates(response.CountryId != null ? response.CountryId : 0);
      if(this.sharedService.CheckIfEmptyOrNull(response.CountryId) === ''){
        response.CountryId = APP_CONSTANTS.emptyString;
      }
      if(this.sharedService.CheckIfEmptyOrNull(response.StateId) === ''){
        response.StateId = APP_CONSTANTS.emptyString;
      }
      this.onBoardCustomerForm.patchValue(response);
      this.sharedService.transformFieldValues(['PercentageMargin'],this.onBoardCustomerForm,this.percentPipe);
      this.persistData=response;
      if (response.Organization != null) {
        this.setOrganizationValueOnSelection(
          response.Organization.Name,
          response.Organization.Id
        );
      }
    });
  }

  /** On cancel button click while updating customer detail
   * @method onCancelUpdateClick
   */
  onCancelUpdateClick(): void {
    const options = {
      title: 'Warning',
      message: `Do you really want to cancel changes?`,
      cancelText: 'No',
      confirmText: 'Yes',
    };
    this.dialogService.open(options);
    this.dialogService.confirmed().subscribe((confirmed) => {
      if (confirmed) {
        this.submittedonBoardCustomer = false;
        this.onBoardCustomerForm.patchValue(this.persistData);
        this.mode = APP_CONSTANTS.view;
        this.checkModeData();
      }
    });
  }

  public onUpperCase(event) {
    if (/^[a-zA-Z1-9 ]+$/.test(event.target.value)) {
      event.target.value = event.target.value.toUpperCase();
    }
  }

   /** on organization selection raised event to verify selected organization name
   * @method checkOrganizationDetail
   */
  checkOrganizationDetail(): AsyncValidatorFn {
    return (control: AbstractControl) => {
      if(this.mode.toLocaleLowerCase() !== 'create'){
          return of();
      }

    let selectedOrganizationName= control.value;
    return this.customerService.GetCustomers(selectedOrganizationName)
     .pipe(
        map(response =>{
          let orgnameDetail= response.filter(t=>t.Name.trim().toLowerCase() ===
              selectedOrganizationName.trim().toLocaleLowerCase());
          return (orgnameDetail!=null && orgnameDetail.length>0)?
          { notUnique : true} : null;
        })
      )
    }
  }

  //   /** on organization selection raised event to verify selected organization name
  //  * @method checkOrganizationDetail
  //  */
  //    public checkOrganizationDetail(): void {
  //     let selectedOrganizationName= this.onBoardCustomerForm.get('OrganizationName')?.value;

  //     if(this.sharedService.CheckIfEmptyOrNull(selectedOrganizationName)!='') {
  //       this.customerService.GetCustomers(selectedOrganizationName).subscribe(response=> {
  //         let orgnameDetail=response.filter(t=>t.Name.trim().toLowerCase() ===
  //         selectedOrganizationName.trim().toLocaleLowerCase());
  //         if(orgnameDetail!=null && orgnameDetail.length>0) {
  //          this.onBoardCustomerForm.controls["OrganizationName"].setErrors({
  //           notUnique: true
  //          });
  //         } else {
  //           this.onBoardCustomerForm.controls['OrganizationName'].setErrors(null);
  //         }
  //       })
  //     }
  // }

   /** verify organization name is exists or not then only submit
   * @method verifyOrganizationDetail
   */
  public verifyOrganizationDetail(): void {
      let selectedOrganizationName = this.onBoardCustomerForm.get('OrganizationName')?.value;

      if(this.sharedService.CheckIfEmptyOrNull(selectedOrganizationName) != APP_CONSTANTS.emptyString) {
        this.customerService.GetCustomers(selectedOrganizationName).subscribe(response=> {
          let orgnameDetail=response.filter(t=>t.Name.trim().toLowerCase() ===
          selectedOrganizationName.trim().toLocaleLowerCase());
          if(orgnameDetail!=null && orgnameDetail.length>0) {
           this.onBoardCustomerForm.controls["OrganizationName"].setErrors({
            notUnique: true
           });
           if (this.onBoardCustomerForm.invalid) {
            return;
          };

          } else {
            this.onBoardCustomerForm.controls['OrganizationName'].setErrors(null);
            this.submitCustomerData();
          }
        })
      }
  }

  public onOrganizationBlur(event : any): void {
    setTimeout(() => {
      this.duplicateOrganisation(event.target.value);
    }, 200);
  }

    /** verify organization name is exists or not then only submit
   * @method duplicateOrganisation
   * @param selectedOrganizationName: selected organization name
   */
     public duplicateOrganisation(selectedOrganizationName: string): void {
      if(this.sharedService.CheckIfEmptyOrNull(selectedOrganizationName) != '') {
        if(this.sharedService.CheckIfEmptyOrNull(selectedOrganizationName) != APP_CONSTANTS.emptyString) {
          this.customerService.GetCustomers(selectedOrganizationName).subscribe(response=> {
            let orgnameDetail=response.filter(t=>t.Name.trim().toLowerCase() ===
            selectedOrganizationName.trim().toLocaleLowerCase());
            if(orgnameDetail!=null && orgnameDetail.length>0) {
             this.onBoardCustomerForm.controls["OrganizationName"].setErrors({
              'notUnique' : true
             });
            } else {
              this.onBoardCustomerForm.controls['OrganizationName'].setErrors(null);
            }
          })
        }
      }
  }

  private submitCustomerData(): void{
    if (this.onBoardCustomerForm.invalid) {
      return;
    }

    this.bindModel();
    if (this.selectedOrganizationId > 0) {
      this.customerService
        .OnBoardNewCustomer(this.customerModel)
        .subscribe((result) => {
          if (result.Id > 0) {
            this.toastr.success('Customer added successfully.');
            this.router.navigate(['/search/customer']);
          } else {
            this.toastr.error('Failed to save record. Error Occured');
          }
        });
    } else {
      this.toastr.error('Select valid organization.');
    }
  }

  public disableIfEditMode() :void {
    if(this.mode=== 'edit') {
      this.onBoardCustomerForm.controls["OrganizationName"].disable();
      }
  }
  public onFocusNumber(element): void { // Correct Implementation
    const updateValue = element.target.value.replace(/[^0-9\.]+/g, "");
    element.target.value = updateValue;
  }
  public onBlurPercent(element): void {
    if (+element.target.value >= 0) {
      const formattedPercent = this.percentPipe.transform(+element.target.value/100,'1.1-2');
      element.target.value = formattedPercent ? formattedPercent : element.target.value;
    }
  }
}
