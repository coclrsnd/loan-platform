import { Injectable } from '@angular/core';
import { Observable, retry } from 'rxjs';
import { ApiService } from 'src/app/services/api.service';
import { BookNow } from './booknow.model';
import { OpportunityAttachmentModel, OpportunityModel } from './opportunity.model';
import { ReservedSpacesModel } from './reserved-spaces-model';
import { StoragefeatureModel } from './storage-feature-model';
@Injectable({
  providedIn: 'root'
})
export class BookNowService {
  apiPrefix: string = "api/Opportunity";

  constructor(private apiBookNowService: ApiService<BookNow>,private apiOpportunityService: ApiService<OpportunityModel>,private apiService: ApiService<object>,private opportunityId: ApiService<number>) { }

  BookNow(model: BookNow): Observable<BookNow> {
    let route: string = "api/StorageFacility/BookNow"
    return this.apiBookNowService.post(route, model).pipe(
      retry(0),
      //catchError(this.handleError)
    )
  }
  //Save Oppotunity detail.
  SaveOppotunity(model: OpportunityModel): Observable<OpportunityModel> {
    let route: string = "api/Opportunity/SaveOpportunity"
    return this.apiOpportunityService.post(route, model).pipe(
      retry(0),
      //catchError(this.handleError)
    )
  }
  //Get Oppotunity detail by Id
  GetOpportunityById(Id:number): Observable<OpportunityModel> {
    let route: string = `api/Opportunity/GetOpportunityById/${Id}`;
    return this.apiOpportunityService.getSingleObjectById(route).pipe(
      retry(0),
      //catchError(this.handleError)
    )
  }

  //Save Opportunity Attachment
  SaveAttachment(model: FormData): Observable<any> {
    let route: string = this.apiPrefix.concat('/SaveAttachment');
    return this.apiService.postFile(route, model,'json').pipe(
      retry(0),
      //catchError(this.handleError)
    )
  }
  //Delete Opportunity Attachment
  DeleteAttachment(model: OpportunityAttachmentModel): Observable<object> {
    let route: string = this.apiPrefix.concat('/DeleteAttachment');
    return this.apiService.post(route, model).pipe(
      retry(0),
      //catchError(this.handleError)
    )
  }
  //Download Opportunity Attachment
  DownloadAttachment(attachmentModel:OpportunityAttachmentModel): Observable<any> {
    let route: string = this.apiPrefix.concat(`/DownloadAttachment`);
    return this.apiService.postFile(route, attachmentModel,'blob').pipe(retry(0));
  }
 //Save Opportunity Reserved Spaces
  SaveReservedSpaces(model:ReservedSpacesModel):Observable<object>
  {
     let route: string = this.apiPrefix.concat('/SaveReservedSpaces');
    return this.apiService.post(route, model).pipe(
      retry(0),
      //catchError(this.handleError)
    )
  }
  //Save Opportunity Features
  SaveOpportunityFeatures(model:StoragefeatureModel):Observable<object>
  {
     let route: string = this.apiPrefix.concat('/SaveOpportunityFeatures');
    return this.apiService.post(route, model).pipe(
      retry(0),
      //catchError(this.handleError)
    )
  }
  //Place Opportunity Order
  PlaceOrderOpportunity(model: OpportunityModel): Observable<OpportunityModel> {
    let route: string = this.apiPrefix.concat('/PlaceOrder');
    return this.apiOpportunityService.post(route,model).pipe(
      retry(0),
      //catchError(this.handleError)
    )
  }
  //Download Opportunity Order Summary
  OrderSummaryDownload(AgreementPath: string): Observable<Blob>{
    let route: string = this.apiPrefix.concat(`/DownloadOpportunitySummary/${AgreementPath}`);
    return this.apiService.getFile(route).pipe(
      retry(0),
      //catchError(this.handleError)
    )
  }
 //Delete Opportunity Reserved Spaces
  DeleteReservedSpace(Id : number): Observable<any> {
    let route: string = this.apiPrefix.concat(`/DeleteReservedSpace/${Id}`);
    return this.apiService.get(route).pipe(retry(0));
  }
   //Get StorageFeature detail by Id
   GetFeaturesById(Id:number): Observable<any> {
    let route: string = `api/StorageFeature/GetStorageFeaturesByFacilityId/${Id}`;
    return this.apiService.get(route).pipe(
      retry(0),
      //catchError(this.handleError)
    )
  }
}
