import { APP_CONSTANTS } from './../app-constants';
import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';

@Component({
  selector: 'app-contracts',
  templateUrl: './contracts.component.html',
  styleUrls: ['./contracts.component.scss']
})
export class ContractsComponent implements OnInit {
  public contractSearchForm: FormGroup;
  public contractType = APP_CONSTANTS.dropdownData;
  public riderNumber = APP_CONSTANTS.dropdownData;
  public customerName = APP_CONSTANTS.dropdownData;
  public submitted = false;
  public myDateValue: Date;
  bsConfig = {
    containerClass:'theme-blue',
    dateInputFormat:'DD MMM YYYY'
  }
  constructor(public formBuilder: FormBuilder) { }

  ngOnInit(): void {
    this.myDateValue = new Date();
    this.initilizeRegForm();
  }
// Initilize Register form
public initilizeRegForm(): void {
  this.contractSearchForm = this.formBuilder.group({
    VendorName: [APP_CONSTANTS.emptyString, Validators.required],
    ContractType: [APP_CONSTANTS.emptyString, Validators.required],
    RiderNumber: [APP_CONSTANTS.emptyString, Validators.required],
    TotalCars: [APP_CONSTANTS.emptyString],
    SwitchIn: [APP_CONSTANTS.emptyString],
    CustomerName: [APP_CONSTANTS.emptyString],
    EffectiveDate: [APP_CONSTANTS.emptyString],
    TerminationDate: [APP_CONSTANTS.emptyString],
    TrackLength: [APP_CONSTANTS.emptyString],
    SwitchOut: [APP_CONSTANTS.false],
    ContractNumber: [APP_CONSTANTS.emptyString],
    AcceptLoadedCars: [APP_CONSTANTS.false],
    AcceptHAZMATCars: [APP_CONSTANTS.emptyString]
  });
}
  // convenience getter for easy access to form fields
  get contractsForm() { return this.contractSearchForm.controls; }

  public submitForm() {
  }
  onDateChange(newDate: Date) {
  }
}
