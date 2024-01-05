import { CurrencyPipe, PercentPipe } from '@angular/common';
import {
  Component,
  EventEmitter,
  Output,
  Input,
  OnInit,
  AfterViewInit,
} from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { elementAt } from 'rxjs-compat/operator/elementAt';
import { APP_CONSTANTS } from 'src/app/app-constants';
import { CurrencyModel } from '../../../search/currency/currency.model';
import { SharedService } from '../../shared.service';
import { ConfirmDialogService } from '../confirm-dialog/confirm-dialog.service';

@Component({
  selector: 'app-rates-form',
  templateUrl: './rates-form.component.html',
  styleUrls: ['./rates-form.component.scss'],
})
export class RatesFormComponent implements OnInit, AfterViewInit {
  @Output() saveRates: EventEmitter<any> = new EventEmitter<boolean>();
  @Output() isSetRatesProcessOpen: EventEmitter<any> =
    new EventEmitter<boolean>();
  @Output() removeRates: EventEmitter<any> = new EventEmitter<boolean>();
  @Input() getRatesForm: FormGroup;
  @Input() currentIndex: number;
  @Input() isSaveRateBtnEnabled: boolean;
  @Input() isUpdateRateBtnEnabled: boolean;
  @Input() parentComponentName: string;
  @Input() allRatesList: FormGroup;
  public ratesDetailsForm: FormGroup;
  public submittedRatesDetails: boolean = false;
  public effDateValue: Date = new Date();
  public expDateValue: Date = new Date();
  public CurrencyList: CurrencyModel[] = [];
  public isViewInitilized: boolean = false;
  public convertToCurrency = [
    'DailyStorageRate',
    'SwitchIn',
    'SwitchOut',
    'SwitchingRate',
    'SpecialSwitchingRate',
    'HazmatSwitchInRate',
    'HazmatSwitchOutRate',
    'LoadedSwitchInRate',
    'LoadedSwitchOutRate',
    'CherryPickingRate',
    'ReservationRate',
  ];
  //public isValidRateDetail: boolean = true;
  public existingRatesList: any;
  defaultValueForDropdownlist: string = APP_CONSTANTS.emptyString;
  constructor(
    public formBuilder: FormBuilder,
    private currencyPipe: CurrencyPipe,
    private percentPipe: PercentPipe,
    private sharedService :SharedService
  ) {}

  ngOnInit(): void {
    // setTimeout(() => {
    //   this.loadMasterData()
    //   }, 500);
    this.loadMasterData();
    this.existingRatesList = Object.assign({}, this.allRatesList);
    }

  ngAfterViewInit(): void {
    this.convertToCurrency.forEach((key) => {
      if (
        (this.getRatesForm.get(key)?.value ||
          this.getRatesForm.get(key)?.value === 0) &&
        this.getRatesForm.get(key)?.value !== APP_CONSTANTS.null
      ) {
        if (typeof this.getRatesForm.get(key)?.value === 'number') {
          const formattedAmount = this.currencyPipe.transform(
            this.getRatesForm.get(key)?.value,
            'USD'
          );
          this.getRatesForm.get(key)?.patchValue(formattedAmount);
        }
      }
    });
  }

  private loadMasterData(): void{
      this.sharedService.getCurrencyList().subscribe((response)=>{
      this.CurrencyList=response;
    });
  }

  // convenience getter for easy access to form fields
  get ratesDetails() {
    return this.getRatesForm.controls;
  }

  /** Event of submission of Rates Form
   * @method onSubmitRatesForm
   */
  public onSubmitRatesForm(): void {
    // Logic to be enabled after development
    this.submittedRatesDetails = true;
    this.checkIfValidRateDetail();

    // stop here if form is invalid
    if (this.getRatesForm.invalid) {
      return;
    }

    this.saveRates.emit(true);
    this.isSetRatesProcessOpen.emit(false);
  }

  public OnRateDateSelection(){
    this.checkIfValidRateDetail();

  }

  /** Check if newly added rates detail is correct or not
 * @method checkIfValidRateDetail
 */
  private checkIfValidRateDetail(): void {
    //this.isValidRateDetail = true;
    for(let i=0;i<this.existingRatesList.value.length;i++){
      let element=this.existingRatesList.value[i];

        let selectedEffectiveDate=new Date(this.getRatesForm.value.FormEffectiveDate).setHours(0,0,0,0);
        let selectedExpirtyDate=new Date(this.getRatesForm.value.FormExpiryDate).setHours(0,0,0,0);
        let currentRecordEffectiveDate=new Date(element.FormEffectiveDate).setHours(0,0,0,0);
        let currentRecordExpiryDate=new Date(element.FormExpiryDate).setHours(0,0,0,0);
        if(this.currentIndex == i &&
          currentRecordEffectiveDate === selectedEffectiveDate &&
          currentRecordExpiryDate === selectedExpirtyDate){
            this.getRatesForm.setErrors(null);
        }
        else if (this.currentIndex != i && (
          (currentRecordEffectiveDate <= selectedEffectiveDate &&
          currentRecordExpiryDate >= selectedEffectiveDate)
            ||
          (currentRecordEffectiveDate <= selectedExpirtyDate &&
            currentRecordExpiryDate >= selectedExpirtyDate)
            ||
          (selectedEffectiveDate <= currentRecordEffectiveDate &&
          selectedExpirtyDate >= currentRecordExpiryDate)
          )) {
          //this.isValidRateDetail = false;
          this.getRatesForm.controls['FormExpiryDate'].setErrors({
            'notUnique': true
          });
          break;

        }
        else {
          this.getRatesForm.controls['FormExpiryDate'].setErrors(null);
        }
    }
  }

  /** Event to trigger when Rates form is updated
   * @method onUpdateRatesForm
   */
  public onUpdateRatesForm(): void {
    this.checkIfValidRateDetail();
    if (this.getRatesForm.invalid) {
      return;
    }
    this.saveRates.emit(true);
    this.isSetRatesProcessOpen.emit(false);
  }

  /** Event to trigger when Rates form is removed by using index
   * @method onRemove
   */
  public onRemove(): void {
    this.removeRates.emit(this.currentIndex);
  }

  public onFocusNumber(element): void {
    // Correct Implementation
    const updateValue = element.target.value.replace(/[^0-9\.]+/g, '');
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
}
