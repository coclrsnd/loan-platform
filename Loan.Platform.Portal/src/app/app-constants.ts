export const APP_CONSTANTS = {
  emptyString: '',
  defaultNumberValue: 0,
  SPLCAutoCompleteMinCharLength: 2,
  DefaultDateTimeFormat: 'MM/dd/yyyy',
  StandardDateTimeFormat:"yyyy-MM-dd'T'HH:mm:ss.ss",
  true: true,
  false: false,
  null: null,
  undefined: undefined,
  string: 'string',
  warning: 'warning',
  create: 'create',
  copy: 'copy',
  edit: 'edit',
  view: 'view',
  delete: 'delete',
  Pending: 'Pending',
  duplicate: 'duplicate',
  addCars: 'addCars',
  update: 'update',
  upload: 'upload',
  loginPage: '/login',
  signUpPage: '/sign-up',
  forgotPasswordPage: '/forgot-password',
  resetPasswordPage: '/reset-password',
  verifyEmail: '/verify-email',
  onboardCustomer: 'onboardCustomer',
  contractTypeReserve:"RESERVE",
  TakeOrPay:"TAKE-OR-PAY",
  storageOrder: 'storageOrder',
  searchRailCars: 'searchRailCars',
  searchCustomerDetails: 'searchCustomerDetails',
  StorageFacilityDetailsComponent: 'StorageFacilityDetailsComponent',
  RatesListComponent: 'RatesListComponent',
  InterchangesListComponent: 'InterchangesListComponent',
  timeRange: [
    {
      Name: 'Last Month',
      Id: 1
    },
    {
      Name: 'Current Month',
      Id: 2
    },
    {
      Name: 'Custom',
      Id: 3
    }
  ],
  SuperAdmin: 'SuperAdmin',
  Admin: 'Admin',
  Vendor: 'Vendor',
  Customer: 'Customer',
  AllowedFileType: ['jpg', 'jpeg', 'doc', 'docx', 'xlsx', 'png', 'csv', 'pdf', 'txt'],
  MaxFileUploadSize: 5242880,
  unitList: [
    {
      Name: 'Kg',
      Id: 1
    },
    {
      Name: 'Ton',
      Id: 2
    },
    {
      Name: 'Metric Ton',
      Id: 3
    },
    {
      Name: 'Pounds',
      Id: 4
    }
  ],
  hazmatTF: [{
    Name: 'Yes',
    Id: true
  },
  {
    Name: 'No',
    Id: false
  }],
  fFeatureList: [
    {
      'Id': 1,
      'Name': 'Hazmat Cars',
      'Description': 'Hazmat Cars',
      'IsActive': true,
      'CreatedTime': '2022-06-17T13:49:42.7133169',
      'CreatedBy': 1,
      'ModifiedTime': '2022-06-17T13:49:42.7133169',
      'ModifiedBy': 0,
      'OrganizationId': 0,
      'TenantId': 0,
      'Checked': true
    },
    {
      'Id': 2,
      'Name': 'Loaded Cars',
      'Description': 'Loaded Cars',
      'IsActive': true,
      'CreatedTime': '2022-06-17T13:49:42.7133177',
      'CreatedBy': 1,
      'ModifiedTime': '2022-06-17T13:49:42.7133178',
      'ModifiedBy': 0,
      'OrganizationId': 0,
      'TenantId': 0,
      'Checked': false
    },
    {
      'Id': 3,
      'Name': 'Cherrypicking',
      'Description': 'Cherrypicking',
      'IsActive': true,
      'CreatedTime': '2022-06-17T13:49:42.7133184',
      'CreatedBy': 1,
      'ModifiedTime': '2022-06-17T13:49:42.7133185',
      'ModifiedBy': 0,
      'OrganizationId': 0,
      'TenantId': 0,
      'Checked': false
    },
    {
      'Id': 4,
      'Name': 'Secured Facility',
      'Description': 'Secured Facility',
      'IsActive': true,
      'CreatedTime': '2022-06-17T13:49:42.7133191',
      'CreatedBy': 1,
      'ModifiedTime': '2022-06-17T13:49:42.7133191',
      'ModifiedBy': 0,
      'OrganizationId': 0,
      'TenantId': 0,
      'Checked': false
    },
    {
      'Id': 5,
      'Name': 'Scrapping',
      'Description': 'Scrapping',
      'IsActive': true,
      'CreatedTime': '2022-06-17T13:49:42.7133197',
      'CreatedBy': 1,
      'ModifiedTime': '2022-06-17T13:49:42.7133197',
      'ModifiedBy': 0,
      'OrganizationId': 0,
      'TenantId': 0,
      'Checked': false
    },
    {
      'Id': 6,
      'Name': 'Repair',
      'Description': 'Repair',
      'IsActive': true,
      'CreatedTime': '2022-06-17T13:49:42.7133205',
      'CreatedBy': 1,
      'ModifiedTime': '2022-06-17T13:49:42.7133206',
      'ModifiedBy': 0,
      'OrganizationId': 0,
      'TenantId': 0,
      'Checked': false
    },
    {
      'Id': 7,
      'Name': 'Mechanical',
      'Description': 'Mechanical',
      'IsActive': true,
      'CreatedTime': '2022-06-17T13:49:42.7133211',
      'CreatedBy': 1,
      'ModifiedTime': '2022-06-17T13:49:42.7133212',
      'ModifiedBy': 0,
      'OrganizationId': 0,
      'TenantId': 0,
      'Checked': false
    },
    {
      'Id': 8,
      'Name': 'Cleaning',
      'Description': 'Cleaning',
      'IsActive': true,
      'CreatedTime': '2022-06-17T13:49:42.7133217',
      'CreatedBy': 1,
      'ModifiedTime': '2022-06-17T13:49:42.7133218',
      'ModifiedBy': 0,
      'OrganizationId': 0,
      'TenantId': 0,
      'Checked': false
    },
    {
      'Id': 9,
      'Name': 'Recertification',
      'Description': 'Recertification',
      'IsActive': true,
      'CreatedTime': '2022-06-17T13:49:42.7133224',
      'CreatedBy': 1,
      'ModifiedTime': '2022-06-17T13:49:42.7133224',
      'ModifiedBy': 0,
      'OrganizationId': 0,
      'TenantId': 0,
      'Checked': false
    },
    {
      'Id': 10,
      'Name': 'Strip Aligning',
      'Description': 'Strip Aligning',
      'IsActive': true,
      'CreatedTime': '2022-06-17T13:49:42.7133231',
      'CreatedBy': 1,
      'ModifiedTime': '2022-06-17T13:49:42.7133232',
      'ModifiedBy': 0,
      'OrganizationId': 0,
      'TenantId': 0
    }
  ],
  railVendorObject: {
      FirstName: 'Travis',
      LastName: 'Scott',
      PrimaryContactNo: 'Hello',
      PrimaryContactEmail: 'Hello',
      SecondaryContactNo: 'Hello',
      SecondaryContactEmail: 'Hello',
      Address: 'Hello',
      Country: 'Hello',
      State: 'Hello',
      City: 'Hello',
      ZipCode: 'Hello',
      Organization: 'Hello',
      Subsidary: 'Hello',
      EffectiveDate: '2022-12-11T18:30:00.000Z',
      ExpiryDate: '2022-12-29T18:30:00.000Z',
      Website: 'Hello',
      Description: 'Hello',
      StorageFacilities : [
              {
              Name: 'Hello',
              Lat: 'Hello',
              Long: 'Hello',
              Capacity: 'Hello',
              AvailableCars: 'Hello',
              Rating: 'Hello',
              PrimaryContactNumber: 'Hello',
              PrimaryEmail: 'Hello@hello.com',
              SecondaryContactNumber: 'Hello',
              SecondaryEmail: 'Hello',
              EffectiveDate: '2022-12-11T18:30:00.000Z',
              ExpiryDate: '2022-12-29T18:30:00.000Z',
              Address: 'Hello',
              ZipCode: 'Hello',
              Country: 'Hello',
              State: 'Hello',
              City: 'Hello',
              SPLC: 'Hello',
              Priority: 'Hello',
              GrossRailRoad: 'Hello',
              StorageFacilityRates : [{
                      Rate: '',
                      Currency: 'USD',
                      PercentageMargin: '2%',
                      DailyStorageRate: '$10',
                      SwitchIn: '',
                      SwitchOut: '',
                      SwitchingRate: '',
                      SpecialSwitchingRate: '',
                      HazmatSurchargeRate: '',
                      LoadedSurchargeRate: '',
                      CherryPickingRate: '',
                      EffectiveDate: '2022-12-11T18:30:00.000Z',
                      ExpiryDate: '2022-12-29T18:30:00.000Z',
                      ReservationRate: ''
                      },
                      {
                      Rate: '',
                      Currency: 'GBP',
                      PercentageMargin: '2%',
                      DailyStorageRate: '$10',
                      SwitchIn: '',
                      SwitchOut: '',
                      SwitchingRate: '',
                      SpecialSwitchingRate: '',
                      HazmatSurchargeRate: '',
                      LoadedSurchargeRate: '',
                      CherryPickingRate: '',
                      EffectiveDate: '2022-12-11T18:30:00.000Z',
                      ExpiryDate: '2022-12-29T18:30:00.000Z',
                      ReservationRate: ''
                      },
                      {
                      Rate: '',
                      Currency: 'USDS',
                      PercentageMargin: '2%',
                      DailyStorageRate: '$10',
                      SwitchIn: '',
                      SwitchOut: '',
                      SwitchingRate: '',
                      SpecialSwitchingRate: '',
                      HazmatSurchargeRate: '',
                      LoadedSurchargeRate: '',
                      CherryPickingRate: '',
                      EffectiveDate: '2022-12-11T18:30:00.000Z',
                      ExpiryDate: '2022-12-29T18:30:00.000Z',
                      ReservationRate: ''
                      }
                  ],
              Features: {
                  HazmatCars: true,
                  LoadedCars: true,
                  CherryPicking: true,
                  FacilitySecurity: true,
                  Scrapping: false,
                  Repair: false,
                  Mechinical: false
                  },
              isExpanded: false
              },
              {
              Name: 'Hello',
              Lat: 'Hello',
              Long: 'Hello',
              Capacity: 'Hello',
              AvailableCars: 'Hello',
              Rating: '',
              PrimaryContactNumber: 'Hello',
              PrimaryEmail: 'Hello2@hello.com',
              SecondaryContactNumber: 'Hello',
              SecondaryEmail: 'Hello',
              EffectiveDate: '2022-06-20T18:30:00.000Z',
              ExpiryDate: '2022-06-29T18:30:00.000Z',
              Address: '',
              ZipCode: '',
              Country: '',
              State: '',
              City: '',
              SPLC: '',
              Priority: '',
              GrossRailRoad: '',
              StorageFacilityRates: [
                      {
                      Rate: '',
                      Currency: 'USD',
                      PercentageMargin: '2%',
                      DailyStorageRate: '$10',
                      SwitchIn: '',
                      SwitchOut: '',
                      SwitchingRate: '',
                      SpecialSwitchingRate: '',
                      HazmatSurchargeRate: '',
                      LoadedSurchargeRate: '',
                      CherryPickingRate: '',
                      EffectiveDate: '2022-12-11T18:30:00.000Z',
                      ExpiryDate: '2022-12-29T18:30:00.000Z',
                      ReservationRate: ''
                      }
                  ],
              Features: {
                  HazmatCars: false,
                  LoadedCars: true,
                  CherryPicking: false,
                  FacilitySecurity: true,
                  Scrapping: true,
                  Repair: true,
                  Mechinical: true
                  },
              isExpanded: false
              }
          ]
},
  dropdownData: [
    {id: 'Admin', value: 'Admin'},
    {id: 'Vendor', value: 'Vendor'},
    {id: 'Customer', value: 'Customer'},
  ],
  statusDetails: [
    {id: 'Pending', value: 'Pending'},
    {id: 'Approved', value: 'Approved'},
    {id: 'Rejected', value: 'Rejected'},
  ],
  organisationDetails: [
    {id: 'Organisation 1', value: 'Organisation 1'},
    {id: 'Organisation 2', value: 'Organisation 2'},
    {id: 'Organisation 3', value: 'Organisation 3'},
  ],
  userType: [
    {id: 'Customer', value: 'Customer'},
    {id: 'Vendor', value: 'Vendor'},
  ],
  bsConfig: {
    containerClass:'theme-blue',
    dateInputFormat: 'DD/MM/YYYY'
  },
  dashboard: 'dashboard',
  login: 'login',
  signUp: 'sign-up',
  forgotPassword: 'forgot-password',
  onBoardVendor: 'on-board-vendor',
  searchVendorDetails: 'search-vendor-details',
  cityState: 'cityState',
  onlyName: 'onlyName',
  brokerageType: [
    { Name: 'Percentage Margin', Id: 0 },
    { Name: 'Flat Rate' , Id: 1 },
  ],
  LandE: [
    { Name: 'Loaded', Id: 1 },
    { Name: 'Empty', Id: 2 },
    { Name: 'Empty Residue', Id: 3 }
  ],
  vendor: [
    { Name: 'IBM', id: 1 },
    { Name: 'Apple' , id: 2 },
    { Name: 'Able Woods' , id: 3 },
    { Name: 'Abercrombie' , id: 4 },
    { Name: 'Abetter' , id: 5 },
    { Name: 'Facebook' , id: 6 },
    { Name: 'Google', id: 7 }
  ],
  customer: [
    { Name: 'IBM', id: 1 },
    { Name: 'Apple' , id: 2 },
    { Name: 'Able Woods' , id: 3 },
    { Name: 'Abercrombie' , id: 4 },
    { Name: 'Abetter' , id: 5 },
    { Name: 'Facebook' , id: 6 },
    { Name: 'Google', id: 7 }
  ],
  numInfo: [
    {
      number: '---',
      details: 'Storage Vendors'
    },
    {
      number: '---',
      details: 'Contracted Space'
    },
    {
      number: '---',
      details: 'Cars On Hand'
    },
    {
      number: '---',
      details: 'Space Available'
    },
    {
      number: '---',
      details: 'Loaded'
    },
    {
      number: '---',
      details: 'Empty'
    }
  ],

  storageOrderInfo: [
    {
      number: 1,
      details: 'Riders'
    },
    {
      number: 1,
      details: 'Active'
    },
    {
      number: 0,
      details: 'Expired'
    },
    {
      number: 200,
      details: 'Contracted Space'
    },
    {
      number: 2,
      details: 'Car Stored'
    },
    {
      number: '95.00',
      details: 'Total Amount IN ($)'
    },
    {
      number: '900.00',
      details: 'Avg. Monthly IN ($)'
    }
  ],
  vendorInfo: [
    {
      number: 6,
      details: 'Storage Vendors'
    },
    {
      number: 10,
      details: 'Storage Facilities'
    },
    {
      number: 200,
      details: 'Contracted Spaces'
    },
    {
      number: 100,
      details: 'Space Available'
    },
    {
      number: 100,
      details: 'Car Stored'
    },
    {
      number: 30,
      details: 'Loaded'
    },
    {
      number: 70,
      details: 'Empty'
    }
  ],
  customerInfo: [
    {
      number: 2,
      details: 'Customers'
    },
    {
      number: 200,
      details: 'Contracted Spaces'
    },
    {
      number: 2,
      details: 'Cars Stored'
    },
    {
      number: 1,
      details: 'Storage Orders'
    },
  ],
  railcarInfo: [
    {
      number: 2,
      details: 'Cars Stored'
    },
    {
      number: 1,
      details: 'Loaded'
    },
    {
      number: 1,
      details: 'Empty'
    },
    {
      number: 2,
      details: 'Car Types'
    },
    {
      number: 1,
      details: 'Contents'
    },
    {
      number: 1,
      details: 'Fleet'
    }
  ],
  searchResults: [
    {
      favourate: true,
      distance: 200,
      rating: 4.5,
      ratingCount: 156,
      cityState: 'Interchange City, State',
      available: 120,
      total: 500,
      rate: 20,
      status: 'one'
    },
    {
      favourate: false,
      distance: 350,
      rating: 4,
      ratingCount: 540,
      cityState: 'Interchange City, State',
      available: 120,
      total: 500,
      rate: 8,
      status: 'two'
    },
    {
      favourate: true,
      distance: 400,
      rating: 3.5,
      ratingCount: 40,
      cityState: 'Interchange City, State',
      available: 190,
      total: 300,
      rate: 25,
      status: 'three'
    },
    {
      favourate: false,
      distance: 500,
      rating: 3,
      ratingCount: 50,
      cityState: 'Interchange City, State',
      available: 270,
      total: 300,
      rate: 20,
      status: 'two'
    },
  ],
  singleRateRecord : [{
    Rates: 'Rate1',
    Currency: 'USD',
    PercentageMargin: 12,
    DailyStorageRate: 10,
    SwitchIn: 120,
    SwitchOut: 150,
    SwitchingRate: 5,
    SpecialSwitchingRate: 5,
    HazmatSurcharge: 100,
    LoadedSurcharge: 100,
    CherryPickingRate: 20,
    EffectiveDate: '2022-03-22',
    ExpiryDate: '2022-03-30',
    ReservationRate: 30,
    isExpanded: false
},
{
  Rates: 'Rate2',
  Currency: 'USD',
  PercentageMargin: 12,
  DailyStorageRate: 10,
  SwitchIn: 120,
  SwitchOut: 150,
  SwitchingRate: 5,
  SpecialSwitchingRate: 5,
  HazmatSurcharge: 100,
  LoadedSurcharge: 100,
  CherryPickingRate: 20,
  EffectiveDate: '2022-03-22',
  ExpiryDate: '2022-03-30',
  ReservationRate: 30,
  isExpanded: false
}],
  USERS : [
    {
      name: 'Rates 1',
      email: 'mason@test.com',
      phone: '9864785214',
      Facility: 'AB Storage',
      Location: 'Somewhere, NY',
      Interchange: 'Railroad 1',
      isExpanded: false,
      AvailableSpace: '500',
      PrimaryContact: '+1123 4567891',
      PrimaryEmail: 'abc@xyz.com',
      addresses: [
        {
          street: 'Street 1',
          Rates: 'Rates 1',
          EffectiveDate: new Date('01/01/2022'),
          ExpiryDate: new Date('01/31/2022'),
          zipCode: '78542',
          city: 'Kansas',
          isExpanded: false,
          Currency: 'USD',
          PercentageMargin: '2%',
          DailyStorageRate: '$ 10',
          SwitchIn: 3,
          SwitchOut: 5,
          SwitchingRate: '$ 7',
          SpecialSwitchingRate: '1$ 0',
          HazmatSurcharge: '$ 5',
          LoadedSurcharge: '$ 3',
          CherryPickingRate: '$ 5',
          ReservationRate: '$ 2',
          comments: [
            {
              commenID: 1,
              comment: 'Test',
              commentStatus: 'Open',
            },
            {
              commenID: 2,
              comment: 'Test',
              commentStatus: 'Open',
            },
            {
              commenID: 3,
              comment: 'Test',
              commentStatus: 'Closed',
            },
          ],
        },
        {
          street: 'Street 2',
          zipCode: '78554',
          city: 'Texas',
          Rates: 'Rates 2',
          EffectiveDate: '01/01/2022',
          ExpiryDate: '01/31/2022',
          isExpanded: false,
          comments: [
            {
              commenID: 4,
              comment: 'Test',
              commentStatus: 'Open',
            },
            {
              commenID: 5,
              comment: 'Test',
              commentStatus: 'Open',
            },
            {
              commenID: 6,
              comment: 'Test',
              commentStatus: 'Closed',
            },
          ],
        },
        {
          street: 'Street 3',
          zipCode: '78554',
          city: 'Texas',
          Rates: 'Rates 3',
          EffectiveDate: '01/01/2022',
          ExpiryDate: '01/31/2022',
          isExpanded: false,
          comments: [
            {
              commenID: 4,
              comment: 'Test',
              commentStatus: 'Open',
            },
            {
              commenID: 5,
              comment: 'Test',
              commentStatus: 'Open',
            },
            {
              commenID: 6,
              comment: 'Test',
              commentStatus: 'Closed',
            },
          ],
        }
      ],
    },
    {
      name: 'Rates 2',
      email: 'eugene@test.com',
      phone: '8786541234',
      Facility: 'B Storage',
      Location: 'Elsewhere, NY',
      Interchange: 'Railroad 2',
      isExpanded: false,
      AvailableSpace: '500',
      PrimaryContact: '+1123 4567890',
      PrimaryEmail: 'abc@xyz.com',
      addresses: [
        {
          street: 'Street 5',
          zipCode: '23547',
          city: 'Utah',
          Rates: 'Rates 1',
          EffectiveDate: '01/01/2022',
          ExpiryDate: '01/31/2022',
          isExpanded: false,
          comments: [
            {
              commenID: 7,
              comment: 'Test',
              commentStatus: 'Open',
            },
            {
              commenID: 8,
              comment: 'Test',
              commentStatus: 'Open',
            },
            {
              commenID: 9,
              comment: 'Test',
              commentStatus: 'Closed',
            },
          ],
        },
        {
          street: 'Street 5',
          zipCode: '23547',
          city: 'Ohio',
          Rates: 'Rates 1',
          EffectiveDate: '01/01/2022',
          ExpiryDate: '01/31/2022',
          isExpanded: false,
          comments: [
            {
              commenID: 19,
              comment: 'Test',
              commentStatus: 'Open',
            },
            {
              commenID: 11,
              comment: 'Test',
              commentStatus: 'Open',
            },
            {
              commenID: 12,
              comment: 'Test',
              commentStatus: 'Closed',
            },
          ],
        },
      ],
    },
    {
      name: 'Rates 3',
      email: 'jason@test.com',
      phone: '7856452187',
      Facility: 'C Storage',
      Location: 'Nowhere, NY',
      Interchange: 'Railroad 3',
      isExpanded: false,
      AvailableSpace: '500',
      PrimaryContact: '+1123 4567893',
      PrimaryEmail: 'abc@xyz.com',
      addresses: [
        {
          street: 'Street 5',
          zipCode: '23547',
          city: 'Utah',
          Rates: 'Rates 1',
          EffectiveDate: '01/01/2022',
          ExpiryDate: '01/31/2022',
          isExpanded: false,
          comments: [
            {
              commenID: 13,
              comment: 'Test',
              commentStatus: 'Open',
            },
            {
              commenID: 14,
              comment: 'Test',
              commentStatus: 'Open',
            },
            {
              commenID: 15,
              comment: 'Test',
              commentStatus: 'Closed',
            },
          ],
        },
        {
          street: 'Street 5',
          zipCode: '23547',
          city: 'Ohio',
          Rates: 'Rates 1',
          EffectiveDate: '01/01/2022',
          ExpiryDate: '01/31/2022',
          isExpanded: false,
          comments: [
            {
              commenID: 16,
              comment: 'Test',
              commentStatus: 'Open',
            },
            {
              commenID: 17,
              comment: 'Test',
              commentStatus: 'Open',
            },
            {
              commenID: 18,
              comment: 'Test',
              commentStatus: 'Closed',
            },
          ],
        },
      ],
    },
  ],
 dataTable : [
    {
      icon: 'icon-green-flag',
      imageUrl:
        'https://i.ytimg.com/vi/XmsSU9uDsbc/hqdefault.jpg?sqp=-oaymwEWCKgBEF5IWvKriqkDCQgBFQAAiEIYAQ==&rs=AOn4CLCA-iTMmDZKrsZh7KfItdBZ6PkqZA',
      position: 1,
      name: 'Hydrogen',
      weight: 1.0079,
      UserType: 'customer',
      FirstName: 'Robby',
      LastName: 'Scott',
      CompanyName: '40 Mile Rail',
      CompanyEmail: 'abc@xyz.com',
      Title: 'Manager',
      ContactNumber: '+1 123 4567890',
      Status: 'Approved',
      Customer: 'Customer A',
      Organisation: 'Company A',
      Subsidary: 'Railroad 3',
      Location: 'Foremost, AB',
      PrimaryContact: '+1 123 4567890',
      PrimaryEmail: 'abc@xyz.com',
      facility: '3 Facilities',
      symbol: 'H',
      vendor: '40 Mile Rail',
      location: 'Foremost, AB',
      contracted_spaces: 500,
      cars_on_hand: 391,
      cars_enroute: 100,
      space_available: 9,
      cars_stored: 1000,
      months: 10,
      total: 30000,
      avg_monthly_cost: 3000,
      avg_par_car_cost: 3,
      exp_in_days: 20,
      Rider: 12345678,
      storage: 'Mountainview Terminals Calgary',
      EffectiveDate: '1/1/2021',
      ExpiryDate: '12/31/2022',
      StorageFacilityId: '1000',
      HazmatSurcharge: 'N',
      SwitchIn: '200',
      SwitchOut: '200',
      Description: 'Rider #12345678 - Mountainview Terminals Calgary & Ontracks Rail',
      SearchName: 'CARG - FRC - 2022 - 1, 40 Mile Rail, Cargill',
      LastRun: '07/05/2022, 03:05 PM',
      Interchanges: '3',
      ContractedSpace: '1,000',
      CarsStored: '1,000',
      TotalAmount: 30000,
      children: [
        {
          Vendor: 'Storage A Tush',
          Location: 'Anywhere, CO',
          Interchanges: 'CP',
          ConstantSpace: '1000',
          CarsStored: '1000',
          TotalAmount: '30000',
          AverageMonthlyCost: '3000',
          AverageCarCost: '3',
          Facility: 'A Storage'
        },
        {
          Vendor: 'Storage B',
          Location: 'Little Town, CO',
          Interchanges: 'CNSF',
          ConstantSpace: '1000',
          CarsStored: '1000',
          TotalAmount: '30000',
          AverageMonthlyCost: '3000',
          AverageCarCost: '3',
          Facility: 'B Storage'
        },
        {
          Vendor: 'Storage C',
          Location: 'That Space, CO',
          Interchanges: 'CN',
          ConstantSpace: '1000',
          CarsStored: '1000',
          TotalAmount: '30000',
          AverageMonthlyCost: '3000',
          AverageCarCost: '3',
          Facility: 'C Storage'
        },
      ]
    },
    {
      icon: 'icon-green-flag',
      imageUrl:
        'https://www.banderasnews.com/1510/images/Ferromex.jpg',
      position: 2,
      name: 'Helium',
      weight: 4.0026,
      UserType: 'vendor',
      FirstName: 'Stephen',
      LastName: 'Martin',
      CompanyName: 'ABC Company',
      CompanyEmail: 'abc@xyz.com',
      Title: 'Manager',
      ContactNumber: '+1 123 4567890',
      Status: 'Rejected',
      Customer: 'Customer B',
      Organisation: 'Company B',
      Subsidary: 'Railroad 2',
      Location: 'Calgary, AB',
      PrimaryContact: '+1 122 4567890',
      PrimaryEmail: 'abc@xyz.com',
      facility: '4 Facilities',
      symbol: 'He',
      vendor: 'Mountainview Terminals',
      location: 'Calgary, AB',
      contracted_spaces: 250,
      cars_on_hand: 100,
      cars_enroute: 50,
      space_available: 100,
      cars_stored: 750,
      months: 10,
      total: 20000,
      avg_monthly_cost: 2000,
      avg_par_car_cost: 2.7,
      exp_in_days: 60,
      Rider: 23456789,
      storage: 'Vendor B',
      EffectiveDate: '1/1/2019',
      ExpiryDate: '12/31/2020',
      StorageFacilityId: '1000',
      HazmatSurcharge: 'N',
      SwitchIn: '200',
      SwitchOut: '200',
      Description: 'Rider #12345678 - Mountainview Terminals Calgary & Ontracks Rail',
      SearchName: 'Rider No - 12345678, Mountainview Terminals Calgary, TRRA',
      LastRun: '07/01/2022, 12:22 AM',
      Interchanges: '3',
      ContractedSpace: '1,000',
      CarsStored: '1,000',
      TotalAmount: 30000,
    children: [
        {
          Vendor: 'Storage A Tushar',
          Location: 'Anywhere, CO',
          Interchanges: 'Railroad 2',
          ConstantSpace: '1000',
          CarsStored: '1000',
          TotalAmount: '30000',
          AverageMonthlyCost: '3000',
          AverageCarCost: '3',
          Facility: 'A Storage',
          comments: [
            {
              commenID: 13,
              comment: 'Test',
              commentStatus: 'Open',
            },
            {
              commenID: 14,
              comment: 'Test',
              commentStatus: 'Open',
            },
            {
              commenID: 15,
              comment: 'Test',
              commentStatus: 'Closed',
            },
          ],
        },
        {
          Vendor: 'Storage B',
          Location: 'Little Town, CO',
          Interchanges: 'Railroad 2',
          ConstantSpace: '1000',
          CarsStored: '1000',
          TotalAmount: '30000',
          AverageMonthlyCost: '3000',
          AverageCarCost: '3',
          Facility: 'A Storage',
          comments: [
            {
              commenID: 16,
              comment: 'Test',
              commentStatus: 'Open',
            },
            {
              commenID: 17,
              comment: 'Test',
              commentStatus: 'Open',
            },
            {
              commenID: 18,
              comment: 'Test',
              commentStatus: 'Closed',
            },
          ],
        },
        {
          Vendor: 'Storage C',
          Location: 'That Space, CO',
          Interchanges: 'Railroad 2',
          ConstantSpace: '1000',
          CarsStored: '1000',
          TotalAmount: '30000',
          AverageMonthlyCost: '3000',
          AverageCarCost: '3',
          Facility: 'A Storage',
          comments: [
            {
              commenID: 13,
              comment: 'Test',
              commentStatus: 'Open',
            },
            {
              commenID: 14,
              comment: 'Test',
              commentStatus: 'Open',
            },
            {
              commenID: 15,
              comment: 'Test',
              commentStatus: 'Closed',
            },
          ],
        },
        {
          Vendor: 'Storage C',
          Location: 'That Space, CO',
          Interchanges: 'Railroad 2',
          ConstantSpace: '1000',
          CarsStored: '1000',
          TotalAmount: '30000',
          AverageMonthlyCost: '3000',
          AverageCarCost: '3',
          Facility: 'A Storage',
          comments: [
            {
              commenID: 13,
              comment: 'Test',
              commentStatus: 'Open',
            },
            {
              commenID: 14,
              comment: 'Test',
              commentStatus: 'Open',
            },
            {
              commenID: 15,
              comment: 'Test',
              commentStatus: 'Closed',
            },
          ],
        }
      ]
    },
    {
      icon: 'icon-grey-flag',
      imageUrl:
        'https://cdnimg.bnamericas.com/UyTZzlOqMxsmaSFWVRfyAjIjuXbHeSxjYkuhaaooqSlbfQqGTUzaYVYtwLUqljcC.jpg',
      position: 3,
      name: 'Lithium',
      weight: 6.941,
      UserType: '',
      FirstName: 'Charl',
      LastName: 'Young',
      CompanyName: 'ABC Company',
      CompanyEmail: 'abc@xyz.com',
      Title: 'Manager',
      ContactNumber: '+1 123 4567890',
      Status: 'Pending',
      Customer: 'Customer C',
      Organisation: 'Company C',
      Subsidary: 'Railroad 3',
      Location: 'Stettler, AB',
      PrimaryContact: '+1 123 4567890',
      PrimaryEmail: 'abc@xyz.com',
      facility: '2 Facilities',
      symbol: 'H',
      vendor: 'Alberta Prairie Railway',
      location: 'Stettler, AB',
      contracted_spaces: 400,
      cars_on_hand: 326,
      cars_enroute: 50,
      space_available: 24,
      cars_stored: 1500,
      months: 10,
      total: 15000,
      avg_monthly_cost: 1500,
      avg_par_car_cost: 1,
      exp_in_days: 5,
      Rider: 34567892,
      storage: 'Vendor B',
      EffectiveDate: '1/1/2019',
      ExpiryDate: '12/31/2020',
      StorageFacilityId: '1000',
      HazmatSurcharge: 'N',
      SwitchIn: '200',
      SwitchOut: '200',
      Description: 'Rider #12345678 - Mountainview Terminals Calgary & Ontracks Rail',
      SearchName: 'Rider No - 12345678, Mountainview Terminals Calgary, TRRA',
      LastRun: '06/30/2022, 01:03 PM',
      Interchanges: '3',
      ContractedSpace: '1,000',
      CarsStored: '1,000',
      TotalAmount: 30000,
    children: [
        {
          Vendor: 'Storage A Dipali',
          Location: 'Anywhere, CO',
          Interchanges: 'Railroad 2',
          ConstantSpace: '1000',
          CarsStored: '1000',
          TotalAmount: '30000',
          AverageMonthlyCost: '3000',
          AverageCarCost: '3',
          Facility: 'A Storage'
        },
        {
          Vendor: 'Storage B',
          Location: 'Little Town, CO',
          Interchanges: 'Railroad 2',
          ConstantSpace: '1000',
          CarsStored: '1000',
          TotalAmount: '30000',
          AverageMonthlyCost: '3000',
          AverageCarCost: '3',
          Facility: 'A Storage'
        }
      ]
    },
    {
      icon: 'icon-red-flag',
      imageUrl:
        'https://www.freightwaves.com/wp-content/uploads/2020/01/Mexico_train_robberies_1.jpg',
      position: 4,
      name: 'Beryllium',
      weight: 9.0122,
      UserType: 'customer',
      FirstName: 'Charl',
      LastName: 'Young',
      CompanyName: 'ABC Company',
      CompanyEmail: 'abc@xyz.com',
      Title: 'Manager',
      ContactNumber: '+1 123 4567890',
      Status: 'Approved',
      Customer: 'Customer D',
      Organisation: 'Company D',
      Subsidary: 'Railroad 4',
      Location: 'Lamont County, AB',
      PrimaryContact: '+1 123 4567890',
      PrimaryEmail: 'abc@xyz.com',
      facility: '5 Facilities',
      symbol: 'Be',
      vendor: 'Alberta Midland Railway Terminal',
      location: 'Lamont County, AB',
      contracted_spaces: 100,
      cars_on_hand: 50,
      cars_enroute: 25,
      space_available: 25,
      cars_stored: 500,
      months: 10,
      total: 10000,
      avg_monthly_cost: 1000,
      avg_par_car_cost: 2,
      exp_in_days: 54,
      Rider: 45678923,
      storage: 'Vendor B',
      EffectiveDate: '1/1/2019',
      ExpiryDate: '12/31/2020',
      StorageFacilityId: '1000',
      HazmatSurcharge: 'N',
      SwitchIn: '200',
      SwitchOut: '200',
      Description: 'Rider #12345678 - Mountainview Terminals Calgary & Ontracks Rail',
      SearchName: 'Rider No - 12345678, Mountainview Terminals Calgary, TRRA',
      LastRun: '06/15/2022, 08:29 PM',
      Interchanges: '3',
      ContractedSpace: '1,000',
      CarsStored: '1,000',
      TotalAmount: 30000,
    children: [
        {
          Vendor: 'Storage A',
          Location: 'Anywhere, CO',
          Interchanges: 'Railroad 2',
          ConstantSpace: '1000',
          CarsStored: '1000',
          TotalAmount: '30000',
          AverageMonthlyCost: '3000',
          AverageCarCost: '3',
          Facility: 'A Storage'
        },
        {
          Vendor: 'Storage B',
          Location: 'Little Town, CO',
          Interchanges: 'Railroad 2',
          ConstantSpace: '1000',
          CarsStored: '1000',
          TotalAmount: '30000',
          AverageMonthlyCost: '3000',
          AverageCarCost: '3',
          Facility: 'A Storage'
        },
        {
          Vendor: 'Storage C',
          Location: 'That Space, CO',
          Interchanges: 'Railroad 2',
          ConstantSpace: '1000',
          CarsStored: '1000',
          TotalAmount: '30000',
          AverageMonthlyCost: '3000',
          AverageCarCost: '3',
          Facility: 'A Storage'
        },
      ]
    },
    {
      icon: 'icon-red-flag',
      imageUrl:
        'https://i.ytimg.com/vi/XmsSU9uDsbc/hqdefault.jpg?sqp=-oaymwEWCKgBEF5IWvKriqkDCQgBFQAAiEIYAQ==&rs=AOn4CLCA-iTMmDZKrsZh7KfItdBZ6PkqZA',
      position: 5,
      name: 'Boron',
      weight: 10.811,
      UserType: '',
      FirstName: 'Charl',
      LastName: 'Young',
      CompanyName: 'ABC Company',
      CompanyEmail: 'abc@xyz.com',
      Title: 'Manager',
      ContactNumber: '+1 123 4567890',
      Status: 'Pending',
      Customer: 'Customer E',
      Organisation: 'Company E',
      Subsidary: 'Railroad 5',
      Location: 'Edmonton, AB',
      PrimaryContact: '+1 123 4567890',
      PrimaryEmail: 'abc@xyz.com',
      facility: '2 Facilities',
      symbol: 'B',
      vendor: 'Mountainview Terminals',
      location: 'Edmonton, AB',
      contracted_spaces: 100,
      cars_on_hand: 50,
      cars_enroute: 25,
      space_available: 25,
      cars_stored: 1000,
      months: 10,
      total: 5000,
      avg_monthly_cost: 6000,
      avg_par_car_cost: 1.2,
      exp_in_days: 15,
      Rider: 15678923,
      storage: 'Vendor B',
      EffectiveDate: '1/1/2019',
      ExpiryDate: '12/31/2020',
      StorageFacilityId: '1000',
      HazmatSurcharge: 'N',
      SwitchIn: '200',
      SwitchOut: '200',
      Description: 'Rider #12345678 - Mountainview Terminals Calgary & Ontracks Rail',
      SearchName: 'Rider No - 12345678, Mountainview Terminals Calgary, TRRA',
      LastRun: '06/11/2022, 08:17 PM',
      Interchanges: '3',
      ContractedSpace: '1,000',
      CarsStored: '1,000',
      TotalAmount: 30000,
    children: [
        {
          Vendor: 'Storage A',
          Location: 'Anywhere, CO',
          Interchanges: 'Railroad 2',
          ConstantSpace: '1000',
          CarsStored: '1000',
          TotalAmount: '30000',
          AverageMonthlyCost: '3000',
          AverageCarCost: '3',
          Facility: 'A Storage'
        },
        {
          Vendor: 'Storage B',
          Location: 'Little Town, CO',
          Interchanges: 'Railroad 2',
          ConstantSpace: '1000',
          CarsStored: '1000',
          TotalAmount: '30000',
          AverageMonthlyCost: '3000',
          AverageCarCost: '3',
          Facility: 'A Storage'
        },
        {
          Vendor: 'Storage C',
          Location: 'That Space, CO',
          Interchanges: 'Railroad 2',
          ConstantSpace: '1000',
          CarsStored: '1000',
          TotalAmount: '30000',
          AverageMonthlyCost: '3000',
          AverageCarCost: '3',
          Facility: 'A Storage'
        },
      ]
    },
    {
      icon: 'icon-green-flag',
      imageUrl:
        'https://i.ytimg.com/vi/XmsSU9uDsbc/hqdefault.jpg?sqp=-oaymwEWCKgBEF5IWvKriqkDCQgBFQAAiEIYAQ==&rs=AOn4CLCA-iTMmDZKrsZh7KfItdBZ6PkqZA',
      position: 6,
      name: 'Carbon',
      weight: 12.0107,
      UserType: '',
      FirstName: 'Charl',
      LastName: 'Young',
      CompanyName: 'ABC Company',
      CompanyEmail: 'abc@xyz.com',
      Title: 'Manager',
      ContactNumber: '+1 123 4567890',
      Status: 'Pending',
      Customer: 'Customer F',
      Organisation: 'Company F',
      Subsidary: 'Railroad 6',
      Location: 'Foremost, AB',
      PrimaryContact: '+1 123 4567890',
      PrimaryEmail: 'abc@xyz.com',
      facility: '3 Facilities',
      symbol: 'C',
      vendor: '40 Mile Rail',
      location: 'Foremost, AB',
      contracted_spaces: 200,
      cars_on_hand: 0,
      cars_enroute: 0,
      space_available: 100,
      cars_stored: 250,
      months: 10,
      total: 10000,
      avg_monthly_cost: 1000,
      avg_par_car_cost: 4,
      exp_in_days: 8,
      Rider: 56789231,
      storage: 'Vendor B',
      EffectiveDate: '1/1/2019',
      ExpiryDate: '12/31/2020',
      StorageFacilityId: '1000',
      HazmatSurcharge: 'N',
      SwitchIn: '200',
      SwitchOut: '200',
      Description: 'Rider #12345678 - Mountainview Terminals Calgary & Ontracks Rail',
      SearchName: 'Rider No - 12345678, Mountainview Terminals Calgary, TRRA',
      LastRun: '06/05/2022, 11:55 PM',
      Interchanges: '3',
      ContractedSpace: '1,000',
      CarsStored: '1,000',
      TotalAmount: 30000,
    children: [
        {
          Vendor: 'Storage A',
          Location: 'Anywhere, CO',
          Interchanges: 'Railroad 2',
          ConstantSpace: '1000',
          CarsStored: '1000',
          TotalAmount: '30000',
          AverageMonthlyCost: '3000',
          AverageCarCost: '3'
        },
        {
          Vendor: 'Storage B',
          Location: 'Little Town, CO',
          Interchanges: 'Railroad 2',
          ConstantSpace: '1000',
          CarsStored: '1000',
          TotalAmount: '30000',
          AverageMonthlyCost: '3000',
          AverageCarCost: '3'
        },
        {
          Vendor: 'Storage C',
          Location: 'That Space, CO',
          Interchanges: 'Railroad 2',
          ConstantSpace: '1000',
          CarsStored: '1000',
          TotalAmount: '30000',
          AverageMonthlyCost: '3000',
          AverageCarCost: '3'
        },
      ]
    },
    {
      icon: 'icon-green-flag',
      imageUrl:
        'https://i.ytimg.com/vi/XmsSU9uDsbc/hqdefault.jpg?sqp=-oaymwEWCKgBEF5IWvKriqkDCQgBFQAAiEIYAQ==&rs=AOn4CLCA-iTMmDZKrsZh7KfItdBZ6PkqZA',
      position: 7,
      name: 'Nitrogen',
      weight: 14.0067,
      UserType: '',
      FirstName: 'Charl',
      LastName: 'Young',
      CompanyName: 'ABC Company',
      CompanyEmail: 'abc@xyz.com',
      Title: 'Manager',
      ContactNumber: '+1 123 4567890',
      Status: 'Pending',
      Customer: 'Customer G',
      Organisation: 'Company G',
      Subsidary: 'Railroad 7',
      Location: 'Calgary, AB',
      PrimaryContact: '+1 123 4567890',
      PrimaryEmail: 'abc@xyz.com',
      facility: '7 Facilities',
      symbol: 'N',
      vendor: 'Mountainview Terminals',
      location: 'Calgary, AB',
      contracted_spaces: 100,
      cars_on_hand: 50,
      cars_enroute: 25,
      space_available: 25,
      cars_stored: 1000,
      months: 10,
      total: 30000,
      avg_monthly_cost: 3000,
      avg_par_car_cost: 3,
      exp_in_days: 72,
      Rider: 67892315,
      storage: 'Vendor B',
      EffectiveDate: '1/1/2019',
      ExpiryDate: '12/31/2020',
      StorageFacilityId: '1000',
      HazmatSurcharge: 'N',
      SwitchIn: '200',
      SwitchOut: '200',
      Description: 'Rider #12345678 - Mountainview Terminals Calgary & Ontracks Rail',
      SearchName: 'Rider No - 12345678, Mountainview Terminals Calgary, TRRA',
      LastRun: '05/22/2022, 01:45 AM',
      Interchanges: '3',
      ContractedSpace: '1,000',
      CarsStored: '1,000',
      TotalAmount: 30000,
    children: [
        {
          Vendor: 'Storage A',
          Location: 'Anywhere, CO',
          Interchanges: 'Railroad 2',
          ConstantSpace: '1000',
          CarsStored: '1000',
          TotalAmount: '30000',
          AverageMonthlyCost: '3000',
          AverageCarCost: '3'
        },
        {
          Vendor: 'Storage B',
          Location: 'Little Town, CO',
          Interchanges: 'Railroad 2',
          ConstantSpace: '1000',
          CarsStored: '1000',
          TotalAmount: '30000',
          AverageMonthlyCost: '3000',
          AverageCarCost: '3'
        },
        {
          Vendor: 'Storage C',
          Location: 'That Space, CO',
          Interchanges: 'Railroad 2',
          ConstantSpace: '1000',
          CarsStored: '1000',
          TotalAmount: '30000',
          AverageMonthlyCost: '3000',
          AverageCarCost: '3'
        },
      ]
    },
    {
      icon: 'icon-green-flag',
      imageUrl:
        'https://i.ytimg.com/vi/XmsSU9uDsbc/hqdefault.jpg?sqp=-oaymwEWCKgBEF5IWvKriqkDCQgBFQAAiEIYAQ==&rs=AOn4CLCA-iTMmDZKrsZh7KfItdBZ6PkqZA',
      position: 8,
      name: 'Oxygen',
      weight: 15.9994,
      UserType: 'customer',
      FirstName: 'Charl',
      LastName: 'Young',
      CompanyName: 'ABC Company',
      CompanyEmail: 'abc@xyz.com',
      Title: 'Manager',
      ContactNumber: '+1 123 4567890',
      Status: 'Approved',
      Customer: 'Customer H',
      Organisation: 'Company H',
      Subsidary: 'Railroad 8',
      Location: 'Stettler, AB',
      PrimaryContact: '+1 123 4567890',
      PrimaryEmail: 'abc@xyz.com',
      facility: '4 Facilities',
      symbol: 'O',
      vendor: 'Alberta Prairie Railway',
      location: 'Stettler, AB',
      contracted_spaces: 200,
      cars_on_hand: 0,
      cars_enroute: 0,
      space_available: 100,
      cars_stored: 1000,
      months: 10,
      total: 30000,
      avg_monthly_cost: 3000,
      avg_par_car_cost: 3,
      exp_in_days: 20,
      Rider: 78923156,
      storage: 'Vendor B',
      EffectiveDate: '1/1/2019',
      ExpiryDate: '12/31/2020',
      StorageFacilityId: '1000',
      HazmatSurcharge: 'N',
      SwitchIn: '200',
      SwitchOut: '200',
      Description: 'Rider #12345678 - Mountainview Terminals Calgary & Ontracks Rail',
      SearchName: 'Rider No - 12345678, Mountainview Terminals Calgary, TRRA',
      LastRun: '05/01/2022, 17:05 PM',
      Interchanges: '3',
      ContractedSpace: '1,000',
      CarsStored: '1,000',
      TotalAmount: 30000,
    children: [
        {
          Vendor: 'Storage A',
          Location: 'Anywhere, CO',
          Interchanges: 'Railroad 2',
          ConstantSpace: '1000',
          CarsStored: '1000',
          TotalAmount: '30000',
          AverageMonthlyCost: '3000',
          AverageCarCost: '3'
        },
        {
          Vendor: 'Storage B',
          Location: 'Little Town, CO',
          Interchanges: 'Railroad 2',
          ConstantSpace: '1000',
          CarsStored: '1000',
          TotalAmount: '30000',
          AverageMonthlyCost: '3000',
          AverageCarCost: '3'
        },
        {
          Vendor: 'Storage C',
          Location: 'That Space, CO',
          Interchanges: 'Railroad 2',
          ConstantSpace: '1000',
          CarsStored: '1000',
          TotalAmount: '30000',
          AverageMonthlyCost: '3000',
          AverageCarCost: '3'
        },
      ]
    },
    {
      icon: 'icon-green-flag',
      imageUrl:
        'https://i.ytimg.com/vi/XmsSU9uDsbc/hqdefault.jpg?sqp=-oaymwEWCKgBEF5IWvKriqkDCQgBFQAAiEIYAQ==&rs=AOn4CLCA-iTMmDZKrsZh7KfItdBZ6PkqZA',
      position: 20,
      name: 'Calcium',
      weight: 40.078,
      UserType: 'vendor',
      FirstName: 'Charl',
      LastName: 'Young',
      CompanyName: 'ABC Company',
      CompanyEmail: 'abc@xyz.com',
      Title: 'Manager',
      ContactNumber: '+1 123 4567890',
      Status: 'Approved',
      Customer: 'Customer I',
      Organisation: 'Company I',
      Subsidary: 'Railroad 9',
      Location: 'Lamont County, AB',
      PrimaryContact: '+1 123 4567890',
      PrimaryEmail: 'abc@xyz.com',
      facility: '2 Facilities',
      symbol: 'Ca',
      vendor: 'Alberta Midland Railway Terminal',
      location: 'Lamont County, AB',
      contracted_spaces: 100,
      cars_on_hand: 50,
      cars_enroute: 25,
      space_available: 25,
      cars_stored: 1000,
      months: 10,
      total: 30000,
      avg_monthly_cost: 3000,
      avg_par_car_cost: 3,
      exp_in_days: 3,
      Rider: 89231567,
      storage: 'Vendor B',
      EffectiveDate: '1/1/2019',
      ExpiryDate: '12/31/2020',
      StorageFacilityId: '1000',
      HazmatSurcharge: 'N',
      SwitchIn: '200',
      SwitchOut: '200',
      Description: 'Rider #12345678 - Mountainview Terminals Calgary & Ontracks Rail',
      SearchName: 'Rider No - 12345678, Mountainview Terminals Calgary, TRRA',
      LastRun: '01/31/2022, 17:05 PM',
      Interchanges: '3',
      ContractedSpace: '1,000',
      CarsStored: '1,000',
      TotalAmount: 30000,
    children: [
        {
          Vendor: 'Storage A',
          Location: 'Anywhere, CO',
          Interchanges: 'Railroad 2',
          ConstantSpace: '1000',
          CarsStored: '1000',
          TotalAmount: '30000',
          AverageMonthlyCost: '3000',
          AverageCarCost: '3'
        },
        {
          Vendor: 'Storage B',
          Location: 'Little Town, CO',
          Interchanges: 'Railroad 2',
          ConstantSpace: '1000',
          CarsStored: '1000',
          TotalAmount: '30000',
          AverageMonthlyCost: '3000',
          AverageCarCost: '3'
        },
        {
          Vendor: 'Storage C',
          Location: 'That Space, CO',
          Interchanges: 'Railroad 2',
          ConstantSpace: '1000',
          CarsStored: '1000',
          TotalAmount: '30000',
          AverageMonthlyCost: '3000',
          AverageCarCost: '3'
        },
      ]
    },
  ],
savedSearch: [
  {
    Name: "Rider No. 12345678, ABC Storage, Vendor A, Customer A",
    LastRun: "01/31/2022"
  },
  {
    Name: "Rider No. 12345678, ABC Storage, Vendor A, Customer A",
    LastRun: "01/31/2022"
  },
  {
    Name: "Rider No. 12345678, ABC Storage, Vendor A, Customer A",
    LastRun: "01/31/2022"
  },
  {
    Name: "Rider No. 12345678, ABC Storage, Vendor A, Customer A",
    LastRun: "01/31/2022"
  }
],
  railCarDetails: [
    {
      CarId: 'GATX-126099',
      CarType: 'Tank Car',
      LandE: 'L',
      ContentsLE: 'LPG',
      BolDate: '2/1/2021',
      ArrivalDate: '1/1/2021',
      DepartureDate: '12/31/2022',
      Fleet: 'Type',
      Notes: 'This tank car was repared on 01/27/2022. This tank car was repared on 01/27/2022. This tank car was repared on 01/27/2022.'
    },
    {
      CarId: 'GATX-127099',
      CarType: 'Gondala',
      LandE: 'P',
      ContentsLE: 'LPG',
      BolDate: '2/1/2021',
      ArrivalDate: '1/1/2021',
      DepartureDate: '12/31/2022',
      Fleet: 'Type',
      Notes: 'This tank car was repared on 01/27/2022.'
    }
  ],
  attachmentsArray: [
    {
      File: 'Arrival Communication 07/03/2022',
      Description: 'Empty box car (GATX1525) with Rider No. CARG - FRC - 2022 - 1 was brought in.',
      DescriptionHistory: 'Railcar - GATX1525 added',
      DateAndTime: '07/03/2022, 10:30 PM',
      User: 'John Doe',
      Action: 'New Railcar Added'
    },
    {
      File: 'Arrival Communication 07/03/2022',
      DateAndTime: '07/03/2022, 11:30 PM',
      Description: 'Empty box car (GATX5522) with Rider No. CARG - FRC - 2022 - 1 was brought in.',
      DescriptionHistory: 'Railcar - GATX5522 added',
      User: 'John Doe',
      Action: 'New Railcar Added'
    },
    {
      File: 'Arrival Communication 07/03/2022',
      Description: 'Loaded covered hopper car (GATX2566) with Rider No. CARG - FRC - 2022 - 1 was brought in',
      DescriptionHistory: 'Railcar - GATX2566 added',
      DateAndTime: '07/03/2022, 12:30 PM',
      User: 'John Doe',
      Action: 'New Railcar Added'
    }
  ],
  placesGeojson : {
      type: 'geojson',
      data: {
        type: 'FeatureCollection',
        features: [
          {
            type: 'Feature',
            properties: {
              Type: 'A',
              name: 'TrimbleMAPS HQ A1'
            },
            geometry: {
              type: 'Point',
              coordinates: [-121.42373085021971, 38.60124315987198],
            },
          },
          {
            type: 'Feature',
            properties: {
              Type: 'A',
              name: 'TrimbleMAPS HQ A2'
            },
            geometry: {
              type: 'Point',
              coordinates: [-121.41669273376465, 38.588899879450764],
            },
          },
          {
            type: 'Feature',
            properties: {
              Type: 'B',
              name: 'TrimbleMAPS HQ B1'
            },
            geometry: {
              type: 'Point',
              coordinates: [-121.4128303527832, 38.61116991045304],
            },
          },
          {
            type: 'Feature',
            properties: {
              Type: 'B',
              name: 'TrimbleMAPS HQ B2'
            },
            geometry: {
              type: 'Point',
              coordinates: [-121.41592025756835, 38.58091586687018],
            },
          },
          {
            type: 'Feature',
            properties: {
              Type: 'C',
              name: `{
                'book': {
                    'name': 'Harry Potter and the Goblet of Fire',
                    'author': 'J. K. Rowling',
                    'year': 2000,
                    'genre': 'Fantasy Fiction',
                    'bestseller': true
                }
            }`
            },
            geometry: {
              type: 'Point',
              coordinates: [-121.39892578125, 38.60164562241362],
            },
          },
        ],
      },
    },
  list : [
    {
      id: 3,
      title: 'BNSF',
      lineColor: '#37A800',
      checked: false,
      points: 'BNSFRRPoints',
      isLayerLoading: false
    },
    {
      id: 4,
      title: 'CN',
      lineColor: '#00C5FF',
      checked: false,
      points: 'CNRRPoints',
      isLayerLoading: false
    },
    {
      id: 5,
      title: 'CPRS',
      lineColor: '#CE8866',
      checked: false,
      points: 'CPRSRRPoints',
      isLayerLoading: false
    },
    {
      id: 2,
      title: 'CSXT',
      lineColor: '#F7BD48',
      checked: false,
      points: 'CSXTRRPoints',
      isLayerLoading: false
    },
    {
      id: 1,
      title: 'KCS',
      lineColor: '#004DA8',
      checked: false,
      points: 'KCSRRPoints',
      isLayerLoading: false
    },
    {
      id: 6,
      title: 'NS',
      lineColor: '#8500A8',
      checked: false,
      points: 'NSRRPoints',
      isLayerLoading: false
    },
    {
      id: 7,
      title: 'UP',
      lineColor: '#F74648',
      checked: false,
      points: 'UPRRPoints',
      isLayerLoading: false
    }
  ],
  contractType : [
    {
      id: 1,
      title: 'Open Term',
      lineColor: '#888432',
      checked: false,
      controlName: 'OpenTerm'
    },
    {
      id: 2,
      title: 'Take or Pay',
      lineColor: '#273d98',
      checked: false,
      controlName: 'TakeOrPay'
    },
    {
      id: 3,
      title: 'Reserve',
      lineColor: '#4a5261',
      checked: false,
      controlName: 'Reserve'
    },
  ],
  favourities: [
    {
      id: 1,
      title: 'Rail Storage Facilty #01',
      checked: false
    },
    {
      id: 2,
      title: 'Rail Storage Facilty #02',
      checked: false
    },
    {
      id: 3,
      title: 'Rail Storage Facilty #03',
      checked: false
    },
    {
      id: 4,
      title: 'Rail Storage Facilty #04',
      checked: false
    },
    {
      id: 5,
      title: 'Rail Storage Facilty #05',
      checked: false
    }
  ],
  designRailcarType: [
    {
      id: 0,
      title: 'All',
    },
    {
      id: 1,
      title: 'Hopper',
    },
    {
      id: 2,
      title: 'Center Beam',
    },
    {
      id: 3,
      title: 'Box Car',
    },
    {
      id: 4,
      title: 'Tank Car',
    },
  ],
  unitedState: [
    {
      id: 1,
      title: 'US Central Region',
    },
    {
      id: 2,
      title: 'US Midwest Region',
    },
    {
      id: 3,
      title: 'US Northeast Region',
    },
    {
      id: 4,
      title: 'US Northwest Region',
    },
    {
      id: 5,
      title: 'US Southeast Region',
    },
    {
      id: 6,
      title: 'US Southwest Region',
    },
  ],
  canadianState: [
    {
      id: 7,
      title: 'Canada Atlantic Region'
    },
    {
      id: 8,
      title: 'Canada Ontario Region'
    },
    {
      id: 9,
      title: 'Canada Pacific Region'
    },
    {
      id: 10,
      title: 'Canada Prairie & Northwest Region'
    },
    {
      id: 11,
      title: 'Canada Quebec Region'
    }
  ],
  features : [
    {   Id: 1,
        Name: 'Hazmat Cars',
        name: 'Hazmat Cars',
        description: 'HazmatCars',
        Checked: false
    },
    {
      Id: 2,
      Name: 'Loaded Cars',
      name: 'Loaded Cars',
      description: 'LoadedCars',
      Checked: false
    },
    {
      Id: 3,
      Name: 'Cherry Picking',
      name: 'Cherry Picking',
      description: 'CherryPicking',
      Checked: false
    },
    {
      Id: 4,
      Name: 'Facility Security',
      name: 'Facility Security',
      description: 'FacilitySecurity',
      Checked: false
    },
    {
      Id: 5,
      Name: 'Scrapping',
      name: 'Scrapping',
      description: 'Scrapping',
      Checked: false
    },
    {
      Id: 6,
      Name: 'Repair',
      name: 'Repair',
      description: 'Repair',
      Checked: false
    },
    {
      Id: 7,
      Name: 'Mechinical',
      name: 'Mechinical',
      description: 'Mechinical',
      Checked: false
    },
    {
      Id: 8,
      Name: 'Loaded Cars',
      name: 'Loaded Cars',
      description: 'LoadedCars',
      Checked: false
    }
  ],
  dailyRates : [
    {
      'Id': 1,
      'value': '10'
    },
    {
      'Id': 2,
      'value': '25'
    },
    {
      'Id': 3,
      'value': '50'
    },
    {
      'Id': 4,
      'value': '75'
    },
    {
      'Id': 5,
      'value': '100'
    }
  ],
  switchingFees : [
    {
      'Id': 1,
      'value': '100'
    },
    {
      'Id': 2,
      'value': '250'
    },
    {
      'Id': 3,
      'value': '500'
    },
    {
      'Id': 4,
      'value': '750'
    },
    {
      'Id': 5,
      'value': '1000'
    }
  ],
  dataTable2 : [
    {
      icon: 'icon-green-flag',
      imageUrl:
        'https://i.ytimg.com/vi/XmsSU9uDsbc/hqdefault.jpg?sqp=-oaymwEWCKgBEF5IWvKriqkDCQgBFQAAiEIYAQ==&rs=AOn4CLCA-iTMmDZKrsZh7KfItdBZ6PkqZA',
      position: 1,
      name: 'Hydrogen',
      weight: 1.0079,
      UserType: 'customer',
      FirstName: 'Robby',
      LastName: 'Scott',
      CompanyName: '40 Mile Rail',
      CompanyEmail: 'abc@xyz.com',
      Title: 'Manager',
      ContactNumber: '+1 123 4567890',
      Status: 'Approved',
      Customer: 'Customer A',
      Organisation: 'Company A',
      Subsidary: 'Railroad 3',
      Location: 'Foremost, AB',
      PrimaryContact: '+1 123 4567890',
      PrimaryEmail: 'abc@xyz.com',
      facility: '1 Facilities',
      symbol: 'H',
      vendor: '40 Mile Rail',
      location: 'Foremost, AB',
      contracted_spaces: 200,
      cars_on_hand: 391,
      cars_enroute: 100,
      space_available: 9,
      cars_stored: 2,
      months: 10,
      total: 95,
      avg_monthly_cost: 900,
      avg_par_car_cost: 4.5,
      exp_in_days: 20,
      Rider: 12345678,
      storage: 'Mountainview Terminals Calgary',
      EffectiveDate: '1/1/2021',
      ExpiryDate: '12/31/2022',
      StorageFacilityId: '1000',
      HazmatSurcharge: 'N',
      SwitchIn: '200',
      SwitchOut: '200',
      Description: 'Rider #12345678 - Mountainview Terminals Calgary & Ontracks Rail',
      SearchName: 'CARG - FRC - 2022 - 1, 40 Mile Rail, Cargill',
      LastRun: '07/05/2022, 03:05 PM',
      Interchanges: '1',
      ContractedSpace: '200',
      CarsStored: '2',
      TotalAmount: 95,
      children: [
        {
          Vendor: '40 Mile Rail',
          Location: 'Foremost, AB',
          Interchanges: 'CPRS',
          ConstantSpace: '200',
          CarsStored: '2',
          TotalAmount: '95',
          AverageMonthlyCost: '900',
          AverageCarCost: '4.5',
          Facility: '40 Mile Rail'
        }
      ]
    },
    {
      icon: 'icon-green-flag',
      imageUrl:
        'https://www.banderasnews.com/1510/images/Ferromex.jpg',
      position: 2,
      name: 'Helium',
      weight: 4.0026,
      UserType: 'vendor',
      FirstName: 'Stephen',
      LastName: 'Martin',
      CompanyName: 'ABC Company',
      CompanyEmail: 'abc@xyz.com',
      Title: 'Manager',
      ContactNumber: '+1 123 4567890',
      Status: 'Rejected',
      Customer: 'Customer B',
      Organisation: 'Company B',
      Subsidary: 'Railroad 2',
      Location: 'Calgary, AB',
      PrimaryContact: '+1 122 4567890',
      PrimaryEmail: 'abc@xyz.com',
      facility: '2 Facilities',
      symbol: 'He',
      vendor: 'Mountainview Terminals',
      location: 'Calgary, AB',
      contracted_spaces: 0,
      cars_on_hand: 100,
      cars_enroute: 50,
      space_available: 100,
      cars_stored: 750,
      months: 10,
      total: 0,
      avg_monthly_cost: 0,
      avg_par_car_cost: 0,
      exp_in_days: 60,
      Rider: 23456789,
      storage: 'Vendor B',
      EffectiveDate: '1/1/2019',
      ExpiryDate: '12/31/2020',
      StorageFacilityId: '1000',
      HazmatSurcharge: 'N',
      SwitchIn: '200',
      SwitchOut: '200',
      Description: 'Rider #12345678 - Mountainview Terminals Calgary & Ontracks Rail',
      SearchName: '40 Mile Rail, 40 Mile Rail',
      LastRun: '07/01/2022, 12:22 AM',
      Interchanges: '2',
      ContractedSpace: '0',
      CarsStored: '0',
      TotalAmount: 0,
    children: [
        {
          Vendor: 'Mountainview Terminals',
          Location: 'Calgary, AB',
          Interchanges: 'CN',
          ConstantSpace: '0',
          CarsStored: '0',
          TotalAmount: '0',
          AverageMonthlyCost: '0',
          AverageCarCost: '0',
          Facility: 'Mountainview Terminals Calgary',
          comments: [
            {
              commenID: 13,
              comment: 'Test',
              commentStatus: 'Open',
            },
            {
              commenID: 14,
              comment: 'Test',
              commentStatus: 'Open',
            },
            {
              commenID: 15,
              comment: 'Test',
              commentStatus: 'Closed',
            },
          ],
        },
        {
          Vendor: 'Mountainview Terminals',
          Location: 'Edmonton, AB',
          Interchanges: 'CN',
          ConstantSpace: '0',
          CarsStored: '0',
          TotalAmount: '0',
          AverageMonthlyCost: '0',
          AverageCarCost: '0',
          Facility: 'Mountainview Terminals Edmonton',
          comments: [
            {
              commenID: 13,
              comment: 'Test',
              commentStatus: 'Open',
            },
            {
              commenID: 14,
              comment: 'Test',
              commentStatus: 'Open',
            },
            {
              commenID: 15,
              comment: 'Test',
              commentStatus: 'Closed',
            },
          ],
        }
      ]
    },
    {
      icon: 'icon-grey-flag',
      imageUrl:
        'https://cdnimg.bnamericas.com/UyTZzlOqMxsmaSFWVRfyAjIjuXbHeSxjYkuhaaooqSlbfQqGTUzaYVYtwLUqljcC.jpg',
      position: 3,
      name: 'Lithium',
      weight: 6.941,
      UserType: '',
      FirstName: 'Charl',
      LastName: 'Young',
      CompanyName: 'ABC Company',
      CompanyEmail: 'abc@xyz.com',
      Title: 'Manager',
      ContactNumber: '+1 123 4567890',
      Status: 'Pending',
      Customer: 'Customer C',
      Organisation: 'Company C',
      Subsidary: 'Railroad 3',
      Location: 'Stettler, AB',
      PrimaryContact: '+1 123 4567890',
      PrimaryEmail: 'abc@xyz.com',
      facility: '1 Facilities',
      symbol: 'H',
      vendor: 'Alberta Prairie Railway',
      location: 'Stettler, AB',
      contracted_spaces: 400,
      cars_on_hand: 326,
      cars_enroute: 50,
      space_available: 24,
      cars_stored: 1500,
      months: 10,
      total: 15000,
      avg_monthly_cost: 0,
      avg_par_car_cost: 0,
      exp_in_days: 5,
      Rider: 34567892,
      storage: 'Vendor B',
      EffectiveDate: '1/1/2019',
      ExpiryDate: '12/31/2020',
      StorageFacilityId: '1000',
      HazmatSurcharge: 'N',
      SwitchIn: '200',
      SwitchOut: '200',
      Description: 'Rider #12345678 - Mountainview Terminals Calgary & Ontracks Rail',
      SearchName: 'Cargill, United States',
      LastRun: '06/30/2022, 01:03 PM',
      Interchanges: '1',
      ContractedSpace: '0',
      CarsStored: '0',
      TotalAmount: 0,
    children: [
        {
          Vendor: 'Alberta Prairie Railway',
          Location: 'Stettler, AB',
          Interchanges: 'CPRS',
          ConstantSpace: '0',
          CarsStored: '0',
          TotalAmount: '0',
          AverageMonthlyCost: '0',
          AverageCarCost: '0',
          Facility: 'Alberta Prairie Railway'
        },
      ]
    },
    {
      icon: 'icon-red-flag',
      imageUrl:
        'https://www.freightwaves.com/wp-content/uploads/2020/01/Mexico_train_robberies_1.jpg',
      position: 4,
      name: 'Beryllium',
      weight: 9.0122,
      UserType: 'customer',
      FirstName: 'Charl',
      LastName: 'Young',
      CompanyName: 'ABC Company',
      CompanyEmail: 'abc@xyz.com',
      Title: 'Manager',
      ContactNumber: '+1 123 4567890',
      Status: 'Approved',
      Customer: 'Customer D',
      Organisation: 'Company D',
      Subsidary: 'Railroad 4',
      Location: 'Lamont County, AB',
      PrimaryContact: '+1 123 4567890',
      PrimaryEmail: 'abc@xyz.com',
      facility: '1 Facilities',
      symbol: 'Be',
      vendor: 'Alberta Midland Railway Terminal',
      location: 'Lamont County, AB',
      contracted_spaces: 0,
      cars_on_hand: 50,
      cars_enroute: 25,
      space_available: 25,
      cars_stored: 500,
      months: 10,
      total: 10000,
      avg_monthly_cost: 0,
      avg_par_car_cost: 0,
      exp_in_days: 54,
      Rider: 45678923,
      storage: 'Vendor B',
      EffectiveDate: '1/1/2019',
      ExpiryDate: '12/31/2020',
      StorageFacilityId: '1000',
      HazmatSurcharge: 'N',
      SwitchIn: '200',
      SwitchOut: '200',
      Description: 'Rider #12345678 - Mountainview Terminals Calgary & Ontracks Rail',
      SearchName: 'CARG - FMR - 2022 - 1, GATX',
      LastRun: '06/15/2022, 08:29 PM',
      Interchanges: '2',
      ContractedSpace: '0',
      CarsStored: '0',
      TotalAmount: 0,
    children: [
        {
          Vendor: 'Alberta Midland Railway Terminal',
          Location: 'Lamont County, AB',
          Interchanges: 'CPRS, CN',
          ConstantSpace: '0',
          CarsStored: '0',
          TotalAmount: '0',
          AverageMonthlyCost: '0',
          AverageCarCost: '0',
          Facility: 'Alberta Midland Railway Terminal'
        },
      ]
    },

  ]
};

export var single = [
  {
    'name': '40 Mile Rail',
    'value': 23.4
  },
  {
    'name': 'Mountainview Terminals Calgary',
    'value': 12.6
  },
  {
    'name': 'Alberta Prairie Railway',
    'value': 21.4
  },
  {
    'name': 'Alberta Midland Railway Terminal',
    'value': 6.9
  },
  {
    'name': 'Mountainview Terminals Edmonton',
    'value': 35.7
  }
]

