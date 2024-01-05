import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { TranslateModule } from '@ngx-translate/core';
import { OnBoardRoutingModule } from './on-board-routing.module';
import { OnBoardComponent } from './on-board.component';
import { CustomerComponent } from './customer/customer.component';
import { VendorComponent } from './vendor/vendor.component';
import { BsDatepickerModule, DatepickerModule } from 'ngx-bootstrap/datepicker';
import { BsDropdownModule } from 'ngx-bootstrap/dropdown';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { SharedModule } from '../shared/shared.module';
import { MaterialModule } from '../material.module';


@NgModule({
  declarations: [
    OnBoardComponent,
    CustomerComponent,
    VendorComponent
  ],
  imports: [
    CommonModule,
    OnBoardRoutingModule,
    TranslateModule,
    FormsModule,
    ReactiveFormsModule,
    MaterialModule,
    SharedModule,
    BsDatepickerModule.forRoot(),
    DatepickerModule.forRoot(),
    BsDropdownModule.forRoot()
  ]
})
export class OnBoardModule { }
