unit DIDSSProperty;

interface
function DSSProperties(mode:longint; arg:pAnsiChar):pAnsiChar; cdecl;

implementation

uses DSSClass, DSSGlobals, Executive, SysUtils;

var
  FPropIndex   :Integer;

function DSSProperties(mode:longint; arg:pAnsiChar):pAnsiChar; cdecl;
begin
  Result := pAnsiChar(AnsiString('')); // Default return value
  case mode of
    0: begin                                           // DSSProperties.Name
      Result := pAnsiChar(AnsiString(''));
      If (ActiveCircuit<> Nil) and (FPropIndex <> 0) {and (FPropClass <> Nil)} Then
        With  ActiveDSSObject.ParentClass   Do
        If FPropIndex <= NumProperties Then
          Result := pAnsiChar(AnsiString(PropertyName^[FPropIndex]));
    end;
    1: begin                                           // DSSProperties.Description
      Result := pAnsiChar(AnsiString(''));
      If (ActiveCircuit<> Nil) and (FPropIndex <> 0) {and (FPropClass <> Nil)} Then
      With  ActiveDSSObject.ParentClass Do
        If FPropIndex <= NumProperties Then
          Result := pAnsiChar(AnsiString(PropertyHelp^[FPropIndex]));
    end;
    2: begin                                           // DSSProperties.Value - read
      Result := pAnsiChar(AnsiString(''));
      If (ActiveCircuit<> Nil)
      THEN  With ActiveDSSObject Do
        If FPropIndex <= ParentClass.NumProperties Then
              Result := pAnsiChar(AnsiString(PropertyValue[ParentClass.PropertyIdxMap[FPropIndex]]));
    end;
    3: begin                                           // DSSProperties.Value - Write
       If (ActiveCircuit<> Nil)
        THEN  With ActiveDSSObject Do
          If FPropIndex <= ParentClass.NumProperties Then
                DSSExecutive.Command := 'Edit ' + ParentClass.Name + '.' + Name + ' ' +
                       ParentClass.PropertyName^[FPropIndex] + '=' +
                       string(arg);
                Result:=pAnsiChar(AnsiString(''));
    end
    else
      Result:=pAnsiChar(ansistring(''));
  end;
end;

end.
