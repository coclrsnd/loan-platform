import { Component, OnInit } from '@angular/core';
import { APP_CONSTANTS } from 'src/app/app-constants';

@Component({
  selector: 'app-customer',
  templateUrl: './customer.component.html',
  styleUrls: ['./customer.component.scss']
})
export class CustomerComponent implements OnInit {
  public isFromPage: string = APP_CONSTANTS.onboardCustomer;
  constructor() { }
  ngOnInit(): void {
  }
}
