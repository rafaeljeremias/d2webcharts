unit uModel.Apex.Charts.Donut;

interface

uses
  System.Math,
  System.Classes,
  System.SysUtils,
  System.StrUtils,
  uModel.Charts.Interfaces;

type
  TModelChartApexDonut = class(TInterfacedObject, iModelChart)
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

{ TModelChartApexDonut }

uses
  uModel.Charts.Data,
  uModel.Charts.Utils,
  uModel.Charts.DataSet;

function TModelChartApexDonut.AddChartDataSet(ALabel: string;
  AyAxis: iModelChartDataAxis = nil): iModelChartDataSet;
begin
  Result := TModelChartDataSet.New(Self, ALabel, cfChartApex, AyAxis);
  FChartDataSets.Add(Result);
end;

function TModelChartApexDonut.ClearDataSets: iModelChart;
begin
  FChartDataSets.Clear;
  Result := Self;
end;

constructor TModelChartApexDonut.Create;
begin
  inherited Create;
  FChartDataSets := TInterfaceList.Create;
  FHeight := '150px';
  FWidth  := '400px';
end;

destructor TModelChartApexDonut.Destroy;
begin
  FChartDataSets.Free;
  inherited Destroy;
end;

function TModelChartApexDonut.Generate: string;
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
    '      type: "donut", '+
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

function TModelChartApexDonut.Height(AValue: string): iModelChart;
begin
  FHeight := AValue;
  Result := Self;
end;

function TModelChartApexDonut.LabelName(AValue: string): iModelChart;
begin
  result := self;
  FLabel := AValue;
end;

function TModelChartApexDonut.LabelName: string;
begin
  Result := FLabel;
end;

class function TModelChartApexDonut.New: iModelChart;
begin
  result := Self.Create;
end;

function TModelChartApexDonut.Width(AValue: string): iModelChart;
begin
  FWidth := AValue;
  Result := Self;
end;

end.
