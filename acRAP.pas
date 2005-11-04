unit acRAP;

interface

uses
  Classes, Forms, raFunc, ppRTTI, db, dbTables, ppUtils, ppReport, ppBands,
  ppEngine, osUtils, osExtenso;

type
  //grupo para as funções personalizadas Acras
  TAcrasRAPFunctions = class (TraSystemFunction)
  public
    class function Category: String; override;
  end;

  TGetSummaryTop = class (TAcrasRAPFunctions)
  public
    procedure ExecuteFunction(aParams: TraParamList); override;
    class function GetSignature: String; override;
  end;

  TValorPorExtenso = class (TAcrasRAPFunctions)
  public
    procedure ExecuteFunction(aParams: TraParamList); override;
    class function GetSignature: String; override;
  end;

  TGetRestricaousuario = class (TAcrasRAPFunctions)
  public
    procedure ExecuteFunction(aParams: TraParamList); override;
    class function GetSignature: String; override;
  end;


  //RTTI da classe ppEngine
  TacTppEngineRTTI = class(TraTObjectRTTI)
  public
    class procedure GetPropList(aClass: TClass; aPropList: TraPropList); override;
    class function  RefClass: TClass; override;
    class function  GetPropRec(aClass: TClass; const aPropName: String; var aPropRec: TraPropRec): Boolean; override;
    class function  CallMethod(aObject: TObject; const aMethodName: String; aParams: TraParamList; aGet: Boolean): Boolean; override;

    class function  GetParams(const aMethodName: String): TraParamList; override;
    class function  GetPropValue(aObject: TObject; const aPropName: String; var aValue): Boolean; override;
    class function  SetPropValue(aObject: TObject; const aPropName: String; var aValue): Boolean; override;
  end;

  TacraTppReportRTTI = class(TraTppReportRTTI)
  public
    class procedure GetPropList(aClass: TClass; aPropList: TraPropList); override;
    class function  GetPropRec(aClass: TClass; const aPropName: String; var aPropRec: TraPropRec): Boolean; override;
    class function  GetParams(const aMethodName: String): TraParamList; override;
    class function  CallMethod(aObject: TObject; const aMethodName: String; aParams: TraParamList; aGet: Boolean): Boolean; override;
    class function  GetPropValue(aObject: TObject; const aPropName: String; var aValue): Boolean; override;
    class function  RefClass: TClass; override;
    class function  SetPropValue(aObject: TObject; const aPropName: String; var aValue): Boolean; override;
  end; {class, TraTppReportRTTI}


implementation

uses ppClass;

{ TmyTDataBaseRTTI }

{ TmyDevelopersFunction }

class function TAcrasRAPFunctions.Category: String;
begin
  Result := 'Acras RAP Functions';
end;

{ TGetSummaryTop }

procedure TGetSummaryTop.ExecuteFunction(aParams: TraParamList);
var
  asSummary: TppSummaryBand;
  lResult: integer;
begin
  GetParamValue(0, asSummary);
  lResult := asSummary.PrintPosRect.Top;
  SetParamValue(1, lResult);
end;

class function TGetSummaryTop.GetSignature: String;
begin
  Result := 'function GetSummaryTop(aSummary: TppSummaryBand): integer;';
end;

{ TGetRestricaousuario }

procedure TGetRestricaousuario.ExecuteFunction(aParams: TraParamList);
var
  id: integer;
  lResult: String;
begin
  GetParamValue(0, id);
  if getRestricaoUsuario(id)<> nil then
    lResult := getRestricaoUsuario(id).Texto
  else
    lResult := '';
  SetParamValue(1, lResult);
end;

class function TGetRestricaousuario.GetSignature: String;
begin
  Result := 'function GetRestricaoUsuario(aIdRestricao: integer): String;';
end;

{ TacraTppReportRTTI }

class function TacraTppReportRTTI.CallMethod(aObject: TObject;
  const aMethodName: String; aParams: TraParamList;
  aGet: Boolean): Boolean;
begin
  result := inherited CallMethod(aObject, aMethodName, aParams, aGet);
end;

class function TacraTppReportRTTI.GetParams(
  const aMethodName: String): TraParamList;
begin
  result := inherited GetParams(aMethodName);
end;

class procedure TacraTppReportRTTI.GetPropList(aClass: TClass;
  aPropList: TraPropList);
begin
  inherited GetPropList(aClass, aPropList);

  {add public props}
  aPropList.AddProp('Engine');
end;


class function TacraTppReportRTTI.GetPropRec(aClass: TClass;
  const aPropName: String; var aPropRec: TraPropRec): Boolean;
begin
  result := inherited getPropRec(aClass, aPropName, aPropRec);
end;

class function TacraTppReportRTTI.GetPropValue(aObject: TObject;
  const aPropName: String; var aValue): Boolean;
begin
  result := inherited getPropValue(aObject, aPropName, aValue);
end;

class function TacraTppReportRTTI.RefClass: TClass;
begin
  result := TppReport;
end;

class function TacraTppReportRTTI.SetPropValue(aObject: TObject;
  const aPropName: String; var aValue): Boolean;
begin
  result := inherited SetPropValue(aObject, aPropName, aValue);
end;

{ TacTppEngineRTTI }

class function TacTppEngineRTTI.CallMethod(aObject: TObject;
  const aMethodName: String; aParams: TraParamList;
  aGet: Boolean): Boolean;
begin
  Result := inherited CallMethod(aObject, aMethodName, aParams, aGet);
end;

class function TacTppEngineRTTI.GetParams(
  const aMethodName: String): TraParamList;
begin
  result := inherited GetParams(aMethodName);
end;

class procedure TacTppEngineRTTI.GetPropList(aClass: TClass;
  aPropList: TraPropList);
begin
  inherited GetPropList(aClass, aPropList);
  aPropList.AddProp('PageBottom');
end;

class function TacTppEngineRTTI.GetPropRec(aClass: TClass;
  const aPropName: String; var aPropRec: TraPropRec): Boolean;
begin
  Result := True;
  if ppEqual(aPropName, 'PageBottom') then
    PropToRec(aPropName, daInteger, True, aPropRec)
  else
    Result := inherited GetPropRec(aClass, aPropName, aPropRec);
end;

class function TacTppEngineRTTI.GetPropValue(aObject: TObject;
  const aPropName: String; var aValue): Boolean;
begin
  Result := True;
  if ppEqual(aPropName, 'PageBottom') then
    integer(aValue) := TppEngine(aObject).PageBottom
  else
    Result := inherited GetPropValue(aObject, aPropName, aValue);
end;

class function TacTppEngineRTTI.RefClass: TClass;
begin
  result := TppEngine;
end;

class function TacTppEngineRTTI.SetPropValue(aObject: TObject;
  const aPropName: String; var aValue): Boolean;
begin
  Result := inherited SetPropValue(aObject, aPropName, aValue);
end;


{ TValorPorExtenso }

procedure TValorPorExtenso.ExecuteFunction(aParams: TraParamList);
var
  valor: double;
  lResult: string;
begin
  GetParamValue(0, valor);
  lResult := ValorPorExtenso(valor);
  SetParamValue(1, lResult);
end;

class function TValorPorExtenso.GetSignature: String;
begin
  Result := 'function ValorPorExtenso(aVlor: double): String;';
end;

initialization
    raRegisterFunction('GetSummaryTop', TGetSummaryTop);
    raRegisterFunction('GetRestricaousuario', TGetRestricaousuario);
    raRegisterFunction('ValorPorExtenso', TValorPorExtenso);

    raUnRegisterRTTI(TraTppReportRTTI);  // unregister the existing RTTI class
    raRegisterRTTI(TacraTppReportRTTI);    // register your custom RTTI class

    raRegisterRTTI(TacTppEngineRTTI);
finalization
    raUnRegisterRTTI(TacraTppReportRTTI);  // unregister the existing RTTI class

    raUnRegisterRTTI(TacTppEngineRTTI);
end.



