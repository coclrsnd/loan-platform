import { Injectable } from '@angular/core';
import { retry } from 'rxjs';
import { Observable } from 'rxjs';
import { catchError } from "rxjs/operators";
import { ApiService } from '../../services/api.service'
import { SecurityContext } from '../../shared/models/SecurityContext';
import { ContractTypeModel } from './ContractTypeModel';





@Injectable()
export class ContractTypeService {
 ContractTypeApiRoutePrefix: string = "api/ContractType";

  constructor(
    private apiContractTypeService: ApiService<ContractTypeModel>,
  ) { }



  GetContractTypeList(): Observable<ContractTypeModel[]> {
    let route: string = this.ContractTypeApiRoutePrefix.concat(`/GetContractTypeList`);
    return this.apiContractTypeService.get(route).pipe(
      retry(0),
      //catchError(this.handleError)
    )
  }

}
