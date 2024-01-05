import { Injectable } from '@angular/core';
import { retry } from 'rxjs';
import { Observable } from 'rxjs';
import { catchError } from "rxjs/operators";
import { ApiService } from '../../../services/api.service';
import { railCarModel } from './railCarModel';


@Injectable()
export class RailCarService {
  RailCarApiRoutePrefix: string = "api/RailCar";

  constructor(
    private apiRailCarService: ApiService<railCarModel>,
  ) { }


  SaveRailCarDetailsForStorageOrder(model: railCarModel): Observable<railCarModel> {
    let route: string = this.RailCarApiRoutePrefix.concat(`/SaveRailCarDetailsForStorageOrder`);
    return this.apiRailCarService.post(route, model).pipe(
      retry(0),
      //catchError(this.handleError)
    )
  }

  GetRailCarDetailsByContractId(contractId: number): Observable<railCarModel[]> {
    let route: string = this.RailCarApiRoutePrefix.concat(`/GetRailCarDetailsByContractId/${contractId}`);
    return this.apiRailCarService.getById(route).pipe(
      retry(0),
      //catchError(this.handleError)
    )
  }

  GetRailCarDetails(model: railCarModel): Observable<any> {
    let route: string = this.RailCarApiRoutePrefix.concat(`/GetRailCarDetails`);
    return this.apiRailCarService.getDataWithPost(route, model).pipe(
      retry(0),
      //catchError(this.handleError)
    )
  }

  UpdateRailCarDetailsForStorageOrder(model: railCarModel): Observable<railCarModel> {
    let route: string = this.RailCarApiRoutePrefix.concat(`/UpdateRailCarDetailsForStorageOrder`);
    return this.apiRailCarService.post(route, model).pipe(
      retry(0),
      //catchError(this.handleError)
    )
  }



}
