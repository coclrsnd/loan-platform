import { Injectable } from '@angular/core';
import { retry } from 'rxjs';
import { Observable } from 'rxjs';
import { ApiService } from '../../services/api.service';
import { CustomerFilterModel } from './customer-filter.model';
import { CustomerModel } from './CustomerModel';
@Injectable()
export class CustomerService {
  CustomerApiRoutePrefix: string = "api/Customer";

  constructor(
    private apiCustomerService: ApiService<CustomerModel>,
    private apiCustomerFilterService: ApiService<CustomerFilterModel>
  ) { }


  // To get customers list
  GetCustomerList(): Observable<CustomerModel[]> {
    let route: string = this.CustomerApiRoutePrefix.concat(`/GetCustomerList`);
    return this.apiCustomerService.get(route).pipe(
      retry(0),
      //catchError(this.handleError)
    )
  }

  GetCustomers(searchText: string): Observable<CustomerModel[]> {
    let route: string = this.CustomerApiRoutePrefix.concat(`/GetCustomers/`);
    return this.apiCustomerService.get(route + searchText).pipe(
      retry(0),
      //catchError(this.handleError)
    )
  }

  // To save new customer detail
  OnBoardNewCustomer(model: CustomerModel): Observable<any> {
    let route: string = this.CustomerApiRoutePrefix.concat(`/OnBoardCustomer`);
    return this.apiCustomerService.post(route, model).pipe(
      retry(0),
      //catchError(this.handleError)
    )
  }

  // Get customer list after applying search filter
  GetCustomersListOnSearch(filtermodel:CustomerFilterModel): Observable<any> {
    let route: string = this.CustomerApiRoutePrefix.concat(`/GetCustomerListOnFilter`);
    return this.apiCustomerFilterService.post(route,filtermodel).pipe(
      retry(0),
      //catchError(this.handleError)
    )
  }

  // Get Customer by ID to view or edit
  GetCustomerByID(id:number): Observable<CustomerModel[]> {
    let route: string = this.CustomerApiRoutePrefix.concat(`/GetCustomerByID`);
    return this.apiCustomerService.get(route+'/'+id).pipe(
      retry(0)
    )
  }

  // Update customer detail
  UpdateCustomer(model: CustomerModel): Observable<any> {
    let route: string = this.CustomerApiRoutePrefix.concat(`/UpdateCustomer`);
    return this.apiCustomerService.put(route, model).pipe(
      retry(0)
    )
  }

  GetCustomerForUserId(userId: number): Observable<CustomerModel> {
    let route: string = this.CustomerApiRoutePrefix.concat(`/GetCustomerForUser/${userId}`);
    return this.apiCustomerService.getEntity(route).pipe(
      retry(0),
      //catchError(this.handleError)
    )
  }

  GetPercentageMarginForCustomer(storageOrderId: number, customerId: number): Observable<CustomerModel> {
    let route: string = this.CustomerApiRoutePrefix.concat(`/GetPercentageMarginForCustomer/${storageOrderId}/${customerId}`);
    return this.apiCustomerService.getEntity(route).pipe(
      retry(0),
      //catchError(this.handleError)
    )
  }

}
