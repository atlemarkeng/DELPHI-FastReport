
{******************************************}
{                                          }
{             FastReport v4.0              }
{            Registration unit             }
{                                          }
{         Copyright (c) 1998-2008          }
{         by Alexander Tzyganenko,         }
{            Fast Reports Inc.             }
{                                          }
{******************************************}

unit FMXfrxRegCtrls;

{$I frx.inc}
//{$I frxReg.inc}

interface


procedure Register;

implementation

uses
  System.SysUtils, System.Classes, FMX.Types, FMX.Controls, FMX.Forms, FMX.frxCtrls, FMX.frxFMX, FMX.frxDesgnCtrls;


procedure Register;
begin

  RegisterComponents('FastReport FMX Controls 2.0',
    [TfrxToolButton, TfrxToolSeparator, TfrxToolGrip, TfrxRuler, TfrxScrollBox, TfrxTreeView]);

end;

end.
