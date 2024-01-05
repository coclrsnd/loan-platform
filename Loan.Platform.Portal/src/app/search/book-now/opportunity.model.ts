import { NumericDictionary } from 'lodash';

export class OpportunityModel {
  Id: number;
  Name: string;
  StartDate: string;
  EndDate: string;
  BookingStatus: number;
  AgreementPath: string;
  VendorId: number;
  OrganizationId: number;
  FacilityId: number;
  TotalNoApproxSpaces: number;
  BookingDate: string;
  OpportunityRailCars: OpportunityRailcarDetailsModel[];
  OpportunityAttachments: OpportunityAttachmentModel[];
}

export class OpportunityRailcarDetailsModel {
  Id: number;
  ExpectedNumberOfCars: number;
  OpportunityID: number;
  LEId: number;
  Commodity: string;
  IsHazmat: boolean;
  Hazmat: string;
  LandE: string;
  CarType: number;
  CarTypeName: string;
  RailCarIds: string;
  IsActive: boolean = true;
}

export class OpportunityAttachmentModel {
  Id: number;
  Path: string;
  FolderName: string;
  Name: string;
  IsActive: boolean = true;
  OpportunityId: number;
  CreatedDate: Date | null;
  Action: string;
  RowId: number;
  Size: string;
}
