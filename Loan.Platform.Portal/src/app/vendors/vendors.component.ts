import { AfterViewInit, Component, OnInit, ViewChild } from '@angular/core';
import { MatPaginator } from '@angular/material/paginator';
import { MatTableDataSource } from '@angular/material/table/table-data-source';
import { APP_CONSTANTS } from '../app-constants';
export interface Element {
  imageUrl: string;
  name: string;
  position: number;
  weight: number;
  symbol: string;
}

@Component({
  selector: 'app-vendors',
  templateUrl: './vendors.component.html',
  styleUrls: ['./vendors.component.scss']
})
export class VendorsComponent implements OnInit, AfterViewInit {
  public numInfo = APP_CONSTANTS.numInfo;
  @ViewChild('MatPaginator', { static: false }) paginator: MatPaginator;
  dataSource: any;
  displayedColumns = [ 'vendor', 'location', 'cars_stored', 'months', 'total', 'avg_monthly_cost', 'avg_par_car_cost', 'exp_in_days'];
  constructor() {
    this.dataSource = APP_CONSTANTS.dataTable;
  }

  ngOnInit(): void {
  }

  ngAfterViewInit(): void {

  }

}
