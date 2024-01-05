import { Component, OnInit, ViewChild } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { debounceTime, finalize, Observable, of, switchMap, tap } from 'rxjs';
import { APP_CONSTANTS } from 'src/app/app-constants';
import { DateValidators } from 'src/app/shared/directives/validatorDate';
import { RiderModel } from '../../search/rider/RiderModel';
import { RiderService } from '../../search/rider/rider-service';
import { MatSort } from '@angular/material/sort';
import { ReportService } from './report-service';
import { ActivityReportModel } from './activityReport-model';
import { DatePipe } from '@angular/common';
import { CustomerService } from '../../search/customer/customer-service';
import { CustomerModel } from '../../search/customer/CustomerModel';
import { ToastrService } from 'ngx-toastr';
import { SharedService } from 'src/app/shared/shared.service';
@Component({
  selector: 'app-activity-report',
  templateUrl: './activity-report.component.html',
  styleUrls: ['./activity-report.component.scss'],
})
export class ActivityReportComponent implements OnInit {
  public activityReportForm: FormGroup;
  public defaultSelectedValueForDropdownlist = APP_CONSTANTS.defaultNumberValue;
  public statusDetails = APP_CONSTANTS.unitList;
  public contractType: string = APP_CONSTANTS.emptyString;
  public contractTypeId: number = 0;
  public contractId: number = 0;
  public timeRange = APP_CONSTANTS.timeRange;
  public todaysDate: Date = new Date();
  public submittedDownload: boolean = false;
  public riderModel = new RiderModel();
  public activityModel = new ActivityReportModel();
  public selectedCustomerId: number = 0;
  public customerList: any;
  public SelectCustomerName: string = '';
  public selectedStorageOrderId: number = 0;
  public customerSearchVal: string = '';
  @ViewChild(MatSort, { static: false }) sort: MatSort;
  isSearching = false;
  noResults = false;
  orgList: any;
  storageOrderList: any;
  public submittedSearch: boolean = false;
  public downloadButtonEnable: boolean = true;
  public storageOrderRibbonModel: any;
  public dataSource: any;

  constructor(
    public formBuilder: FormBuilder,
    public riderService: RiderService,
    public customerService: CustomerService,
    private reportservice: ReportService,
    private datePipe: DatePipe,
    public toastr: ToastrService,
    public sharedService: SharedService
  ) { }
  public oldvalueCustomer: string = '';
  ngOnInit(): void {
    this.initializeActivityReportForm();
    this.loadCustomers();
  }

  // Initilize users search form
  public initializeActivityReportForm(): void {
    this.activityReportForm = this.formBuilder.group(
      {
        Organization: [APP_CONSTANTS.emptyString, Validators.required],
        StorageOrder: [APP_CONSTANTS.emptyString, Validators.required],
        ContractType: [{ value: APP_CONSTANTS.emptyString, disabled: true }, APP_CONSTANTS.emptyString],
        TimeRange: [APP_CONSTANTS.defaultNumberValue, Validators.required],
        FormFromDate: [APP_CONSTANTS.null, Validators.required],
        FormToDate: [APP_CONSTANTS.null, Validators.required],
      },
      {
        validator: Validators.compose([
          DateValidators.dateLessThan('FormFromDate', 'FormToDate', {
            expiryIssue: true,
          }),
        ]),
      }
    );
  }

  // To Reset Activity Report Form
  public onResetActivityReportForm(): void {
    this.submittedDownload = false;
    this.activityReportForm.reset();
    this.activityReportForm.patchValue({
      ContractType: APP_CONSTANTS.emptyString,
      TimeRange: this.defaultSelectedValueForDropdownlist,
    });
    this.storageOrderList = [];
    this.orgList = [];
    this.customerSearchVal = APP_CONSTANTS.emptyString;
    this.onDownloadButtonEnable();
  }

  public onDownloadButtonEnable():void{
    this.downloadButtonEnable = true;
    if((this.activityReportForm.get('ContractType')?.value).toLowerCase() === APP_CONSTANTS.contractTypeReserve.toLowerCase())
    {
      this.downloadButtonEnable = false;
    }
  }

  // On Submit of Activity Report Form
  public onSearchActivityReportForm(): void {
    this.submittedDownload = true;
    // stop here if form is invalid

    if (this.activityReportForm.invalid) {
      return;
    } else {
      this.activityModel.ContractTypeId = this.contractTypeId;
      this.activityModel.ContractId = this.contractId;
      this.activityModel.ContractName = this.activityReportForm.getRawValue()?.StorageOrder;
      this.activityModel.CustomerId = this.selectedCustomerId;

      let Fromdate =this.datePipe.transform(new Date(this.activityReportForm.getRawValue()?.FormFromDate),"yyyy-MM-dd'T'HH:mm:ss.ss'Z'");
      let Todate = this.datePipe.transform(new Date(this.activityReportForm.getRawValue()?.FormToDate), "yyyy-MM-dd") + "T00:00:00.00Z";
      this.activityModel.FromDate = Fromdate;
      this.activityModel.ToDate = Todate;
      this.reportservice
        .GetActivityReport(this.activityModel)
        .subscribe((result) => {
          this.download(result);
        },
        error => {
          this.toastr.error("Unable to generate report. Please contact administrator.");
        });
    }
  }

  public download(data: Blob) {
    const downloadedFile = new Blob([data], { type: data.type });
    const a = document.createElement('a');
    a.setAttribute('style', 'display:none;');
    document.body.appendChild(a);
    a.download = this.activityModel.ContractName.replace(/[.]/g, "").trim().concat('_').concat(this.todaysDate.toLocaleDateString().replace(/\//g, "").toString());
    a.href = URL.createObjectURL(downloadedFile);
    a.target = '_blank';
    a.click();
    document.body.removeChild(a);
  }

  // On Change of Time Range Dropdown selection
  public onTimeRangeSelected(event): void {
    switch (event.value) {
      case 1:
        {
          this.activityReportForm.patchValue({
            FormFromDate: new Date(
              this.todaysDate.getFullYear(),
              this.todaysDate.getMonth() - 1,
              1
            ),
            FormToDate: new Date(
              this.todaysDate.getFullYear(),
              this.todaysDate.getMonth(),
              0
            ),
          });
        }
        break;
      case 2:
        {
          this.activityReportForm.patchValue({
            FormFromDate: new Date(
              this.todaysDate.getFullYear(),
              this.todaysDate.getMonth(),
              1
            ),
            FormToDate: this.todaysDate,
          });
        }
        break;
      case 3:
        {
          this.activityReportForm.patchValue({
            FormFromDate: APP_CONSTANTS.null,
            FormToDate: APP_CONSTANTS.null,
          });
        }
        break;
    }
  }

  /** To filter and load Customer from API based on user input
   * @method filterOrg
   * @param val - Customer text entered by user
   */
  public filterCustomer(val: string): Observable<CustomerModel[]> {
    if (this.sharedService.CheckIfEmptyOrNull(val) != '' && val.length > 1) {
      this.isSearching = true;
      this.customerSearchVal = val;
      return this.customerService.GetCustomers(val);
    } else {
      this.noResults = false;
      if (
        (val == APP_CONSTANTS.null || val.length == 0) &&
        this.activityReportForm.controls['Organization'].dirty
      ) {
        this.selectedCustomerId = 0;
        this.orgList = [];
      }
      return of([]);
    }
  }

  public onCustomerBlur(event: any): void {

    var customer = this.orgList?.filter((m) => m.Name == event.target.value)[0]?.Name;
    if (this.sharedService.CheckIfEmptyOrNull(event.target.value) === '' || this.sharedService.CheckIfEmptyOrNull(customer) === '') {
      this.storageOrderList = [];
      this.activityReportForm.patchValue({
        StorageOrder: APP_CONSTANTS.emptyString,
        ContractType: APP_CONSTANTS.emptyString,
        FormFromDate: APP_CONSTANTS.emptyString,
        FormToDate: APP_CONSTANTS.emptyString,
        TimeRange: APP_CONSTANTS.defaultNumberValue
      });
      this.onDownloadButtonEnable();
    }
  }

  public onStorageOrderBlur(event: any): void {
    if (this.sharedService.CheckIfEmptyOrNull(event.target.value) === '') {
      this.activityReportForm.patchValue({
        StorageOrder: APP_CONSTANTS.emptyString,
        ContractType: APP_CONSTANTS.emptyString,
        FormFromDate: APP_CONSTANTS.emptyString,
        FormToDate: APP_CONSTANTS.emptyString,
        TimeRange: APP_CONSTANTS.defaultNumberValue
      });
      this.onDownloadButtonEnable();
    }
  }

  /** Raised event when user select or change selected Customer
   * @method onCustomerChanged
   * @param event - change event
   */
  public onCustomerChanged(event: any): void {
    this.activityReportForm.patchValue({
      Organization: event.option.value.Name,
    });
    this.selectedCustomerId = event.option.value.Id;
    this.SelectCustomerName = event.option.value.Name;
    this.getStorageOrderDetails(event.option.value.Id);
  }

  public onStorageOrderChanged(event: any): void {
    this.activityReportForm.patchValue({
      StorageOrder: event.option.value.Name,
      ContractType: event.option.value.ContractType,
    });
    this.contractId = event.option.value.Id;
    this.contractTypeId = event.option.value.ContractTypeId;
    if(event.option.value.ContractType.toLowerCase() === APP_CONSTANTS.contractTypeReserve.toLowerCase())
    {
      this.toastr.error(
        'Report for reserve contract type is not available currently.'
      );
    }
    this.onDownloadButtonEnable();
  }

  /** To load Customers on autocomplete (min 2 character required to enter)
   * @method loadCustomers
   */
  public loadCustomers(): void {
    const orgControl = this.activityReportForm.get('Organization');
    if (orgControl) {
      orgControl?.valueChanges
        .pipe(
          debounceTime(1000),
          tap(() => {
            this.orgList = [];
          }),
          switchMap((value) =>
            this.filterCustomer(value).pipe(
              finalize(() => {
                if (value.length > 1 && this.orgList.length === 0) {
                  this.selectedCustomerId = -1;
                  this.noResults = true;
                } else if (value.length == 0 && this.orgList.length === 0) {
                  this.selectedCustomerId = 0;
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
          } else {
            this.noResults = true;
          }
        });
    }
  }
  private getStorageOrderDetails(customerId: number) {
    if(this.storageOrderList.length === 0)
    {
      this.riderService.GetStorageOrderByCustomer(customerId).subscribe(
        (result) => {
          this.storageOrderList = result;
        },
        (error) => { }
      );
    }
  }
}
