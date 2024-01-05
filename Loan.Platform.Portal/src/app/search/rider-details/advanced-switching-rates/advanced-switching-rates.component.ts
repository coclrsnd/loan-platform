import { Component, Input, EventEmitter, Output, OnChanges } from '@angular/core';
import { FormGroup, Validators } from '@angular/forms';
import { CurrencyPipe } from '@angular/common';
import { APP_CONSTANTS } from 'src/app/app-constants';

@Component({
  selector: 'app-advanced-switching-rates',
  templateUrl: './advanced-switching-rates.component.html',
  styleUrls: ['./advanced-switching-rates.component.scss']
})
export class AdvancedSwitchingRatesComponent implements OnChanges {
  @Input() AdvancedSwitchingRate: FormGroup;
  @Input() currentUserRole: string;
  @Output() AdvancedHazmatSwitchingEnabled = new EventEmitter<any>();
  @Output() AdvancedLoadedSwitchingEnabled = new EventEmitter<any>();
  @Input() isDetailsSubmitted: boolean;
  @Input() mode: any;

  constructor(
    private currencyPipe: CurrencyPipe
    ) { }

  public isAdvancedHazmatSwitchingEnabled: boolean = false;
  public isAdvancedLoadedSwitchingEnabled: boolean = false;

  ngOnChanges(): void {
   this.disableHazmatFields();
   this.disableLoadedFields();
   if (this.currentUserRole === APP_CONSTANTS.SuperAdmin ||  this.currentUserRole === APP_CONSTANTS.Admin ||
    (this.currentUserRole === APP_CONSTANTS.Vendor && this.mode === APP_CONSTANTS.create)) {
      this.setHazmatSwitchingRates(this.AdvancedSwitchingRate.get('IsAdvancedHazmatSwitchingEnabled')?.value);
      this.setLoadedSwitchingRates(this.AdvancedSwitchingRate.get('IsAdvancedLoadedSwitchingEnabled')?.value);
   }
  }

    /** On check-uncheck of Advanced Hazmat Switching
   * @method onAdvancedHazmatSwitchingChanged
   * @param hazmatCheckboxEvent - click event on checkbox
   */
     public onAdvancedHazmatSwitchingChanged(hazmatCheckboxEvent: any) {
      this.setHazmatSwitchingRates(hazmatCheckboxEvent.checked);
    }

  /** On check-uncheck of Advanced Loaded Switching
   * @method onAdvancedLoadedSwitchingChanged
   * @param loadedCheckboxEvent - click event on checkbox
   */
      public onAdvancedLoadedSwitchingChanged(loadedCheckboxEvent: any) {
        this.setLoadedSwitchingRates(loadedCheckboxEvent.checked);
    }

    private setHazmatSwitchingRates(isHazmatSwitchingRatesEnabled:boolean): void {
      if(isHazmatSwitchingRatesEnabled) {
        this.isAdvancedHazmatSwitchingEnabled = true;
        this.setValidations(this.AdvancedSwitchingRate,['HazmatSwitchIn','HazmatSwitchOut']);
        this.enableHazmatFields();
      }
      else {
        this.isAdvancedHazmatSwitchingEnabled = false;
        this.resetValidations(this.AdvancedSwitchingRate,['HazmatSwitchIn','HazmatSwitchOut']);
        this.disableHazmatFields();
      }

      this.AdvancedHazmatSwitchingEnabled.emit(this.isAdvancedHazmatSwitchingEnabled);
    }

    private setLoadedSwitchingRates(isLoadedSwitchingEnabled:boolean): void {
      if(isLoadedSwitchingEnabled) {
        this.isAdvancedLoadedSwitchingEnabled = true;
        this.setValidations(this.AdvancedSwitchingRate,['LoadedSwitchIn','LoadedSwitchOut']);
        this.enableLoadedFields();
      }
      else {
        this.isAdvancedLoadedSwitchingEnabled = false;
        this.resetValidations(this.AdvancedSwitchingRate,['LoadedSwitchIn','LoadedSwitchOut']);
        this.disableLoadedFields();
      }
      this.AdvancedLoadedSwitchingEnabled.emit(this.isAdvancedLoadedSwitchingEnabled);
    }

    private disableHazmatFields(): void {
      this.AdvancedSwitchingRate.get('HazmatSwitchIn')?.disable();
      this.AdvancedSwitchingRate.get('HazmatSwitchOut')?.disable();
    }

    private disableLoadedFields(): void {
      this.AdvancedSwitchingRate.get('LoadedSwitchIn')?.disable();
      this.AdvancedSwitchingRate.get('LoadedSwitchOut')?.disable();
    }

    private enableHazmatFields(): void {
        this.AdvancedSwitchingRate.get('HazmatSwitchIn')?.enable();
        this.AdvancedSwitchingRate.get('HazmatSwitchOut')?.enable();
      }

    private enableLoadedFields(): void {
      this.AdvancedSwitchingRate.get('LoadedSwitchIn')?.enable();
      this.AdvancedSwitchingRate.get('LoadedSwitchOut')?.enable();
    }

    public setValidations(formControl:any, formFields:any): void {
      formFields.forEach((key) => {
        formControl.get(key)?.setValidators(Validators.required);
        formControl.get(key)?.updateValueAndValidity();
      });
    }

    public resetValidations(formControl:any, formFields:any): void {
      formFields.forEach((key) => {
        formControl.get(key)?.setValidators(null);
        formControl.get(key)?.updateValueAndValidity();
        formControl.get(key)?.patchValue(null);
      });
    }

    public onBlurAmount(element) {
      const formattedAmount = this.currencyPipe.transform(element.target.value, 'USD');
      element.target.value = formattedAmount;
    }

   public onFocusNumber(element): void {
      const updateValue = element.target.value.replace(/[^0-9\.]+/g, '');
      element.target.value = updateValue;
    }
}
