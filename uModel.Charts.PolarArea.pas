unit uModel.Charts.PolarArea;

interface

uses
  System.Generics.Collections,
  System.Variants,
  uModel.Charts.Interfaces,
  System.Classes;

type
  TModelChartPolarArea = class(TInterfacedObject, IModelChart)
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
    function LabelName(AValue: string): iModelChart; overload;
    function ClearDataSets: iModelChart;
    function Height(AValue: string): iModelChart;
    function Width(AValue: string): iModelChart;
    function Generate: string;
  end;

implementation

uses
  System.SysUtils,
  uModel.Charts.Data,
  uModel.Charts.Utils,
  uModel.Charts.DataSet;

{ TModelChartPolarArea }

function TModelChartPolarArea.AddChartDataSet(ALabel: string;
  AyAxis: iModelChartDataAxis; AWidthBar: Integer; AShowDataLabel: Boolean): IModelChartDataSet;
begin
  Result := TModelChartDataSet.New(Self, ALabel, cfChartJS, AyAxis, AWidthBar,
    AShowDataLabel);

  FChartDataSets.Add(Result);
end;

function TModelChartPolarArea.ClearDataSets: iModelChart;
begin
  FChartDataSets.Clear;
  Result := Self;
end;

constructor TModelChartPolarArea.Create;
begin
  inherited Create;
  FChartDataSets := TInterfaceList.Create;
  FHeight := '150px';
  FWidth  := '400px';
end;

destructor TModelChartPolarArea.Destroy;
begin
  FChartDataSets.Free;
  inherited Destroy;
end;

function TModelChartPolarArea.Height(AValue: string): iModelChart;
begin
  FHeight := AValue;
  Result := Self;
end;

function TModelChartPolarArea.LabelName(AValue: string): iModelChart;
begin
  result := self;
  FLabel := AValue;
end;

function TModelChartPolarArea.LabelName: string;
begin
  Result := FLabel;
end;

function TModelChartPolarArea.Width(AValue: string): iModelChart;
begin
  FWidth := AValue;
  Result := Self;
end;

class function TModelChartPolarArea.New: iModelChart;
begin
  Result := Self.Create;
end;

function TModelChartPolarArea.Generate: string;
var
  LLabelsStr, LDatasetsStr, LChartID: string;
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
    '<canvas id="chartjs-polar-area'+ LChartID +'" width="%s" height="%s"></canvas>' +
    '<script>' +
    'document.addEventListener("DOMContentLoaded", () => {' +
    '  new Chart(document.getElementById("chartjs-polar-area' + LChartID + '"), {' +
    '    type: "polarArea",' +
    '    data: {' +
    '      labels: [%s],' +
    '      datasets: [%s]' +
    '    }' +
    '  });' +
    '});' +
    '</script>',
    [FWidth, FHeight, LLabelsStr, LDatasetsStr]);
end;

end.

