import { Component, Input, OnInit, SimpleChanges, OnChanges, Output, EventEmitter, ChangeDetectorRef } from '@angular/core';
import { FormGroup } from '@angular/forms';
import { APP_CONSTANTS } from 'src/app/app-constants';
import { SharedService } from '../../shared.service';
import { ToastrService } from 'ngx-toastr';

@Component({
  selector: 'app-rates-list',
  templateUrl: './rates-list.component.html',
  styleUrls: ['./rates-list.component.scss']
})
export class RatesListComponent implements OnInit, OnChanges {
  @Input() storageFacilityDetailsForm: any;
  @Input() getRatesForm: FormGroup;
  @Input() currentIndex: number;
  @Input() configuration: any;
  @Input() isSetRatesProcessOngoing;
  @Output() removeRates: EventEmitter<any> = new EventEmitter<boolean>();
  // @Input() isLastAllowed: boolean;
  isLastAllowed = true;
  @Output() setRates: EventEmitter<any> = new EventEmitter();
  @Output() isSetRatesProcess: EventEmitter<any> = new EventEmitter();
  innerDisplayedColumns = ['expand','Rates', 'EffectiveDate', 'ExpiryDate', 'AddRate'];
  innerExpandedElements: any[] = [];
  dataSourceInner: any;
  // dataSourceInner = APP_CONSTANTS.singleRateRecord;
  public ratesDetailsForm: FormGroup;
  public showSetRateButton: boolean = true;
  public showAddedRow: boolean = false;
  public isSaveRateBtnEnabled: boolean = false;
  public parentComponentName: string = APP_CONSTANTS.RatesListComponent;
  public defaultDateTimeFormat = APP_CONSTANTS.DefaultDateTimeFormat;

  constructor(public cd: ChangeDetectorRef, private sharedService:SharedService,  private toastr: ToastrService,) { }

  ngOnInit(): void {
    this.getRatesForm.value.forEach(data => {
      data.EffectiveDate=this.sharedService.ConvertToFormatedDate(data.FormEffectiveDate);
      data.ExpiryDate=this.sharedService.ConvertToFormatedDate(data.FormExpiryDate);
    });
    const ratesDetails = this.getRatesForm;
    this.dataSourceInner = this.isLastAllowed || ratesDetails.value.length === 1 ? ratesDetails.value : ratesDetails.value.slice(0,-1);
  }

  ngOnChanges(changes: SimpleChanges): void {
    this.getRatesForm.value.forEach(data => {
      data.EffectiveDate=this.sharedService.ConvertToFormatedDate(data.FormEffectiveDate);
      data.ExpiryDate=this.sharedService.ConvertToFormatedDate(data.FormExpiryDate);
    });
    const ratesDetails = this.getRatesForm;
    this.dataSourceInner = this.isLastAllowed || ratesDetails.value.length === 1 ? ratesDetails.value : ratesDetails.value.slice(0,-1);
  }

  /** Event to trigger when Rates are toggled
 * @method toggleRates
 * @param rates - current toggled rate
 */
  public toggleRates(rates: any): void {
    rates.updateButton = false;
    const index = this.innerExpandedElements.findIndex((x) => x === rates);
    if (index === -1) {
      rates.isExpanded = true;
      this.innerExpandedElements.push(rates);
    } else {
      rates.isExpanded = false;
      this.innerExpandedElements.splice(index, 1);
    }
  }

    /** Event to trigger when Rate is edited
 * @method onEditRates
 * @param rates - current selected rate to edit
 */
  public onEditRates(rates: any): void {
    if (!rates.isExpanded) {
      const index = this.innerExpandedElements.findIndex((x) => x === rates);
      rates.isExpanded = true;
      rates.updateButton = true;
      this.innerExpandedElements.push(rates);
    } else if (this.innerExpandedElements.length) {
      rates.updateButton = true;
    }
  }


    /** Event to trigger when new Rate is added
 * @method onSetRates
 */
  public onSetRates(): void {
     if (this.storageFacilityDetailsForm.status === "VALID") {
    this.setRates.emit(this.dataSourceInner);
    this.isSetRatesProcessOngoing = true;
    this.isSetRatesProcess.emit(this.isSetRatesProcessOngoing);
     }    
  }

  /** Event to trigger when Rate is saved
 * @method onSaveRates
 * @param event - true or false value to set rate
 * @param element - current rate to toggle.
 */
  public onSaveRates(event: boolean, element): void {
  this.toggleRates(element);
  }


   /** Event to trigger when Rate is removed
 * @method onRemoveRates
 * @param index - index for removing rate
 */
  public onRemoveRates(index): void {
    this.removeRates.emit(index);
  }


   /** Event to track if adding rate process is currently active
 * @method OnSetRatesProcessOpen
 * @param event - true or false for process status
 */
  public OnSetRatesProcessOpen(event: boolean): void {
    this.isSetRatesProcessOngoing = false;
    this.isSetRatesProcess.emit(this.isSetRatesProcessOngoing);
  }

}
