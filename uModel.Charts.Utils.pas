unit uModel.Charts.Utils;

interface

uses
  uModel.Charts.Interfaces;

  function ColorEnumToStringHtml(AColor: EnumColors): string;
  function ChartTypeToString(AChartType: EnumChartType): string;
function ColorEnumToString(AColor: EnumColors; AOpacity: Double = 1.0): string;

implementation

uses
  System.SysUtils;

function ColorEnumToString(AColor: EnumColors; AOpacity: Double = 1.0): string;
begin
  case AColor of
    none:         Result  := 'rgba(222, 226, 230, ' + StringReplace(FloatToStr(AOpacity), ',', '.', [rfReplaceAll]) + ')';
    blue:         Result  := 'rgba(13, 110, 253, '  + StringReplace(FloatToStr(AOpacity), ',', '.', [rfReplaceAll]) + ')';
    indigo:       Result  := 'rgba(102, 16, 242, '  + StringReplace(FloatToStr(AOpacity), ',', '.', [rfReplaceAll]) + ')';
    purple:       Result  := 'rgba(111, 66, 193, '  + StringReplace(FloatToStr(AOpacity), ',', '.', [rfReplaceAll]) + ')';
    pink:         Result  := 'rgba(214, 51, 132, '  + StringReplace(FloatToStr(AOpacity), ',', '.', [rfReplaceAll]) + ')';
    red:          Result  := 'rgba(220, 53, 69, '   + StringReplace(FloatToStr(AOpacity), ',', '.', [rfReplaceAll]) + ')';
    orange:       Result  := 'rgba(253, 126, 20, '  + StringReplace(FloatToStr(AOpacity), ',', '.', [rfReplaceAll]) + ')';
    yellow:       Result  := 'rgba(255, 193, 7, '   + StringReplace(FloatToStr(AOpacity), ',', '.', [rfReplaceAll]) + ')';
    green:        Result  := 'rgba(25, 135, 84, '   + StringReplace(FloatToStr(AOpacity), ',', '.', [rfReplaceAll]) + ')';
    teal:         Result  := 'rgba(32, 201, 151, '  + StringReplace(FloatToStr(AOpacity), ',', '.', [rfReplaceAll]) + ')';
    cyan:         Result  := 'rgba(13, 202, 240, '  + StringReplace(FloatToStr(AOpacity), ',', '.', [rfReplaceAll]) + ')';
    black:        Result  := 'rgba(0, 0, 0, '       + StringReplace(FloatToStr(AOpacity), ',', '.', [rfReplaceAll]) + ')';
    white:        Result  := 'rgba(255, 255, 255, ' + StringReplace(FloatToStr(AOpacity), ',', '.', [rfReplaceAll]) + ')';
    gray:         Result  := 'rgba(108, 117, 125, ' + StringReplace(FloatToStr(AOpacity), ',', '.', [rfReplaceAll]) + ')';
    graydark:     Result  := 'rgba(52, 58, 64, '    + StringReplace(FloatToStr(AOpacity), ',', '.', [rfReplaceAll]) + ')';
    gray100:      Result  := 'rgba(248, 249, 250, ' + StringReplace(FloatToStr(AOpacity), ',', '.', [rfReplaceAll]) + ')';
    gray200:      Result  := 'rgba(233, 236, 239, ' + StringReplace(FloatToStr(AOpacity), ',', '.', [rfReplaceAll]) + ')';
    gray300:      Result  := 'rgba(222, 226, 230, ' + StringReplace(FloatToStr(AOpacity), ',', '.', [rfReplaceAll]) + ')';
    gray400:      Result  := 'rgba(206, 212, 218, ' + StringReplace(FloatToStr(AOpacity), ',', '.', [rfReplaceAll]) + ')';
    gray500:      Result  := 'rgba(173, 181, 189, ' + StringReplace(FloatToStr(AOpacity), ',', '.', [rfReplaceAll]) + ')';
    gray600:      Result  := 'rgba(108, 117, 125, ' + StringReplace(FloatToStr(AOpacity), ',', '.', [rfReplaceAll]) + ')';
    gray700:      Result  := 'rgba(73, 80, 87, '    + StringReplace(FloatToStr(AOpacity), ',', '.', [rfReplaceAll]) + ')';
    gray800:      Result  := 'rgba(52, 58, 64, '    + StringReplace(FloatToStr(AOpacity), ',', '.', [rfReplaceAll]) + ')';
    gray900:      Result  := 'rgba(33, 37, 41, '    + StringReplace(FloatToStr(AOpacity), ',', '.', [rfReplaceAll]) + ')';
    primary:      Result  := 'rgba(13, 110, 253, '  + StringReplace(FloatToStr(AOpacity), ',', '.', [rfReplaceAll]) + ')';
    secondary:    Result  := 'rgba(108, 117, 125, ' + StringReplace(FloatToStr(AOpacity), ',', '.', [rfReplaceAll]) + ')';
    success:      Result  := 'rgba(25, 135, 84, '   + StringReplace(FloatToStr(AOpacity), ',', '.', [rfReplaceAll]) + ')';
    info:         Result  := 'rgba(13, 202, 240, '  + StringReplace(FloatToStr(AOpacity), ',', '.', [rfReplaceAll]) + ')';
    warning:      Result  := 'rgba(255, 193, 7, '   + StringReplace(FloatToStr(AOpacity), ',', '.', [rfReplaceAll]) + ')';
    danger:       Result  := 'rgba(220, 53, 69, '   + StringReplace(FloatToStr(AOpacity), ',', '.', [rfReplaceAll]) + ')';
    light:        Result  := 'rgba(248, 249, 250, ' + StringReplace(FloatToStr(AOpacity), ',', '.', [rfReplaceAll]) + ')';
    dark:         Result  := 'rgba(33, 37, 41, '    + StringReplace(FloatToStr(AOpacity), ',', '.', [rfReplaceAll]) + ')';
    transparent:  Result  := 'transparent';
  end;
end;

function ChartTypeToString(AChartType: EnumChartType): string;
begin
  result := '';

  case AChartType of
    ctColumn: result := 'column';
    ctArea: result := 'area';
    ctLinha: result := 'line';
    ctPizza: result := 'pie';
    ctDonut: result := 'donut';
  end;
end;

function ColorEnumToStringHtml(AColor: EnumColors): string;
begin
  result := '';

  case AColor of
    blue:         Result  := 'blue';
    indigo:       Result  := 'indigo';
    purple:       Result  := 'purple';
    pink:         Result  := 'pink';
    red:          Result  := 'red';
    orange:       Result  := 'orange';
    yellow:       Result  := 'yellow';
    green:        Result  := 'green';
    teal:         Result  := 'teal';
    cyan:         Result  := 'cyan';
    black:        Result  := 'black';
    white:        Result  := 'white';
    gray:         Result  := 'gray';
    graydark:     Result  := 'graydark';
    gray100:      Result  := 'gray100';
    gray200:      Result  := 'gray200';
    gray300:      Result  := 'gray300';
    gray400:      Result  := 'gray400';
    gray500:      Result  := 'gray500';
    gray600:      Result  := 'gray600';
    gray700:      Result  := 'gray700';
    gray800:      Result  := 'gray800';
    gray900:      Result  := 'gray900';
    primary:      Result  := 'primary';
    secondary:    Result  := 'secondary';
    success:      Result  := 'success';
    info:         Result  := 'info';
    warning:      Result  := 'warning';
    danger:       Result  := 'danger';
    light:        Result  := 'light';
    dark:         Result  := 'dark';
    transparent:  Result  := 'transparent';
  end;
end;

end.
