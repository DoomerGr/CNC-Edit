unit ChpuPlugin;

interface

uses
  NppPlugin,SysUtils, Windows, SciSupport, AboutChpu,ChpuRenumForms;

type
  TNppChpuPlugin = class(TNppPlugin)
  public
    constructor Create;
    procedure FuncChpuNpp;
    procedure FuncRenumNpp;
    procedure FuncRacPrintNpp;
    procedure FuncAbout;
    procedure DoNppnToolbarModification; override;
  end;

procedure _FuncChpuNpp; cdecl;
procedure _FuncRenumNpp; cdecl;
procedure _FuncAbout; cdecl;
procedure _FuncRacPrintNpp; cdecl;

var
  Npp: TNppChpuPlugin;


implementation

uses NppChpuPrint;


{ TNppChpuPlugin }

constructor TNppChpuPlugin.Create;
var
  sk: TShortcutKey;
begin
  inherited;
  self.PluginName := 'CNC Edit';
  sk.IsCtrl := true; sk.IsAlt := true; sk.IsShift := false;
  sk.Key := #118; // CTRL ALT SHIFT F7
  self.AddFuncItem('CNC Edit', _FuncRenumNpp,sk);
  self.AddFuncItem('Rational printing', _FuncRacPrintNpp);
  self.AddFuncItem('About', _FuncAbout);
end;

procedure _FuncChpuNpp; cdecl;
begin
  Npp.FuncChpuNpp;
end;


procedure _FuncRacPrintNpp; cdecl;
begin
  Npp.FuncRacPrintNpp;
end;


procedure _FuncAbout; cdecl;
begin
  Npp.FuncAbout;
end;

procedure _FuncRenumNpp; cdecl;
begin
  Npp.FuncRenumNpp;
end;

procedure TNppChpuPlugin.FuncChpuNpp;
var
  s: string;
begin
  s := 'Chpu';
  SendMessage(self.NppData.ScintillaMainHandle, SCI_REPLACESEL, 0, LPARAM(PChar(s)));
end;

procedure TNppChpuPlugin.FuncAbout;
var
  a: TFmAboutChpu;
begin
  a := TFmAboutChpu.Create(self);
  a.ShowModal;
  a.Free;
end;

procedure TNppChpuPlugin.FuncRacPrintNpp;
begin
  FmNppCHPUPrint:= TFmNppCHPUPrint.Create(self);
  FmNppCHPUPrint.ShowModal;
  FmNppCHPUPrint.Free;
end;


procedure TNppChpuPlugin.FuncRenumNpp;
begin
  if (not Assigned(FmChpuRenum)) then FmChpuRenum := TFmChpuRenum.Create(self);
  FmChpuRenum.Show;
end;

procedure TNppChpuPlugin.DoNppnToolbarModification;
var
  tb: TToolbarIcons;
begin
  tb.ToolbarIcon := 0;
  tb.ToolbarBmp := LoadImage(Hinstance, 'IDB_TB_TEST', IMAGE_BITMAP, 0, 0, (LR_DEFAULTSIZE or LR_LOADMAP3DCOLORS));
  SendMessage(self.NppData.NppHandle, NPPM_ADDTOOLBARICON, WPARAM(self.CmdIdFromDlgId(0)), LPARAM(@tb));
end;

initialization
  Npp := TNppChpuPlugin.Create;
end.
