import { Injectable } from '@angular/core';
import { Observable, retry } from 'rxjs';
import { ApiService } from '../services/api.service';
import { ChangePassword } from './changepassword.model';
import { LoginModel } from './LoginModel';
import { UserModel } from './UserModel';

@Injectable()
export class UserService {
  UsersApiRoutePrefix: string = "api/User";

  constructor(
    private apiSignUpService: ApiService<UserModel>, private apiLoginService: ApiService<LoginModel>,
    private apiUserService: ApiService<UserModel>, private apiUserProfileService: ApiService<ChangePassword>
  ) { }

  SignUp(model: UserModel): Observable<UserModel> {
    //let route: string = this.UsersApiRoutePrefix.concat(`/SignUp`);
    let route: string = "api/Accounts/register"
    return this.apiSignUpService.post(route, model).pipe(
      retry(0),
      //catchError(this.handleError)
    )
  }

  Login(model: LoginModel): Observable<any> {
    let route: string = this.UsersApiRoutePrefix.concat(`/Login`);
    return this.apiLoginService.post(route, model).pipe(
      retry(0),
      //catchError(this.handleError)
    )
  }

    // To get users list
    GetUserList(): Observable<UserModel[]> {
      let route: string = this.UsersApiRoutePrefix.concat(`/GetUserDetails`);
      return this.apiUserService.get(route).pipe(
        retry(0)
        //catchError(this.handleError)
      );
    }

    // Get user by ID to view or edit
    GetUserByID(id: number): Observable<UserModel> {
      let route: string = this.UsersApiRoutePrefix.concat(`/GetUserById`);
      return this.apiUserService.getSingleObjectById(route + '/' + id).pipe(
        retry(0));
    }

    // Update user detail
    UpdateUserDetail(model: UserModel): Observable<any> {
      let route: string = this.UsersApiRoutePrefix.concat(`/UpdateUserDetail`);
      return this.apiUserService.put(route, model).pipe(retry(0));
    }

    ChangePassword(model: ChangePassword):Observable<any>{
      let route: string = this.UsersApiRoutePrefix.concat(`/ChangePassword`);
      return this.apiUserProfileService.post(route, model).pipe(retry(0));
    }


}
