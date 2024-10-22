unit uModel.Apex.Charts.Bar.Horizontal;

interface

uses
  System.Classes,
  uModel.Charts.Interfaces;

type
  TModelChartApexBarHorizontal = class(TInterfacedObject, iModelChart)
  strict private
    FChartDataSets: TInterfaceList;
    FWidth: string;
    FLabel: string;
    FChartID: string;
    FHeight: string;
  public
    constructor Create(AChartID: string = '');
    destructor Destroy; override;
    class function New(AChartID: string = ''): IModelChart;

    function AddChartDataSet(ALabel: string; AyAxis: iModelChartDataAxis = nil;
      AWidthBar: Integer = 70): iModelChartDataSet; overload;
    function LabelName: string; overload;
    function LabelName(AValue: string): iModelChart; overload;
    function ClearDataSets: iModelChart;
    function Height(AValue: string): iModelChart;
    function Width(AValue: string): iModelChart;
    function Generate: string;
  end;

implementation

{ TModelChartApexBarHorizontal }

uses
  System.SysUtils,
  uModel.Charts.Data,
  uModel.Charts.Utils,
  uModel.Charts.DataSet;

function TModelChartApexBarHorizontal.AddChartDataSet(ALabel: string;
  AyAxis: iModelChartDataAxis; AWidthBar: Integer): iModelChartDataSet;
begin
  Result := TModelChartDataSet.New(Self, ALabel, cfChartApex, AyAxis, AWidthBar);
  FChartDataSets.Add(Result);
end;

function TModelChartApexBarHorizontal.ClearDataSets: iModelChart;
begin
  FChartDataSets.Clear;
  Result := Self;
end;

constructor TModelChartApexBarHorizontal.Create(AChartID: string);
begin
  inherited Create;
  FChartDataSets := TInterfaceList.Create;
  FHeight := '150px';
  FWidth  := '400px';
  FChartID := AChartID;

  if FChartID = '' then
    FChartID := IntToStr(Random(MaxInt));
end;

destructor TModelChartApexBarHorizontal.Destroy;
begin
  FChartDataSets.Free;
  inherited Destroy;
end;

function TModelChartApexBarHorizontal.Generate: string;
var
  LChartID: string;
  LLabelsStr: string;
  LBarColors: string;
  LDatasetsStr: string;
  LPointColors: string;
  LChartDataSet: iModelChartDataSet;
begin
  LDatasetsStr := EmptyStr;
  LBarColors   := EmptyStr;
  LPointColors := EmptyStr;
  LLabelsStr   := (FChartDataSets[0] as iModelChartDataSet).GenerateLabels;
  LChartID     := FChartID;

  for var I := 0 to Pred(FChartDataSets.Count) do
  begin
    LChartDataSet := (FChartDataSets[i] as iModelChartDataSet);

    if I > 0 then
    begin
      LDatasetsStr := LDatasetsStr + ', ';
      LPointColors := LPointColors +', ';
      LBarColors   := LBarColors + ', ';
    end;

    LDatasetsStr := LDatasetsStr + LChartDataSet.Generate;
    LPointColors := LPointColors + LChartDataSet.GeneratePointColor;
    LBarColors   := LBarColors + LChartDataSet.GeneratePointBackgroundColor;
  end;

  Result :=Format(
    '<div id="chart'+ LChartID +'"> '+
    '  <div id="timeline-chart'+ LChartID +'"></div> '+
    '</div> '+
    '<script src="https://cdn.jsdelivr.net/npm/apexcharts"></script> '+
    '<script> '+
    '  var options = { '+
    '    series: [ %s ], '+
    '    chart: { '+
    '      type: "bar", '+
    '      height: %s '+
    '    }, '+
    '    plotOptions: { '+
    '      bar: { '+
    '        horizontal: true, '+
    '          dataLabels: { '+
    '            position: "top", '+
    '          }, '+
    '        } '+
    '      }, '+
    '      dataLabels: { '+
    '        enabled: true, '+
    '        offsetX: 80, '+
    '        offsetY: -2, '+
    '        style: { '+
    '          fontSize: "12px", '+
    '          colors: [%s] '+
    '        } '+
    '      }, '+
    '      stroke: { '+
    '        show: true, '+
    '        width: 1, '+
    '        colors: ["#fff"] '+
    '      }, '+
    '      tooltip: { '+
    '        shared: true, '+
    '        intersect: false, '+
    '        fixed: { '+
    '          enabled: true, '+
    '          position: "bottomRight", '+
    '          offsetX: 0, '+
    '          offsetY: 0, '+
    '        }, '+
    '      }, '+
    '      xaxis: { '+
    '        categories: [ %s ], '+
    '      }, '+
    '      colors: [%s] '+
    '    }; '+
    '  var chart = new ApexCharts(document.querySelector("#chart'+ LChartID +'"), options); '+
    '  chart.render(); '+
    '</script>', [LDatasetsStr, FHeight, LPointColors, LLabelsStr, LBarColors]);
end;

function TModelChartApexBarHorizontal.Height(AValue: string): iModelChart;
begin
  FHeight := AValue;
  Result := Self;
end;

function TModelChartApexBarHorizontal.LabelName(AValue: string): iModelChart;
begin
  result := self;
  FLabel := AValue;
end;

function TModelChartApexBarHorizontal.LabelName: string;
begin
  Result := FLabel;
end;

class function TModelChartApexBarHorizontal.New(AChartID: string): IModelChart;
begin
  result := Self.Create(AChartID);
end;

function TModelChartApexBarHorizontal.Width(AValue: string): iModelChart;
begin
  FWidth := AValue;
  Result := Self;
end;

end.
