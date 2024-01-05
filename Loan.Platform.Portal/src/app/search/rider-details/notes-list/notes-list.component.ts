import { DatePipe } from '@angular/common';
import { Component, Input, OnChanges, OnDestroy, OnInit,Output,EventEmitter } from '@angular/core';
import { FormBuilder, FormGroup } from '@angular/forms';
import { MatTableDataSource } from '@angular/material/table';
import { ToastrService } from 'ngx-toastr';
import { Observable } from 'rxjs/internal/Observable';
import { Subscription } from 'rxjs/internal/Subscription';
import { APP_CONSTANTS } from 'src/app/app-constants';
import { SharedService } from 'src/app/shared/shared.service';
import { RiderService } from '../../rider/rider-service';
import { NoteModel } from './noteModel';

@Component({
  selector: 'app-notes-list',
  templateUrl: './notes-list.component.html',
  styleUrls: ['./notes-list.component.scss']
})
export class NotesListComponent implements OnInit, OnChanges, OnDestroy {
  @Input() events: Observable<void>;
  @Input() riderModelData;
  @Input() mode;
  @Output() updateHistoryList = new EventEmitter<boolean>();
  public isNotes: boolean = false;
  public notesForm: FormGroup;
  private eventsSubscription: Subscription;
  public submittedDetails: boolean = false;
  public dataSource: any;
  columnsToDisplay = ['Description', 'CreatedTime', 'User'];
  public selectedFiles: any;
  public noteModel = new NoteModel;
  constructor(public formBuilder: FormBuilder, public datepipe: DatePipe, public riderService: RiderService,
    public toastr: ToastrService,private sharedService: SharedService) { }

  ngOnInit(): void {
    this.eventsSubscription = this.events.subscribe(() => this.triggerNotesEvent());
    this.initilizeNotesForm();
    if (this.riderModelData.Id && this.mode !== APP_CONSTANTS.copy) {
      this.GetNotes(this.riderModelData.Id);
    }
  }

  public GetNotes(ContractId: number) {
    this.riderService.GetNotesByContractId(ContractId).subscribe(notes => {
      this.dataSource = notes;
    }, error => {
    });
  }

  public ngOnChanges(changes: any) {
  }

  public ngOnDestroy() {
    this.eventsSubscription.unsubscribe();
  }

  public initilizeNotesForm(): void {
    this.notesForm = this.formBuilder.group({
      Description: [APP_CONSTANTS.emptyString],
    });
  }

  get notesFormGetter() { return this.notesForm.controls; }

  public triggerNotesEvent() {
    this.isNotes = true;
  }

  public insertDataInTable(formattedObj): any {
    this.dataSource.filteredData.push(formattedObj);
    this.dataSource._updateChangeSubscription();
  }

  public onSubmitNotesForm(): void {
    this.submittedDetails = true;
    // stop here if form is invalid
    if (this.notesForm.invalid && !this.riderModelData.Id) {
      return;
    }
    if(this.sharedService.CheckIfEmptyOrNull(this.notesForm.value.Description) != '')
    {
      const formData = this.notesForm.getRawValue();
      const formattedObj = this.formattedData(formData);
      this.noteModel = Object.assign(this.notesForm.value);
      this.noteModel.ContractId = this.riderModelData.Id
      this.riderService.SaveNotes(this.noteModel).subscribe(result => {
        if (result.Id) {
          this.toastr.success("Note added successfully.");
          this.GetNotes(this.riderModelData.Id);
          this.updateHistoryList.emit(true);
        }
      }, error => {
        this.toastr.error("Error while saving Note.");
        this.GetNotes(this.riderModelData.Id);
      });
    }
    //this.insertDataInTable(formattedObj);
    this.isNotes = false;
    this.notesForm.reset();
  }

  public formattedData(formData): any {
    formData.DateAndTime = this.datepipe.transform(new Date(), 'dd/MM/yyyy, hh:mm a');
    formData.User = 'User Name';
    return formData;
  }

}
