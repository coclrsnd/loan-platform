import { NgModule } from '@angular/core';
import { CommonModule, CurrencyPipe, DatePipe, PercentPipe } from '@angular/common';
import { HeaderComponent } from './components/header/header.component';
import { FooterComponent } from './components/footer/footer.component';
import { SideNavComponent } from './components/side-nav/side-nav.component';
import { MaterialModule } from '../material.module';
import { RouterModule } from '@angular/router';
import { NotificationComponent } from './components/notification/notification.component';
import { PageTitleComponent } from './components/page-title/page-title.component';
import { CarouselModule } from '@marcreichel/angular-carousel';
import { TranslateModule } from '@ngx-translate/core';
import { TrimFieldDirective } from './directives/trim-field.directive';
import { CharactorOnlyDirective } from './directives/charactor-only.directive';
import { NumbersOnlyDirective } from './directives/number-only.directive';
import { TopHeaderComponent } from './components/top-header/top-header.component';
import { OpenedPagesComponent } from './components/opened-pages/opened-pages.component';
import { SvgIconComponent } from './components/svg-icon/svg-icon.component';
import { StorageFacilityDetailsComponent } from './components/storage-facility-details/storage-facility-details.component';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { BsDatepickerModule, DatepickerModule } from 'ngx-bootstrap/datepicker';
import { VendorFormComponent } from './components/vendor-form/vendor-form.component';
import { RatesFormComponent } from './components/rates-form/rates-form.component';
import { GlobalSearchComponent } from './components/global-search/global-search.component';
import { RatesDetailsTableComponent } from './components/rates-details-table/rates-details-table.component';
import { GlobalSearchListDirective } from './directives/global-search-list.directive';
import { RatesListComponent } from './components/rates-list/rates-list.component';
import { InputAutocompleteComponent } from './components/input-autocomplete/input-autocomplete.component';
import { CustomerFormComponent } from './components/customer-form/customer-form.component';
import { PageNotFoundComponent } from './components/page-not-found/page-not-found.component';
import { NestedFacilityDetailsComponent } from './components/nested-facility-details/nested-facility-details.component';
import { MultiSelectComponent } from './components/multi-select/multi-select.component';
import { MatSelectModule } from '@angular/material/select';
import { MatCheckboxModule } from '@angular/material/checkbox';
import { OrganizationDialogComponent } from './components/organization-dialog/organization-dialog.component';
import { MatDialogModule } from '@angular/material/dialog';
import { EllipsifyMeDirective } from './directives/ellipsify-me.directive';
import { ConfirmDialogModule } from './components/confirm-dialog/confirm-dialog.module';
import { LoaderComponent } from './components/loader/loader.component';
import { LoaderService } from './components/loader/loader.service';
import { MatProgressSpinnerModule } from '@angular/material/progress-spinner';
import { PercentageDirective } from './directives/percentage.directive';
import { InterchangeFormComponent } from './components/interchange-form/interchange-form.component';
import { InterchangesListComponent } from './components/interchanges-list/interchanges-list.component';
import { VarcharOnlyDirective } from './directives/varchar-only.directive';
import { VarcharSpaceDirective } from './directives/varchar-space.directive';
import { DragDropModule } from '@angular/cdk/drag-drop';
import { SavedSearchComponent } from './components/saved-search/saved-search.component';
import { CurrencyOnlyDirective } from './directives/currency-only.directive';
import { LoanSearchComponent } from './components/Loan/loan-search';

@NgModule({
  declarations: [
    HeaderComponent,
    FooterComponent,
    SideNavComponent,
    NotificationComponent,
    PageTitleComponent,
    TrimFieldDirective,
    CharactorOnlyDirective,
    NumbersOnlyDirective,
    TopHeaderComponent,
    OpenedPagesComponent,
    SvgIconComponent,
    StorageFacilityDetailsComponent,
    VendorFormComponent,
    RatesFormComponent,
    RatesDetailsTableComponent,
    GlobalSearchComponent,
    GlobalSearchListDirective,
    RatesListComponent,
    InputAutocompleteComponent,
    CustomerFormComponent,
    PageNotFoundComponent,
    NestedFacilityDetailsComponent,
    MultiSelectComponent,
    OrganizationDialogComponent,
    EllipsifyMeDirective,
    LoaderComponent,
    PercentageDirective,
    InterchangeFormComponent,
    InterchangesListComponent,
    VarcharOnlyDirective,
    VarcharSpaceDirective,
    SavedSearchComponent,
    CurrencyOnlyDirective,
    LoanSearchComponent
  ],
  imports: [
    CommonModule,
    MaterialModule,
    RouterModule,
    CarouselModule,
    TranslateModule,
    DragDropModule,
    FormsModule,
    ReactiveFormsModule,
    MaterialModule,
    MatSelectModule,
    MatCheckboxModule,
    ConfirmDialogModule,
    MatProgressSpinnerModule,
    BsDatepickerModule.forRoot(),
    DatepickerModule.forRoot()
  ],
  providers: [
    DatePipe,
    LoaderService,
    CurrencyPipe,
    PercentPipe
  ],
  exports: [
    HeaderComponent,
    FooterComponent,
    SideNavComponent,
    NotificationComponent,
    PageTitleComponent,
    TrimFieldDirective,
    CharactorOnlyDirective,
    NumbersOnlyDirective,
    TopHeaderComponent,
    OpenedPagesComponent,
    SvgIconComponent,
    StorageFacilityDetailsComponent,
    VendorFormComponent,
    RatesFormComponent,
    RatesDetailsTableComponent,
    GlobalSearchComponent,
    GlobalSearchListDirective,
    RatesListComponent,
    InputAutocompleteComponent,
    CustomerFormComponent,
    PageNotFoundComponent,
    NestedFacilityDetailsComponent,
    MatSelectModule,
    MatCheckboxModule,
    MultiSelectComponent,
    MatDialogModule,
    EllipsifyMeDirective,
    LoaderComponent,
    PercentageDirective,
    InterchangeFormComponent,
    VarcharOnlyDirective,
    VarcharSpaceDirective,
    SavedSearchComponent,
    CurrencyOnlyDirective,
    LoanSearchComponent
  ]
})
export class SharedModule { }
