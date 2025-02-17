unit uModel.Charts.Options.Factory;

interface

uses
  uModel.Apex.Charts,
  uModel.Charts.Factory,
  uModel.Charts.Interfaces;

type
  TModelChartOptionsFactory = class(TInterfacedObject, IModelChartOptionsFactory)
  public
    class function New: IModelChartOptionsFactory;

    function ChartJS: IModelChartFactory;
    function ChartApex: IModelChartApexFactory;
  End;

implementation

{ TModelChartOptionsFactory }

function TModelChartOptionsFactory.ChartApex: IModelChartApexFactory;
begin
  result := TModelChartApexFactory.New;
end;

function TModelChartOptionsFactory.ChartJS: IModelChartFactory;
begin
  result := TModelChartFactory.New;
end;

class function TModelChartOptionsFactory.New: iModelChartOptionsFactory;
begin
  result := Self.Create;
end;

end.
