unit uModel.Charts.Interfaces;

interface

uses
  System.Classes;

type
  EnumChartType = (ctNone, ctColumn, ctArea, ctLinha, ctPizza, ctDonut, ctRadialBar);
  EnumChartFramework = (cfNone, cfChartJS, cfChartApex);
  EnumColors = (none, blue, indigo, purple, pink ,red ,orange, yellow, green, teal, cyan, black, white, gray, graydark, gray100, gray200, gray300, gray400, gray500, gray600, gray700, gray800, gray900, primary, secondary, success, info, warning, danger, light, dark, transparent);

type
  iModelChartData = interface;
  iModelChartDataSet = interface;
  iModelChart = interface;

  iModelChartDataAxis = interface
    ['{408BD82C-2264-4166-9541-E6E8546386D5}']
    function Title: string; overload;
    function Visible: Boolean; overload;
    function Opposite: Boolean; overload;
    function SufixoLabel: string; overload;
    function TickAmount: Integer; overload;
    function MinValueAxis: Integer; overload;
    function MaxValueAxis: Integer; overload;

    function Title(AValue: string): iModelChartDataAxis; overload;
    function Visible(AValue: Boolean): iModelChartDataAxis; overload;
    function Opposite(AValue: Boolean): iModelChartDataAxis; overload;
    function SufixoLabel(AValue: string): iModelChartDataAxis; overload;
    function TickAmount(AValue: Integer): iModelChartDataAxis; overload;
    function MinValueAxis(AValue: Integer): iModelChartDataAxis; overload;
    function MaxValueAxis(AValue: Integer): iModelChartDataAxis; overload;
  end;

  iModelChartData = interface
    ['{8E128234-A31F-422D-9001-00D12883C4E5}']
    function LabelName(AValue: string): iModelChartData; overload;
    function Value(AValue: Variant): iModelChartData; overload;
    function ChartType(AValue: EnumChartType): iModelChartData; overload;
    function BackgroundColor(AValue: EnumColors): iModelChartData; overload;
    function BorderColor(AValue: EnumColors): iModelChartData; overload;
    function PointColor(AValue: EnumColors): iModelChartData; overload;
    function PointBackgroundColor(AValue: EnumColors): iModelChartData; overload;
    function PointBorderColor(AValue: EnumColors): iModelChartData; overload;
    function PointHoverBackgroundColor(AValue: EnumColors): iModelChartData; overload;
    function PointHoverBorderColor(AValue: EnumColors): iModelChartData; overload;

    function LabelName: string; overload;
    function Value: Variant; overload;
    function ChartType: EnumChartType; overload;
    function BackgroundColor: EnumColors; overload;
    function BorderColor: EnumColors; overload;
    function PointColor: EnumColors; overload;
    function PointBackgroundColor: EnumColors; overload;
    function PointBorderColor: EnumColors; overload;
    function PointHoverBackgroundColor: EnumColors; overload;
    function PointHoverBorderColor: EnumColors; overload;
  end;

  IModelChartDataSet = interface
    ['{A1234567-89AB-CDEF-0123-456789ABCDEF}']
    function WidthBar: string;
    function GenerateAxisY: string;
    function GenerateLabels: string;
    function ShowDataLabel: Boolean;
    function GenerateToolTipY: string;
    function GeneratePointColor: string;
    function GenerateBackgroundColors: string;
    function GeneratePointBackgroundColor: string;
    function AddChartData(ALabel: string; AValue: Variant;
      APointBackgroundColor: EnumColors = none): iModelChartDataSet; overload;
    function AddChartData(ALabel: string; AValue: Variant; AChartType: EnumChartType;
      APointBackgroundColor: EnumColors = none; APointColor: EnumColors = none): iModelChartDataSet; overload;
    function AddChartData(ALabel: string; AValue: Variant; ABackgroundColor, ABorderColor: EnumColors;
      APointBackgroundColor: EnumColors = None; APointBorderColor: EnumColors = None;
      APointHoverBackgroundColor: EnumColors = None; APointHoverBorderColor: EnumColors = None): iModelChartDataSet; overload;
    function LabelName: string; overload;
    function LabelName(AValue: string): iModelChartDataSet; overload;
    function Opacity(AValue: Double): iModelChartDataSet; overload;
    function Generate: string;
    function Opacity: Double; overload;
    function RecordCount: integer;
    function &End: iModelChart;
  end;

  IModelChart = interface
    ['{C9BD1133-7A8F-42A9-A2C9-950251F8177A}']
    function AddChartDataSet(ALabel: string; AyAxis: IModelChartDataAxis = nil;
      AWidthBar: Integer = 70; AShowDataLabel: Boolean = True): IModelChartDataSet; overload;
    function LabelName: string; overload;
    function LabelName(AValue: string): IModelChart; overload;
    function ClearDataSets: IModelChart;
    function Height(AValue: string): IModelChart;
    function Width(AValue: string): IModelChart;
    function Generate: string;
  end;

  IModelChartFactory = interface
    ['{AABB99D5-B5A5-4F99-B2AF-332E27B66172}']
    function Bar: iModelChart;
    function Line: iModelChart;
    function Pie: iModelChart;
    function Doughnut: iModelChart;
    function PolarArea: iModelChart;
    function Radar: iModelChart;
  end;

  IModelChartApexBar = interface
    function Vertical: IModelChart;
    function Horizontal(AChartID: string = ''): IModelChart;
  End;

  iModelChartApexFactory = interface
    ['{1CAD72D1-4B88-4332-9DE3-9B3B17A1916B}']
    function Bar: iModelChartApexBar;
    function Donut: iModelChart;
    function Mixed(AChartID: string): iModelChart;
    function Pie: iModelChart;
    function RadialBar: iModelChart;
  End;

  iModelChartOptionsFactory = interface
    ['{D28FEACA-469E-4437-B015-427A4BD5135D}']
    function ChartJS: iModelChartFactory;
    function ChartApex: iModelChartApexFactory;
  End;

implementation

end.

