import { Injectable } from '@angular/core';
import { retry } from 'rxjs';
import { Observable } from 'rxjs';
import { catchError } from "rxjs/operators";
import { ApiService } from '../../services/api.service'
import { SecurityContext } from '../../shared/models/SecurityContext';
import { railCarTypeModel } from './railCarTypeModel';




@Injectable()
export class RailCarTypeService {
  RailCarTypeApiRoutePrefix: string = "api/RailCarType";

  constructor(
    private apiRailCarTypeService: ApiService<railCarTypeModel>,
  ) { }



  GetRailCarTypeList(): Observable<railCarTypeModel[]> {
    let route: string = this.RailCarTypeApiRoutePrefix.concat(`/GetRailCarTypeList`);
    return this.apiRailCarTypeService.get(route).pipe(
      retry(0),
      //catchError(this.handleError)
    )
  }

}
