import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { AuthGuard } from '../shared/authgaurd/auth.guard';
import { AppPermissions } from '../shared/models/permissions';
import { CustomerComponent } from './customer/customer.component';
import { VendorComponent } from './vendor/vendor.component';
const appPermissions: AppPermissions = new AppPermissions();
const routes: Routes = [
  {
    path: '',
    component: CustomerComponent,
    canActivate:[AuthGuard],
    data :
    {
      title: 'Customer',
      parent: 'Onboard',
      permission : appPermissions.OnboardCustomer
    }
  },
  {
    path: 'customer/:mode',
    component: CustomerComponent,
    canActivate:[AuthGuard],
    data :
    {
      title: 'Customer',
      parent: 'Onboard',
      permission : appPermissions.OnboardCustomer
    }
  },
  {
    path: 'vendor/:mode',
    component: VendorComponent,
    canActivate:[AuthGuard],
    data :
    {
      title: 'Vendor',
      parent: 'Onboard',
      permission : appPermissions.OnboardVendor
    }
  }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class OnBoardRoutingModule { }
