import { Component, OnInit } from '@angular/core';
import { APP_CONSTANTS } from 'src/app/app-constants';

@Component({
  selector: 'app-customer-details',
  templateUrl: './customer-details.component.html',
  styleUrls: ['./customer-details.component.scss']
})
export class CustomerDetailsComponent implements OnInit {
  public isFromPage: string = APP_CONSTANTS.searchCustomerDetails;
  constructor() { }

  ngOnInit(): void {
  }

}
