import { MaterialModule } from './../material.module';
import { TranslateModule } from '@ngx-translate/core';
import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { ContractsRoutingModule } from './contracts-routing.module';
import { ContractsComponent } from './contracts.component';
import { SharedModule } from '../shared/shared.module';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { DatepickerModule, BsDatepickerModule } from 'ngx-bootstrap/datepicker';

@NgModule({
  declarations: [
    ContractsComponent
  ],
  imports: [
    CommonModule,
    ContractsRoutingModule,
    FormsModule,
    MaterialModule,
    ReactiveFormsModule,
    SharedModule,
    TranslateModule,
    BsDatepickerModule.forRoot(),
    DatepickerModule.forRoot()
  ]
})
export class ContractsModule { }
