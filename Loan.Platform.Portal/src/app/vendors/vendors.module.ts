import { TranslateModule } from '@ngx-translate/core';
import { SharedModule } from './../shared/shared.module';
import { MaterialModule } from './../material.module';
import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { VendorsRoutingModule } from './vendors-routing.module';
import { VendorsComponent } from './vendors.component';


@NgModule({
  declarations: [
    VendorsComponent
  ],
  imports: [
    CommonModule,
    VendorsRoutingModule,
    MaterialModule,
    SharedModule,
    TranslateModule
  ]
})
export class VendorsModule { }
