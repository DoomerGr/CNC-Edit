unit NppChpuPrint;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RzButton, RzRadChk, StdCtrls, Mask, RzEdit, RzLabel, RzPanel,Buttons,
  UprPreviewPageSettings,  ExtCtrls, frxClass, frxDBSet, frxGradient,
  scisupport,frxExportPDF, frxExportRTF,frxPreview,NppPlugin,NppForms;

type
   ZagolRacPrn = record
             Name:String;
             Razrab:String;
             Vendor:String;
             CPU:String;
   end;

  TFmNppCHPUPrint = class(TNppForm)
    RzPanel1: TRzPanel;
    RzBox1: TRzGroupBox;
    RzLbl1: TRzLabel;
    RzEditRazrab: TRzEdit;
    RzLbl2: TRzLabel;
    RzEditCNC: TRzEdit;
    RzLbl3: TRzLabel;
    RzEditVendor: TRzEdit;
    RzLbl4: TRzLabel;
    RzEditNameDetal: TRzEdit;
    RzRadBtnPrintName: TRzRadioButton;
    RzRadBtnPrintNoInfo: TRzRadioButton;
    RzRadBtnPrintInfo: TRzRadioButton;
    RzBitBtnRacioPrint: TRzBitBtn;
    RzBitBtnClose: TRzBitBtn;
    frxRTFExport1: TfrxRTFExport;
    frxReportUprPrint: TfrxReport;
    frxPDFExport1: TfrxPDFExport;
    frxGradObjct1: TfrxGradientObject;
    DlgFont1: TFontDialog;
    procedure RzBitBtnRacioPrintClick(Sender: TObject);
    procedure OpredMaxStr;
    procedure RzBitBtnCloseClick(Sender: TObject);
    procedure frxReportUprPrintPreview(Sender: TObject);
    procedure SetupM(Sender: TObject);
    procedure SelectFont(Sender: TObject);
    procedure frxReportUprPrintGetValue(const VarName: String;
      var Value: Variant);

  private
    { Private declarations }
  public
   SL: TStringList;
   MaxLeng,nmax:Integer;
   Zagolovok:ZagolRacPrn;
   ReportZagolovok:string;
   PrintZagolovok:string[10];

    { Public declarations }
  end;

var
  FmNppCHPUPrint: TFmNppCHPUPrint;

implementation

{$R *.dfm}

procedure TFmNppCHPUPrint.OpredMaxStr;
var i:Integer;
begin
 inherited;
  MaxLeng:=0;
  for i:=0 to SL.Count-1 do
  If Length(SL.Strings[i])>MaxLeng Then begin MaxLeng:=Length(SL.Strings[i]);nmax:=i end;
end;

procedure TFmNppCHPUPrint.RzBitBtnRacioPrintClick(Sender: TObject);
var   Page: TfrxReportPage;
  MPrevHandle:hwnd;
  nLen:Cardinal;
  buf:string;

begin
 inherited;
   with Zagolovok do
    begin
     Razrab:=RzEditRazrab.Text;
     CPU:=RzEditCNC.Text;
     Vendor:=RzEditVendor.Text;
     Name:=RzEditNameDetal.Text;
    end;

  if RzRadBtnPrintInfo.Checked then
   with Zagolovok do
    begin
     PrintZagolovok:='All';
     ReportZagolovok:='Позиция: '+Name+#13+#10+
          'Компания: '+Vendor+'  Разработчик: '+Razrab+'  СЧПУ: '+CPU;
    (frxReportUprPrint.FindObject('RptTitleZagolovok') as TfrxReportTitle).Visible:=True;
    end;

  if RzRadBtnPrintName.Checked then
   with Zagolovok do
    begin
     PrintZagolovok:='Name';
     ReportZagolovok:='Позиция: '+Name;
     (frxReportUprPrint.FindObject('RptTitleZagolovok') as TfrxReportTitle).Visible:=True;
    end;

   if RzRadBtnPrintNoInfo.Checked then
    begin
     (frxReportUprPrint.FindObject('RptTitleZagolovok') as TfrxReportTitle).Visible:=false;
     PrintZagolovok:='OFF';
    end;

   nLen:=SendMessage(Npp.NppData.ScintillaMainHandle, SCI_GETLENGTH,0,0);
   SetLength(buf,nLen+1);
   SendMessage(Npp.NppData.ScintillaMainHandle, SCI_GETTEXT,nLen+1,LPARAM(Pchar(buf)));


   SL := TStringList.Create;
   SL.Text:=buf;
   Page := TfrxReportPage(frxReportUprPrint.Pages[1]);
   frxReportUprPrint.ReportOptions.Name := 'Печать управляющей программы: '+Zagolovok.name;

   frxReportUprPrint.ShowReport;
   MPrevHandle:=frxReportUprPrint.Preview.Handle;

end;

procedure TFmNppCHPUPrint.RzBitBtnCloseClick(Sender: TObject);
begin
 inherited;
Close
end;


procedure TFmNppCHPUPrint.SetupM(Sender: TObject);
var   APage: TfrxReportPage;
      FMSetup:TPrnUprPageSettings;
begin
 inherited;
 APage :=TfrxReportPage(frxReportUprPrint.Pages[1]);
 if Assigned(APage) then
 begin
  FMSetup:=TPrnUprPageSettings.Create(self);
  with FMSetup do
   begin
    Page := APage;
    Report := Self.frxReportUprPrint;
    ShowModal;
    if ModalResult=mrOk then Self.frxReportUprPrint.PrepareReport;
   end;
  FMSetup.Free;
 end;
end;


procedure TFmNppCHPUPrint.SelectFont(Sender: TObject);
var MemoTextProg: TfrxMemoView;

begin
 inherited;
 MemoTextProg:= frxReportUprPrint.FindObject('MemoUprProg') as TfrxMemoView;
if DlgFont1.Execute then
 begin
  MemoTextProg.Font.Assign(DlgFont1.Font);
  Self.frxReportUprPrint.PrepareReport;
 end;
end;


procedure TFmNppCHPUPrint.frxReportUprPrintPreview(Sender: TObject);
var Button: TSpeedButton;

begin
 inherited;
 // Добавление новой кнопки
   Button := TSpeedButton.Create(TfrxPreviewForm(frxReportUprPrint.PreviewForm).ToolBar);
   Button.Parent:=TfrxPreviewForm(frxReportUprPrint.PreviewForm).ToolBar;
   Button.Caption:=''; Button.Width:=26; Button.Left:=380;
   Button.Flat:=true;Button.Hint:='Изменить шрифт УП';Button.ShowHint:=True;
   Button.Glyph.LoadFromResourceName(HInstance,'ICONFONT');
 // Обработчик новой кнопки
   Button.OnClick:=SelectFont;
   TfrxPreviewForm(frxReportUprPrint.PreviewForm).PageSettingsB.OnClick :=SetupM;
end;

procedure TFmNppCHPUPrint.frxReportUprPrintGetValue(const VarName: String;
  var Value: Variant);
begin
 inherited;
  OpredMaxStr;
  DlgFont1.Font.Assign((frxReportUprPrint.FindObject('MemoUprProg') as TfrxMemoView).Font);
  if CompareText(VarName, 'KolStolb') = 0 then  Value:=1;
  if CompareText(VarName, 'KolStr') = 0 then  Value:=SL.Count;
  if CompareText(VarName, 'Maxstr') = 0 then Value:=SL.Strings[nmax];
  if CompareText(VarName, 'UprProg') = 0 then Value := sl.Text;
  if CompareText(VarName, 'Poziciya') = 0 then
    if RzRadBtnPrintNoInfo.Checked then
     begin
      (frxReportUprPrint.FindObject('Line2') as TfrxLineView).Visible:=False;
      Value:=''
    end
     else
      begin
       Value:=Zagolovok.Name;
       (frxReportUprPrint.FindObject('Line2') as TfrxLineView).Visible:=True;
      end;
  if CompareText(VarName, 'Zagolovok') = 0 then  Value:=ReportZagolovok;
end;

end.
