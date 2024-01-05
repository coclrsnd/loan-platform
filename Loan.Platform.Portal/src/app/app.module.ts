import { APP_INITIALIZER, NgModule } from '@angular/core';
import { BrowserModule, Title } from '@angular/platform-browser';
import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { BrowserAnimationsModule } from '@angular/platform-browser/animations';
import { SharedModule } from './shared/shared.module';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { TranslateLoader, TranslateModule} from '@ngx-translate/core';
import { TranslateHttpLoader} from '@ngx-translate/http-loader';
import { HttpClient, HttpClientModule, HTTP_INTERCEPTORS} from '@angular/common/http';
import { UserService } from './login/user-service';
import { ApiService } from './services/api.service';
import { NgMultiSelectDropDownModule } from 'ng-multiselect-dropdown';
import { ToastrModule } from 'ngx-toastr';
import { AuthService } from './services/auth.service';
import { NgChartsModule } from 'ng2-charts';
import { BsDropdownModule } from 'ngx-bootstrap/dropdown';
import { RiderService } from './search/rider/rider-service';
import { CurrencyService } from './search/currency/currency-service';
import { StorageFeatureService } from './search/storagefeature/storagefeature-service';

import { UserManagementService } from './search/users/usermanagement-service';
import { VendorService } from './search/vendor/vendor-service';
import { CustomerService } from './search/customer/customer-service';
import { StorageFacilityService } from './search/storage-facility/storagefacility-service';
import { ContractTypeService } from './search/contract-type/contracttype-service';
import { RailCarTypeService } from './search/rail-car-type/railCarTypeService';
import { LEContentService } from './search/le-content/leContentService';
import { RailCarService } from './search/rider-details/rail-car-details-tab/railCarService';
import { MatTooltipModule } from '@angular/material/tooltip';
import { ApiInterceptor } from './services/api.interceptor';
import { AppConfigService } from './services/app-config.service';
import { JwtModule } from "@auth0/angular-jwt";
import { ReportService } from './reports/activity-report/report-service';

const appInitializerFn = (appConfig: AppConfigService) => {
  return () => {
    return appConfig.loadAppConfig();
  }
};

@NgModule({
  declarations: [
    AppComponent
  ],
  imports: [
    BrowserModule,
    AppRoutingModule,
    BrowserAnimationsModule,
    SharedModule,
    FormsModule,
    ReactiveFormsModule,
    HttpClientModule,
    NgChartsModule,
    MatTooltipModule,
    NgMultiSelectDropDownModule.forRoot(),
    ToastrModule.forRoot(),
    TranslateModule.forRoot({
      loader: {
          provide: TranslateLoader,
          useFactory: HttpLoaderFactory,
          deps: [HttpClient]
      }
  }),
    BsDropdownModule.forRoot(),
    JwtModule.forRoot({
      config: {
        tokenGetter:  () => localStorage.getItem('Token')
      }
    })
  ],
  providers: [Title, UserService, ApiService, AuthService, RiderService, CurrencyService, StorageFeatureService,
      UserManagementService, VendorService, CustomerService, StorageFacilityService, ContractTypeService, RailCarTypeService, LEContentService, RailCarService,ReportService,
    { provide: HTTP_INTERCEPTORS, useClass: ApiInterceptor, multi: true },
    AppConfigService,{ provide: APP_INITIALIZER, useFactory: appInitializerFn, multi: true, deps: [AppConfigService] }],
  bootstrap: [AppComponent]
})
export class AppModule { }

export function HttpLoaderFactory(http: HttpClient): TranslateHttpLoader {
  return new TranslateHttpLoader(http);
}
