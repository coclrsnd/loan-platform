import { Injectable } from '@angular/core';
import { retry } from 'rxjs';
import { Observable } from 'rxjs';
import { ApiService } from '../../services/api.service';
import { ActivityReportModel } from './activityReport-model';

@Injectable()
export class ReportService {
  reportApiRoutePrefix: string = 'api/Report';

  constructor(private apiReportService: ApiService<ActivityReportModel>) {}

  GetActivityReport(model: ActivityReportModel): Observable<any> {
    let route: string = this.reportApiRoutePrefix.concat(`/ActivityReport`);
    return this.apiReportService.postFile(route, model,'blob').pipe(retry(0));
  }
}
