import { ComponentFixture, TestBed } from '@angular/core/testing';

import { RatesDetailsTableComponent } from './rates-details-table.component';

describe('RatesDetailsTableComponent', () => {
  let component: RatesDetailsTableComponent;
  let fixture: ComponentFixture<RatesDetailsTableComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ RatesDetailsTableComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(RatesDetailsTableComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
