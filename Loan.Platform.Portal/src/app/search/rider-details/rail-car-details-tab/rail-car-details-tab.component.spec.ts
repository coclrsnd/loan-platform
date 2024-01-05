import { ComponentFixture, TestBed } from '@angular/core/testing';

import { RailCarDetailsTabComponent } from './rail-car-details-tab.component';

describe('RailCarDetailsTabComponent', () => {
  let component: RailCarDetailsTabComponent;
  let fixture: ComponentFixture<RailCarDetailsTabComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ RailCarDetailsTabComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(RailCarDetailsTabComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
