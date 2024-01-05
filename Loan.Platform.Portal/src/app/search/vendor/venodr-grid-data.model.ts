export class VenodrGridDataModel {
  Id:number;
  Vendor:string;
  Facility:string;
  Location:string;
  Interchanges:string;
  ContractedSpace :number;
  CarsStored:number;
  TotalAmount:number;
  AVGMonthlyCost:number;
  AVGCarCost:number;
  VendorChildData:VenodrGridDataModel[];
}
