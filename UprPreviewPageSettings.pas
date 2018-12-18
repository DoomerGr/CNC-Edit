
unit UprPreviewPageSettings;

interface

{$I frx.inc}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, frxClass,NppForms,ChpuPlugin
{$IFDEF Delphi6}
, Variants, RzButton, RzRadChk, RzPanel, RzRadGrp
{$ENDIF};

type
  TDesignerUnits = (duCM, duInches, duPixels, duChars);

  TPrnUprPageSettings = class(TNppForm)
    OKB: TButton;
    CancelB: TButton;
    SizeL: TGroupBox;
    WidthL: TLabel;
    HeightL: TLabel;
    UnitL1: TLabel;
    UnitL2: TLabel;
    WidthE: TEdit;
    HeightE: TEdit;
    SizeCB: TComboBox;
    OrientationL: TGroupBox;
    PortraitImg: TImage;
    LandscapeImg: TImage;
    PortraitRB: TRadioButton;
    LandscapeRB: TRadioButton;
    MarginsL: TGroupBox;
    LeftL: TLabel;
    TopL: TLabel;
    RightL: TLabel;
    BottomL: TLabel;
    UnitL3: TLabel;
    UnitL4: TLabel;
    UnitL5: TLabel;
    UnitL6: TLabel;
    MarginLeftE: TEdit;
    MarginTopE: TEdit;
    MarginRightE: TEdit;
    MarginBottomE: TEdit;
    RzRadioGroupZagolovok: TRzRadioGroup;
    procedure FormShow(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure PortraitRBClick(Sender: TObject);
    procedure SizeCBClick(Sender: TObject);
    procedure WidthEChange(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure OKBClick(Sender: TObject);
  private
    { Private declarations }
    FPage: TfrxReportPage;
    FReport: TfrxReport;
    FUnits: TDesignerUnits;
    FUpdating: Boolean;

    function mmToUnits(mm: Extended): Extended;
    function UnitsTomm(mm: Extended): Extended;
  public
     ModalResult:Integer;
    { Public declarations }
    property Page: TfrxReportPage read FPage write FPage;
    property Report: TfrxReport read FReport write FReport;


  end;


implementation

{$R *.DFM}

uses Printers, frxPrinter, frxUtils, frxRes, IniFiles, NppChpuPrint;


function TPrnUprPageSettings.mmToUnits(mm: Extended): Extended;
begin
 inherited;
  Result := 0;
  case FUnits of
    duCM, duPixels, duChars:
      Result := mm / 10;
    duInches:
      Result := mm / 25.4;
  end;
end;

function TPrnUprPageSettings.UnitsTomm(mm: Extended): Extended;
begin

  Result := 0;
  case FUnits of
    duCM, duPixels, duChars:
      Result := mm * 10;
    duInches:
      Result := mm * 25.4;
  end;
end;



procedure TPrnUprPageSettings.FormShow(Sender: TObject);
var
  i: Integer;
  Ini: TCustomIniFile;
  uStr: String;
begin
  inherited;
  FUpdating := True;
  Caption := frxGet(400);
  WidthL.Caption := frxGet(401);
  HeightL.Caption := frxGet(402);
  SizeL.Caption := frxGet(403);
  OrientationL.Caption := frxGet(404);
  LeftL.Caption := frxGet(405);
  TopL.Caption := frxGet(406);
  RightL.Caption := frxGet(407);
  BottomL.Caption := frxGet(408);
  MarginsL.Caption := frxGet(409);
  PortraitRB.Caption := frxGet(410);
  LandscapeRB.Caption := frxGet(411);
  OKB.Caption := frxGet(1);
  CancelB.Caption := frxGet(2);




  Ini := Report.GetIniFile;
  FUnits := TDesignerUnits(Ini.ReadInteger('Form.TfrxDesignerForm', 'Units', 0));
  Ini.Free;

  uStr := '';
  case FUnits of
    duCM, duPixels, duChars:
      uStr := frxResources.Get('uCm');
    duInches:
      uStr := frxResources.Get('uInch');
  end;

  UnitL1.Caption := uStr;
  UnitL2.Caption := uStr;
  UnitL3.Caption := uStr;
  UnitL4.Caption := uStr;
  UnitL5.Caption := uStr;
  UnitL6.Caption := uStr;

  SizeCB.Items := frxPrinters.Printer.Papers;
  i := frxPrinters.Printer.PaperIndex(Page.PaperSize);
  if i = -1 then  i := frxPrinters.Printer.PaperIndex(256);
  SizeCB.ItemIndex := i;

  WidthE.Text := frxFloatToStr(mmToUnits(Page.PaperWidth));
  HeightE.Text := frxFloatToStr(mmToUnits(Page.PaperHeight));
  PortraitRB.Checked := Page.Orientation = poPortrait;
  LandscapeRB.Checked := Page.Orientation = poLandscape;

  MarginLeftE.Text := frxFloatToStr(mmToUnits(Page.LeftMargin));
  MarginRightE.Text := frxFloatToStr(mmToUnits(Page.RightMargin));
  MarginTopE.Text := frxFloatToStr(mmToUnits(Page.TopMargin));
  MarginBottomE.Text := frxFloatToStr(mmToUnits(Page.BottomMargin));

  PortraitRBClick(nil);
  FUpdating := False;

  if FmNppCHPUPrint.PrintZagolovok='All' then RzRadioGroupZagolovok.ItemIndex:=0
   else if FmNppCHPUPrint.PrintZagolovok='Name' then RzRadioGroupZagolovok.ItemIndex:=1
    else if FmNppCHPUPrint.PrintZagolovok='OFF' then RzRadioGroupZagolovok.ItemIndex:=2;

end;

procedure TPrnUprPageSettings.FormHide(Sender: TObject);
begin
  if ModalResult = mrOk then
  begin
    if PortraitRB.Checked then
      Page.Orientation := poPortrait else
      Page.Orientation := poLandscape;

    Page.PaperWidth := UnitsTomm(frxStrToFloat(WidthE.Text));
    Page.PaperHeight := UnitsTomm(frxStrToFloat(HeightE.Text));
    Page.PaperSize := frxPrinters.Printer.PaperNameToNumber(SizeCB.Text);

    Page.LeftMargin := UnitsTomm(frxStrToFloat(MarginLeftE.Text));
    Page.RightMargin := UnitsTomm(frxStrToFloat(MarginRightE.Text));
    Page.TopMargin := UnitsTomm(frxStrToFloat(MarginTopE.Text));
    Page.BottomMargin := UnitsTomm(frxStrToFloat(MarginBottomE.Text));

    Page.AlignChildren;

    if RzRadioGroupZagolovok.ItemIndex=0 then
     with FmNppCHPUPrint do
      begin
       PrintZagolovok:='All';
       ReportZagolovok:='Позиция: '+Zagolovok.Name+#13+#10+
            'Компания: '+Zagolovok.Vendor+'  Разработчик: '+Zagolovok.Razrab+'  СЧПУ: '+Zagolovok.CPU;
      (frxReportUprPrint.FindObject('RptTitleZagolovok') as TfrxReportTitle).Visible:=True;
      end;

    if RzRadioGroupZagolovok.ItemIndex=1 then
     with FmNppCHPUPrint do
      begin
       PrintZagolovok:='Name';
       ReportZagolovok:='Позиция: '+Zagolovok.Name;
       (frxReportUprPrint.FindObject('RptTitleZagolovok') as TfrxReportTitle).Visible:=True;
      end;

    if RzRadioGroupZagolovok.ItemIndex=2 then
     with FmNppCHPUPrint do
      begin
       (frxReportUprPrint.FindObject('RptTitleZagolovok') as TfrxReportTitle).Visible:=false;
       PrintZagolovok:='OFF';
      end;
  end;
end;

procedure TPrnUprPageSettings.PortraitRBClick(Sender: TObject);
begin
  inherited;
  PortraitImg.Visible := PortraitRB.Checked;
  LandscapeImg.Visible := LandscapeRB.Checked;
  SizeCBClick(nil);
end;

procedure TPrnUprPageSettings.SizeCBClick(Sender: TObject);
var
  pOr: TPrinterOrientation;
  pNumber: Integer;
  pWidth, pHeight: Extended;
begin
  inherited;
  if FUpdating then Exit;
  FUpdating := True;

  with frxPrinters.Printer do
  begin
    pNumber := PaperNameToNumber(SizeCB.Text);
    pWidth := UnitsTomm(frxStrToFloat(WidthE.Text));
    pHeight := UnitsTomm(frxStrToFloat(HeightE.Text));
    if PortraitRB.Checked then
      pOr := poPortrait else
      pOr := poLandscape;

    if pNumber = 256 then
      SetViewParams(pNumber, pHeight, pWidth, pOr) else
      SetViewParams(pNumber, pWidth, pHeight, pOr);

    WidthE.Text := frxFloatToStr(mmToUnits(PaperWidth));
    HeightE.Text := frxFloatToStr(mmToUnits(PaperHeight));
  end;

  FUpdating := False;
end;

procedure TPrnUprPageSettings.WidthEChange(Sender: TObject);
begin
  inherited;
  if not FUpdating then
    SizeCB.ItemIndex := 0;
end;

procedure TPrnUprPageSettings.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if Key = VK_F1 then
    frxResources.Help(Self);
end;

procedure TPrnUprPageSettings.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  close
end;

procedure TPrnUprPageSettings.OKBClick(Sender: TObject);
begin
  inherited;
  ModalResult:=mrOk;
end;

end.



