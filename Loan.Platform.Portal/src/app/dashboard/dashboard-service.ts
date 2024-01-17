import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { ApiService } from '../services/api.service';

@Injectable()
export class DashboardService {
  reportApiRoutePrefix: string = 'api/Loan';

  constructor(private apiReportService: ApiService<DashboardService>) {}

  GetLoansByAdhar(adharNumber: string): Observable<any> {
    let route: string = this.reportApiRoutePrefix.concat(`/loan-search/${adharNumber}`);
    return this.apiReportService.get(route);
  }
}
