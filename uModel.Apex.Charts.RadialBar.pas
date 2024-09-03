unit uModel.Apex.Charts.RadialBar;

interface

uses
  System.Math,
  System.Classes,
  System.SysUtils,
  System.StrUtils,
  uModel.Charts.Interfaces;

type
  TModelChartApexRadialBar = class(TInterfacedObject, iModelChart)
  strict private
    FChartDataSets: TInterfaceList;
    FHeight: string;
    FWidth: string;
    FLabel: string;
  public
    constructor Create;
    destructor Destroy; override;
    class function New: iModelChart;

    function AddChartDataSet(ALabel: string; AyAxis: iModelChartDataAxis = nil): iModelChartDataSet; overload;
    function LabelName: string; overload;
    function LabelName(AValue: string): iModelChart; overload;
    function ClearDataSets: iModelChart;
    function Height(AValue: string): iModelChart;
    function Width(AValue: string): iModelChart;
    function Generate: string;
  end;

implementation

{ TModelChartApexRadialBar }

uses
  uModel.Charts.Data,
  uModel.Charts.Utils,
  uModel.Charts.DataSet;

function TModelChartApexRadialBar.AddChartDataSet(ALabel: string;
  AyAxis: iModelChartDataAxis): iModelChartDataSet;
begin
  Result := TModelChartDataSet.New(Self, ALabel, cfChartApex);
  FChartDataSets.Add(Result);
end;

function TModelChartApexRadialBar.ClearDataSets: iModelChart;
begin
  FChartDataSets.Clear;
  Result := Self;
end;

constructor TModelChartApexRadialBar.Create;
begin
  inherited Create;
  FChartDataSets := TInterfaceList.Create;
  FHeight := '150px';
  FWidth  := '400px';
end;

destructor TModelChartApexRadialBar.Destroy;
begin
  FChartDataSets.Free;
  inherited Destroy;
end;

function TModelChartApexRadialBar.Generate: string;
var
  LChartID: string;
  LBarColors: string;
  LDatasetsStr: string;
  LBackgroundColors: string;
  LChartDataSet: iModelChartDataSet;
begin
  LChartID := IntToStr(Random(MaxInt));
  LChartDataSet := (FChartDataSets[0] as iModelChartDataSet);
  LDatasetsStr := LChartDataSet.Generate;
  LBarColors := LChartDataSet.GeneratePointBackgroundColor;
  LBackgroundColors := LChartDataSet.GenerateBackgroundColors;
  LBarColors := AnsiReplaceStr(LBarColors, ', 0)', ')');
  LBackgroundColors := AnsiReplaceStr(LBackgroundColors, ', 0)', ')');

  Result := Format(
    '<div id="chart'+ LChartID +'"> '+
    '  <div id="timeline-chart'+ LChartID +'"></div> '+
    '</div> '+
    '<script src="https://cdn.jsdelivr.net/npm/apexcharts"></script> '+
    '<script> '+
    '  var options = { '+
    '    series: [ %s ], '+
    '    chart: { '+
    '      type: "radialBar", '+
    '      offsetY: -20, '+
    '      sparkline: { '+
    '        enabled: true '+
    '      } '+
    '    }, '+
    '    plotOptions: { '+
    '      radialBar: { '+
    '        startAngle: -90, '+
    '        endAngle: 90, '+
    '        track: { '+
    '          background: %s, '+
    '          strokeWidth: "%s", '+
    '          margin: 5, '+
    '          dropShadow: { '+
    '            enabled: true, '+
    '            top: 2, '+
    '            left: 0, '+
    '            color: "#999", '+
    '            opacity: 1, '+
    '            blur: 2 '+
    '          } '+
    '        }, '+
    '        dataLabels: { '+
    '          name: { '+
    '            show: false '+
    '          }, '+
    '          value: { '+
    '            offsetY: -2, '+
    '            fontSize: "22px" '+
    '          } '+
    '        } '+
    '      } '+
    '    }, '+
    '    grid: { '+
    '      padding: { '+
    '        top: -10 '+
    '      } '+
    '    }, '+
    '    fill: { '+
    '      type: "gradient", '+
    '      gradient: { '+
    '        shade: "light", '+
    '        shadeIntensity: 0.4, '+
    '        inverseColors: false, '+
    '        opacityFrom: 1, '+
    '        opacityTo: 1, '+
    '        stops: [0, 50, 53, 91] '+
    '      }, '+
    '    }, '+
    '    colors: [ %s ] '+
    '  }; '+
    '  var chart = new ApexCharts(document.querySelector("#chart'+ LChartID +'"), options); '+
    '  chart.render(); '+
    '</script>',
    [LDatasetsStr, LBackgroundColors, '97%', LBarColors]);
end;

function TModelChartApexRadialBar.Height(AValue: string): iModelChart;
begin
  FHeight := AValue;
  Result := Self;
end;

function TModelChartApexRadialBar.LabelName(AValue: string): iModelChart;
begin
  result := self;
  FLabel := AValue;
end;

function TModelChartApexRadialBar.LabelName: string;
begin
  Result := FLabel;
end;

class function TModelChartApexRadialBar.New: iModelChart;
begin
  result := Self.Create;
end;

function TModelChartApexRadialBar.Width(AValue: string): iModelChart;
begin
  FWidth := AValue;
  Result := Self;
end;

end.
