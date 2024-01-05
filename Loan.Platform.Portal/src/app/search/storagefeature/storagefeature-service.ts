import { Injectable } from '@angular/core';
import { of, retry } from 'rxjs';
import { Observable } from 'rxjs';
import { ApiService } from '../../services/api.service'
import { StorageFeatureModel } from './StoragefeatureModel';

@Injectable()
export class StorageFeatureService {
  StorageFeatureApiRoutePrefix: string = "api/StorageFeature";

  constructor(
    private apiStorageFeatureService: ApiService<StorageFeatureModel>,
  ) { }



  GetStorageFeaturesList(): Observable<StorageFeatureModel[]> {
    let route: string = this.StorageFeatureApiRoutePrefix.concat(`/GetStorageFeaturesList`);
    return this.apiStorageFeatureService.get(route).pipe(
      retry(0),
      //catchError(this.handleError)
    )
  }

  GetStorageFeaturesByFacilityId(facilityId: number): Observable<StorageFeatureModel[]> {
    let route: string = this.StorageFeatureApiRoutePrefix.concat(`/GetStorageFeaturesByFacilityId/${facilityId}`);
    return this.apiStorageFeatureService.get(route).pipe(
      retry(0),
      //catchError(this.handleError)
    )
  }

}
