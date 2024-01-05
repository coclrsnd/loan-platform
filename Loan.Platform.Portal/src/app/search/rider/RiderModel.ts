import { StorageFeatureModel } from "../storagefeature/StoragefeatureModel";
import { StorageOrderRibbon } from 'src/app/shared/models/storageorder-ribbon.model';
import { ContractRate } from "./contractrate.model";
export class RiderModel {
  Id: number;
  Rider: string;
  VendorName: string;
  StorageFacilityName: string;
  EffectiveDate: string | null;
  ExpiryDate: string | null;
  TotalCars: number;
  Hazmat: string;
  SwitchIn: number;
  SwitchOut: number;
  IsDefault: boolean;
  CurrencyId?: number | null
  SwitchInMin?: number | null
  SwitchInMax?: number | null
  SwitchOutMin?: number | null
  SwitchOutMax?: number | null
  StorageFeatureIds: number[];
  IsFlatRateContract: boolean;
  VendorId: number;
  StorageFacilityId: number;
  CustomerId: number;
  ContractTypeId: number;
  ReservedSpaces: number | null;
  Location: string;
  CarsStored: number;
  CurrencyName: string;
  ContractTypeName: string;
  storageFeatureViewModels: StorageFeatureModel[];
  FormEffectiveDate: Date;
  FormExpiryDate: Date;
  RiderModel:  RiderModel[];
  StorageOrderRibbon: StorageOrderRibbon;
  VendorCost: ContractRate;
  CustomerRate: ContractRate;
  PercentageRate: ContractRate;
  IsAdvancedSwitchingRatesEnabled: boolean;
}
