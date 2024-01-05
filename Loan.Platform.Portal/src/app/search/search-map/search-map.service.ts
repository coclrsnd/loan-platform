import { EventEmitter, Injectable, Output } from '@angular/core';
import { MatDialog } from '@angular/material/dialog';
import * as TrimbleMaps from '@trimblemaps/trimblemaps-js';
import { Observable } from 'rxjs';
import { APP_CONSTANTS } from 'src/app/app-constants';
import { ApiService } from 'src/app/services/api.service';
import { BookNowComponent } from '../book-now/book-now.component';
import { StorageFacilitySearchModel } from './StorageFacilitySearchModel';

@Injectable({
  providedIn: 'root',
})
export class SearchMapService {
  map: TrimbleMaps.Map;
  public allRailRoads = APP_CONSTANTS.list;
  public placesGeojson = APP_CONSTANTS.placesGeojson;
  setGeoLocationPoints: EventListener;
  facilities: any;
  public markers: TrimbleMaps.Marker[] = [];
  private stops: Array<TrimbleMaps.LngLat> = [];
  FacilityMapApiRoutePrefix: string = 'api/StorageFacility';

  constructor(private dialog: MatDialog,
    private apiStorageFacilityService: ApiService<StorageFacilitySearchModel>
  ) {}

  SearchStorageFacility(
    model: StorageFacilitySearchModel
  ): Observable<StorageFacilitySearchModel> {
    let route: string = this.FacilityMapApiRoutePrefix.concat(
      `/SearchStorageFacilities`
    );
    return this.apiStorageFacilityService
      .post(route, model)
      .pipe
      // retry(0),
      //catchError(this.handleError)
      ();
  }

  /**
   * method to initilize Map
   * @param apiKey is api key
   * @param options to specify map options
   * @returns created map
   */
  initMap(apiKey: string, options: any) {
    TrimbleMaps.setAPIKey(apiKey);
    this.map = new TrimbleMaps.Map(options);
    this.map.addControl(new TrimbleMaps.NavigationControl());
    const scale = new TrimbleMaps.ScaleControl({
      maxWidth: 300,
      unit: 'imperial',
    });
    this.map.addControl(scale);
    this.map.setRegion(TrimbleMaps.Common.Region.NA);
    this.map.addControl(new TrimbleMaps.FullscreenControl());
    this.map.addControl(new TrimbleMaps.GeolocateControl());
    return this.map;
  }

  toggleRailRoadVisibility(isVisible: boolean, railRoad: RailRoad) {
    const railRoadLayer = this.getLayer(railRoad.toString());
    if (railRoadLayer == undefined) {
      // this.mapRailRoadLayer(railRoad.toString());
    }

    let visibility: string = isVisible ? 'visible' : 'none';
    this.map.setLayoutProperty(railRoad.toString(), 'visibility', visibility);
  }

  mapRailRoadLayer(railRoad: any, unit: any) {
    const selectedRailroad = unit.title;
    railRoad.checked
      ? this.addRailRoadLayerColour(unit)
      : this.removeRailRoadLayer(unit);
  }

  addRailRoadLayerColour(unit) {
    // AddSource
    let mapSourceId = unit.title;
    this.map.addSource(mapSourceId, {
      type: 'geojson',
      data: '../assets/rail-network/' + unit.title + '_Lines.geojson',
    });
    let layerId = unit.title;
    let firstSymbolLayerId;
    const layers = this.map.getStyle().layers;
    if (layers != null) {
      for (let i = 0; i < layers?.length; i++) {
        const layer = layers[i];
        if (layer.type === 'symbol') {
          firstSymbolLayerId = layer.id;
          break;
        }
      }
    }

    // AddLayer
    this.map.addLayer(
      {
        id: layerId,
        type: 'line',
        source: mapSourceId,
        paint: {
          'line-width': 2,
          'line-color': unit.lineColor,
          'line-blur': 0.8,
        },
      },
      firstSymbolLayerId
    );
  }

  addRoutePathLayer(routePath, railRoadColor) {
    this.removeRoutePath();
    var route = JSON.parse(routePath);
    const routeLength = route.geometry.coordinates[0].length - 1;
    this.addRouteOriginDestinitionPoints(
      route.geometry.coordinates[0][0],
      route.geometry.coordinates[0][routeLength]
    );

    // AddSource
    this.map.addSource('point', {
      type: 'geojson',
      data: route,
    });

    let firstSymbolLayerId;
    const layers = this.map.getStyle().layers;
    if (layers != null) {
      for (let i = 0; i < layers?.length; i++) {
        const layer = layers[i];
        if (layer.type === 'symbol') {
          firstSymbolLayerId = layer.id;
          break;
        }
      }
    }
    //AddLayer
    this.map.addLayer(
      {
        id: 'point',
        source: 'point',
        type: 'line',
        paint: {
          'line-color': railRoadColor,
          'line-width': 4,
        },
      },
      firstSymbolLayerId
    );
    //this.addOriginAndDestinationMarkers(route.geometry.coordinates);
    this.map.setPadding({ left: 200, top: 200, bottom: 250, right: 200 });
    this.map.fitBounds([
      route.geometry.coordinates[0][0],
      route.geometry.coordinates[0][route.geometry.coordinates[0].length - 1],
    ]);
    //this.map.setCenter(routePath.geometry.coordinates[0][0]);
  }

  addRouteOriginDestinitionPoints(
    arg0: TrimbleMaps.LngLat,
    arg1: TrimbleMaps.LngLat
  ) {
    const features :any = [];

    let firstSymbolLayerId;
    const layers = this.map.getStyle().layers;
    if (layers != null) {
      for (let i = 0; i < layers?.length; i++) {
        const layer = layers[i];
        if (layer.type === 'symbol') {
          firstSymbolLayerId = layer.id;
          break;
        }
      }
    }
    features.push({
      type: 'Feature',
      properties: {
        name: 'Origin',
        category: 'O',
      },
      geometry: {
        type: 'Point',
        coordinates: [arg0[0], arg0[1]],
      },
    });
    features.push({
      type: 'Feature',
      properties: {
        name: 'Destination',
        category: 'D',
      },
      geometry: {
        type: 'Point',
        coordinates: [arg1[0], arg1[1]],
      },
    });

    this.map.addSource('originDestinationPoints', {
      type: 'geojson',
      data: {
        type: 'FeatureCollection',
        features: features,
      },
    });
    this.map.addLayer(
      {
        id: 'originDestinationPoints',
        type: 'symbol',
        source: 'originDestinationPoints',
        layout: {
          'icon-image': [
            'match',
            ['get', 'category'],
            'O',
            'poi_origin',
            'D',
            'poi_destination',
            '#ffffff',
          ],
          'icon-allow-overlap': true,
          'icon-ignore-placement':true,
          'icon-size': 1,
        },
      },
      firstSymbolLayerId
    );
  }

  addRailRoadLayer(railRoad) {}

  public removeRoutePath(): void {
    const isPoint = this.map.getLayer('point');
    if (isPoint) {
      this.map.removeLayer('point');
      this.map.removeSource('point');
    }

    const isoriginDestinationPoints = this.map.getLayer('originDestinationPoints');
    if (isoriginDestinationPoints) {
      this.map.removeLayer('originDestinationPoints');
      this.map.removeSource('originDestinationPoints');
    }

    this.allRailRoads.forEach((railroad) => {
      this.removeRailRoadLayer(railroad);
    });
  }

  public removeStorageFacilities(): void {
    this.markers.forEach((e) => e.remove());
    this.markers = [];
    const facilitiesLayer = this.map.getLayer('placesSource');
    if (facilitiesLayer) {
      this.map.removeLayer('placesSource');
      this.map.removeSource('placesSource');
    }
  }

  public removeRailRoadLayer(unit): void {
    const isPoint = this.map.getLayer(unit.title);
    if (isPoint) {
      this.map.removeLayer(unit.title);
      this.map.removeSource(unit.title);
    }
  }

  public removeRailRoadLayerByName(name): void {
    const isPoint = this.map.getLayer(name);
    if (isPoint) {
      this.map.removeLayer(name);
      this.map.removeSource(name);
    }
  }

  getLayer(layer: string) {
    return this.map.getLayer(layer);
  }

  addGeoLocationData(cordinates, facilities) {
    var res = JSON.parse(cordinates);
    var sfacilities = res.features.filter((e) => e.properties.Type === 'A');
    if (sfacilities != null && sfacilities.length > 0) {
      this.markers.forEach((e) => e.remove());
      this.markers = [];
      sfacilities.forEach((e) => {
        const lngLat = e.geometry.coordinates;
        const popupLocation = lngLat;
        const popupContent = e.properties;
        this.facilities = facilities;
        const facilityDetails = this.facilities.find(
          (a: { Id: any }) => a.Id == popupContent.StorageId
        );
        const popupHTML = this.createPopup(
          popupLocation,
          popupContent,
          facilityDetails
        );
        const marker = new TrimbleMaps.Marker({ color: 'orange' });
        marker.setLngLat(lngLat);
        this.setGeoLocationPoints = function (e) {
          popupHTML
            .getElement()
            .getElementsByClassName('olButton')[0]
            .addEventListener('click', () => {
             this.bookNow(facilityDetails);
            });
        };
        this.setGeoLocationPoints = this.setGeoLocationPoints.bind(this);
        marker.setPopup(popupHTML);
        popupHTML.once('open', this.setGeoLocationPoints);

        this.markers.push(marker);
      });
    }
    if (this.markers.length > 0) {
      this.markers.forEach((e) => e.addTo(this.map));
    }
    if (res != null && res.features != null && res.features.length > 0) {
      this.map.setCenter(
        new TrimbleMaps.LngLat(
          res?.features[0].geometry.coordinates[0],
          res?.features[0].geometry.coordinates[1]
        )
      );
      this.map.zoomTo(3);
    }
  }
  bookNow(facilityDetails: any) {
    const dialogRef = this.dialog.open(BookNowComponent, {
      disableClose: true,
      data:{
        title: 'Book',
        message: 'Are you sure want to delete?',
        buttonText: {
          ok: 'Save',
          cancel: 'No'
        },
        facility: facilityDetails
      }
    });
  }

  createPopup(popupLocation, popupContent, facilityDetails): TrimbleMaps.Popup {
    const totalRows = Math.ceil(facilityDetails.StorageFeatures.length / 2);
    let facilityCount = facilityDetails.StorageFeatures.length;
    let createdRows = '';
    let counter = 0;
    for (let i = 0; i < totalRows; i++) {
      if (counter <= facilityCount) {
      createdRows += '<tr>'
        for (let j = 0; j < 2; j++) {
          if(facilityDetails.StorageFeatures[counter]?.Name !== undefined && facilityDetails.StorageFeatures[counter]?.Name !== 'Not Assigned Yet') {
            createdRows += `<td>${counter+1}.</td>`
            createdRows += '<td>'
            createdRows += facilityDetails.StorageFeatures[counter]?.Name
            createdRows += '</td>';
            counter++;
          } else {
            createdRows += `<tr><td colspan="2"></td></tr>`;
          }
        }
      }
      createdRows += '</tr>'
    }
    const popup = new TrimbleMaps.Popup({
      closeOnMove: true,
      closeButton: true,
      closeOnClick: true,
    }).setLngLat(popupLocation).setHTML(`<ul class="geo-location-detail">
        <li class="current-facility-details"> ${popupContent.Name} </li>
        <li class="citystate">${facilityDetails.City}, ${facilityDetails.StateCode} </li>
        <li class="citystate">Interchanges: ${facilityDetails.Interchanges} </li>
        <li class="availibility">Availibility: ${facilityDetails.AvailableCars} out of ${facilityDetails.Capacity} </li>
    </ul>
    <h4>Features:</h4>
    <span class="info">Some features may be subject to additional charges.</span>
   <table class="bordered-table">
    <tbody>
    ${createdRows}
    </tbody>
    </table>
    <div class="row g-0">
    <div class="col-7">
    <div class="price-holder">
    <p>Daily Rate</p>
      <span class="rates">$${facilityDetails.DailyStorageRate}</span>
    </div>
    </div>
    <div class="col-5 book-now">
    <button id="bookNow" class="olButton mt-3 pull-right">
      Book
      </button>
    </div>
    </div>
    `);
    return popup;
  }
}

export enum RailRoad {
  KCS,
  CSXT,
  BNSF,
  CN,
  CPRS,
  NS,
  UP,
  SHORTLINE
}
