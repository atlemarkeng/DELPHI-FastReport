
{******************************************}
{                                          }
{             FastReport v4.0              }
{             Image Converter              }
{                                          }
{         Copyright (c) 1998-2011          }
{           by Anton Khayrudinov           }
{             Fast Reports Inc.            }
{                                          }
{******************************************}

{$I frx.inc}
{$I fmx.inc}

unit FMX.frxImageConverter;

interface

uses
  System.Classes, FMX.Types
{$IFDEF DELPHI18}
  , FMX.Surfaces
{$ENDIF}
{$IFDEF DELPHI19}
  , FMX.Graphics
  , FMX.frxFMX
{$ENDIF};

type
  TfrxPictureType = (gpPNG, gpBMP, gpEMF, gpWMF, gpJPG, gpGIF);

procedure SaveGraphicAs(Graphic: TBitmap; Stream: TStream; PicType: TfrxPictureType); overload;
procedure SaveGraphicAs(Graphic: TBitmap; Path: string; PicType: TfrxPictureType); overload;

function GetPicFileExtension(PicType: TfrxPictureType): string;

implementation


function GetPicFileExtension(PicType: TfrxPictureType): string;
begin
  case PicType of
    gpPNG: Result := 'png';
    gpBMP: Result := 'bmp';
    gpEMF: Result := 'png';
    gpWMF: Result := 'png';
    gpJPG: Result := 'jpg';
    gpGIF: Result := 'gif';
    else   Result := '';
  end;
end;

procedure SaveGraphicAs(Graphic: TBitmap; Path: string; PicType: TfrxPictureType);
var
  Stream: TStream;
begin
  Stream := TFileStream.Create(Path, fmCreate);

  try
    SaveGraphicAs(Graphic, Stream, PicType)
  finally
    Stream.Free
  end
end;

procedure SaveGraphicAs(Graphic: TBitmap; Stream: TStream; PicType: TfrxPictureType);
{$IFNDEF DELPHI18}
{$IFNDEF Delphi17}
var
  Filter: TBitmapCodec;
begin
  Filter := DefaultBitmapCodecClass.Create;
  try
    case PicType of
      gpEMF: Filter.SaveToStream(Stream, Graphic, 'png'); // not supported back compatibility only
      gpWMF: Filter.SaveToStream(Stream, Graphic, 'png');
      gpBMP: Filter.SaveToStream(Stream, Graphic, 'bmp');
      gpPNG: Filter.SaveToStream(Stream, Graphic, 'png');
      gpJPG: Filter.SaveToStream(Stream, Graphic, 'jpg');
      gpGIF: Filter.SaveToStream(Stream, Graphic, 'gif');
    end;
  finally
    Filter.Free;
  end;
{$ELSE}
begin
    case PicType of
      gpEMF: TBitmapCodecManager.SaveToStream(Stream, Graphic, 'png'); // not supported back compatibility only
      gpWMF: TBitmapCodecManager.SaveToStream(Stream, Graphic, 'png');
      gpBMP: TBitmapCodecManager.SaveToStream(Stream, Graphic, 'bmp');
      gpPNG: TBitmapCodecManager.SaveToStream(Stream, Graphic, 'png');
      gpJPG: TBitmapCodecManager.SaveToStream(Stream, Graphic, 'jpg');
      gpGIF: TBitmapCodecManager.SaveToStream(Stream, Graphic, 'gif');
    end;
{$ENDIF}
{$ELSE}
var
  Surf: TBitmapSurface;
begin
  Surf := TBitmapSurface.Create;
  try
    Surf.Assign(Graphic);
    case PicType of
      gpEMF: TBitmapCodecManager.SaveToStream(Stream, Surf, 'png'); // not supported back compatibility only
      gpWMF: TBitmapCodecManager.SaveToStream(Stream, Surf, 'png');
      gpBMP: TBitmapCodecManager.SaveToStream(Stream, Surf, 'bmp');
      gpPNG: TBitmapCodecManager.SaveToStream(Stream, Surf, 'png');
      gpJPG: TBitmapCodecManager.SaveToStream(Stream, Surf, 'jpg');
      gpGIF: TBitmapCodecManager.SaveToStream(Stream, Surf, 'gif');
    end;
  finally
    Surf.Free;
  end;
{$ENDIF}
end;

end.
