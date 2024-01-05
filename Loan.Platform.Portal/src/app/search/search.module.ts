import { TranslateModule } from '@ngx-translate/core';
import { SharedModule } from './../shared/shared.module';
import { CUSTOM_ELEMENTS_SCHEMA, NgModule } from '@angular/core';
import { CommonModule, CurrencyPipe, PercentPipe } from '@angular/common';
import { SearchRoutingModule } from './search-routing.module';
import { SearchComponent } from './search.component';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
// import { NgMultiSelectDropDownModule } from 'ng-multiselect-dropdown';
import { MaterialModule } from '../material.module';
import { UiSwitchModule } from 'ngx-ui-switch';
import { SearchMapComponent } from './search-map/search-map.component';
import { RiderComponent } from './rider/rider.component';
import { VendorComponent } from './vendor/vendor.component';
import { CustomerComponent } from './customer/customer.component';
import { RailCarComponent } from './rail-car/rail-car.component';
import { UsersComponent } from './users/users.component';
import { BsDatepickerModule, DatepickerModule } from 'ngx-bootstrap/datepicker';
import { BsDropdownModule } from 'ngx-bootstrap/dropdown';
import { RiderDetailsComponent } from './rider-details/rider-details.component';
import { VendorDetailsComponent } from './vendor-details/vendor-details.component';
import { NgxSliderModule } from '@angular-slider/ngx-slider';
import { RailCarDetailsTabComponent } from './rider-details/rail-car-details-tab/rail-car-details-tab.component';
import { CustomerDetailsComponent } from './customer-details/customer-details.component';
import { AttachmentsListComponent } from './rider-details/attachments-list/attachments-list.component';
import { NotesListComponent } from './rider-details/notes-list/notes-list.component';
import { HistoryListComponent } from './rider-details/history-list/history-list.component';
import { MatTooltipModule } from '@angular/material/tooltip';
import { BookNowComponent } from './book-now/book-now.component';
import { MatStepperModule } from '@angular/material/stepper';
import { DragDropModule } from '@angular/cdk/drag-drop';
import { DateValueAccessorModule } from 'angular-date-value-accessor';
import { MatProgressSpinnerModule } from '@angular/material/progress-spinner';
import { StoragePackageComponent } from './book-now/storage-package/storage-package.component';
import { AdvancedSwitchingRatesComponent } from './rider-details/advanced-switching-rates/advanced-switching-rates.component';
@NgModule({
  declarations: [
    SearchComponent,
    SearchMapComponent,
    RiderComponent,
    VendorComponent,
    CustomerComponent,
    RailCarComponent,
    UsersComponent,
    RiderDetailsComponent,
    VendorDetailsComponent,
    RailCarDetailsTabComponent,
    CustomerDetailsComponent,
    AttachmentsListComponent,
    NotesListComponent,
    HistoryListComponent,
    BookNowComponent,
    StoragePackageComponent,    
    AdvancedSwitchingRatesComponent
  ],
  imports: [
    CommonModule,
    SearchRoutingModule,
    MatProgressSpinnerModule,
    MatTooltipModule,
    MatStepperModule,
    DragDropModule,
    SharedModule,
    FormsModule,
    MaterialModule,
    ReactiveFormsModule,
    NgxSliderModule,
    DateValueAccessorModule,
    UiSwitchModule.forRoot({
      size: 'small',
      color: '#16366f',
      switchColor: '#FFFFFF',
      defaultBgColor: '#16366f',
      defaultBoColor : '#16366f',
      checkedLabel: '',
      uncheckedLabel: ''
    }),
    TranslateModule,
   // NgMultiSelectDropDownModule.forRoot(),
    BsDatepickerModule.forRoot(),
    DatepickerModule.forRoot(),
    BsDropdownModule.forRoot()
  ],
  providers: [ CurrencyPipe, PercentPipe ],
  schemas: [CUSTOM_ELEMENTS_SCHEMA],
})
export class SearchModule { }
