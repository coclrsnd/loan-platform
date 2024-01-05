export class ContractRate {
  Id: number;
  ContractId: number;
  RateTypeId: number;
  SwitchIn: number | null;
  SwitchOut: number | null;
  SpecialSwitchingRate: number | null;
  DailyStorageRate: number | null;
  SwitchingRate: number | null;
  HazmatSurcharge: number | null;
  LoadedSurcharge: number | null;
  CherryPickingRate: number | null;
  ReservationRate: number | null;
  IsActive: number | null;
  BookingFee: number;
  ListingFee: number;
  IsAdvancedHazmatSwitchingEnabled: boolean;
  IsAdvancedLoadedSwitchingEnabled: boolean;
  HazmatSwitchIn: number | null
  HazmatSwitchOut: number | null
  LoadedSwitchIn: number | null
  LoadedSwitchOut: number | null
  StandardSwitchIn: number | null
  StandardSwitchOut: number | null
}
