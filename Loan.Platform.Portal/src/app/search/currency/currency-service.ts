import { Injectable } from '@angular/core';
import { retry } from 'rxjs';
import { Observable } from 'rxjs';
import { ApiService } from '../../services/api.service'
import { CurrencyModel } from '../currency/currency.model';





@Injectable()
export class CurrencyService {
  CurrencyApiRoutePrefix: string = "api/Currency";

  constructor(
    private apiCurrencyService: ApiService<CurrencyModel>,
  ) { }



  GetCurrencyList(): Observable<CurrencyModel[]> {
    let route: string = this.CurrencyApiRoutePrefix.concat(`/GetCurrencyList`);
    return this.apiCurrencyService.get(route).pipe(
      retry(0),
      //catchError(this.handleError)
    )
  }

}
