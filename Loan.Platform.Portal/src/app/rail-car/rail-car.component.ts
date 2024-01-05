import { APP_CONSTANTS } from '../app-constants';
import {
  Component,
  OnInit,
  HostBinding,
  AfterViewInit,
  ViewChild,
} from '@angular/core';
import {
  trigger,
  state,
  style,
  transition,
  animate,
} from '@angular/animations';
import { MatTableDataSource } from '@angular/material/table';
import { MatPaginator } from '@angular/material/paginator';
import { MatSort } from '@angular/material/sort';


export interface Element {
  imageUrl: string;
  name: string;
  position: number;
  weight: number;
  symbol: string;
}



@Component({
  selector: 'app-rail-car',
  templateUrl: './rail-car.component.html',
  styleUrls: ['./rail-car.component.scss'],
  animations: [
    trigger('detailExpand', [
      state(
        'collapsed',
        style({ height: '0px', minHeight: '0', visibility: 'hidden' })
      ),
      state('expanded', style({ height: '*', visibility: 'visible' })),
      transition(
        'expanded <=> collapsed',
        animate('225ms cubic-bezier(0.4, 0.0, 0.2, 1)')
      ),
    ]),
  ],
})
export class RailCarComponent implements OnInit, AfterViewInit {
  displayedColumns = ['position', 'vendor', 'location', 'contracted_spaces', 'cars_on_hand', 'action'];
  dataSource: MatTableDataSource<Element>;

  @ViewChild('MatPaginator', { static: false }) paginator: MatPaginator;
  @ViewChild('sort', { static: false }) sort: MatSort;

  expandedElement: any;

  constructor() {
    this.dataSource = new MatTableDataSource();
  }

  ngOnInit() {
    this.dataSource.data = APP_CONSTANTS.dataTable;
  }

  ngAfterViewInit(): void {
    this.dataSource.sort = this.sort;
    this.dataSource.paginator = this.paginator;
  }
}



