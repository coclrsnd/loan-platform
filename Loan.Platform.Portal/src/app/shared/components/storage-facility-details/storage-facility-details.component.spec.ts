import { ComponentFixture, TestBed } from '@angular/core/testing';

import { StorageFacilityDetailsComponent } from './storage-facility-details.component';

describe('StorageFacilityDetailsComponent', () => {
  let component: StorageFacilityDetailsComponent;
  let fixture: ComponentFixture<StorageFacilityDetailsComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ StorageFacilityDetailsComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(StorageFacilityDetailsComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
