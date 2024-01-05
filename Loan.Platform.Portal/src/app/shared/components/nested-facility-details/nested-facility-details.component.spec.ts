import { ComponentFixture, TestBed } from '@angular/core/testing';

import { NestedFacilityDetailsComponent } from './nested-facility-details.component';

describe('NestedFacilityDetailsComponent', () => {
  let component: NestedFacilityDetailsComponent;
  let fixture: ComponentFixture<NestedFacilityDetailsComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ NestedFacilityDetailsComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(NestedFacilityDetailsComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
