import { Component, OnInit } from '@angular/core';
import { LoaderService } from './loader.service';

@Component({
  selector: 'app-loader',
  templateUrl: './loader.component.html',
  styleUrls: ['./loader.component.scss']
})
export class LoaderComponent implements OnInit {

  loading: boolean = false;

  constructor(
    private loaderService: LoaderService
  ) {
  }

  ngOnInit(): void {
    this.loaderService.isLoading.subscribe((v) => {
      this.loading = v;
    });
  }

}
