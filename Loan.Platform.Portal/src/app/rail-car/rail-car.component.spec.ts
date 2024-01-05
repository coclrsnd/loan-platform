import { ComponentFixture, TestBed } from '@angular/core/testing';

import { RailCarComponent } from './rail-car.component';

describe('RailCarComponent', () => {
  let component: RailCarComponent;
  let fixture: ComponentFixture<RailCarComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ RailCarComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(RailCarComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
