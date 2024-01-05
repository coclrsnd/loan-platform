import { APP_CONSTANTS } from '../../../app-constants';
import { Component, OnInit, TemplateRef, ViewChild } from '@angular/core';

@Component({
  selector: 'app-notification',
  templateUrl: './notification.component.html',
  styleUrls: ['./notification.component.scss']
})
export class NotificationComponent implements OnInit {
  navItems = APP_CONSTANTS.dataTable;
  public isNotificationShown: boolean = true;
  constructor() { }

  ngOnInit(): void {
  }

  public hideNotification(): void {
    this.isNotificationShown = false;
  }

}
