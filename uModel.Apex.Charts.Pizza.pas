unit uModel.Apex.Charts.Pizza;

interface

uses
  System.Math,
  System.Classes,
  System.SysUtils,
  System.StrUtils,
  uModel.Charts.Interfaces;

type
  TModelChartApexPizza = class(TInterfacedObject, iModelChart)
  strict private
    FChartDataSets: TInterfaceList;
    FHeight: string;
    FWidth: string;
    FLabel: string;
  public
    constructor Create;
    destructor Destroy; override;
    class function New: iModelChart;

    function AddChartDataSet(ALabel: string; AyAxis: iModelChartDataAxis = nil): iModelChartDataSet;
    function LabelName: string; overload;
    function LabelName(AValue: string): iModelChart; overload;
    function ClearDataSets: iModelChart;
    function Height(AValue: string): iModelChart;
    function Width(AValue: string): iModelChart;
    function Generate: string;
  end;

implementation

{ TModelChartApexPizza }

uses
  uModel.Charts.Data,
  uModel.Charts.Utils,
  uModel.Charts.DataSet;

function TModelChartApexPizza.AddChartDataSet(ALabel: string;
  AyAxis: iModelChartDataAxis): iModelChartDataSet;
begin
  Result := TModelChartDataSet.New(Self, ALabel, cfChartApex, AyAxis);
  FChartDataSets.Add(Result);
end;

function TModelChartApexPizza.ClearDataSets: iModelChart;
begin
  FChartDataSets.Clear;
  Result := Self;
end;

constructor TModelChartApexPizza.Create;
begin
  inherited Create;
  FChartDataSets := TInterfaceList.Create;
  FHeight := '150px';
  FWidth  := '400px';
end;

destructor TModelChartApexPizza.Destroy;
begin
  FChartDataSets.Free;
  inherited Destroy;
end;

function TModelChartApexPizza.Generate: string;
var
  LChartID: string;
  LLabelsStr: string;
  LBarColors: string;
  LDatasetsStr: string;
  LChartDataSet: iModelChartDataSet;
begin
  LDatasetsStr := EmptyStr;
  LBarColors   := EmptyStr;
  LLabelsStr   := EmptyStr;
  LChartID     := IntToStr(Random(MaxInt));

  for var I := 0 to Pred(FChartDataSets.Count) do
  begin
    LChartDataSet := (FChartDataSets[i] as iModelChartDataSet);

    if I > 0 then
    begin
      LBarColors   := LBarColors + ', ';
      LLabelsStr   := LLabelsStr + ', ';
      LDatasetsStr := LDatasetsStr + ', ';
    end;

    LDatasetsStr := LDatasetsStr + LChartDataSet.Generate;
    LLabelsStr   := LLabelsStr + LChartDataSet.GenerateLabels;
    LBarColors   := LBarColors + LChartDataSet.GeneratePointBackgroundColor;
  end;

  Result := Format(
    '<div id="chart'+ LChartID +'"> '+
    '  <div id="timeline-chart'+ LChartID +'"></div> '+
    '</div> '+
    '<script src="https://cdn.jsdelivr.net/npm/apexcharts"></script> '+
    '<script> '+
    '  var options = { '+
    '    series: [ %s ], '+
    '    chart: { '+
    '      type: "pie", '+
    '      width: %s, '+
    '    }, '+
    '    labels: [ %s ],'+
    '    responsive: [{ '+
    '      breakpoint: 480, '+
    '      options: { '+
    '        chart: { '+
    '          width: 200 '+
    '        }, '+
    '        legend: { '+
    '          position: "bottom" '+
    '        } '+
    '      } '+
    '    }], '+
    '    colors: [%s] '+
    '  }; '+
    '  var chart = new ApexCharts(document.querySelector("#chart'+ LChartID +'"), options); '+
    '  chart.render(); '+
    '</script>',
    [LDatasetsStr,
     ifThen(FWidth = '0', '380', FWidth),
     LLabelsStr,
     LBarColors]);
end;

function TModelChartApexPizza.Height(AValue: string): iModelChart;
begin
  FHeight := AValue;
  Result := Self;
end;

function TModelChartApexPizza.LabelName(AValue: string): iModelChart;
begin
  result := self;
  FLabel := AValue;
end;

function TModelChartApexPizza.LabelName: string;
begin
  Result := FLabel;
end;

class function TModelChartApexPizza.New: iModelChart;
begin
  result := Self.Create;
end;

function TModelChartApexPizza.Width(AValue: string): iModelChart;
begin
  FWidth := AValue;
  Result := Self;
end;

end.
