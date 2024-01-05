import { Component, ElementRef, EventEmitter, Input, OnChanges, OnInit, Output, SimpleChanges, ViewChild } from '@angular/core';
import * as TrimbleMaps from '@trimblemaps/trimblemaps-js';
import { environment } from 'src/environments/environment';
import { SearchMapService } from './search-map.service';

@Component({
  selector: 'app-search-map',
  templateUrl: './search-map.component.html',
  styleUrls: ['./search-map.component.scss']
})
export class SearchMapComponent implements OnInit, OnChanges {
  @ViewChild("map", { static: true }) mapElement: ElementRef;
  @Output() filter = new EventEmitter<any>();
  @Output() searchResult = new EventEmitter<any>();
  @Input() upadateMap;
  @Input() railRoadColor;
  public isExpanded: boolean = false;
  map: TrimbleMaps.Map;
  apiKey: string = environment.authToken;
  mapCenter = {
    longitude: -95,
    latitude: 38,
    zoom: 3,
  };

  constructor(private mapService: SearchMapService) { }

  ngOnInit(): void {
    this.map = this.mapService.initMap(this.apiKey, {
      container: this.mapElement.nativeElement,
      style: TrimbleMaps.Common.Style.TRANSPORTATION,
      center: [this.mapCenter.longitude, this.mapCenter.latitude],
      zoom: this.mapCenter.zoom,
      hash: false,
    });
    this.map.setMinZoom(2);
    this.map.setRenderWorldCopies(true);
  }

  ngOnChanges(changes: SimpleChanges) {
    const isUpadateMap = changes['upadateMap']?.currentValue;
    if (isUpadateMap) {
      this.drawRailTrack(isUpadateMap);
    }
  }

  public onFilterTrigger(): void {
    this.filter.emit(true);
  }
  public onResultTrigger(): void {
    this.searchResult.emit(true);
  }

  public onExpandCollapse(): void {
    this.isExpanded = !this.isExpanded;
    setTimeout(() => {
      window.dispatchEvent(new Event('resize'));
    }, 100);
  }
  public drawRailTrack(isUpadateMap: any): void {
    this.mapService.addRoutePathLayer(isUpadateMap, "red");
  }
}
