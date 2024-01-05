import { Pagination } from "src/app/shared/models/pagination.model";
import { Sorting } from "src/app/shared/models/sorting.model";
import { UserModel } from "./UserModel";

export class UserFilterModel {
  FirstName: string;
  CompanyName: string;
  StatusId: number | null;
  UserList: UserModel[];
  PaginationModel: Pagination;
  SortingModel: Sorting;
}
