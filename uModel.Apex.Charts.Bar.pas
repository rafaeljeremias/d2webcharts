unit uModel.Apex.Charts.Bar;

interface

uses
  uModel.Charts.Interfaces,
  uModel.Apex.Charts.Bar.Vertical,
  uModel.Apex.Charts.Bar.Horizontal;

type
  TModelChartApexBar = class(TInterfacedObject, IModelChartApexBar)
  strict private
  public
    class function New: IModelChartApexBar;

    function Horizontal: iModelChart;
    function Vertical: iModelChart;
  End;

implementation

{ TModelChartApexBar }

function TModelChartApexBar.Horizontal: iModelChart;
begin
  result := TModelChartApexBarHorizontal.New;
end;

class function TModelChartApexBar.New: IModelChartApexBar;
begin
  result := Self.Create;
end;

function TModelChartApexBar.Vertical: iModelChart;
begin
  result := TModelChartApexBarVertical.New;
end;

end.
