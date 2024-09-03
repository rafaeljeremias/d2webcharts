unit uModel.Charts.Data;

interface

uses
  uModel.Charts.Interfaces;

type
  TModelChartData = class(TInterfacedObject, iModelChartData)
  private
    FLabelName: string;
    FValue: Variant;
    FBorderColor: EnumColors;
    FChartType: EnumChartType;
    FBackgroundColor: EnumColors;
    FPointColor: EnumColors;
    FPointBorderColor: EnumColors;
    FPointBackgroundColor: EnumColors;
    FPointHoverBorderColor: EnumColors;
    FPointHoverBackgroundColor: EnumColors;
  public
    constructor Create(const ALabel: string; AValue: Variant; ABackgroundColor, ABorderColor, APointBackgroundColor, APointBorderColor, APointHoverBackgroundColor, APointHoverBorderColor: EnumColors;
      AChartType: EnumChartType = ctNone; APointColor: EnumColors = none);
    class function New(const ALabel: string; AValue: Variant; ABackgroundColor, ABorderColor, APointBackgroundColor, APointBorderColor, APointHoverBackgroundColor, APointHoverBorderColor: EnumColors;
      AChartType: EnumChartType = ctNone; APointColor: EnumColors = none): iModelChartData;
    destructor Destroy; override;
    function LabelName(AValue: string): iModelChartData; overload;
    function Value(AValue: Variant): iModelChartData; overload;
    function ChartType(AValue: EnumChartType): iModelChartData; overload;
    function BackgroundColor(AValue: EnumColors): iModelChartData; overload;
    function BorderColor(AValue: EnumColors): iModelChartData; overload;
    function PointColor(AValue: EnumColors): iModelChartData; overload;
    function PointBackgroundColor(AValue: EnumColors): iModelChartData; overload;
    function PointBorderColor(AValue: EnumColors): iModelChartData; overload;
    function PointHoverBackgroundColor(AValue: EnumColors): iModelChartData; overload;
    function PointHoverBorderColor(AValue: EnumColors): iModelChartData; overload;
    function LabelName: string; overload;
    function Value: Variant; overload;
    function ChartType: EnumChartType; overload;
    function PointColor: EnumColors; overload;
    function BackgroundColor: EnumColors; overload;
    function BorderColor: EnumColors; overload;
    function PointBackgroundColor: EnumColors; overload;
    function PointBorderColor: EnumColors; overload;
    function PointHoverBackgroundColor: EnumColors; overload;
    function PointHoverBorderColor: EnumColors; overload;
  end;

implementation

{ TChartData }

function TModelChartData.BorderColor: EnumColors;
begin
  result := FBorderColor;
end;

function TModelChartData.BorderColor(AValue: EnumColors): iModelChartData;
begin
  result := Self;
  FBorderColor := AValue;
end;

function TModelChartData.BackgroundColor(AValue: EnumColors): iModelChartData;
begin
  result := Self;
  FBackgroundColor := AValue;
end;

function TModelChartData.BackgroundColor: EnumColors;
begin
  Result := FBackgroundColor;
end;

function TModelChartData.ChartType(AValue: EnumChartType): iModelChartData;
begin
  result := Self;

  FChartType := AValue;
end;

function TModelChartData.ChartType: EnumChartType;
begin
  result := FChartType;
end;

constructor TModelChartData.Create(const ALabel: string; AValue: Variant;
  ABackgroundColor, ABorderColor, APointBackgroundColor, APointBorderColor,
  APointHoverBackgroundColor, APointHoverBorderColor: EnumColors;
  AChartType: EnumChartType; APointColor: EnumColors);
begin
  FLabelName                  := ALabel;
  FValue                      := AValue;
  FChartType                  := AChartType;
  FPointColor                 := APointColor;
  FBorderColor                := ABorderColor;
  FBackgroundColor            := ABackgroundColor;
  FPointBorderColor           := APointBorderColor;
  FPointBackgroundColor       := APointBackgroundColor;
  FPointHoverBorderColor      := APointHoverBorderColor;
  FPointHoverBackgroundColor  := APointHoverBackgroundColor;
end;

destructor TModelChartData.Destroy;
begin

  inherited;
end;

function TModelChartData.LabelName: string;
begin
  Result := FLabelName;
end;

function TModelChartData.LabelName(AValue: string): iModelChartData;
begin
  result := Self;
  FLabelName := AValue;
end;

class function TModelChartData.New(const ALabel: string; AValue: Variant;
  ABackgroundColor, ABorderColor, APointBackgroundColor, APointBorderColor,
  APointHoverBackgroundColor, APointHoverBorderColor: EnumColors;
  AChartType: EnumChartType; APointColor: EnumColors): iModelChartData;
begin
  result := self.Create(ALabel,
                        AValue,
                        ABackgroundColor,
                        ABorderColor,
                        APointBackgroundColor,
                        APointBorderColor,
                        APointHoverBackgroundColor,
                        APointHoverBorderColor,
                        AChartType,
                        APointColor);
end;

function TModelChartData.PointBackgroundColor(AValue: EnumColors): iModelChartData;
begin
  result := Self;
  FPointBackgroundColor := AValue;
end;

function TModelChartData.PointBackgroundColor: EnumColors;
begin
  Result := FPointBackgroundColor;
end;

function TModelChartData.PointBorderColor: EnumColors;
begin
  Result := FPointBorderColor;
end;

function TModelChartData.PointColor: EnumColors;
begin
  result := FPointColor;
end;

function TModelChartData.PointColor(AValue: EnumColors): iModelChartData;
begin
  result := Self;

  FPointColor := AValue;
end;

function TModelChartData.PointBorderColor(AValue: EnumColors): iModelChartData;
begin
  result := Self;
  FPointBorderColor := AValue;
end;

function TModelChartData.PointHoverBackgroundColor(AValue: EnumColors): iModelChartData;
begin
  result := Self;
  FPointHoverBackgroundColor := AValue;
end;

function TModelChartData.PointHoverBackgroundColor: EnumColors;
begin
  Result := FPointHoverBackgroundColor;
end;

function TModelChartData.PointHoverBorderColor(AValue: EnumColors): iModelChartData;
begin
  result := Self;
  FPointHoverBorderColor := AValue;
end;

function TModelChartData.PointHoverBorderColor: EnumColors;
begin
  Result := FPointHoverBorderColor;
end;

function TModelChartData.Value(AValue: Variant): iModelChartData;
begin
  result := Self;
  FValue := AVAlue;
end;

function TModelChartData.Value: Variant;
begin
  result := FValue;
end;

end.
