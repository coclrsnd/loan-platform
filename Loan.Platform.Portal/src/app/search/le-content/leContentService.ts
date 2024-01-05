import { Injectable } from '@angular/core';
import { retry } from 'rxjs';
import { Observable } from 'rxjs';
import { catchError } from "rxjs/operators";
import { ApiService } from '../../services/api.service'
import { SecurityContext } from '../../shared/models/SecurityContext';
import { leContentModel } from './leContentModel';




@Injectable()
export class LEContentService {
  LEContentApiRoutePrefix: string = "api/LEContent";

  constructor(
    private apiLEContentService: ApiService<leContentModel>,
  ) { }



  GetLEContentList(): Observable<leContentModel[]> {
    let route: string = this.LEContentApiRoutePrefix.concat(`/GetLEContentList`);
    return this.apiLEContentService.get(route).pipe(
      retry(0),
      //catchError(this.handleError)
    )
  }

}
