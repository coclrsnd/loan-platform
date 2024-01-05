import { Injectable } from '@angular/core';
import { retry } from 'rxjs';
import { Observable } from 'rxjs';
import { ApiService } from '../../services/api.service';
import { StorageFacilityModel } from './StorageFacilityModel';

@Injectable()
export class StorageFacilityService {
  StorageFacilityApiRoutePrefix: string = "api/StorageFacility";

  constructor(
    private apiStorageFacilityService: ApiService<StorageFacilityModel>,
  ) { }


 // Get requested Vendor ID's storage facility detail.
  getStorageFacilitiesByVendorId(vendorId:number): Observable<StorageFacilityModel[]> {
    let route: string = this.StorageFacilityApiRoutePrefix.concat(`/GetStorageFacilitiesByVendorId/${vendorId}`);
    return this.apiStorageFacilityService.get(route).pipe(
      retry(0),
      //catchError(this.handleError)
    )
  }

  // Get Storage Fcility detail for requested organization/vendor ID
  GetStorageFacilities(orgId:number): Observable<StorageFacilityModel[]> {
    let route: string = this.StorageFacilityApiRoutePrefix.concat(`/GetStorageFacilities/${orgId}`);
    return this.apiStorageFacilityService.get(route).pipe(
      retry(0),
      //catchError(this.handleError)
    )
  }
}
