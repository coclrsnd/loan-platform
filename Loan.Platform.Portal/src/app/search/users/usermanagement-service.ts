import { Injectable } from '@angular/core';
import { retry } from 'rxjs';
import { Observable } from 'rxjs';
import { catchError } from "rxjs/operators";
import { ApiService } from '../../services/api.service';
import { SecurityContext } from '../../shared/models/SecurityContext';
import { ApproveRejectUserModel } from './approverejectuser.model';
import { UserFilterModel } from './UserFilterModel';
import { UserModel } from './UserModel';


@Injectable()
export class UserManagementService {
  UsersApiRoutePrefix: string = "api/User";

  constructor(
    private apiSignUpService: ApiService<UserFilterModel>,
    private apiApproveRejectService: ApiService<ApproveRejectUserModel>
  ) { }

  GetUserDetails(model: UserFilterModel): Observable<UserFilterModel> {
    let route: string = this.UsersApiRoutePrefix.concat(`/GetUserDetails`);
    return this.apiSignUpService.post(route, model).pipe(
      retry(0),
      //catchError(this.handleError)
    )
  }

  ApproveRejectUsers(users : ApproveRejectUserModel) :Observable<ApproveRejectUserModel>{
    let route: string = this.UsersApiRoutePrefix.concat(`/ApproveRejectUsers/`);
    return this.apiApproveRejectService.post(route, users).pipe(
      retry(0),
      //catchError(this.handleError)
    )
  }
}
