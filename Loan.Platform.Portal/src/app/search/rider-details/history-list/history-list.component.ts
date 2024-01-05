import { Component, Input, OnChanges, OnInit, Output, SimpleChanges } from '@angular/core';
import { PageEvent } from '@angular/material/paginator';
import { MatTableDataSource } from '@angular/material/table';
import { APP_CONSTANTS } from 'src/app/app-constants';
import { Pagination } from 'src/app/shared/models/pagination.model';
import { Sorting } from 'src/app/shared/models/sorting.model';
import { RiderService } from '../../rider/rider-service';
import { AuditLogFilterModel } from './auditLog-filter.model';

@Component({
  selector: 'app-history-list',
  templateUrl: './history-list.component.html',
  styleUrls: ['./history-list.component.scss']
})
export class HistoryListComponent implements OnInit,OnChanges {
  public dataSource: any;
  columnsToDisplay = ['Action', 'Description', 'CreatedTime', 'User'];
  @Input() riderModelData;
  @Input() configuration: any;

  public paginationModel: Pagination;
  public filterModel: AuditLogFilterModel;
  public sortingModel: Sorting;
  public totalRows: number = 0;
  public pageSize: number = 10;
  public currentPage: number = 0
  public pageSizeOptions = [10, 15, 20, 50];
  public isPaginationEnabled: boolean = false;
  constructor(public riderService: RiderService) { }

  ngOnInit(): void {
    if (this.riderModelData.Id) {
      this.GetAuditLogs(this.riderModelData.Id);
    }
  }

  ngOnChanges(changes: SimpleChanges): void {
    if (this.configuration) {
      this.GetAuditLogs(this.riderModelData.Id);
    }
  }

  public GetAuditLogs(ContractId: number) {
    this.bindFilterModel(ContractId);
    this.riderService.GetAuditLogsOnFilter(this.filterModel).subscribe(result => {
      if (result.AuditLogModel != null) {
        this.dataSource = result.AuditLogModel;
        this.totalRows = result.Pagination.TotalRecords;
        this.isPaginationEnabled = true;
      } else {
        this.isPaginationEnabled = false;
      }
    }, error => {
    });
  }

  /** Load Audit logs from specified page index and with count page size
   * @method pageChanged
   * @param event - page selection change event
   */
  pageChanged(event: PageEvent): void {
    this.pageSize = event.pageSize;
    this.currentPage = event.pageIndex;
    this.GetAuditLogs(this.filterModel.ContractId)
  }

  /** Load Audit logs from specified pageindex with count of pagesize
   * @method bindFilterModel
   * @param ContractId - ContractId to which data should be filtered
   */
  public bindFilterModel(ContractId: number): void {
    this.filterModel = new AuditLogFilterModel();
    this.filterModel.ContractId = ContractId;

    // set pagination detail
    this.paginationModel = new Pagination();
    this.paginationModel.Index = this.currentPage;
    this.paginationModel.Size = this.pageSize;
    this.filterModel.Pagination = this.paginationModel;

    // set Sorting
    this.sortingModel = new Sorting();
    this.sortingModel.SortByColumnName = "CreatedTime"
    this.sortingModel.SortBy = "";
    this.filterModel.Sorting = this.sortingModel;
  }
}
