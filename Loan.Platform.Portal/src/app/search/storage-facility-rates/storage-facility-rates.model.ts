export class StorageFacilityRatesModel {
    Id: number;
    StorageFacilityId: number;
    CurrencyId?: number;
    DailyStorageRate: number;
    SwitchIn?: number;
    SwitchOut?: number;
    SwitchingRate?: number;
    SpecialSwitchingRate?: number;
    HazmatSwitchInRate: number;
    HazmatSwitchOutRate: number;
    LoadedSwitchInRate: number;
    LoadedSwitchOutRate: number;
    CherryPickingRate?: number;
    ReservationRate?: number;
    EffectiveDate: string | null;
    ExpiryDate: string | null;
    IsActive:boolean;
    FormEffectiveDate: Date;
    FormExpiryDate: Date;
  }
