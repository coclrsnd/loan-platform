import { Component, Input, OnInit } from '@angular/core';

@Component({
  selector: 'app-rates-details-table',
  templateUrl: './rates-details-table.component.html',
  styleUrls: ['./rates-details-table.component.scss']
})
export class RatesDetailsTableComponent implements OnInit {
  @Input() dataSourceInner: any;
  @Input() innerDisplayedColumns: any;

  innerExpandedElements: any[] = [];
  constructor() { }

  ngOnInit(): void {
  }
  toggleAddress(address: any) {
    const index = this.innerExpandedElements.findIndex((x) => x === address);
    if (index === -1) {
      address.isExpanded = true;
      this.innerExpandedElements.push(address);
    } else {
      address.isExpanded = false;
      this.innerExpandedElements.splice(index, 1);
    }
  }
}
