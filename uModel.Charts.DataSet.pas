unit uModel.Charts.DataSet;

interface

uses
  System.Generics.Collections,
  System.Variants,
  uModel.Charts.Interfaces,
  System.StrUtils,
  System.Classes;

type
  TModelChartDataSet = class(TInterfacedObject, iModelChartDataSet)
  private
    [weak]
    FParent: iModelChart;
    FyAxis: iModelChartDataAxis;
    FChartFramework: EnumChartFramework;
    FChartDataList: TInterfaceList;
    FOpacity: Double;
    FLabel: string;
    FWidthBar: Integer;
    function GenerateBorderColors: string;
    function GenerateValue: string;
    function GenerateFrameworkChartJS: string;
    function GenerateFrameworkChartApex: string;
  public
    constructor Create(AParent: iModelChart; ALabel: string; AChartFramework: EnumChartFramework; AyAxis:
      iModelChartDataAxis = nil; AWidthBar: Integer = 70);
    class function New(AParent: iModelChart; ALabel: string; AChartFramework: EnumChartFramework = cfChartJS;
      AyAxis: iModelChartDataAxis = nil; AWidthBar: Integer = 70): iModelChartDataSet;
    destructor Destroy; override;

    function WidthBar: string;
    function GenerateAxisY: string;
    function GenerateLabels: string;
    function GenerateToolTipY: string;
    function GeneratePointColor: string;
    function GenerateBackgroundColors: string;
    function GeneratePointBackgroundColor: string;
    function AddChartData(ALabel: string; AValue: Variant; APointBackgroundColor: EnumColors = none): iModelChartDataSet; overload;
    function AddChartData(ALabel: string; AValue: Variant; AChartType: EnumChartType; APointBackgroundColor: EnumColors = none; APointColor: EnumColors = none): iModelChartDataSet; overload;
    function AddChartData(ALabel: string; AValue: Variant; ABackgroundColor, ABorderColor: EnumColors; APointBackgroundColor: EnumColors = None; APointBorderColor: EnumColors = None; APointHoverBackgroundColor: EnumColors = None; APointHoverBorderColor: EnumColors = None): iModelChartDataSet; overload;
    function LabelName: string; overload;
    function LabelName(AValue: string): iModelChartDataSet; overload;
    function Opacity(AValue: Double): iModelChartDataSet; overload;
    function Generate: string;
    function Opacity: Double; overload;
    function RecordCount: integer;
    function &End: iModelChart;
  end;

implementation

uses
  System.SysUtils,
  uModel.Charts.Data,
  uModel.Charts.Utils;

{ TModelChartDataSet }

function TModelChartDataSet.AddChartData(ALabel: string;
  AValue: Variant; APointBackgroundColor: EnumColors): iModelChartDataSet;
begin
  Result := Self;
  var ChartData := TModelChartData.New(ALabel,
                     AValue,
                     none,
                     none,
                     APointBackgroundColor,
                     none,
                     none,
                     none);

  FChartDataList.Add(ChartData);
end;

function TModelChartDataSet.AddChartData(ALabel: string; AValue: Variant;
  AChartType: EnumChartType;
  APointBackgroundColor, APointColor: EnumColors): iModelChartDataSet;
begin
  Result := Self;
  var ChartData := TModelChartData.New(ALabel,
                     AValue,
                     none,
                     none,
                     APointBackgroundColor,
                     none,
                     none,
                     none,
                     AChartType,
                     APointColor);

  FChartDataList.Add(ChartData);
end;

constructor TModelChartDataSet.Create(AParent: iModelChart; ALabel: string;
  AChartFramework: EnumChartFramework; AyAxis: iModelChartDataAxis;
  AWidthBar: Integer);
begin
  FParent := AParent;
  FChartDataList := TInterfaceList.Create;
  FLabel := ALabel;
  FOpacity := 1;
  FWidthBar := AWidthBar;
  FChartFramework := AChartFramework;
  FyAxis := AyAxis;
End;

destructor TModelChartDataSet.Destroy;
begin
  FChartDataList.Free;
  inherited Destroy;
end;

function TModelChartDataSet.&End: iModelChart;
begin
  result := FParent;
end;

function TModelChartDataSet.AddChartData(ALabel: string; AValue: Variant;
  ABackgroundColor, ABorderColor: EnumColors; APointBackgroundColor: EnumColors = None;
  APointBorderColor: EnumColors = None; APointHoverBackgroundColor: EnumColors = None;
  APointHoverBorderColor: EnumColors = None): iModelChartDataSet;
begin
  Result := Self;
  var ChartData := TModelChartData.New(ALabel, AValue, ABackgroundColor, ABorderColor, APointBackgroundColor, APointBorderColor, APointHoverBackgroundColor, APointHoverBorderColor);
  FChartDataList.Add(ChartData);
end;

function TModelChartDataSet.GenerateValue: string;
begin
  var DataStr := EmptyStr;
  for var I := 0 to FChartDataList.Count - 1 do
  begin
    var ChartData := FChartDataList[I] as iModelChartData;
    DataStr := DataStr + VarToStr(ChartData.Value);
    if I < FChartDataList.Count - 1 then
      DataStr := DataStr + ', ';
  end;
  Result := DataStr;
end;

function TModelChartDataSet.GenerateLabels: string;
begin
  var DataStr := EmptyStr;
  for var I := 0 to FChartDataList.Count - 1 do
  begin
    var ChartData := FChartDataList[I] as iModelChartData;
    DataStr := DataStr + '"' + VarToStr(ChartData.LabelName) + '"';
    if I < FChartDataList.Count - 1 then
      DataStr := DataStr + ', ';
  end;
  Result := DataStr;
end;

function TModelChartDataSet.LabelName(AValue: string): iModelChartDataSet;
begin
  result := Self;
  FLabel := AValue;
end;

function TModelChartDataSet.LabelName: string;
begin
  Result := FLabel;
end;

class function TModelChartDataSet.New(AParent: iModelChart;
  ALabel: string; AChartFramework: EnumChartFramework;
  AyAxis: iModelChartDataAxis; AWidthBar: Integer): iModelChartDataSet;
begin
  Result := self.Create(AParent, Alabel, AChartFramework, AyAxis, AWidthBar);
end;

function TModelChartDataSet.Opacity: Double;
begin
  result := FOpacity;
end;

function TModelChartDataSet.Opacity(AValue: Double): iModelChartDataSet;
begin
  result := self;
  FOpacity := AValue;
end;

function TModelChartDataSet.RecordCount: integer;
begin
  Result := FChartDataList.Count;
end;

function TModelChartDataSet.WidthBar: string;
begin
  result := IntToStr(FWidthBar);
end;

function TModelChartDataSet.GenerateBackgroundColors: string;
begin
  var ColorsStr := EmptyStr;
  for var I := 0 to FChartDataList.Count - 1 do
  begin
    var ChartData := FChartDataList[I] as iModelChartData;
    ColorsStr := ColorsStr + '"' + ColorEnumToString(ChartData.BackgroundColor, FOpacity) + '"';
    if I < FChartDataList.Count - 1 then
      ColorsStr := ColorsStr + ', ';
  end;
  Result := ColorsStr;
end;

function TModelChartDataSet.GeneratePointBackgroundColor: string;
begin
  var BackgroundColorStr := EmptyStr;
  if FChartDataList.Count > 0 then
  begin
    var ChartData := FChartDataList[0] as iModelChartData;
    BackgroundColorStr := '"' + ColorEnumToString(ChartData.PointBackgroundColor, FOpacity) + '"';
  end;
  Result := BackgroundColorStr;
end;

function TModelChartDataSet.GeneratePointColor: string;
begin
  var PointColorStr := EmptyStr;

  if FChartDataList.Count > 0 then
  begin
    var ChartData := FChartDataList[0] as iModelChartData;
    PointColorStr := '"' + ColorEnumToStringHtml(ChartData.PointColor) + '"';
  end;
  Result := PointColorStr;
end;

function TModelChartDataSet.GenerateToolTipY: string;
begin
  var DataStr := EmptyStr;

  if FyAxis <> nil then
  begin
    DataStr := Format('{ '+
                      '  formatter: function (y) { '+
                      '    if (typeof y !== "undefined") { '+
                      '      return y.toFixed(2) + "%s"; '+
                      '    } '+
                      '    return y; '+
                      '  } '+
                      '} ',
                      [FyAxis.SufixoLabel]);
  end;

  result := DataStr;
end;

function TModelChartDataSet.GenerateBorderColors: string;
begin
  var ColorsStr := EmptyStr;
  for var I := 0 to FChartDataList.Count - 1 do
  begin
    var ChartData := FChartDataList[I] as iModelChartData;
    ColorsStr := ColorsStr + '"' + ColorEnumToString(ChartData.BorderColor, FOpacity) + '"';
    if I < FChartDataList.Count - 1 then
      ColorsStr := ColorsStr + ', ';
  end;
  Result := ColorsStr;
end;

function TModelChartDataSet.GenerateFrameworkChartApex: string;
var
  LChartType: EnumChartType;
begin
  var ChartData := FChartDataList[0] as iModelChartData;

  if (ChartData.ChartType = ctPizza) or (ChartData.ChartType = ctDonut) or
    (ChartData.ChartType = ctRadialBar) then
  begin
    result := GenerateValue;
  end
  else
  begin
    result := Format('{ data: ['+ GenerateValue +'], name: "%s"%s }',
                     [FLabel,
                      ifThen(ChartData.ChartType = ctNone, '', ', type: "'+ ChartTypeToString(ChartData.ChartType) +'"')]);
  end;
end;

function TModelChartDataSet.GenerateFrameworkChartJS: string;
var
  LPointBackgroundColorStr, LPointBorderColorStr, LPointHoverBackgroundColorStr, LPointHoverBorderColorStr: string;
begin
  var LPointBackgroundColor := (FChartDataList[0] as iModelChartData).PointBackgroundColor;
  if LPointBackgroundColor <> Default(EnumColors) then
      LPointBackgroundColorStr := Format('pointBackgroundColor: "%s",', [ColorEnumToString(LPointBackgroundColor, FOpacity)])
  else LPointBackgroundColorStr := '';

  var LPointBorderColor := (FChartDataList[0] as iModelChartData).PointBackgroundColor;
  if LPointBorderColor <> Default(EnumColors) then
      LPointBorderColorStr := Format('pointBorderColor: "%s",', [ColorEnumToString(LPointBorderColor, FOpacity)])
  else LPointBorderColorStr := '';

  var LPointHoverBackgroundColor := (FChartDataList[0] as iModelChartData).PointBackgroundColor;
  if LPointHoverBackgroundColor <> Default(EnumColors) then
      LPointHoverBackgroundColorStr := Format('pointHoverBackgroundColor: "%s",', [ColorEnumToString(LPointHoverBackgroundColor, FOpacity)])
  else LPointHoverBackgroundColorStr := '';

  var LPointHoverBorderColor := (FChartDataList[0] as iModelChartData).PointBackgroundColor;
  if LPointHoverBorderColor <> Default(EnumColors) then
      LPointHoverBorderColorStr := Format('pointHoverBorderColor: "%s",', [ColorEnumToString(LPointHoverBorderColor, FOpacity)])
  else LPointHoverBorderColorStr := '';

  Result := Format(
    '{' +
    '   label: "%s",' +
    '   fill: true,' +
    '   backgroundColor: [%s],' +
    '   borderColor: [%s],' +
    '   %s' +
    '   %s' +
    '   %s' +
    '   %s' +
    '   data: [%s]' +
    '}', [self.LabelName, self.GenerateBackgroundColors, self.GenerateBorderColors,
          LPointBackgroundColorStr, LPointBorderColorStr, LPointHoverBackgroundColorStr,
          LPointHoverBorderColorStr, Self.GenerateValue]);
end;

function TModelChartDataSet.Generate: string;
begin
  if FChartFramework = cfChartJS then
    result := GenerateFrameworkChartJS
  else
    result := GenerateFrameworkChartApex;
end;

function TModelChartDataSet.GenerateAxisY: string;
begin
  var DataStr := EmptyStr;

  if FyAxis <> nil then
  begin
    DataStr := Format('{ '+
                      '  show: %s, '+
                      '  opposite: %s, '+
                      '  title: { '+
                      '    text: "%s" '+
                      '  }, '+
                      '  labels: { '+
                      '    show: %s, '+
                      '    formatter: function (value) { '+
                      '      return value + "%s"; '+
                      '    } '+
                      '  }, '+
                      '  min: %d, '+
                      '  max: %d, '+
                      '  tickAmount: %d '+
                      '}',
                      [ifThen(FyAxis.Visible, 'true', 'false'),
                       ifThen(FyAxis.Opposite, 'true', 'false'),
                       FyAxis.Title,
                       ifThen(FyAxis.Visible, 'true', 'false'),
                       FyAxis.SufixoLabel,
                       FyAxis.MinValueAxis,
                       FyAxis.MaxValueAxis,
                       FyAxis.TickAmount]);
  end;

  Result := DataStr;
end;

end.

