import { Directive, ElementRef, HostListener, Input } from '@angular/core';
import { NgControl } from '@angular/forms';
import { APP_CONSTANTS } from 'src/app/app-constants';

@Directive({
  selector: 'input[ngCurrencyOnly]'
})
export class CurrencyOnlyDirective {

  @Input('max') max: any;
  @Input('min') min: any;
  @Input('step') step = '1';
  @Input('allowNegative') allowNegative : boolean=false;
  private selected = false;
  private selectedIncludesDot = false;
  constructor(public _el: ElementRef, private control: NgControl) {}

  @HostListener('blur', ['$event'])
  blur(e: any) {
    if (!isNaN(Number.parseFloat(e.target.value))) {
      this?.control?.control?.setValue(Number.parseFloat(e.target.value));
    } else  {
      let numericValue;
      if (this.allowNegative) {
        numericValue = e.target.value.replace(/[^\d\.-]*/g, '');
      }
      else {
        numericValue = e.target.value.replace(/[^\d\.]*/g, '');
      }
    let numberVal = parseFloat(numericValue);
     if (!isNaN(numberVal) && (numberVal === APP_CONSTANTS.defaultNumberValue || typeof numberVal === 'number')) {
      this?.control?.control?.setValue(Number.parseFloat(numberVal.toString()));
     } else {
      this.control?.control?.setValue(null);
     }
    }
  }

  @HostListener('keyup', ['$event'])
  onKeyUp(e: any) {
    // increase value on Arrow Up
    if (e.keyCode === 38) {
      if (e.target.value == '' || e.target.value == '-') {
        e.preventDefault();
        return;
      }
      if (!this.step.includes('.')) {
        this.control?.control?.setValue(
          Math.floor(Number.parseFloat(e.target.value)) + 1
        );
      } else {
        this.control?.control?.setValue(
          (
            Number.parseFloat(e.target.value) + Number.parseFloat(this.step)
          ).toFixed(2)
        );
      }
    }

    // decrease value on Arrow down
    if (e.keyCode === 40 && (Number.parseFloat(e.target.value) > 0|| this.allowNegative)) {
      if (e.target.value == '' || e.target.value == '-') {
        e.preventDefault();
        return;
      }
      if (!this.step.includes('.')) {
        this.control?.control?.setValue(
          Math.floor(Number.parseFloat(e.target.value)) - 1
        );
      } else {
        this.control?.control?.setValue(
          (
            Number.parseFloat(e.target.value) - Number.parseFloat(this.step)
          ).toFixed(2)
        );
      }
    }

    //Allow you to render the key value in the control if the control is empty and when user tried to enter minus from number pad in the fields which allow negative values
    if (e.keyCode === 109 && e.target.value === '' && this.allowNegative) {
      this.control?.control?.setValue(e.key);
    }

    if (
      this.max &&
      Number.parseFloat(e.target.value) > Number.parseFloat(this.max)
    ) {
      this.control?.control?.setValue(this.max);
    }
    if (e.target.value < this.min) {
      this.control?.control?.setValue(this.min);
    }

    // Allow 2 chars after dot '.'
    if (e.target.value.includes('.')) {
      const arr = e.target.value.split('.');
      if (arr[1] && arr[1].length > 2) {
        this.control?.control?.setValue(Math.trunc(e.target.value * 100) / 100);
      }
    }
  }
  @HostListener('keydown', ['$event'])
  onKeyDown(e: any) {
        // Allow only single minus '-'
    if (this.allowNegative && e.target.value.includes('-') && e.keyCode == 189) {
      e.preventDefault();
    }
    else if (!this.allowNegative && e.keyCode == 189) {
      e.preventDefault();
    }
    else if (e.target.value > 0 && e.keyCode == 189) {
      e.preventDefault();
    }
    const selectedString = e.target.value.substr(
      e.target.selectionStart,
      e.target.selectionEnd - e.target.selectionStart
    );
    if (selectedString) {
      this.selected = true;
      this.selectedIncludesDot = selectedString.includes('.');
    } else {
      this.selected = false;
    }

    // Allow only single dot '.'
    if (
      e.target.value.includes('.') &&
      e.keyCode === 190 &&
      !(this.selected && this.selectedIncludesDot)
    ) {
      e.preventDefault();
    }

    if (
      // Allow: Delete, Backspace, Tab, Escape, Enter
      [46, 8, 9, 27, 13].indexOf(e.keyCode) !== -1 ||
      (e.keyCode === 65 && e.ctrlKey === true) || // Allow: Ctrl+A
      (e.keyCode === 67 && e.ctrlKey === true) || // Allow: Ctrl+C
      (e.keyCode === 86 && e.ctrlKey === true) || // Allow: Ctrl+V
      (e.keyCode === 88 && e.ctrlKey === true) || // Allow: Ctrl+X
      (e.keyCode === 65 && e.metaKey === true) || // Cmd+A (Mac)
      (e.keyCode === 67 && e.metaKey === true) || // Cmd+C (Mac)
      (e.keyCode === 86 && e.metaKey === true) || // Cmd+V (Mac)
      (e.keyCode === 88 && e.metaKey === true) || // Cmd+X (Mac)
      (e.keyCode >= 35 && e.keyCode <= 40) // Home, End, Left, Right
    ) {
      return; // let it happen, don't do anything
    }
    // Ensure that it is a number and stop the keypress
    if (
      (e.shiftKey || (e.keyCode < 48 || e.keyCode > 57)) &&
      (e.keyCode < 96 || e.keyCode > 105) &&
      e.keyCode !== 190 && e.keyCode !== 110 && e.keyCode !== 189
    ) {
        e.preventDefault();
    }
  }

}
