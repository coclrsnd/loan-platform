import { Injectable } from '@angular/core';
import { Observable, retry } from 'rxjs';
import { StorageOrderModel } from '../../reports/activity-report/Storage-Order-model';
import { ApiService } from '../../services/api.service';
import { AttachmentModel } from '../rider-details/attachments-list/attachmentModel';
import { AuditLogFilterModel } from '../rider-details/history-list/auditLog-filter.model';
import { AuditLogModel } from '../rider-details/history-list/auditLogModel';
import { NoteModel } from '../rider-details/notes-list/noteModel';
import { RiderModel } from './RiderModel';



@Injectable()
export class RiderService {
  ContractApiRoutePrefix: string = "api/Contract";

  constructor(
    private apiRiderService: ApiService<RiderModel>, private apiStorageOrderService: ApiService<StorageOrderModel>, private apiRiderNoteService: ApiService<NoteModel>, private apiRiderAttachmentService: ApiService<AttachmentModel>, private apiAuditLogService: ApiService<AuditLogModel>, private apiAuditLogFilterService: ApiService<AuditLogFilterModel>
  ) { }


  SaveStorageOrder(model: RiderModel): Observable<RiderModel> {
    let route: string = this.ContractApiRoutePrefix.concat(`/SaveContractDetail`);
    return this.apiRiderService.post(route, model).pipe(
      retry(0),
      //catchError(this.handleError)
    )
  }

  //UpdateStorageOrder(model: RiderModel): Observable<RiderModel> {
  //  let route: string = this.ContractApiRoutePrefix.concat(`/SaveContractDetail`);
  //  return this.apiRiderService.post(route, model).pipe(
  //    retry(0),
  //    //catchError(this.handleError)
  //  )
  //}

  GetStorageOrderDetails(model: RiderModel): Observable<any> {
    let route: string = this.ContractApiRoutePrefix.concat(`/GetStorageOrderDetails`);
    return this.apiRiderService.getDataWithPost(route, model).pipe(
      retry(0),
      //catchError(this.handleError)
    )
  }

  GetStorageOrderDetailsById(id: number): Observable<RiderModel> {
    let route: string = this.ContractApiRoutePrefix.concat(`/GetStorageOrderDetailsById/${id}`);
    return this.apiRiderService.getSingleObjectById(route).pipe(
      retry(0),
      //catchError(this.handleError)
    )
  }

  GetStorageOrderList(searchText: string): Observable<RiderModel[]> {
    let route: string = this.ContractApiRoutePrefix.concat(`/GetStorageOrderList/`);
    return this.apiRiderService.get(route + searchText).pipe(
      retry(0),
      //catchError(this.handleError)
    )
  }

  SaveNotes(model:NoteModel): Observable<NoteModel> {
    let route: string = this.ContractApiRoutePrefix.concat(`/SaveNotes`);
    return this.apiRiderNoteService.post(route, model).pipe(
      retry(0),
      //catchError(this.handleError)
    )
  }

  GetNotesByContractId(contractId: number): Observable<NoteModel[]> {
    let route: string = this.ContractApiRoutePrefix.concat(`/GetNotesByContractId/${contractId}`);
    return this.apiRiderNoteService.getById(route).pipe(
      retry(0),
      //catchError(this.handleError)
    )
  }

  GetAttachmentsByContractId(contractId: number): Observable<AttachmentModel[]> {
    let route: string = this.ContractApiRoutePrefix.concat(`/GetAttachmentsByContractId/${contractId}`);
    return this.apiRiderAttachmentService.getById(route).pipe(
      retry(0),
      //catchError(this.handleError)
    )
  }

  ValidateAndExpire(contractId: number): Observable<boolean> {
    let route: string = this.ContractApiRoutePrefix.concat(`/ValidateAndExpire/${contractId}`);
    return this.apiRiderService.getBoolean(route).pipe(
      retry(0),
      //catchError(this.handleError)
    )
  }

  GetStorageOrderByCustomer(CustomerId: number): Observable<StorageOrderModel[]> {
    let route: string = this.ContractApiRoutePrefix.concat(`/GetStorageOrderByCustomer/${CustomerId}`);
    return this.apiStorageOrderService.getById(route).pipe(
      retry(0)
    )
  }

  GetAuditLogsByContractId(contractId: number): Observable<AuditLogModel[]> {
    let route: string = this.ContractApiRoutePrefix.concat(`/GetAuditLogsByContractId/${contractId}`);
    return this.apiAuditLogService.getById(route).pipe(
      retry(0),
      //catchError(this.handleError)
    )
  }

  GetAuditLogsOnFilter(auditLogFilterModel: AuditLogFilterModel): Observable<any> {
    let route: string = this.ContractApiRoutePrefix.concat(`/GetAuditLogsOnFilter`);
    return this.apiAuditLogFilterService.post(route, auditLogFilterModel).pipe(
      retry(0),
      //catchError(this.handleError)
    )
  }
}
