import { CustomerFilterModel } from "./customer-filter.model";
export class CustomerModel {
  Id: number;
  Name: string;
  PrimaryContactNo: string;
  PrimaryContactEmail: string;
  SecondaryContactNo: string;
  SecondaryContactEmail: string;
  Address: string;
  ZipCode: string;
  City: string;
  StateId: number;
  CountryId: number;
  EffectiveDate: string | null;
  ExpiryDate: string | null;
  Website: string;
  Description: string;
  Location:string;
  OrganizationId:number;
  PercentageMargin:number;
}
