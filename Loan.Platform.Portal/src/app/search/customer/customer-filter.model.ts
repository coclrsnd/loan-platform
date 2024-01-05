import { CustomerRibbon } from 'src/app/shared/models/customer-ribbon.model';
import { Pagination } from 'src/app/shared/models/pagination.model';
import { Sorting } from 'src/app/shared/models/sorting.model';
import { CustomerModel } from './CustomerModel';


export class CustomerFilterModel {
  OrganizationId: number;
  Organization: string;
  CountryId: number;
  StateId: number;
  CityName: string;
  Pagination: Pagination;
  CustomerModel: CustomerModel[];
  Sorting:Sorting;
  CustomerRibbon: CustomerRibbon;
}
