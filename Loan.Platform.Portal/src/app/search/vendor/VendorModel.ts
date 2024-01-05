import { StorageFacilityModel } from "../storage-facility/StorageFacilityModel";

export class VendorModel {
  Id: number;
  ContactPersonName: string;
  PrimaryContactNo: string;
  SecondaryContactNo: string;
  Organization: string;
  Address: string;
  ZipCode: string;
  City: string;
  StateId?: number;
  CountryId?: number;
  EffectiveDate: string | null;
  ExpiryDate: string | null;
  PrimaryContactEmail: string;
  SecondaryContactEmail: string;
  Website: string;
  Description: string;
  StorageFacilities: StorageFacilityModel[];
  OrganizationId:number;
  RegionId?:number;
  PercentageMargin:number;
  FormEffectiveDate: Date;
  FormExpiryDate: Date;
}
