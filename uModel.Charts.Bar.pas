unit uModel.Charts.Bar;

interface

uses
  System.Generics.Collections,
  System.Variants,
  uModel.Charts.Interfaces,
  System.Classes;

type
  TModelChartBar = class(TInterfacedObject, IModelChart)
  private
    FChartDataSets: TInterfaceList;
    FHeight: string;
    FWidth: string;
    FLabel: string;
  public
    constructor Create;
    destructor Destroy; override;
    class function New: IModelChart;
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

uses
  System.SysUtils,
  uModel.Charts.Data,
  uModel.Charts.Utils,
  uModel.Charts.DataSet;

{ TModelChartBar }

function TModelChartBar.AddChartDataSet(ALabel: string;
  AyAxis: IModelChartDataAxis; AWidthBar: Integer; AShowDataLabel: Boolean): IModelChartDataSet;
begin
  Result := TModelChartDataSet.New(Self, ALabel, cfChartJS, AyAxis, AWidthBar,
    AShowDataLabel);

  FChartDataSets.Add(Result);
end;

function TModelChartBar.ClearDataSets: IModelChart;
begin
  FChartDataSets.Clear;
  Result := Self;
end;

constructor TModelChartBar.Create;
begin
  inherited Create;
  FChartDataSets := TInterfaceList.Create;
  FHeight := '150px';
  FWidth  := '400px';
end;

destructor TModelChartBar.Destroy;
begin
  FChartDataSets.Free;
  inherited Destroy;
end;

function TModelChartBar.Height(AValue: string): iModelChart;
begin
  FHeight := AValue;
  Result := Self;
end;

function TModelChartBar.LabelName(AValue: string): iModelChart;
begin
  result := self;
  FLabel := AValue;
end;

function TModelChartBar.LabelName: string;
begin
  Result := FLabel;
end;

function TModelChartBar.Width(AValue: string): iModelChart;
begin
  FWidth := AValue;
  Result := Self;
end;

class function TModelChartBar.New: iModelChart;
begin
  Result := Self.Create;
end;

function TModelChartBar.Generate: string;
var
  LLabelsStr, LChartID, LDatasetsStr: string;
  LChartDataSet: iModelChartDataSet;
begin
  LLabelsStr    := EmptyStr;
  LDatasetsStr  := EmptyStr;
  LChartID      := EmptyStr;
  LLabelsStr    := (FChartDataSets[0] as iModelChartDataSet).GenerateLabels;
  LChartID      := IntToStr(Random(MaxInt));
  for var i := 0 to Pred(FChartDataSets.Count) do
  begin
    LChartDataSet := (FChartDataSets[i] as iModelChartDataSet);
    if i > 0 then
      LDatasetsStr  := LDatasetsStr + ', ';
    LDatasetsStr  := LDatasetsStr + LChartDataSet.Generate;
  end;

  Result := Format(
    '<canvas id="chartjs-bar'+ LChartID +'" width="%s" height="%s"></canvas>' +
    '<script>' +
    'document.addEventListener("DOMContentLoaded", () => {' +
    '  new Chart(document.getElementById("chartjs-bar' + LChartID + '"), {' +
    '    type: "bar",' +
    '    data: {' +
    '      labels: [%s],' +
    '      datasets: [%s]' +
    '    },' +
    '    options: {' +
    '      scales: {' +
    '        xAxes: [{' +
    '          reverse: true,' +
    '          gridLines: {' +
    '            color: "rgba(0,0,0,0.05)"' +
    '          }' +
    '        }],' +
    '        yAxes: [{' +
    '          borderDash: [5, 5],' +
    '          gridLines: {' +
    '            color: "rgba(0,0,0,0)",' +
    '            fontColor: "#fff"' +
    '          }' +
    '        }]' +
    '      }' +
    '    }' +
    '  });' +
    '});' +
    '</script>', [FWidth, FHeight, LLabelsStr, LDatasetsStr]);
end;

end.

