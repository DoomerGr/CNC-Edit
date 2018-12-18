library NppAddChpu;

{$R 'ChpuNppres.res' 'ChpuNppres.rc'}

uses
  SysUtils,
  Classes,
  Types,
  Windows,
  Messages,
  nppplugin in 'lib\nppplugin.pas',
  scisupport in 'lib\SciSupport.pas',
  NppForms in 'lib\NppForms.pas' {NppForm},
  ChpuPlugin in 'ChpuPlugin.pas',
  AboutChpu in 'AboutChpu.pas' {FmAboutChpu},
  ChpuRenumForms in 'ChpuRenumForms.pas' {FmChpuRenum},
  UprPreviewPageSettings in 'UprPreviewPageSettings.pas' {PrnUprPageSettings},
  NppChpuPrint in 'NppChpuPrint.pas' {FmNppCHPUPrint};

{$R *.res}

{$Include 'lib\NppPluginInclude.pas'}

begin
  { First, assign the procedure to the DLLProc variable }
  DllProc := @DLLEntryPoint;
  { Now invoke the procedure to reflect that the DLL is attaching to the process }
  DLLEntryPoint(DLL_PROCESS_ATTACH);
end.
