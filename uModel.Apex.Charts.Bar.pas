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

    function Vertical: IModelChart;
    function Horizontal(AChartID: string = ''): IModelChart;
  End;

implementation

{ TModelChartApexBar }

function TModelChartApexBar.Horizontal(AChartID: string): IModelChart;
begin
  result := TModelChartApexBarHorizontal.New(AChartID);
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
