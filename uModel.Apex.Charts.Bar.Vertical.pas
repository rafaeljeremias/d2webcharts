unit uModel.Apex.Charts.Bar.Vertical;

interface

uses
  System.Classes,
  uModel.Charts.Interfaces;

type
  TModelChartApexBarVertical = class(TInterfacedObject, IModelChart)
  strict private
    FChartDataSets: TInterfaceList;
    FHeight: string;
    FWidth: string;
    FLabel: string;
  public
    constructor Create;
    destructor Destroy; override;
    class function New: iModelChart;

    function AddChartDataSet(ALabel: string; AyAxis: IModelChartDataAxis = nil;
      AWidthBar: Integer = 70; AShowDataLabel: Boolean = True): IModelChartDataSet; overload;
    function LabelName: string; overload;
    function LabelName(AValue: string): iModelChart; overload;
    function ClearDataSets: iModelChart;
    function Height(AValue: string): iModelChart;
    function Width(AValue: string): iModelChart;
    function Generate: string;
  end;

implementation

{ TModelChartApexBarVertical }

uses
  System.SysUtils,
  uModel.Charts.Data,
  uModel.Charts.Utils,
  uModel.Charts.DataSet;

function TModelChartApexBarVertical.AddChartDataSet(ALabel: string;
  AyAxis: IModelChartDataAxis; AWidthBar: Integer; AShowDataLabel: Boolean): IModelChartDataSet;
begin
  Result := TModelChartDataSet.New(Self, ALabel, cfChartApex, AyAxis, AWidthBar,
    AShowDataLabel);
  FChartDataSets.Add(Result);
end;

function TModelChartApexBarVertical.ClearDataSets: iModelChart;
begin
  FChartDataSets.Clear;
  Result := Self;
end;

constructor TModelChartApexBarVertical.Create;
begin
  inherited Create;
  FChartDataSets := TInterfaceList.Create;
  FHeight := '150px';
  FWidth  := '400px';
end;

destructor TModelChartApexBarVertical.Destroy;
begin
  FChartDataSets.Free;
  inherited Destroy;
end;

function TModelChartApexBarVertical.Generate: string;
var
  LChartID: string;
  LLabelsStr: string;
  LBarColors: string;
  LDatasetsStr: string;
  LChartDataSet: iModelChartDataSet;
begin
  LDatasetsStr := EmptyStr;
  LBarColors   := EmptyStr;
  LLabelsStr   := (FChartDataSets[0] as iModelChartDataSet).GenerateLabels;
  LChartID     := IntToStr(Random(MaxInt));

  for var I := 0 to Pred(FChartDataSets.Count) do
  begin
    LChartDataSet := (FChartDataSets[i] as iModelChartDataSet);

    if I > 0 then
    begin
      LDatasetsStr := LDatasetsStr + ', ';
      LBarColors   := LBarColors + ', ';
    end;

    LDatasetsStr := LDatasetsStr + LChartDataSet.Generate;
    LBarColors   := LBarColors + LChartDataSet.GeneratePointBackgroundColor;
  end;

  Result := Format(
    '<div id="chart'+ LChartID +'"> '+
    '  <div id="timeline-chart'+ LChartID +'"></div> '+
    '</div> '+
    '/*IMPORT_APEX*/ '+
//    '<script src="https://cdn.jsdelivr.net/npm/apexcharts"></script> '+
    '<script> '+
    '  var options = { '+
    '    series: [ %s ], '+
    '    chart: { '+
    '      type: "bar", '+
    '      height: %s '+
    '    }, '+
    '    plotOptions: { '+
    '      bar: { '+
    '        horizontal: false, '+
    '          dataLabels: { '+
    '            position: "top", '+
    '          }, '+
    '        } '+
    '      }, '+
    '      dataLabels: { '+
    '        enabled: true, '+
    '        offsetX: 0, '+
    '        style: { '+
    '          fontSize: "12px", '+
    '          colors: ["#fff"] '+
    '        } '+
    '      }, '+
    '      stroke: { '+
    '        show: true, '+
    '        width: 1, '+
    '        colors: ["#fff"] '+
    '      }, '+
    '      tooltip: { '+
    '        shared: true, '+
    '        intersect: false '+
    '      }, '+
    '      xaxis: { '+
    '        categories: [ %s ], '+
    '      }, '+
    '      colors: [%s] '+
    '    }; '+
    '  var chart = new ApexCharts(document.querySelector("#chart'+ LChartID +'"), options); '+
    '  chart.render(); '+
    '</script>', [LDatasetsStr, FHeight, LLabelsStr, LBarColors]);
end;

function TModelChartApexBarVertical.Height(AValue: string): iModelChart;
begin
  FHeight := AValue;
  Result := Self;
end;

function TModelChartApexBarVertical.LabelName(AValue: string): iModelChart;
begin
  result := self;
  FLabel := AValue;
end;

function TModelChartApexBarVertical.LabelName: string;
begin
  Result := FLabel;
end;

class function TModelChartApexBarVertical.New: iModelChart;
begin
  result := Self.Create;
end;

function TModelChartApexBarVertical.Width(AValue: string): iModelChart;
begin
  FWidth := AValue;
  Result := Self;
end;

end.
