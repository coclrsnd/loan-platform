import { StorageFeatureModel } from "../storagefeature/StoragefeatureModel";

export class StorageFacilitySearchModel {
    IsMulticityEnable: boolean;
    Origin:any;
    Destination:any;
    RegionId:number | null;
    RailRoads:string;
    EffectiveDate: Date | null;
    ExpiryDate: Date | null;
    DailyRate:number | null;
    SwitchingFee: number | null;
    Features : Array<StorageFeatureModel> = [];
}
