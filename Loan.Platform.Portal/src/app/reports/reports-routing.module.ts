import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { AuthGuard } from '../shared/authgaurd/auth.guard';
import { AppPermissions } from '../shared/models/permissions';
import { ActivityReportComponent } from './activity-report/activity-report.component';
import { ReportsComponent } from './reports.component';
const appPermissions: AppPermissions = new AppPermissions();
const routes: Routes = [
  {
    path: '',
    canActivate:[AuthGuard],
    component: ActivityReportComponent,
    data :
    {
      title: 'Activity Report',
      parent: '',
      permission : appPermissions.Reports
    }
  },
  {
    path: 'activity-report',
    component: ActivityReportComponent,
    canActivate:[AuthGuard],
    data :
    {
      title: 'Activity Report',
      parent: '',
      permission : appPermissions.Reports
    }
  }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class ReportsRoutingModule { }
