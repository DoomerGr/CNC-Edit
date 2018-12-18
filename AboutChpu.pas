unit AboutChpu;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, NppForms, StdCtrls, RzLabel, jpeg, ExtCtrls, RzButton, RzPanel,
  XPMan, Mask, RzEdit, RzCmboBx, RzBorder, RzStatus;

type
  TFmAboutChpu = class(TNppForm)
    RzPanel2: TRzPanel;
    Lbl1: TRzLabel;
    Lbl2: TRzLabel;
    Btn1: TButton;
    rzbrdr1: TRzBorder;
    RzVersInf1: TRzVersionInfo;
    rzvrsnfsts1: TRzVersionInfoStatus;
    Img1: TImage;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FmAboutChpu: TFmAboutChpu;

implementation

{$R *.dfm}

end.
