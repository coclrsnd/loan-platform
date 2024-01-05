import { TranslateModule } from '@ngx-translate/core';
import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { RailCarRoutingModule } from './rail-car-routing.module';
import { RailCarComponent } from './rail-car.component';
import { MaterialModule } from '../material.module';
import { SharedModule } from '../shared/shared.module';


@NgModule({
  declarations: [
    RailCarComponent
  ],
  imports: [
    CommonModule,
    RailCarRoutingModule,
    MaterialModule,
    SharedModule,
    TranslateModule
  ]
})
export class RailCarModule { }
