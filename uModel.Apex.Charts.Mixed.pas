unit uModel.Apex.Charts.Mixed;

interface

uses
  System.Classes,
  System.StrUtils,
  System.SysUtils,
  uModel.Charts.Interfaces;

type
  TModelChartApexMixed = class(TInterfacedObject, IModelChart)
  strict private
    FChartDataSets: TInterfaceList;
    FHeight: string;
    FWidth: string;
    FLabel: string;
    FChartID: string;
  public
    constructor Create(AChartID: string);
    destructor Destroy; override;
    class function New(AChartID: string): IModelChart;

    function AddChartDataSet(ALabel: string; AyAxis: IModelChartDataAxis = nil;
      AWidthBar: Integer = 70; AShowDataLabel: Boolean = true): IModelChartDataSet; overload;
    function LabelName: string; overload;
    function LabelName(AValue: string): IModelChart; overload;
    function ClearDataSets: IModelChart;
    function Height(AValue: string): IModelChart;
    function Width(AValue: string): IModelChart;
    function Generate: string;
  end;

implementation

{ TModelChartApexMixed }

uses
  uModel.Charts.Data,
  uModel.Charts.Utils,
  uModel.Charts.DataSet;

function TModelChartApexMixed.AddChartDataSet(ALabel: string;
  AyAxis: IModelChartDataAxis; AWidthBar: Integer; AShowDataLabel: Boolean): IModelChartDataSet;
begin
  Result := TModelChartDataSet.New(Self, ALabel, cfChartApex, AyAxis, AWidthBar,
    AShowDataLabel);

  FChartDataSets.Add(Result);
end;

function TModelChartApexMixed.ClearDataSets: IModelChart;
begin
  FChartDataSets.Clear;
  Result := Self;
end;

constructor TModelChartApexMixed.Create(AChartID: string);
begin
  inherited Create;
  FChartDataSets := TInterfaceList.Create;
  FHeight := '150px';
  FWidth  := '400px';
  FChartID := AChartID;
end;

destructor TModelChartApexMixed.Destroy;
begin
  FChartDataSets.Free;
  inherited Destroy;
end;

function TModelChartApexMixed.Generate: string;
var
  LAxisY: string;
  LChartID: string;
  LWidthBar: string;
  LLabelsStr: string;
  LBarColors: string;
  LToolTipStr: string;
  LDatasetsStr: string;
  LPointColorStr: string;
  LChartDataSet: IModelChartDataSet;
begin
  LAxisY         := EmptyStr;
  LDatasetsStr   := EmptyStr;
  LBarColors     := EmptyStr;
  LToolTipStr    := EmptyStr;
  LPointColorStr := EmptyStr;
  LLabelsStr     := (FChartDataSets[0] as IModelChartDataSet).GenerateLabels;

  if FChartID <> '' then
    LChartID := FChartID
  else
    LChartID := IntToStr(Random(MaxInt));

  LWidthBar := (FChartDataSets[0] as iModelChartDataSet).WidthBar;

  for var I := 0 to Pred(FChartDataSets.Count) do
  begin
    LChartDataSet := (FChartDataSets[i] as IModelChartDataSet);

    if I > 0 then
    begin
      if LAxisY <> '' then
        LAxisY := LAxisY + ', ';

      if LToolTipStr <> '' then
        LToolTipStr := LToolTipStr +', ';

      LBarColors := LBarColors + ', ';
      LDatasetsStr := LDatasetsStr + ', ';
      LPointColorStr := LPointColorStr +', ';
    end;

    LAxisY         := LAxisY + LChartDataSet.GenerateAxisY;
    LDatasetsStr   := LDatasetsStr + LChartDataSet.Generate;
    LToolTipStr    := LToolTipStr + LChartDataSet.GenerateToolTipY;
    LPointColorStr := LPointColorStr + LChartDataSet.GeneratePointColor;
    LBarColors     := LBarColors + LChartDataSet.GeneratePointBackgroundColor;
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
    '      height: %s, '+
    '      stacked: false '+
    '    }, '+
    '    stroke: { '+
    '      width: [0, 4, 5], '+
    '      curve: "smooth" '+
    '    }, '+
    '    plotOptions: { '+
    '      bar: { '+
    '        columnWidth: "%s", '+
    '        dataLabels: { '+
    '          position: "top", '+
    '        }, '+
    '      } '+
    '    }, '+
    '    fill: { '+
    '      opacity: [0.85, 0.25, 1], '+
    '      gradient: { '+
    '        inverseColors: false, '+
    '        shade: "light", '+
    '        type: "vertical", '+
    '        opacityFrom: 0.85, '+
    '        opacityTo: 0.55, '+
    '        stops: [0, 100, 100, 100] '+
    '      } '+
    '    }, '+
    '    labels: [ %s ],'+
    '    markers: { '+
    '      size: 0 '+
    '    }, '+
    '    xaxis: { '+
    '      type: "date" '+
    '    }, '+
    '    %s '+
    '    tooltip: { '+
    '      shared: true, '+
    '      intersect: false, '+
    '      %s '+
    '    }, '+
    '    dataLabels: { '+
    '        enabled: true, '+
    '        position: "top", '+
    '          offsetX: 0, '+
    '          offsetY: -20, '+
    '        style: { '+
    '          fontSize: "10px", '+
    '          colors: [%s] '+
    '        } '+
    '    }, '+
    '    colors: [%s] '+
    '    }; '+
    '  var chart = new ApexCharts(document.querySelector("#chart'+ LChartID +'"), options); '+
    '  chart.render(); '+
    '</script>',
    [LDatasetsStr,
     FHeight,
     LWidthBar +'%',
     LLabelsStr,
     ifThen(LAxisY = '', '', 'yaxis: [ '+ LAxisY +' ], '),
     ifThen(LToolTipStr = '', '', 'y: [ '+ LToolTipStr +' ]'),
     LPointColorStr,
     LBarColors]);
end;

function TModelChartApexMixed.Height(AValue: string): iModelChart;
begin
  FHeight := AValue;
  Result := Self;
end;

function TModelChartApexMixed.LabelName(AValue: string): iModelChart;
begin
  result := self;
  FLabel := AValue;
end;

function TModelChartApexMixed.LabelName: string;
begin
  Result := FLabel;
end;

class function TModelChartApexMixed.New(AChartID: string): iModelChart;
begin
  result := Self.Create(AChartID);
end;

function TModelChartApexMixed.Width(AValue: string): iModelChart;
begin
  FWidth := AValue;
  Result := Self;
end;

end.
