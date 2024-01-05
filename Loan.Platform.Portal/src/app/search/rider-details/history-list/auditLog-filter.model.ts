import { CustomerRibbon } from 'src/app/shared/models/customer-ribbon.model';
import { Pagination } from 'src/app/shared/models/pagination.model';
import { Sorting } from 'src/app/shared/models/sorting.model';
import { AuditLogModel } from './auditLogModel';


export class AuditLogFilterModel {
  ContractId: number;
  Pagination: Pagination;
  AuditLogModel: AuditLogModel[];
  Sorting: Sorting;
}
