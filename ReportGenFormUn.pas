{******************************************************************************}
{                                                                              }
{                   ReportBuilder Report Component Library                     }
{                                                                              }
{             Copyright (c) 1996-1998 Digital Metaphors Corporation            }
{                                                                              }
{******************************************************************************}

unit ReportGenFormUn;

interface

{ By removing the 'x' which begins each of these compiler directives,
  you can enable different functionality within the end-user reporting
  solution.

  DADE - the data tab where queries can be created by the end-user

  BDE  - BDE support for the Query Tools

  ADO  - ADO support for the Query Tools

  IBExpress - Interbase Express support for the Query Tools

  RAP -  the calc tab, where calculations can be coded at run-time
         (RAP is included with ReportBuilder Enterprise)

  CrossTab - adds the CrossTab component to the component palette in the
             report designer.

  CheckBox - adds a checkbox component to the component palette in the
         report designer.

  TeeChart - adds a teechart component to the report designer component
         palette. You must have TeeChart installed. More information
         is available in ..\RBuilder\TeeChart\ReadMe.doc

  UseDesignPath - determines whether the path used by the Database
         object on this form is replaced in the OnCreate event handler of
         this form with the current path.}

{$DEFINE DADE}            {remove the 'x' to enable DADE}
{$DEFINE BDE}             {remove the 'x' to enable Borland Database Engine (BDE) }
{$DEFINE ADO}            {remove the 'x' to enable ADO}
{x$DEFINE IBExpress}      {remove the 'x' to enable Interbase Express}
{$DEFINE CrossTab}        {remove the 'x' to enable CrossTab}
{$DEFINE RAP}            {remove the 'x' to enable RAP}
{$DEFINE CheckBox}       {remove the 'x' to enable CheckBox}
{$DEFINE TeeChart}       {remove the 'x' to enable standard TeeChart}
{$DEFINE UseDesignPath}  {remove the 'x' to use the design-time settings of Database object on this form}

uses

{$IFDEF DADE}
  daIDE,
{$ENDIF}

{$IFDEF BDE}
  daDBBDE,
{$ENDIF}

{$IFDEF ADO}
  daADO,
{$ENDIF}

{$IFDEF IBExpress}
  daIBExpress,
{$ENDIF}

{$IFDEF CrossTab}
  ppCTDsgn,
{$ENDIF}

{$IFDEF RAP}
  raIDE,
{$ENDIF}

{$IFDEF CheckBox}
  myChkBox,
{$ENDIF}

{$IFDEF TeeChart}
  ppChrtUI,
{$ENDIF}

  Windows, Classes, Controls, SysUtils, Forms, StdCtrls, ExtCtrls, Dialogs, Graphics,
  DB, DBTables,  ppComm, ppCache, ppClass, ppProd, ppReport, ppRptExp, ppBands,
  ppDBBDE, ppEndUsr, ppDBPipe, ppDB, ppPrnabl, ppStrtch, ppDsgnDB,
  ppRelatv, ppModule, ppViewr, ppForms, ppFormWrapper, DBXpress, SqlExpr,
  DBClient, SimpleDS, daDataModule, daDBExpress;

type

  TReportGenForm = class(TForm)
    btnLaunch: TButton;
    Memo: TMemo;
    pnlStatusBar: TPanel;
    Shape20: TShape;
    Shape7: TShape;
    Shape26: TShape;
    Shape25: TShape;
    Shape24: TShape;
    Shape1: TShape;
    Shape4: TShape;
    Shape11: TShape;
    Label6: TLabel;
    Shape12: TShape;
    Shape9: TShape;
    Label5: TLabel;
    Shape10: TShape;
    Shape6: TShape;
    Label7: TLabel;
    Shape5: TShape;
    Label8: TLabel;
    Shape3: TShape;
    Label1: TLabel;
    Shape2: TShape;
    Shape15: TShape;
    Label2: TLabel;
    Shape16: TShape;
    Shape22: TShape;
    Label10: TLabel;
    Shape23: TShape;
    Shape18: TShape;
    Shape13: TShape;
    Label3: TLabel;
    Shape14: TShape;
    Label9: TLabel;
    Shape19: TShape;
    Shape21: TShape;
    Shape27: TShape;
    Label4: TLabel;
    dsTable: TDataSource;
    dsField: TDataSource;
    DataDictionary: TppDataDictionary;
    Designer: TppDesigner;
    dsItem: TDataSource;
    Report: TppReport;
    ppHeaderBand1: TppHeaderBand;
    ppDetailBand1: TppDetailBand;
    ppFooterBand1: TppFooterBand;
    dsFolder: TDataSource;
    ReportExplorer: TppReportExplorer;
    plFolder: TppDBPipeline;
    plItem: TppDBPipeline;
    plTable: TppDBPipeline;
    plField: TppDBPipeline;
    dsJoin: TDataSource;
    plJoin: TppDBPipeline;
    SQLConnection: TSQLConnection;
    sdsFolder: TSimpleDataSet;
    sdsItem: TSimpleDataSet;
    sdsTable: TSimpleDataSet;
    sdsField: TSimpleDataSet;
    sdsJoin: TSimpleDataSet;
    Shape30: TShape;
    Shape31: TShape;
    Shape35: TShape;
    Shape36: TShape;
    Shape8: TShape;
    Shape17: TShape;
    Shape28: TShape;
    Shape29: TShape;
    Shape32: TShape;
    Shape33: TShape;
    procedure FormCreate(Sender: TObject);
    procedure btnLaunchClick(Sender: TObject);
    procedure ReportPreviewFormCreate(Sender: TObject);
    procedure DesignerCreateReport(Sender: TObject;
      const aDataName: String; var aReport: TObject);
    procedure FormShow(Sender: TObject);
  private
    procedure LoadEndEvent(Sender: TObject);
  public
  end;

var
  ReportGenForm: TReportGenForm;

implementation

{$R *.DFM}

uses
  ppTypes;

{------------------------------------------------------------------------------}
{ TmyEndUserSolution.FormCreate }

procedure TReportGenForm.FormCreate(Sender: TObject);
var
  sName : string;
  i : integer;
begin
  SQLConnection.Close;
  with TStringList.Create do
  begin
    try
      LoadFromFile('AppParams.ini');
      for i := 0 to Count - 1 do
      begin
        sName := Names[i];
        SQLConnection.Params.Values[sName] := Values[sName];
      end;
    finally
      Free;
    end;
  end;
  SQLConnection.Open;
  sdsFolder.Open;
  sdsItem.Open;

  Designer.DataSettings.SessionType := 'dbExpressSession';
  Designer.DataSettings.DatabaseName := SQLConnection.Name;

  ClientHeight := btnLaunch.Top + btnLaunch.Height + pnlStatusBar.Height + 8;

  Report.Template.OnLoadEnd := LoadEndEvent;

end;


procedure TReportGenForm.LoadEndEvent(Sender: TObject);
begin
  Report.OnPreviewFormCreate := ReportPreviewFormCreate;
end;

procedure TReportGenForm.ReportPreviewFormCreate(Sender: TObject);
begin
  Report.PreviewForm.WindowState := wsMaximized;
  TppViewer(Report.PreviewForm.Viewer).ZoomSetting := zs100Percent;
end;

procedure TReportGenForm.btnLaunchClick(Sender: TObject);
begin
  if not(ReportExplorer.Execute) then
  begin
    pnlStatusBar.Caption := 'Erro: ' + ReportExplorer.ErrorMessage;
    MessageBeep(0);
  end;
end;

procedure TReportGenForm.DesignerCreateReport(Sender: TObject;
  const aDataName: String; var aReport: TObject);
begin
  MessageDlg('create report', mtWarning, [mbOK], 0);
end;

procedure TReportGenForm.FormShow(Sender: TObject);
begin
  btnLaunch.Click;
end;

end.
