import { VenodrGridDataModel } from "./venodr-grid-data.model";
import { VendorRibbon } from 'src/app/shared/models/vendor-ribbon.model';
export class VendorFilterModel {
  OrganizationId: number;
  Organization: string;
  StorageFacilityId: number;
  InterchangeId: number;
  City: string;
  CountryId:number;
  StateId:number;
  //Pagination: Pagination;
  VendorGridData: VenodrGridDataModel[];
  //Sorting:Sorting;
  VendorRibbon : VendorRibbon;
}
