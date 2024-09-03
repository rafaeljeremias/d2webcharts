unit uModel.Charts.Options.Factory;

interface

uses
  uModel.Apex.Charts,
  uModel.Charts.Factory,
  uModel.Charts.Interfaces;

type
  TModelChartOptionsFactory = class(TInterfacedObject, iModelChartOptionsFactory)
  public
    class function New: IModelChartOptionsFactory;

    function ChartJS: iModelChartFactory;
    function ChartApex: iModelChartApexFactory;
  End;

implementation

{ TModelChartOptionsFactory }

function TModelChartOptionsFactory.ChartApex: iModelChartApexFactory;
begin
  result := TModelChartApexFactory.New;
end;

function TModelChartOptionsFactory.ChartJS: iModelChartFactory;
begin
  result := TModelChartFactory.New;
end;

class function TModelChartOptionsFactory.New: iModelChartOptionsFactory;
begin
  result := Self.Create;
end;

end.
