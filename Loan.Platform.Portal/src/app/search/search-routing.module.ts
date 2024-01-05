import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { AuthGuard } from '../shared/authgaurd/auth.guard';
import { AppPermissions } from '../shared/models/permissions';
import { CustomerDetailsComponent } from './customer-details/customer-details.component';
import { CustomerComponent } from './customer/customer.component';
import { RailCarComponent } from './rail-car/rail-car.component';
import { RiderDetailsComponent } from './rider-details/rider-details.component';
import { RiderComponent } from './rider/rider.component';
import { SearchComponent } from './search.component';
import { UsersComponent } from './users/users.component';
import { VendorDetailsComponent } from './vendor-details/vendor-details.component';
import { VendorComponent } from './vendor/vendor.component';
const appPermissions: AppPermissions = new AppPermissions();
const routes: Routes = [
  { 
    path: '', 
    component: SearchComponent,
    canActivate:[AuthGuard], 
    data : { 
      title: 'Facility Map', 
      parent: 'Search', 
      permission : appPermissions.SearchFacility
    } 
  },
  { 
    path: 'facility', 
    component: SearchComponent, 
    canActivate:[AuthGuard],
    data : { 
      title: 'Facility Map', 
      parent: 'Search',
      permission : appPermissions.SearchFacility
    } 
  },
  { 
    path: 'rider', 
    component: RiderComponent, 
    canActivate:[AuthGuard],
    data : 
    { 
      title: 'Storage Order', 
      parent: 'Search',
      permission : appPermissions.StorageOrder
    } 
  },
  { 
    path: 'rider/rider-details/:mode', 
    component: RiderDetailsComponent, 
    canActivate:[AuthGuard],
    data : 
    { 
      title: 'Storage Order', 
      parent: 'Search',
      permission : appPermissions.StorageOrder
    }
  },
  { 
    path: 'rider/rider-details/:mode/:id', 
    component: RiderDetailsComponent, 
    canActivate:[AuthGuard],
    data : 
    { 
      title: 'Storage Order', 
      parent: 'Search',
      permission : appPermissions.StorageOrder
    }
  },
  { 
    path: 'vendor', 
    component: VendorComponent, 
    canActivate:[AuthGuard],
    data : 
    { 
      title: 'Vendor', 
      parent: 'Search',
      permission : appPermissions.Vendor
    } 
  },
  { 
    path: 'vendor/vendor-details/:mode/:id', 
    component: VendorDetailsComponent, 
    canActivate:[AuthGuard],
    data : 
    { 
      title: 'Vendor Details', 
      parent: 'Search',
      permission : true//appPermissions.Vendor
    }
  },
  { 
    path: 'customer', 
    component: CustomerComponent, 
    canActivate:[AuthGuard],
    data : 
    { 
      title: 'Customer', 
      parent: 'Search',
      permission : appPermissions.Customer
    } 
  },
  { 
    path: 'customer/customer-details/:mode/:id', 
    component: CustomerDetailsComponent,
    canActivate:[AuthGuard], 
    data : 
    { 
      title: 'Customer Details', 
      parent: 'Search',
      permission : true//appPermissions.Customer
    } 
  },
  { 
    path: 'railcar', 
    component: RailCarComponent, 
    canActivate:[AuthGuard],
    data : 
    { 
      title: 'Railcar', 
      parent: 'Search',
      permission : appPermissions.RailCars
    } 
  },
  { 
    path: 'users', 
    component: UsersComponent, 
    canActivate:[AuthGuard],
    data : 
    { 
      title: 'Users', 
      parent: 'Search',
      permission : appPermissions.Users
    } 
  },
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class SearchRoutingModule { }
