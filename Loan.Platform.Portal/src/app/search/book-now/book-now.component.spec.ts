import { ComponentFixture, TestBed } from '@angular/core/testing';

import { StoragePackageComponent } from './storage-package.component';

describe('StoragePackageComponent', () => {
  let component: StoragePackageComponent;
  let fixture: ComponentFixture<StoragePackageComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [StoragePackageComponent]
    })
      .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(StoragePackageComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
