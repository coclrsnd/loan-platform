import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { ReportsRoutingModule } from './reports-routing.module';
import { ReportsComponent } from './reports.component';
import { SharedModule } from '../shared/shared.module';
import { ActivityReportComponent } from './activity-report/activity-report.component';
import { TranslateModule } from '@ngx-translate/core';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { MaterialModule } from '../material.module';
import { MatTooltipModule } from '@angular/material/tooltip';

@NgModule({
  declarations: [
    ReportsComponent,
    ActivityReportComponent
  ],
  imports: [
    CommonModule,
    ReportsRoutingModule,
    SharedModule,
    CommonModule,
    TranslateModule,
    FormsModule,
    ReactiveFormsModule,
    MaterialModule,
    MatTooltipModule
  ]
})
export class ReportsModule { }
