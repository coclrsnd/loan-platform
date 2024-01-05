import { Component, Input, OnDestroy, OnInit ,Output,EventEmitter} from '@angular/core';
import { ToastrService } from 'ngx-toastr';
import { Observable } from 'rxjs/internal/Observable';
import { Subscription } from 'rxjs/internal/Subscription';
import { APP_CONSTANTS } from 'src/app/app-constants';
import { RiderService } from '../../rider/rider-service';
import { AttachmentModel } from './attachmentModel';
import { AttachmentService } from './attachmentService';
import { DomSanitizer } from '@angular/platform-browser';

@Component({
  selector: 'app-attachments-list',
  templateUrl: './attachments-list.component.html',
  styleUrls: ['./attachments-list.component.scss']
})
export class AttachmentsListComponent implements OnInit, OnDestroy {
  @Input() events: Observable<void>;
  @Input() riderModelData;
  @Input() mode;
  @Output() updateHistoryList = new EventEmitter<boolean>();
  public isUpload: boolean = false;
  private eventsSubscription: Subscription;
  public dataSource: any;
  columnsToDisplay = ['FileName', 'CreatedTime', 'User'];
  public selectedFiles: any;
  public allowedFileType : string[] =['jpg', 'jpeg', 'doc', 'docx', 'xlsx', 'png', 'csv', 'pdf', 'txt'];
  public attachmentModel = new AttachmentModel;
  frmData: FormData;
  fileUrl;
  constructor(public attachmentService: AttachmentService, public toastr: ToastrService, public riderService: RiderService, private sanitizer: DomSanitizer) { }

  ngOnInit(): void {
    this.eventsSubscription = this.events.subscribe(() => this.triggerUploadEvent());
    if (this.riderModelData.Id && this.mode !== APP_CONSTANTS.copy) {
      this.GetAttachments(this.riderModelData.Id);
    }
  }

  public GetAttachments(ContractId: number) {
    this.riderService.GetAttachmentsByContractId(ContractId).subscribe(attachments => {
      this.dataSource = attachments;
    }, error => {
    });
  }

  public ngOnDestroy() {
    this.eventsSubscription.unsubscribe();
  }

  public triggerUploadEvent() {
    this.isUpload = true;
  }

  public selectFile(event) {
    this.selectedFiles = (event.target as HTMLInputElement).files;
  }

  public downloadAttachment(attachmentModel) {
    this.attachmentService.DownloadAttachment(attachmentModel.ContractId,attachmentModel.FileName).subscribe(
      fileData => {
          this.downloadFile(fileData, attachmentModel);
      });
  }

  private downloadFile = (data: Blob, attachmentModel: AttachmentModel) => {
    const downloadedFile = new Blob([data], { type: data.type });
    const a = document.createElement('a');
    a.setAttribute('style', 'display:none;');
    document.body.appendChild(a);
    a.download = attachmentModel.FileName;
    a.href = URL.createObjectURL(downloadedFile);
    a.target = '_blank';
    a.click();
    document.body.removeChild(a);
  }

  public onSubmitUploadForm(): void {
    if (this.riderModelData.Id) {
      if (!this.selectedFiles) {
        this.toastr.error("Please select file to upload.");
        return;
      }
      if (this.selectedFiles[0].size >= 5242880) {
        this.toastr.error("Maximum file size limit is 5mb.");
        return;
      }
      if(!this.CheckValidExtension(this.selectedFiles[0]))
      {
        this.toastr.error("Incorrect file format. Allowed types .docx, .doc, .pdf, .png, .jpg, .jpeg, .txt, .xlsx, .csv");
        return;
      }
      this.frmData = new FormData();
      /*this.frmData.append("FileName", this.selectedFiles[0].name);*/
      this.frmData.append("File", this.selectedFiles[0]);
      this.frmData.append("ContractId", this.riderModelData.Id);
      this.attachmentService.SaveAttachment(this.frmData).subscribe(
        data => {
          if (data != null) {
            this.toastr.success("Attachment added successfully.");
            this.isUpload = false;
            this.selectedFiles = "";
            this.GetAttachments(this.riderModelData.Id);
            this.updateHistoryList.emit(true);
          }
        });
    }
  }

  public CheckValidExtension(file :any):boolean{
    let fileExtension=this.GetExtension(file.name);
    if(this.allowedFileType.indexOf(fileExtension.toLowerCase())>-1){
      return true;
    }
    return false;
  }

  public GetExtension(filename:string){
    var parts = filename.split('.');
    return parts[parts.length - 1];
  }
}

