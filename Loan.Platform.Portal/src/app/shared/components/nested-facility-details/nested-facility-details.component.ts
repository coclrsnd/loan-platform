import {
  animate,
  state,
  style,
  transition,
  trigger,
} from '@angular/animations';
import {
  ChangeDetectorRef,
  Component,
  EventEmitter,
  Input,
  OnChanges,
  OnInit,
  Output,
  QueryList,
  SimpleChanges,
  ViewChild,
  ViewChildren,
} from '@angular/core';
import { MatSort } from '@angular/material/sort';
import { MatTable, MatTableDataSource } from '@angular/material/table';
import { SharedService } from '../../shared.service';

@Component({
  selector: 'app-nested-facility-details',
  templateUrl: './nested-facility-details.component.html',
  styleUrls: ['./nested-facility-details.component.scss'],
  animations: [
    trigger('detailExpand', [
      state(
        'collapsed',
        style({ height: '0px', minHeight: '0', display: 'none' })
      ),
      state('expanded', style({height: 'auto', display: 'block' })),
      transition(
        'expanded <=> collapsed',
        animate('225ms cubic-bezier(0.4, 0.0, 0.2, 1)')
      ),
    ]),
  ],
})
export class NestedFacilityDetailsComponent implements OnInit, OnChanges {
  @Input() dataSource;
  @Input() columnsToDisplay;
  @Input() isFromPage;
  @Input() data;
  @Input() mode;
  @Input() reFrameTable;
  @Output() removeStorageFacility: EventEmitter<any> = new EventEmitter();
  @Output() deletedRate: EventEmitter<any> = new EventEmitter();
  @Output() deletedLocationDetail: EventEmitter<any> = new EventEmitter();
  @Output() deletedInterchange: EventEmitter<any> = new EventEmitter();
  @ViewChild('outerSort', { static: true }) sort: MatSort;
  @ViewChildren('innerSort') innerSort: QueryList<MatSort>;
  @ViewChildren('innerTables') innerTables: QueryList<MatTable<any>>;
  public expandedElements: any[] = [];
  public usersData: any[] = [];
  public nestedDisplay: boolean = true;
  public isAllowedFromNestedDisplayRate: boolean = false;
  public isAllowedFromNestedDisplayInterchange: boolean = false;
  constructor(public cd: ChangeDetectorRef,
    private sharedService: SharedService) {}

  ngOnInit(): void {
    this.onRenderTable();
  }

  ngOnChanges(changes: SimpleChanges): void {
    this.cd.detectChanges();
    const isTableToUpdate = changes['reFrameTable']?.firstChange;
    if (!isTableToUpdate) {
      this.onRenderTable();
    }
  }

  /**To render table of Storage Facility Rate for sorting and restructuring
   * @method onRenderTable
   */
  public onRenderTable(): void {
    this.usersData = [];
    this.data.value.StorageFacilities.forEach((user) => {
      if (
        user.StorageFacilityRates &&
        Array.isArray(user.StorageFacilityRates) &&
        user.StorageFacilityRates.length
      ) {
        this.usersData = [
          ...this.usersData,
          {
            ...user,
            StorageFacilityRates: new MatTableDataSource(
              user.StorageFacilityRates
            ),
          },
        ];
      } else {
        this.usersData = [...this.usersData, user];
      }
    });
    this.dataSource = new MatTableDataSource(this.usersData);
    this.dataSource._updateChangeSubscription();
    this.dataSource.sort = this.sort;
  }

  /**To expand and collapse row to view details
   * @method toggleRow
   * @param element - current element in the row
   */
  public toggleRow(element: any) {    
    element.StorageFacilityRates &&
    (element.StorageFacilityRates as MatTableDataSource<any>).data.length
      ? this.toggleElement(element)
      : null;
    this.cd.detectChanges();
    this.innerTables.forEach(
      (table, index) =>
        ((table.dataSource as MatTableDataSource<any>).sort =
          this.innerSort.toArray()[index])
    );
  }

  /**To check is current row in expanded state
   * @method isExpanded
   * @param row - currently selected row
   */
  public isExpanded(row: any): string {
    const index = this.expandedElements.findIndex((x) => x.Name == row.Name);
    if (index !== -1) {
      row.isExpanded = true;
      return 'expanded';
    }
    row.isExpanded = false;
    return 'collapsed';
  }

  /**To expand and collapse current row in context
   * @method toggleElement
   * @param row - currently selected row
   */
  public toggleElement(row: any) {
    const index = this.expandedElements.findIndex((x) => x.name == row.name);
    let openSpanId = this.expandedElements.find((m)=>m)?.Id;
    if (index === -1) {
      this.expandedElements.push(row);
    } else {
      this.expandedElements.splice(index, 1);
       if(openSpanId!=row.Id)
       {
        this.expandedElements.push(row);
       }
    }
  }

  /**To apply filter on table
   * @method applyFilter
   * @param filterValue - value which needs to be filtered
   */
  applyFilter(filterValue: string) {
    this.innerTables.forEach(
      (table, index) =>
        ((table.dataSource as MatTableDataSource<any>).filter = filterValue
          .trim()
          .toLowerCase())
    );
  }

  /** Event to be triggered when save rate
   * @method saveRates
   * @param event - save row event
   */
  public saveRates(event: any): void {}

  /** Event to delete storage facility
   * @method onDeleteStorageFacility
   * @param index - storage facility index to be removed
   */
  public onDeleteStorageFacility(index): void {
    this.removeStorageFacility.emit(index);
  }

    /**To Get State name for Facility Grid
   * @method GetStateName
   * @param stateId - index to remove location
   * @return Name of state or empty
   */
  public GetStateName(stateId: number): string {
    let stateDetail;
    if (stateId != undefined && stateId > 0) {
      this.sharedService.getStatesList().subscribe((response) => {
         stateDetail = response.filter((t) => t.Id == stateId);
      });
      if (
        stateDetail != undefined &&
        stateDetail != null &&
        stateDetail.length > 0
      ) {
        return ', ' + stateDetail[0]?.Name;
      }
    }
    return '';
  }


   /** On delete storage facility interchange
   * @method onDeleteInterchange
   * @param - deletedInterchange - data of the deleted storage facility Interchange
   */
    onDeleteInterchange(deletedInterchange:any){
      this.deletedInterchange.emit(deletedInterchange);
     }

  /** On delete storage facility Rate
   * @method onDeleteRate
   * @param - deletedRateDetail - data of the deleted storage facility  Rate
   */
  onDeleteRate(deletedRateDetail:any){
   this.deletedRate.emit(deletedRateDetail);
  }

    /** On delete storage facility interchange location
   * @method onDeleteLocation
   * @param - deletedLocationDetail - data of the deleted storage facility Interchange location
   */
  onDeleteLocation(deletedLocationDetail:any){
    this.deletedLocationDetail.emit(deletedLocationDetail);
  }
}
