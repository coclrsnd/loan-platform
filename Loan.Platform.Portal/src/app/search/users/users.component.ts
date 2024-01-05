import { Component, ViewChildren, OnInit, QueryList, ElementRef } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { APP_CONSTANTS } from 'src/app/app-constants';
import { MatInput } from '@angular/material/input';
import { SelectionModel } from '@angular/cdk/collections';
import { UserManagementService } from './usermanagement-service';
import { UserModel } from './UserModel';
import { ApproveRejectUserModel } from './approverejectuser.model';
import { OrganizationModel } from 'src/app/shared/models/organization-model.model';
import { MasterDataService } from 'src/app/services/master-data.service';
import { UserStatusModel } from 'src/app/shared/models/user-status.model';
import { ApiService } from 'src/app/services/api.service';
import { SharedService } from 'src/app/shared/shared.service';
import { ToastrService } from 'ngx-toastr';
import { AuthService } from 'src/app/services/auth.service';
import { UserTypeModel } from '../../shared/models/userType.model';
import { Pagination } from 'src/app/shared/models/pagination.model';
import { Sorting } from 'src/app/shared/models/sorting.model';
import { PageEvent } from '@angular/material/paginator';
import { UserFilterModel } from './UserFilterModel';
@Component({
  selector: 'app-users',
  templateUrl: './users.component.html',
  styleUrls: ['./users.component.scss']
})
export class UsersComponent implements OnInit {
  @ViewChildren(MatInput, { read: ElementRef }) inputs: QueryList<ElementRef>;
  public usersForm: FormGroup;
  public submittedSearch: boolean = false;
  public statusDetails: UserStatusModel[]=[];
  public userType :UserTypeModel[]=[];
  public organizations:OrganizationModel[]=[];
  public userModel = new UserModel;
  public displayedColumns: string[] = ['select','FirstName', 'LastName', 'CompanyName', 'CompanyEmail', 'Title', 'ContactNumber', 'Organization', 'UserType', 'Status'];
  public dataSource: any; // = APP_CONSTANTS.dataTable;
  public selection = new SelectionModel<any>(true, []);
  public isVerifiedSelected: boolean = false;
  public approveRejectUserModel :ApproveRejectUserModel;
  public defaultSelectedValueForDropdownlist = APP_CONSTANTS.defaultNumberValue;
  public paginationModel: Pagination;
  public sortingModel: Sorting;
  public sortColumn: string = 'Id';
  public sortDirection: string = 'Asc';
  public totalRows: number = 0;
  public pageSize: number = 10;
  public currentPage: number = 0
  public pageSizeOptions = [10, 15, 20, 50];
  public isPaginationEnabled: boolean = false;
  /** Whether the number of selected elements matches the total number of rows. */
  isAllSelected() {
    const numSelected = this.selection.selected.length;
    const numRows = this.dataSource.length;
    return numSelected === numRows;
  }

  /** Selects all rows if they are not all selected; otherwise clear selection. */
  masterToggle() {
    this.isAllSelected()
      ? this.selection.clear()
      : this.dataSource.forEach((row: any) => this.selection.select(row));
  }

  onValueChange(element: any) {
    const changedElement = JSON.stringify(element);
  }
  constructor(public formBuilder: FormBuilder, public userService: UserManagementService,private masterService:MasterDataService,
    private sharedService:SharedService, public toastr: ToastrService, private authService: AuthService) {
    this.LoadInitialUserDetails();
  }

  ngOnInit(): void {
    this.initilizeUsersForm();
    this.GetOrganizations();
    this.GetUserTypes();
    this.GetUserStatuses();
  }

  // Initilize users search form
  public initilizeUsersForm(): void {
    this.usersForm = this.formBuilder.group({
      FirstName: [APP_CONSTANTS.emptyString],
      CompanyName: [APP_CONSTANTS.emptyString, Validators.pattern(/^[a-zA-Z0-9-&. ]*$/)],
     StatusId: [APP_CONSTANTS.defaultNumberValue]
    });
  }

  private GetOrganizations(){
    this.masterService.GetOrganizations().subscribe(result=>{
      this.organizations=result;
    });
  }

  private GetUserTypes(){
    this.masterService.GetUserTypes().subscribe(result=>{
      this.userType=result;
    });
  }

  private GetUserStatuses(){
    this.masterService.GetUserStatuses().subscribe(result=>{
      this.statusDetails=result;
    });
  }
   // On form submit
  public onSearchUsersForm(): void {
    this.submittedSearch = true;
    // stop here if form is invalid
    if (this.usersForm.invalid) {
      return;
    }
    this.currentPage = 0;
    this.userModel = Object.assign(this.usersForm.value);
    this.getUserDetails(this.userModel);
  }
  public onStatusApproval(): void {
    this.approveRejectUsers('approve');
  }

  public onStatusReject(): void {
    this.approveRejectUsers('reject');
  }

  private approveRejectUsers(action: string) {
    let isOktoProcess = true;
    this.approveRejectUserModel = new ApproveRejectUserModel();
    this.approveRejectUserModel.Action = action;
    this.approveRejectUserModel.Users = [];
    if (this.selection.selected.length > 0) {
      this.selection.selected.forEach(user => {
        if (action == "approve" && (user.Organization === "" || user.UserType === "") && isOktoProcess) {
          this.toastr.info("Select user(s), associated organization and user type.");
          isOktoProcess = false;
          return;
        }

        let userModel = new UserModel();
        userModel.Id = user.Id;
        userModel.FirstName = user.FirstName;
        userModel.LastName = user.LastName;
        userModel.Designation = user.Designation;
        userModel.EmailId = user.EmailId;
        userModel.ContactNo = user.ContactNo;
        userModel.OrganizationId = user.Organization.Id;
        userModel.Organization = user.Organization.Name;
        userModel.UserTypeId = user.UserType.Id;
        userModel.UserType = user.UserType.Name;
        userModel.CompanyName = user.CompanyName;
        userModel.ApprovedBy = this.authService.getUserId();
        this.approveRejectUserModel.Users.push(userModel);

      });
      if (
        this.approveRejectUserModel != null && isOktoProcess &&
        this.approveRejectUserModel.Users != null && this.approveRejectUserModel.Users.length > 0
      ) {
        this.userService
          .ApproveRejectUsers(this.approveRejectUserModel)
          .subscribe(
            (result) => {
              this.isVerifiedSelected = false;
              this.toastr.success("The information was updated successfully.");
              this.getUserDetails(this.userModel);
            },
            (error) => {
            }
          );
      }
    }
    else{
      this.toastr.info("Please select at least one record to proceed!");
    }
  }

  private LoadInitialUserDetails() {
    this.userModel = new UserModel();
    this.userModel.FirstName = "";
    this.userModel.CompanyName = "";
    this.userModel.IsApproved = true;
    this.getUserDetails(this.userModel)
  }

  private getUserDetails(user :UserModel){
    var userfilterModel = this.prepareUserFilterModel(user);
    this.userService.GetUserDetails(userfilterModel).subscribe(result => {
      this.dataSource = result.UserList;
      if (result.UserList !== undefined && result.UserList.length > 0) {
        this.isPaginationEnabled = true;
        this.totalRows = result.PaginationModel.TotalRecords;
      }
      this.statusDetails.find(s=>s.Id==this.userModel.StatusId && s.Name=="Verified")
      //if(this.userModel.Status=='Pending')
      if(this.statusDetails.find(s=>s.Id==this.userModel.StatusId && s.Name=="Verified"))
      {
        this.isVerifiedSelected=true;
      }
      else
      {
        this.isVerifiedSelected=false;
      }
    }, error => {
    });
  }

  public prepareUserFilterModel(user: UserModel): UserFilterModel {
    let userfilterModel = new UserFilterModel();
    userfilterModel.FirstName = user.FirstName;
    userfilterModel.CompanyName = user.CompanyName;
    userfilterModel.StatusId = user.StatusId;
    this.paginationModel = new Pagination();
    this.paginationModel.Index = this.currentPage;
    this.paginationModel.Size = this.pageSize;
    userfilterModel.PaginationModel = this.paginationModel;
    this.sortingModel = new Sorting();
    this.sortingModel.SortByColumnName = this.sortColumn;
    this.sortingModel.SortBy = this.sortDirection;
    userfilterModel.SortingModel = this.sortingModel;
    return userfilterModel;
  }

  public onResetSearch(): void {
    // this.usersForm.patchValue({
    //   CompanyName: APP_CONSTANTS.emptyString,
    //   FirstName: APP_CONSTANTS.emptyString,
    //   StatusId: APP_CONSTANTS.defaultNumberValue
    // })
    this.initilizeUsersForm();
    this.LoadInitialUserDetails();
  }

  pageChanged(event: PageEvent): void {
    this.pageSize = event.pageSize;
    this.currentPage = event.pageIndex;
    this.userModel = Object.assign(this.usersForm.value);
    this.getUserDetails(this.userModel);
  }
}
