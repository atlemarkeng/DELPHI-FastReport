{******************************************}
{                                          }
{             FastReport FMX v2.0          }
{            	Font parser                }
{                                          }
{         Copyright (c) 1998-2013          }
{          by Aleksey Mandrykin,       	   }
{             Fast Reports Inc.            }
{                                          }
{******************************************}

unit FMX.TTFHelpers;

interface

type

TTF_Helpers = class abstract
    // Methods
    strict protected constructor Create;
    public class function Increment(ptr: Pointer; cbSize: Integer): Pointer; static;
    public class function SwapInt16(v: Smallint): Smallint; static;
    public class function SwapInt32(v: Integer): Integer; static;
    public class function SwapUInt16(v: Word): Word; static;
    public class function SwapUInt32(v: Cardinal): Cardinal; static;
    public class function SwapUInt64(v: UInt64): UInt64; static;

end;

implementation

// Methods
    constructor TTF_Helpers.Create;
    begin
    end;

    class function TTF_Helpers.Increment(ptr: Pointer; cbSize: Integer): Pointer;
    begin
        Result := Pointer(NativeInt(ptr) + cbSize)
    end;

    class function TTF_Helpers.SwapInt16(v: Smallint): Smallint;
    begin
        Result := Smallint((((v and $ff) shl 8) or ((v shr 8) and $ff)))
    end;

    class function TTF_Helpers.SwapInt32(v: Integer): Integer;
    begin
        Result := ((TTF_Helpers.SwapInt16(Smallint(v)) and $ffff) shl $10) or (TTF_Helpers.SwapInt16(Smallint(v shr $10)) and $ffff)
    end;

    class function TTF_Helpers.SwapUInt16(v: Word): Word;
    begin
        Result := Word((((v and $ff) shl 8) or ((v shr 8) and $ff)))
    end;

    class function TTF_Helpers.SwapUInt32(v: Cardinal): Cardinal;
    begin
        Result := Cardinal((((TTF_Helpers.SwapUInt16(Word(v)) and $ffff) shl $10) or (TTF_Helpers.SwapUInt16(Word(v shr $10)) and $ffff)))
    end;

    class function TTF_Helpers.SwapUInt64(v: UInt64): UInt64;
    begin
        Result := (((TTF_Helpers.SwapUInt32(Cardinal(v)) and $ffffffff) shl $20) or (TTF_Helpers.SwapUInt32((Cardinal(v shr $20))) and $ffffffff))
    end;

 end.

