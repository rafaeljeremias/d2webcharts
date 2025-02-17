unit uModel.Apex.Charts;

interface

uses
  uModel.Apex.Charts.Bar,
  uModel.Apex.Charts.Donut,
  uModel.Apex.Charts.Pizza,
  uModel.Apex.Charts.Mixed,
  uModel.Charts.Interfaces,
  uModel.Apex.Charts.RadialBar;

type
  TModelChartApexFactory = class(TInterfacedObject, IModelChartApexFactory)
  public
    class function New: IModelChartApexFactory;

    function Bar: IModelChartApexBar;
    function Donut: IModelChart;
    function Mixed(AChartID: string): IModelChart;
    function Pie: IModelChart;
    function RadialBar: IModelChart;
  End;

implementation

{ TModelChartApexFactory }

function TModelChartApexFactory.Bar: IModelChartApexBar;
begin
  result := TModelChartApexBar.New;
end;

function TModelChartApexFactory.Donut: iModelChart;
begin
  result := TModelChartApexDonut.New;
end;

function TModelChartApexFactory.Mixed(AChartID: string): iModelChart;
begin
  result := TModelChartApexMixed.New(AChartID);
end;

class function TModelChartApexFactory.New: IModelChartApexFactory;
begin
  result := Self.Create;
end;

function TModelChartApexFactory.Pie: IModelChart;
begin
  result := TModelChartApexPizza.New;
end;

function TModelChartApexFactory.RadialBar: iModelChart;
begin
  result := TModelChartApexRadialBar.New;
end;

end.
