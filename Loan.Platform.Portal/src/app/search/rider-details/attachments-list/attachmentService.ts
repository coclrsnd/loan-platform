import { Injectable } from '@angular/core';
import { HttpClient, HttpEvent, HttpResponse } from '@angular/common/http';
import { Observable, retry } from 'rxjs';
import { ApiService } from '../../../services/api.service';
import { RiderModel } from '../../rider/RiderModel';
import { AttachmentModel } from './attachmentModel';
@Injectable({
  providedIn: 'root'
})
export class AttachmentService {

  ContractApiRoutePrefix: string = "api/Contract";

  constructor(
    private fileApiService: ApiService<FormData>, private fileDownloadApiService: ApiService<HttpEvent<Blob>>
  ) { }



  SaveAttachment(model: FormData): Observable<object> {
    let route: string = this.ContractApiRoutePrefix.concat(`/SaveAttachment`);
    return this.fileApiService.postFile(route, model,'blob').pipe(
      retry(0),
      //catchError(this.handleError)
    )
  }

  DownloadAttachment(contractId : string, fileName :string): Observable<Blob> {
    let route: string = this.ContractApiRoutePrefix.concat(`/DownloadAttachment?fileName=` + fileName + `&contractId=` + contractId);
    return this.fileDownloadApiService.getFile(route).pipe(
      retry(0),
      //catchError(this.handleError)
    )
  }

}
