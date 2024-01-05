import { Component, Input, OnInit } from '@angular/core';
import { APP_CONSTANTS } from '../../../app-constants';
import { OpportunityModel } from '../opportunity.model';

@Component({
  selector: 'app-storage-package',
  templateUrl: './storage-package.component.html',
  styleUrls: ['./storage-package.component.scss']
})
export class StoragePackageComponent implements OnInit {
@Input() storageInfo;
@Input() opportunityModel:OpportunityModel;
public defaultDateTimeFormat = APP_CONSTANTS.DefaultDateTimeFormat;
  constructor() { }

  ngOnInit(): void {

  }

}
