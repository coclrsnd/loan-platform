import { Injectable } from '@angular/core';
import { retry } from 'rxjs';
import { Observable } from 'rxjs';
import { ApiService } from '../../services/api.service'
import { VendorFilterModel } from './vendor-filter.model';
import { VendorModel } from './VendorModel';

@Injectable()
export class VendorService {
  VendorApiRoutePrefix: string = "api/Vendor";

  constructor(
    private apiVendorService: ApiService<VendorModel>,
    private apiVendorFilterService: ApiService<VendorFilterModel>
  ) { }



  GetVendorList(searchText: string): Observable<VendorModel[]> {
    let route: string = this.VendorApiRoutePrefix.concat(`/GetVendorList/`);
    return this.apiVendorService.get(route + searchText).pipe(
      retry(0),
      //catchError(this.handleError)
    )
  }

   // Get requested ID's Vendor detail.
  GetVendorDetails(vendorId :number): Observable<VendorModel> {
    let route: string = this.VendorApiRoutePrefix.concat(`/GetVendorDetails/${vendorId}`);
    return this.apiVendorService.getSingleObjectById(route).pipe(
      retry(0),
      //catchError(this.handleError)
    )
  }

   // Save Vendor detail
  SaveVendorDetails(model: VendorModel): Observable<VendorModel> {
    let route: string = this.VendorApiRoutePrefix.concat(`/SaveVendor`);
    return this.apiVendorService.post(route,model).pipe(
      retry(0),
      //catchError(this.handleError)
    )
  }

    // Get vendor list after applying search filter
    GetVendorsOnFilter(filtermodel:VendorFilterModel): Observable<any> {
      let route: string = this.VendorApiRoutePrefix.concat(`/GetVendorsOnFilter`);
      return this.apiVendorFilterService.post(route,filtermodel).pipe(
        retry(0),
        //catchError(this.handleError)
      )
    }

  GetVendorListForAutoComplete(searchText: string): Observable<VendorModel[]> {
    let route: string = this.VendorApiRoutePrefix.concat(`/GetVendorListForAutoComplete/`);
    return this.apiVendorService.get(route + searchText).pipe(
      retry(0),
      //catchError(this.handleError)
    )
  }

  GetVendorForUserId(userId: number): Observable<VendorModel> {
    let route: string = this.VendorApiRoutePrefix.concat(`/GetVendorForUser/${userId}`);
    return this.apiVendorService.getEntity(route).pipe(
      retry(0),
      //catchError(this.handleError)
    )
  }

  GetPercentageMarginForVendor(storageOrderId: number, vendorId: number): Observable<VendorModel> {
    let route: string = this.VendorApiRoutePrefix.concat(`/GetPercentageMarginForVendor/${storageOrderId}/${vendorId}`);
    return this.apiVendorService.getEntity(route).pipe(
      retry(0),
      //catchError(this.handleError)
    )
  }
  
}
