unit ChpuRenumForms;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, NppForms, StdCtrls, NppPlugin, Mask, RzEdit, RzCmboBx,
  scisupport,RzLabel, RzBorder, RzButton, ExtCtrls, RzPanel, RzSpnEdt,
  RzTabs, RzRadChk, RzLstBox, RzStatus;


type

  SimSet = set of char;
  TArrayTxt = array of string[25];
  TArrayChar = set of char;

  TFmChpuRenum = class(TNppForm)
    RzPagCtrlRzPagCtrDopoln: TRzPageControl;
    RzTabShtTabSheet1: TRzTabSheet;
    RzPanel1: TRzPanel;
    Lbl4: TRzLabel;
    Lbl5: TRzLabel;
    rzbrdr1: TRzBorder;
    RzBitBtnDelNum: TRzBitBtn;
    RzBitBtnClose: TRzBitBtn;
    RzBitBtnRenum: TRzBitBtn;
    RzEditPropInStr: TRzEdit;
    RzEditPropStr1: TRzEdit;
    RzTabShtTabSheet2: TRzTabSheet;
    RzPanel2: TRzPanel;
    RzEditStrTextPos: TRzEdit;
    Lbl8: TRzLabel;
    RzMemoAddStr: TRzMemo;
    RzBitBtnStrRun: TRzBitBtn;
    RzBitBtn2: TRzBitBtn;
    RzTabShtTabSheet3: TRzTabSheet;
    RzPanel3: TRzPanel;
    RzBox1: TRzGroupBox;
    RzSpnKorProc: TRzSpinner;
    Lbl11: TRzLabel;
    Lbl12: TRzLabel;
    RzNEditKorNa: TRzNumericEdit;
    RzRadBtnKorProc: TRzRadioButton;
    RzRadBtnKorNa: TRzRadioButton;
    RzBitBtnKorAdrRun: TRzBitBtn;
    RzBitBtnKorZnClose: TRzBitBtn;
    RzComBoxDopOperac: TRzComboBox;
    Lbl13: TRzLabel;
    Lbl14: TRzLabel;
    RzSpnEdtPropStr: TRzSpinEdit;
    RzTabShtTabSheet4: TRzTabSheet;
    RzPanel4: TRzPanel;
    RzBox2: TRzGroupBox;
    Lbl10: TRzLabel;
    TRzEditKorAdr: TRzEdit;
    RzBox3: TRzGroupBox;
    Lbl17: TRzLabel;
    RzNEditStartStrProbel: TRzNumericEdit;
    Lbl22: TRzLabel;
    RzNEditProbel_N: TRzNumericEdit;
    RzSpnBtnNProbel: TRzSpinButtons;
    RzEditProbProp1Sim: TRzEdit;
    RzEditProbProp2Sim: TRzEdit;
    Lbl19: TRzLabel;
    RzEditProbPropStr: TRzEdit;
    Lbl18: TRzLabel;
    Lbl6: TRzLabel;
    RzComBoxFormatNom: TRzComboBox;
    Lbl1: TRzLabel;
    RzEditSim_Nom: TRzEdit;
    Lbl3: TRzLabel;
    RzNEditStartNStr: TRzNumericEdit;
    Lbl7: TRzLabel;
    RzNEditStartNum: TRzNumericEdit;
    Lbl2: TRzLabel;
    RzNEditShag: TRzNumericEdit;
    RzSpnBtnShag: TRzSpinButtons;
    RzSpnBtnProbel: TRzSpinButtons;
    RzNEditNProbel: TRzNumericEdit;
    Lbl9: TRzLabel;
    RzBox4: TRzGroupBox;
    RzBitBtnInsProbelRun: TRzBitBtn;
    RzBitBtnDelProbelRun: TRzBitBtn;
    RzBitBtnCloseProbel: TRzBitBtn;
    RzCheckBoxRound: TRzCheckBox;
    RzSpnNZnak: TRzSpinner;
    Lbl15: TRzLabel;
    Lbl16: TRzLabel;
    Lbl20: TRzLabel;
    rzvrsnfsts1: TRzVersionInfoStatus;
    RzVersInf1: TRzVersionInfo;
    procedure FormCreate(Sender: TObject);
{    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormHide(Sender: TObject);
    procedure FormFloat(Sender: TObject);
    procedure FormDock(Sender: TObject);
    procedure FormShow(Sender: TObject);}
    procedure RzBitBtnRenumClick(Sender: TObject);
    procedure RzBitBtnCloseClick(Sender: TObject);
    procedure RzBitBtnDelNumClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure RzSpnBtnShagUpRightClick(Sender: TObject);
    procedure RzSpnBtnShagDownLeftClick(Sender: TObject);
    procedure RzSpnBtnProbelDownLeftClick(Sender: TObject);
    procedure RzSpnBtnProbelUpRightClick(Sender: TObject);
    procedure RzBitBtnStrRunClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure RzComBoxDopOperacChange(Sender: TObject);
    procedure RzBitBtnKorAdrRunClick(Sender: TObject);
    procedure RzBitBtnInsProbelRunClick(Sender: TObject);
    procedure RzSpnBtnNProbelDownLeftClick(Sender: TObject);
    procedure RzSpnBtnNProbelUpRightClick(Sender: TObject);
    function  LoadArrayTxt(St:string):TArrayTxt;
    function  LoadArrayChar(St:string):TArrayChar;
  private
    { Private declarations }
  public
    { Public declarations }
   SimSet_Lat:SimSet;
   SimSet_Cifr,SimSet_all:SimSet;
  end;

var
  FmChpuRenum: TFmChpuRenum;

implementation

uses AboutChpu;

{$R *.dfm}

procedure TFmChpuRenum.FormCreate(Sender: TObject);
begin
  self.KeyPreview := true; // special hack for input forms
{  self.NppDefaultDockingMask := DWS_DF_FLOATING; // whats the default docking position

  self.OnFloat := self.FormFloat;
  self.OnDock := self.FormDock;
  self.Width:=648;}

  inherited;
  SimSet_Lat:=['a'..'z']+['A'..'Z','=','"','_'];SimSet_Cifr:=['0'..'9','+','-','.',','];
  SimSet_all:=['!'..'~'];
  DecimalSeparator := '.'
end;


procedure TFmChpuRenum.FormKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if (Key = #13) and (self.RzMemoAddStr.Focused) then self.RzMemoAddStr.Perform(WM_CHAR, 10, 0);
end;

procedure TFmChpuRenum.RzBitBtnRenumClick(Sender: TObject);
var SimPropInStr,SimPropBegStr:TArrayTxt;
    Tek_Size,StartNStr,Nom,Shag:Extended;
    N1,N2,i,p,LengthStr,CountLine,
    Block1,Block2,N_Line,TekPos:integer;
    buf,WorkList:string;
    Probel:string[100];
    Block,Propusk,DelOldNum:Boolean;

begin
  inherited;

 Block1:=0;Block2:=0;Block:=False;
 N1:=SendMessage(Npp.NppData.ScintillaMainHandle, SCI_GETSELECTIONSTART,0,0);
 N2:=SendMessage(Npp.NppData.ScintillaMainHandle, SCI_GetSELECTIONEND,0,0);
 TekPos:=SendMessage(Npp.NppData.ScintillaMainHandle,SCI_GETFIRSTVISIBLELINE,0,0);

 if N1<>N2 then
  begin
   Block1:=SendMessage(Npp.NppData.ScintillaMainHandle,SCI_LINEFROMPOSITION,N1,0);
   Block2:=SendMessage(Npp.NppData.ScintillaMainHandle,SCI_LINEFROMPOSITION,N2,0);
   Block:=True;
  end;

  if RzEditPropStr1.Text<>'' then
    SimPropBegStr:=LoadArrayTxt(RzEditPropStr1.Text);

  if RzEditPropInStr.Text<>'' then
     SimPropInStr:=LoadArrayTxt(RzEditPropInStr.Text);

  Shag:=RzNEditShag.Value;Nom:=RzNEditStartNum.Value;
  Tek_Size:=0;WorkList:='';Probel:='';

  if RzNEditNProbel.Value>0 then for i:=1 to Trunc(RzNEditNProbel.Value) do Probel:=Probel+' ';
  CountLine:=SendMessage(Npp.NppData.ScintillaMainHandle, SCI_GETLINECOUNT,0,0);
  if Block then StartNStr:=Block1
   else  begin StartNStr:=RzNEditStartNStr.Value-1;Block2:=CountLine end;

  for N_Line:=0 to CountLine-1 do
   begin
    LengthStr:=SendMessage(Npp.NppData.ScintillaMainHandle, SCI_LINELENGTH, N_Line,0);
    Tek_Size:=Tek_Size+LengthStr;
    SetLength(buf,LengthStr);
    SendMessage(Npp.NppData.ScintillaMainHandle, SCI_GETLINE, N_Line,LPARAM(PChar(buf)));
    propusk:=False;

    if Length(buf)<>0 then
     begin
      if (buf[1]=#10) or (buf[1]=#13) then begin WorkList:=WorkList+buf;Continue end
     end else Continue;

    if Length(SimPropInStr)>0 then
      for i:=0 to Length(SimPropInStr)-1 do
        if Pos(SimPropInStr[i],buf)<>0 then propusk:=True;

    if Length(SimPropBegStr)>0 then
      for i:=0 to Length(SimPropBegStr)-1 do
        if Pos(SimPropBegStr[i],buf)=1 then propusk:=True;

     if (N_Line>=StartNStr) and (not(propusk) and (Block2>=N_Line)) then
       begin
        p:=Pos(RzEditSim_Nom.Text,buf);
        if p>0 then
         begin
          DelOldNum:=True;
          for i:=1 to p-1 do
           if buf[i] in SimSet_all then begin DelOldNum:=False;Break end;

          if DelOldNum then
           begin
             for i:=p+Length(RzEditSim_Nom.Text) to Length(buf)-1 do
             if buf[i] in SimSet_Lat then begin Delete(buf,1,i-1);Break end;
           end;
         end;
        WorkList:=WorkList+AnsiToUtf8(RzEditSim_Nom.Text)+
        FormatFloat(RzComBoxFormatNom.Text,Nom)+Probel+buf;
        Nom:=Nom+Shag;
       end
     else WorkList:=WorkList+buf;
   end;
  SendMessage(self.Npp.NppData.ScintillaMainHandle, SCI_SETTEXT, 0, LPARAM(PChar(WorkList)));
  WorkList:='';Probel:='';SetLength(SimPropBegStr,0);SetLength(SimPropInStr,0);
  SendMessage(Npp.NppData.ScintillaMainHandle,SCI_LINESCROLL,0,TekPos)
end;

procedure TFmChpuRenum.RzBitBtnCloseClick(Sender: TObject);
begin
  inherited;
  close
//  self.Hide;
end;

procedure TFmChpuRenum.RzBitBtnDelNumClick(Sender: TObject);
var i,p:Integer;
    Block1,Block2,TekPos,LengthStr,N1,N2,
    CountLine,N_Line,StartStr:integer;
    buf,WorkList:string;
    Block,DelOldNum:Boolean;
 begin
  inherited;

  WorkList:='';
  CountLine:=SendMessage(Npp.NppData.ScintillaMainHandle, SCI_GETLINECOUNT,0,0);
  TekPos:=SendMessage(Npp.NppData.ScintillaMainHandle,SCI_GETFIRSTVISIBLELINE,0,0);
  Block1:=0;Block2:=0;Block:=False;
  N1:=SendMessage(Npp.NppData.ScintillaMainHandle, SCI_GETSELECTIONSTART,0,0);
  N2:=SendMessage(Npp.NppData.ScintillaMainHandle, SCI_GetSELECTIONEND,0,0);

  if N1<>N2 then
    begin
     Block1:=SendMessage(Npp.NppData.ScintillaMainHandle,SCI_LINEFROMPOSITION,N1,0);
     Block2:=SendMessage(Npp.NppData.ScintillaMainHandle,SCI_LINEFROMPOSITION,N2,0);
     Block:=True;
    end;

  if Block then StartStr:=Block1
   else  begin StartStr:=0;Block2:=CountLine end;

  for N_Line:=0 to CountLine-1 do
   begin
    LengthStr:=SendMessage(Npp.NppData.ScintillaMainHandle, SCI_LINELENGTH, N_Line,0);
    SetLength(buf,LengthStr);
    SendMessage(Npp.NppData.ScintillaMainHandle, SCI_GETLINE, N_Line,LPARAM(PChar(buf)));

    if (N_Line>=StartStr) and (Block2>=N_Line) then
     begin
      p:=Pos(RzEditSim_Nom.Text,buf);
       if p>0 then
        begin
         DelOldNum:=True;
         for i:=1 to p-1 do
          if buf[i] in SimSet_all then begin DelOldNum:=False;Break end;

         if DelOldNum then
          begin
            for i:=p+Length(RzEditSim_Nom.Text) to Length(buf)-1 do
            if buf[i] in SimSet_Lat then begin Delete(buf,1,i-1);Break end;
          end;
        end;
     end;
    WorkList:=WorkList+buf;
   end;
  SendMessage(self.Npp.NppData.ScintillaMainHandle, SCI_SETTEXT, 0, LPARAM(PChar(WorkList)));
  SendMessage(Npp.NppData.ScintillaMainHandle,SCI_LINESCROLL,0,TekPos);
  WorkList:='';
 end;
procedure TFmChpuRenum.FormShow(Sender: TObject);

begin
  inherited;
  if RzPagCtrlRzPagCtrDopoln.Focused then RzBitBtnRenum.SetFocus;
end;

procedure TFmChpuRenum.RzSpnBtnShagUpRightClick(Sender: TObject);
begin
  inherited;
  RzNEditShag.Value:=RzNEditShag.Value+1;
end;

procedure TFmChpuRenum.RzSpnBtnShagDownLeftClick(Sender: TObject);
begin
  inherited;
  if RzNEditShag.Value=1 then Exit;
  RzNEditShag.Value:=RzNEditShag.Value-1;
end;

procedure TFmChpuRenum.RzSpnBtnProbelDownLeftClick(Sender: TObject);
begin
  inherited;
  if RzNEditNProbel.Value=0 then Exit;
  RzNEditNProbel.Value:=RzNEditNProbel.Value-1;
end;

procedure TFmChpuRenum.RzSpnBtnProbelUpRightClick(Sender: TObject);
begin
  inherited;
  RzNEditNProbel.Value:=RzNEditNProbel.Value+1;
end;

procedure TFmChpuRenum.RzBitBtnStrRunClick(Sender: TObject);
var Variant,TekPos,LengthStr,CountLine,
    StartStr,Block1,Block2,IndProp,N_Line,LengthStrF:integer;
    Fbuf,buf,WorkList:string;
    Block,PropStr:Boolean;
    N1,N2:Integer;

 begin
  inherited;
  if RzEditStrTextPos.Text='' then Exit;

  WorkList:='';PropStr:=False;IndProp:=0;
  Block1:=0;Block2:=0;Block:=False;
  N1:=SendMessage(Npp.NppData.ScintillaMainHandle, SCI_GETSELECTIONSTART,0,0);
  N2:=SendMessage(Npp.NppData.ScintillaMainHandle, SCI_GetSELECTIONEND,0,0);
  CountLine:=SendMessage(Npp.NppData.ScintillaMainHandle, SCI_GETLINECOUNT,0,0);
  TekPos:=SendMessage(Npp.NppData.ScintillaMainHandle,SCI_GETFIRSTVISIBLELINE,0,0);
    if N1<>N2 then
    begin
     Block1:=SendMessage(Npp.NppData.ScintillaMainHandle,SCI_LINEFROMPOSITION,N1,0);
     Block2:=SendMessage(Npp.NppData.ScintillaMainHandle,SCI_LINEFROMPOSITION,N2,0);
     Block:=True;
    end;
  if Block then StartStr:=Block1
   else  begin StartStr:=0;Block2:=CountLine end;


  Variant:=StrToInt(RzComBoxDopOperac.Value);
  for N_Line:=0 to CountLine-1 do
   begin
    LengthStr:=SendMessage(Npp.NppData.ScintillaMainHandle, SCI_LINELENGTH, N_Line,0);
    SetLength(buf,LengthStr);
    SendMessage(Npp.NppData.ScintillaMainHandle, SCI_GETLINE, N_Line,LPARAM(PChar(buf)));
    if ((N_Line>=StartStr) and (Block2>=N_Line)) then
      case Variant of
        1: if Pos(RzEditStrTextPos.Text,buf)=0 then WorkList:=WorkList+buf;
        3: if Pos(RzEditStrTextPos.Text,buf)<>0 then
            WorkList:=WorkList+copy(buf,1,Length(buf)-2)+RzMemoAddStr.Lines.Strings[0]+#13+#10
           else WorkList:=WorkList+buf;
        4: if (Pos(RzEditStrTextPos.Text,buf)<>0) or (PropStr) then
            begin
              if IndProp=RzSpnEdtPropStr.Value then
               begin
                WorkList:=WorkList+buf+RzMemoAddStr.Text+#13+#10;
                if IndProp>0 then begin IndProp:=0;PropStr:=False end;
               end
              else
               begin
                WorkList:=WorkList+buf;
                PropStr:=True;Inc(IndProp);
               end;
            end
            else WorkList:=WorkList+buf;
       5: begin
           IndProp:=Trunc(RzSpnEdtPropStr.Value)+N_Line;
           if IndProp<=CountLine-1 then
             begin
              LengthStrF:=SendMessage(Npp.NppData.ScintillaMainHandle, SCI_LINELENGTH, IndProp,0);
              SetLength(Fbuf,LengthStrF);
              SendMessage(Npp.NppData.ScintillaMainHandle, SCI_GETLINE, IndProp,LPARAM(PChar(Fbuf)));
              if Pos(RzEditStrTextPos.Text,Fbuf)<>0 then WorkList:=WorkList+RzMemoAddStr.Text+#13+#10+buf
              else WorkList:=WorkList+buf;
             end
           else WorkList:=WorkList+buf;
          end;
       2: begin
           if Pos(RzEditStrTextPos.Text,buf)=0 then WorkList:=WorkList+buf
           else WorkList:=WorkList+RzMemoAddStr.Text+#13+#10;
          end;
      end
    else
     WorkList:=WorkList+buf;
  end;
  SendMessage(self.Npp.NppData.ScintillaMainHandle, SCI_SETTEXT, 0, LPARAM(PChar(WorkList)));
  SendMessage(Npp.NppData.ScintillaMainHandle,SCI_LINESCROLL,0,TekPos);
  WorkList:='';
end;


procedure TFmChpuRenum.RzComBoxDopOperacChange(Sender: TObject);
var ind:word;
begin
  inherited;
  ind:=StrToInt(RzComBoxDopOperac.Value);
  if ind>1 then RzMemoAddStr.Enabled:=True else  RzMemoAddStr.Enabled:=False;
  if ind>3 then
   begin
    Lbl14.Visible:=True;RzSpnEdtPropStr.Visible:=True;
   end
   else
    begin
     Lbl14.Visible:=False;RzSpnEdtPropStr.Visible:=False;
    end;
end;

procedure TFmChpuRenum.RzBitBtnKorAdrRunClick(Sender: TObject);

var Variant,TekPos,LengthStr,CountLine,
    Block1,Block2,i,IndN,IndEnd,N_Line:integer;
    StartStr,N1,N2,Pos1,Pos2:Integer;
    workstr,buf,WorkList:string;
    Tochn:string[15];
    WorkCifr:Real;
    Block:Boolean;

 begin
  inherited;
  if TRzEditKorAdr.Text='' then Exit;

  Block1:=0;Block2:=0;Block:=False;WorkList:='';
  N1:=SendMessage(Npp.NppData.ScintillaMainHandle, SCI_GETSELECTIONSTART,0,0);
  N2:=SendMessage(Npp.NppData.ScintillaMainHandle, SCI_GetSELECTIONEND,0,0);
  CountLine:=SendMessage(Npp.NppData.ScintillaMainHandle, SCI_GETLINECOUNT,0,0);

  if N1<>N2 then
    begin
     Block1:=SendMessage(Npp.NppData.ScintillaMainHandle,SCI_LINEFROMPOSITION,N1,0);
     Block2:=SendMessage(Npp.NppData.ScintillaMainHandle,SCI_LINEFROMPOSITION,N2,0);
     Block:=True;
    end;

  if Block then StartStr:=Block1
   else  begin StartStr:=0;Block2:=CountLine end;

  TekPos:=SendMessage(Npp.NppData.ScintillaMainHandle,SCI_GETFIRSTVISIBLELINE,0,0);
  if RzRadBtnKorNa.Checked then Variant:=1 else Variant:=2;
  Tochn:='###0.';
  for i:=1 to RzSpnNZnak.Value do Tochn:=Tochn+'#';

  for N_Line:=0 to CountLine-1 do
   begin
    LengthStr:=SendMessage(Npp.NppData.ScintillaMainHandle, SCI_LINELENGTH, N_Line,0);
     SetLength(buf,LengthStr);
    SendMessage(Npp.NppData.ScintillaMainHandle, SCI_GETLINE, N_Line,LPARAM(PChar(buf)));
    try
     if (Pos(TRzEditKorAdr.Text,buf)<>0) and
      (buf[Pos(TRzEditKorAdr.Text,buf)+Length(TRzEditKorAdr.Text)] in SimSet_Cifr) and
          ((N_Line>=StartStr) and (Block2>=N_Line)) then
      begin
       IndN:=Pos(TRzEditKorAdr.Text,buf);
       for IndEnd:=indN+Length(TRzEditKorAdr.Text) to LengthStr do if not(buf[IndEnd] in SimSet_Cifr) then Break;
       Dec(IndEnd);
       Pos1:=IndN+Length(TRzEditKorAdr.Text);//начало цифры
       Pos2:=IndEnd-(IndN-1+Length(TRzEditKorAdr.Text));//число цифр
       workstr:=Copy(buf,Pos1,Pos2);
       delete(buf,IndN,IndEnd-IndN+1);
       WorkCifr:=StrToFloat(workstr);
       if RzRadBtnKorNa.Checked then
         WorkCifr:=WorkCifr+RzNEditKorNa.Value
          else
            WorkCifr:=WorkCifr+RzSpnKorProc.Value*(WorkCifr/100);
       if RzCheckBoxRound.Checked then WorkCifr:=Round(WorkCifr);
       workstr:=TRzEditKorAdr.Text+FormatFloat(Tochn,WorkCifr);
       Insert(workstr,buf,IndN);
      end;
     WorkList:=WorkList+buf;
     except
      MessageDlg('При обработке текста возникла ошибка в строке N '+
      IntToStr(N_Line+1)+'.'+#10+'Проверьте синтаксис в программе ЧПУ.',
      mtError, [mbOK], 0);
      Exit;
     end;
  end;
  SendMessage(self.Npp.NppData.ScintillaMainHandle, SCI_SETTEXT, 0, LPARAM(PChar(WorkList)));
  SendMessage(Npp.NppData.ScintillaMainHandle,SCI_LINESCROLL,0,TekPos);
  WorkList:='';
end;

function TFmChpuRenum.LoadArrayTxt(St:string):TArrayTxt;
var p,i:Integer;

begin
 if St<>'' then
   begin
    p:=0;
    for i:=1 to Length(st) do if st[i]=',' then Inc(p);
    if p>0 then SetLength(Result,p+1) else SetLength(Result,1);
    i:=0;
    if Pos(',',St)=0 then Result[i]:=st
    else
     begin
      for i:=0 to p-1 do
       begin
        Result[i]:=Copy(st,1,Pos(',',St)-1);
        Delete(st,1,Pos(',',St));
       end;
      Result[p]:=st;
    end;
   end;
end;


function TFmChpuRenum.LoadArrayChar(St:string):TArrayChar;
var i:Integer;
begin
try
 if St<>'' then
  if ((Pos(',',St)=0)) and (Length(St)=1) then Include(Result,St[1])
    else
     begin
      while Pos(',',St)>0 do Delete(st,Pos(',',St),1);
      for i:=1 to Length(St) do Include(Result,St[i]);
     end;
 except
  end;
end;



procedure TFmChpuRenum.RzBitBtnInsProbelRunClick(Sender: TObject);
var SimPropBegin_Str:TArrayTxt;
    ProbProp1Sim,ProbProp2Sim:TArrayChar;
    N1,N2,i,LengthStr,CountLine,
    StartStr,Block1,Block2,N_Line,TekPos:integer;
    buf,WorkList:string;
    Probel:string[100];
    SimUnkn,SimLat,SimWord,Block,SimPropusk,Propusk:Boolean;

begin
  inherited;

 Block1:=0;Block2:=0;Block:=False;
 WorkList:='';Probel:='';
 N1:=SendMessage(Npp.NppData.ScintillaMainHandle, SCI_GETSELECTIONSTART,0,0);
 N2:=SendMessage(Npp.NppData.ScintillaMainHandle, SCI_GetSELECTIONEND,0,0);
 TekPos:=SendMessage(Npp.NppData.ScintillaMainHandle,SCI_GETFIRSTVISIBLELINE,0,0);
 CountLine:=SendMessage(Npp.NppData.ScintillaMainHandle, SCI_GETLINECOUNT,0,0);

 if N1<>N2 then
  begin
   Block1:=SendMessage(Npp.NppData.ScintillaMainHandle,SCI_LINEFROMPOSITION,N1,0);
   Block2:=SendMessage(Npp.NppData.ScintillaMainHandle,SCI_LINEFROMPOSITION,N2,0);
   Block:=True;
  end;

//Заполнение массивов ограничений
  if Block then StartStr:=Block1
   else  begin StartStr:=RzNEditStartStrProbel.IntValue-1;Block2:=CountLine end;

  if RzEditProbPropStr.Text<>'' then
     SimPropBegin_Str:=LoadArrayTxt(RzEditProbPropStr.Text);

  if RzEditProbProp1Sim.Text<>'' then ProbProp1Sim:=LoadArrayChar(RzEditProbProp1Sim.Text);
  if RzEditProbProp2Sim.Text<>'' then ProbProp2Sim:=LoadArrayChar(RzEditProbProp2Sim.Text);

//===============================

 if TRzBitBtn(Sender).Name='RzBitBtnDelProbelRun' then  probel:=''
  else
   if RzNEditProbel_N.Value>0 then for i:=1 to RzNEditProbel_N.IntValue do Probel:=Probel+' ';
   SimPropusk:=False;

 for N_Line:=0 to CountLine-1 do
  begin
   LengthStr:=SendMessage(Npp.NppData.ScintillaMainHandle, SCI_LINELENGTH, N_Line,0);
   SetLength(buf,LengthStr);
   SendMessage(Npp.NppData.ScintillaMainHandle, SCI_GETLINE, N_Line,LPARAM(PChar(buf)));

   SimUnkn:=False;SimLat:=False;SimWord:=False;Propusk:=False;


   if Length(buf)<>0 then
    begin
     if (buf[1]=#10) or (buf[1]=#13) then begin WorkList:=WorkList+buf;Continue end
    end
   else Continue;


   if Length(SimPropBegin_Str)>0 then
    for i:=0 to Length(SimPropBegin_Str)-1 do
      if Pos(SimPropBegin_Str[i],buf)=1 then propusk:=True;


   if (N_Line>=StartStr) and (not(propusk) and (Block2>=N_Line)) then
     begin

      for i:=1 to Length(buf) do
       begin

         if (buf[i] in ProbProp1Sim) or (buf[i] in ProbProp2Sim) or Simpropusk  then
          begin

           if Simpropusk then
            begin
             if  not(buf[i] in ProbProp2Sim) then
              begin
               WorkList:=WorkList+buf[i];
               Continue;
              end;
             if  (buf[i] in ProbProp2Sim) then
              begin WorkList:=WorkList+buf[i];Simpropusk:=false end;
             Continue;
            end;

           if (buf[i] in ProbProp1Sim) then
            begin
              WorkList:=WorkList+buf[i];
              Simpropusk:=True;
              Continue;
            end;
          end;

        if (buf[i]=' ') then
         begin
           SimWord:=False;SimLat:=False;
           SimUnkn:=False;
           Continue;
          end;

         if buf[i] in SimSet_Lat then
          begin
           if (not(SimWord)) then
            begin
             if (i>1) and  not(SimLat) then
              WorkList:=WorkList+probel+buf[i]
               else
               WorkList:=WorkList+buf[i];
               SimLat:=True;SimUnkn:=False;
             Continue;
            end;
           if(SimWord) then
            begin
             SimLat:=True;SimWord:=False;SimUnkn:=False;
             WorkList:=WorkList+probel+buf[i];
             Continue;
            end;
          end;

         if buf[i] in SimSet_Cifr then
          begin
           if SimLat then
            begin
             SimWord:=True;SimLat:=False;SimUnkn:=False;
             WorkList:=WorkList+buf[i];
             Continue;
            end;
           if SimWord then
            begin
             WorkList:=WorkList+buf[i];SimUnkn:=False;
             Continue;
            end;
           if (not(SimLat)) and (not(SimWord)) then
            begin
             SimUnkn:=False;
             WorkList:=WorkList+buf[i];
             Continue;
            end;
          end;

         if (buf[i]<>#10) and (buf[i]<>#13) then
           begin
            if not(SimUnkn) then WorkList:=WorkList+probel+buf[i] else
             WorkList:=WorkList+buf[i];
             SimWord:=False;SimLat:=False;
             SimUnkn:=True;
           end
         else  WorkList:=WorkList+buf[i];

        end;
     end
   else WorkList:=WorkList+buf;
 end;
  SendMessage(self.Npp.NppData.ScintillaMainHandle, SCI_SETTEXT, 0, LPARAM(PChar(WorkList)));
  WorkList:='';Probel:='';
  SetLength(SimPropBegin_Str,0);
  SendMessage(Npp.NppData.ScintillaMainHandle,SCI_LINESCROLL,0,TekPos)
end;

procedure TFmChpuRenum.RzSpnBtnNProbelDownLeftClick(Sender: TObject);
begin
  inherited;
  if RzNEditProbel_N.Value=0 then Exit;
  RzNEditProbel_N.Value:=RzNEditProbel_N.IntValue-1;
end;


procedure TFmChpuRenum.RzSpnBtnNProbelUpRightClick(Sender: TObject);
begin
  inherited;
  RzNEditProbel_N.Value:=RzNEditProbel_N.intValue+1;
end;

end.


