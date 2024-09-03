unit uModel.Charts.DataAxis;

interface

uses
  uModel.Charts.Interfaces;

type
  TModelChartDataAxis = class(TInterfacedObject, iModelChartDataAxis)
  strict private
    FTitle: string;
    FVisible: Boolean;
    FOpposite: Boolean;
    FSufixoLabel: string;
    FTickAmount: Integer;
    FMinValueAxis: Integer;
    FMaxValueAxis: Integer;
  public
    class function New: iModelChartDataAxis;

    function Title: string; overload;
    function Visible: Boolean; overload;
    function Opposite: Boolean; overload;
    function SufixoLabel: string; overload;
    function TickAmount: Integer; overload;
    function MinValueAxis: Integer; overload;
    function MaxValueAxis: Integer; overload;

    function Title(AValue: string): iModelChartDataAxis; overload;
    function Visible(AValue: Boolean): iModelChartDataAxis; overload;
    function Opposite(AValue: Boolean): iModelChartDataAxis; overload;
    function SufixoLabel(AValue: string): iModelChartDataAxis; overload;
    function TickAmount(AValue: Integer): iModelChartDataAxis; overload;
    function MinValueAxis(AValue: Integer): iModelChartDataAxis; overload;
    function MaxValueAxis(AValue: Integer): iModelChartDataAxis; overload;
  end;

implementation

{ TModelChartDataAxis }

function TModelChartDataAxis.MaxValueAxis: Integer;
begin
  result := FMaxValueAxis;
end;

function TModelChartDataAxis.MaxValueAxis(AValue: Integer): iModelChartDataAxis;
begin
  result := Self;

  FMaxValueAxis := AValue;
end;

function TModelChartDataAxis.MinValueAxis: Integer;
begin
  result := FMinValueAxis;
end;

function TModelChartDataAxis.MinValueAxis(AValue: Integer): iModelChartDataAxis;
begin
  result := Self;

  FMinValueAxis := AValue;
end;

class function TModelChartDataAxis.New: iModelChartDataAxis;
begin
  result := Self.Create;
end;

function TModelChartDataAxis.Opposite(AValue: Boolean): iModelChartDataAxis;
begin
  result := Self;

  FOpposite := AValue;
end;

function TModelChartDataAxis.Opposite: Boolean;
begin
  result := FOpposite;
end;

function TModelChartDataAxis.SufixoLabel(AValue: string): iModelChartDataAxis;
begin
  result := Self;

  FSufixoLabel := AValue;
end;

function TModelChartDataAxis.SufixoLabel: string;
begin
  result := FSufixoLabel;
end;

function TModelChartDataAxis.TickAmount(AValue: Integer): iModelChartDataAxis;
begin
  result := Self;

  FTickAmount := AValue;
end;

function TModelChartDataAxis.TickAmount: Integer;
begin
  result := FTickAmount;
end;

function TModelChartDataAxis.Title(AValue: string): iModelChartDataAxis;
begin
  result := Self;

  FTitle := AValue;
end;

function TModelChartDataAxis.Title: string;
begin
  result := FTitle;
end;

function TModelChartDataAxis.Visible(AValue: Boolean): iModelChartDataAxis;
begin
  result := Self;

  FVisible := AValue;
end;

function TModelChartDataAxis.Visible: Boolean;
begin
  result := FVisible;
end;

end.
