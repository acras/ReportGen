program ReportGen;

uses
  Forms,
  ReportGenFormUn in 'ReportGenFormUn.pas' {ReportGenForm},
  acRAP in 'acRAP.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TReportGenForm, ReportGenForm);
  Application.Run;
end.
