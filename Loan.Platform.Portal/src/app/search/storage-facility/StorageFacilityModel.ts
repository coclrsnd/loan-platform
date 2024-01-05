import { StorageFeatureModel } from "../storagefeature/StoragefeatureModel";
import {StorageFacilityRatesModel } from "../storage-facility-rates/storage-facility-rates.model"
import { StorageFacilityInterchangesModel } from "src/app/shared/models/storage-facility-interchanges.model";

export class StorageFacilityModel {
  Id: number;
  Name: string;
  Lat: string;
  Long: string;
  Capacity: number;
  AvailableCars: number;
  Rating: number;
  Address: string;
  PrimaryContactNumber: string;
  SecondaryContactNumber: string;
  PrimaryEmail: string;
  SecondaryEmail: string;
  ZipCode: string;
  City: string;
  StateId: number|null;
  CountryId: number|null;
  VendorId: number;
  RegionId: number|null;
  EffectiveDate: string | null;
  ExpiryDate: string | null;
  SPLC: string;
  Priority: number;
  Description: string;
  StorageFeatures:any[];
  StorageFacilityRates:StorageFacilityRatesModel[];
  StorageFacilityInterchanges:StorageFacilityInterchangesModel[];
  Mark:string;
  IsTrimbleVerified:boolean;
  FormEffectiveDate: Date;
  FormExpiryDate: Date;
}





