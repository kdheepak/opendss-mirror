unit ImplLoads;

{$WARN SYMBOL_PLATFORM OFF}

interface

uses
  ComObj, ActiveX, OpenGICEngine_TLB, StdVcl;

type
  TLoads = class(TAutoObject, ILoads)
  protected
    function Get_AllNames: OleVariant; safecall;
    function Get_First: Integer; safecall;
    function Get_idx: Integer; safecall;
    function Get_Name: WideString; safecall;
    function Get_Next: Integer; safecall;
    procedure Set_idx(Value: Integer); safecall;
    procedure Set_Name(const Value: WideString); safecall;
    function Get_kV: Double; safecall;
    function Get_kvar: Double; safecall;
    function Get_kW: Double; safecall;
    function Get_PF: Double; safecall;
    procedure Set_kV(Value: Double); safecall;
    procedure Set_kvar(Value: Double); safecall;
    procedure Set_kW(Value: Double); safecall;
    procedure Set_PF(Value: Double); safecall;
    function Get_Count: Integer; safecall;
    function Get_AllocationFactor: Double; safecall;
    function Get_Cfactor: Double; safecall;
    function Get_Class_: Integer; safecall;
    function Get_CVRcurve: WideString; safecall;
    function Get_CVRvars: Double; safecall;
    function Get_CVRwatts: Double; safecall;
    function Get_daily: WideString; safecall;
    function Get_duty: WideString; safecall;
    function Get_Growth: WideString; safecall;
    function Get_IsDelta: WordBool; safecall;
    function Get_kva: Double; safecall;
    function Get_kwh: Double; safecall;
    function Get_kwhdays: Double; safecall;
    function Get_Model: LoadModels; safecall;
    function Get_NumCust: Integer; safecall;
    function Get_PctMean: Double; safecall;
    function Get_PctStdDev: Double; safecall;
    function Get_Rneut: Double; safecall;
    function Get_Spectrum: WideString; safecall;
    function Get_Status: LoadStatus; safecall;
    function Get_Vmaxpu: Double; safecall;
    function Get_Vminemerg: Double; safecall;
    function Get_Vminnorm: Double; safecall;
    function Get_Vminpu: Double; safecall;
    function Get_xfkVA: Double; safecall;
    function Get_Xneut: Double; safecall;
    function Get_Yearly: WideString; safecall;
    procedure Set_AllocationFactor(Value: Double); safecall;
    procedure Set_Cfactor(Value: Double); safecall;
    procedure Set_Class_(Value: Integer); safecall;
    procedure Set_CVRcurve(const Value: WideString); safecall;
    procedure Set_CVRvars(Value: Double); safecall;
    procedure Set_CVRwatts(Value: Double); safecall;
    procedure Set_daily(const Value: WideString); safecall;
    procedure Set_duty(const Value: WideString); safecall;
    procedure Set_Growth(const Value: WideString); safecall;
    procedure Set_IsDelta(Value: WordBool); safecall;
    procedure Set_kva(Value: Double); safecall;
    procedure Set_kwh(Value: Double); safecall;
    procedure Set_kwhdays(Value: Double); safecall;
    procedure Set_Model(Value: LoadModels); safecall;
    procedure Set_NumCust(Value: Integer); safecall;
    procedure Set_PctMean(Value: Double); safecall;
    procedure Set_PctStdDev(Value: Double); safecall;
    procedure Set_Rneut(Value: Double); safecall;
    procedure Set_Spectrum(const Value: WideString); safecall;
    procedure Set_Status(Value: LoadStatus); safecall;
    procedure Set_Vmaxpu(Value: Double); safecall;
    procedure Set_Vminemerg(Value: Double); safecall;
    procedure Set_Vminnorm(Value: Double); safecall;
    procedure Set_Vminpu(Value: Double); safecall;
    procedure Set_xfkVA(Value: Double); safecall;
    procedure Set_Xneut(Value: Double); safecall;
    procedure Set_Yearly(const Value: WideString); safecall;

  end;

implementation

uses ComServ,DSSGlobals, Executive, Load, Variants, SysUtils;

function ActiveLoad: TLoadObj;
begin
  Result := nil;
  if ActiveCircuit <> Nil then Result := ActiveCircuit.Loads.Active;
end;

procedure Set_Parameter(const parm: string; const val: string);
var
  cmd: string;
begin
  if not Assigned (ActiveCircuit) then exit;
  SolutionAbort := FALSE;  // Reset for commands entered from outside
  cmd := Format ('load.%s.%s=%s', [ActiveLoad.Name, parm, val]);
  DSSExecutive.Command := cmd;
end;

function TLoads.Get_AllNames: OleVariant;
Var
  LoadElem:TLoadObj;
  k:Integer;

Begin
    Result := VarArrayCreate([0, 0], varOleStr);
    Result[0] := 'NONE';
    IF ActiveCircuit <> Nil THEN
     WITH ActiveCircuit DO
     If Loads.ListSize > 0 Then
     Begin
       VarArrayRedim(Result, Loads.ListSize-1);
       k:=0;
       LoadElem := Loads.First;
       WHILE LoadElem<>Nil DO  Begin
          Result[k] := LoadElem.Name;
          Inc(k);
          LoadElem := Loads.Next;
       End;
     End ;
end;

function TLoads.Get_First: Integer;
Var
   pLoad:TLoadObj;

Begin

   Result := 0;
   If ActiveCircuit <> Nil Then
   Begin
        pLoad := ActiveCircuit.Loads.First;
        If pLoad <> Nil Then
        Begin
          Repeat
            If pLoad.Enabled
            Then Begin
              ActiveCircuit.ActiveCktElement := pLoad;
              Result := 1;
            End
            Else pLoad := ActiveCircuit.Loads.Next;
          Until (Result = 1) or (pLoad = nil);
        End
        Else
            Result := 0;  // signify no more
   End;

end;

function TLoads.Get_idx: Integer;
begin
    if ActiveCircuit <> Nil then
       Result := ActiveCircuit.Loads.ActiveIndex
    else Result := 0;
end;

function TLoads.Get_Name: WideString;
Var
   pLoad:TLoadObj;

Begin
   Result := '';
   If ActiveCircuit <> Nil Then
   Begin
        pLoad := ActiveCircuit.Loads.Active;
        If pLoad <> Nil Then
          Result := pLoad.Name
        Else
            Result := '';  // signify no name
   End;

end;

function TLoads.Get_Next: Integer;
Var
   pLoad:TLoadObj;

Begin
   Result := 0;
   If ActiveCircuit <> Nil Then
   Begin
        pLoad := ActiveCircuit.Loads.Next;
        If pLoad <> Nil Then
        Begin
          Repeat
            If pLoad.Enabled
            Then Begin
              ActiveCircuit.ActiveCktElement := pLoad;
              Result := ActiveCircuit.Loads.ActiveIndex;
            End
            Else pLoad := ActiveCircuit.Loads.Next;
          Until (Result > 0) or (pLoad = nil);
        End
        Else
            Result := 0;  // signify no more
   End;

end;

procedure TLoads.Set_idx(Value: Integer);
Var
    pLoad:TLoadObj;
begin
    if ActiveCircuit <> Nil then   Begin
        pLoad := ActiveCircuit.Loads.Get(Value);
        If pLoad <> Nil Then ActiveCircuit.ActiveCktElement := pLoad;
    End;

end;

procedure TLoads.Set_Name(const Value: WideString);
VAR
    ActiveSave :integer;
    pLoad:TLoadObj;
    S: String;
    Found :Boolean;
Begin

  IF ActiveCircuit <> NIL
  THEN Begin      // Search list of Loads in active circuit for name
     WITH ActiveCircuit.Loads DO
       Begin
           S := Value;  // Convert to Pascal String
           Found := FALSE;
           ActiveSave := ActiveIndex;
           pLoad := First;
           While pLoad <> NIL Do
           Begin
              IF (CompareText(pLoad.Name, S) = 0)
              THEN Begin
                  ActiveCircuit.ActiveCktElement := pLoad;
                  Found := TRUE;
                  Break;
              End;
              pLoad := Next;
           End;
           IF NOT Found
           THEN Begin
               DoSimpleMsg('Load "'+S+'" Not Found in Active Circuit.', 5003);
               pLoad := Get(ActiveSave);    // Restore active Load
               ActiveCircuit.ActiveCktElement := pLoad;
           End;
       End;
  End;

end;

function TLoads.Get_kV: Double;
begin
   Result := 0.0;
   IF ActiveCircuit<> NIL THEN Begin
         WITH ActiveCircuit.Loads Do Begin
             IF ActiveIndex<>0 THEN Begin
                 Result := TLoadObj(Active).kVLoadBase;
             End;
         End;
   End;

end;

function TLoads.Get_kvar: Double;
begin
   Result := 0.0;
   IF ActiveCircuit<> NIL THEN Begin
         WITH ActiveCircuit.Loads Do Begin
             IF ActiveIndex<>0 THEN Begin
                 Result := TLoadObj(Active).kvarBase;
             End;
         End;
   End;
end;

function TLoads.Get_kW: Double;
begin
   Result := 0.0;
   IF ActiveCircuit<> NIL THEN Begin
         WITH ActiveCircuit.Loads Do Begin
             IF ActiveIndex<>0 THEN Begin
                 Result := TLoadObj(Active).kWBase;
             End;
         End;
   End;
end;

function TLoads.Get_PF: Double;
begin
   Result := 0.0;
   IF ActiveCircuit<> NIL THEN Begin
         WITH ActiveCircuit.Loads Do Begin
             IF ActiveIndex<>0 THEN Begin
                 Result := TLoadObj(Active).PFNominal;
             End;
         End;
   End;
end;

procedure TLoads.Set_kV(Value: Double);
begin
   IF ActiveCircuit<> NIL THEN Begin
         WITH ActiveCircuit.Loads Do Begin
             IF ActiveIndex<>0 THEN Begin
                  TLoadObj(Active).kVLoadBase := Value;
                  TLoadObj(Active).UpdateVoltageBases;  // side effectes
             End;
         End;
   End;
end;

procedure TLoads.Set_kvar(Value: Double);
begin
   IF ActiveCircuit<> NIL THEN Begin
         WITH ActiveCircuit.Loads Do Begin
             IF ActiveIndex<>0 THEN Begin
                  TLoadObj(Active).kvarBase := Value;
                  TLoadObj(Active).LoadSpecType := 1;
             End;
         End;
   End;
end;

procedure TLoads.Set_kW(Value: Double);
begin
   IF ActiveCircuit<> NIL THEN Begin
         WITH ActiveCircuit.Loads Do Begin
             IF ActiveIndex<>0 THEN Begin
                  TLoadObj(Active).kWBase := Value;
                  TLoadObj(Active).LoadSpecType := 0;
             End;
         End;
   End;
end;

procedure TLoads.Set_PF(Value: Double);
begin
   IF ActiveCircuit<> NIL THEN Begin
         WITH ActiveCircuit.Loads Do Begin
             IF ActiveIndex<>0 THEN Begin
                  TLoadObj(Active).PFNominal := Value;
             End;
         End;
   End;
end;

function TLoads.Get_Count: Integer;
begin
    If Assigned(ActiveCircuit) Then
       Result := ActiveCircuit.Loads.ListSize ;
end;

function TLoads.Get_AllocationFactor: Double;
var
  elem: TLoadObj;
begin
  Result := 0.0;
  elem := ActiveLoad;
  if elem <> nil then Result := elem.AllocationFactor;
end;

function TLoads.Get_Cfactor: Double;
var
  elem: TLoadObj;
begin
  Result := 0.0;
  elem := ActiveLoad;
  if elem <> nil then Result := elem.CFactor;
end;

function TLoads.Get_Class_: Integer;
var
  elem: TLoadObj;
begin
  Result := 0;
  elem := ActiveLoad;
  if elem <> nil then Result := elem.LoadClass;
end;

function TLoads.Get_CVRcurve: WideString;
var
  elem: TLoadObj;
begin
  Result := '';
  elem := ActiveLoad;
  if elem <> nil then Result := elem.CVRshape;
end;

function TLoads.Get_CVRvars: Double;
var
  elem: TLoadObj;
begin
  Result := 0.0;
  elem := ActiveLoad;
  if elem <> nil then Result := elem.CVRvars;
end;

function TLoads.Get_CVRwatts: Double;
var
  elem: TLoadObj;
begin
  Result := 0.0;
  elem := ActiveLoad;
  if elem <> nil then Result := elem.CVRwatts;
end;

function TLoads.Get_daily: WideString;
var
  elem: TLoadObj;
begin
  Result := '';
  elem := ActiveLoad;
  if elem <> nil then Result := elem.DailyShape;
end;

function TLoads.Get_duty: WideString;
var
  elem: TLoadObj;
begin
  Result := '';
  elem := ActiveLoad;
  if elem <> nil then Result := elem.DailyShape;
end;

function TLoads.Get_Growth: WideString;
var
  elem: TLoadObj;
begin
  Result := '';
  elem := ActiveLoad;
  if elem <> nil then Result := elem.GrowthShape;
end;

function TLoads.Get_IsDelta: WordBool;
var
  elem: TLoadObj;
begin
  Result := FALSE;
  elem := ActiveLoad;
  if elem <> nil then if elem.Connection > 0 then Result := TRUE;
end;

function TLoads.Get_kva: Double;
var
  elem: TLoadObj;
begin
  Result := 0.0;
  elem := ActiveLoad;
  if elem <> nil then Result := elem.kVABase;
end;

function TLoads.Get_kwh: Double;
var
  elem: TLoadObj;
begin
  Result := 0.0;
  elem := ActiveLoad;
  if elem <> nil then Result := elem.kWh;
end;

function TLoads.Get_kwhdays: Double;
var
  elem: TLoadObj;
begin
  Result := 0.0;
  elem := ActiveLoad;
  if elem <> nil then Result := elem.kWhDays;
end;

function TLoads.Get_Model: LoadModels;
var
  elem: TLoadObj;
begin
  Result := dssLoadConstPQ;
  elem := ActiveLoad;
  if elem <> nil then begin
    case elem.FLoadModel of
      1: Result := dssLoadConstPQ;
      2: Result := dssLoadConstZ;
      3: Result := dssLoadMotor;
      4: Result := dssLoadCVR;
      5: Result := dssLoadConstI;
      6: Result := dssLoadConstPFixedQ;
      7: Result := dssLoadConstPFixedX;
    end;
  end;
end;

function TLoads.Get_NumCust: Integer;
var
  elem: TLoadObj;
begin
  Result := 0;
  elem := ActiveLoad;
  if elem <> nil then Result := elem.NumCustomers;
end;

function TLoads.Get_PctMean: Double;
var
  elem: TLoadObj;
begin
  Result := 0.0;
  elem := ActiveLoad;
  if elem <> nil then Result := elem.puMean * 100.0;
end;

function TLoads.Get_PctStdDev: Double;
var
  elem: TLoadObj;
begin
  Result := 0.0;
  elem := ActiveLoad;
  if elem <> nil then Result := elem.puStdDev * 100.0;
end;

function TLoads.Get_Rneut: Double;
var
  elem: TLoadObj;
begin
  Result := 0.0;
  elem := ActiveLoad;
  if elem <> nil then Result := elem.Rneut;
end;

function TLoads.Get_Spectrum: WideString;
var
  elem: TLoadObj;
begin
  Result := '';
  elem := ActiveLoad;
  if elem <> nil then Result := elem.Spectrum;
end;

function TLoads.Get_Status: LoadStatus;
var
  elem: TLoadObj;
begin
  Result := dssLoadVariable;
  elem := ActiveLoad;
  if elem <> nil then begin
    if elem.ExemptLoad then
      Result := dssLoadExempt
    else if elem.FixedLoad then
      Result := dssLoadFixed;
  end;
end;

function TLoads.Get_Vmaxpu: Double;
var
  elem: TLoadObj;
begin
  Result := 0.0;
  elem := ActiveLoad;
  if elem <> nil then Result := elem.MaxPU;
end;

function TLoads.Get_Vminemerg: Double;
var
  elem: TLoadObj;
begin
  Result := 0.0;
  elem := ActiveLoad;
  if elem <> nil then Result := elem.MinEmerg;
end;

function TLoads.Get_Vminnorm: Double;
var
  elem: TLoadObj;
begin
  Result := 0.0;
  elem := ActiveLoad;
  if elem <> nil then Result := elem.MinNormal;
end;

function TLoads.Get_Vminpu: Double;
var
  elem: TLoadObj;
begin
  Result := 0.0;
  elem := ActiveLoad;
  if elem <> nil then Result := elem.MinPU;
end;

function TLoads.Get_xfkVA: Double;
var
  elem: TLoadObj;
begin
  Result := 0.0;
  elem := ActiveLoad;
  if elem <> nil then Result := elem.ConnectedkVA;
end;

function TLoads.Get_Xneut: Double;
var
  elem: TLoadObj;
begin
  Result := 0.0;
  elem := ActiveLoad;
  if elem <> nil then Result := elem.Xneut;
end;

function TLoads.Get_Yearly: WideString;
var
  elem: TLoadObj;
begin
  Result := '';
  elem := ActiveLoad;
  if elem <> nil then Result := elem.YearlyShape;
end;

procedure TLoads.Set_AllocationFactor(Value: Double);
begin
  Set_Parameter ('AllocationFactor', FloatToStr (Value));
end;

procedure TLoads.Set_Cfactor(Value: Double);
begin
  Set_Parameter ('Cfactor', FloatToStr (Value));
end;

procedure TLoads.Set_Class_(Value: Integer);
begin
  Set_Parameter ('Class', IntToStr (Value));
end;

procedure TLoads.Set_CVRcurve(const Value: WideString);
begin
  Set_Parameter ('CVRcurve', Value);
end;

procedure TLoads.Set_CVRvars(Value: Double);
begin
  Set_Parameter ('CVRvars', FloatToStr (Value));
end;

procedure TLoads.Set_CVRwatts(Value: Double);
begin
  Set_Parameter ('CVRwatts', FloatToStr (Value));
end;

procedure TLoads.Set_daily(const Value: WideString);
begin
  Set_Parameter ('Daily', Value);
end;

procedure TLoads.Set_duty(const Value: WideString);
begin
  Set_Parameter ('Duty', Value);
end;

procedure TLoads.Set_Growth(const Value: WideString);
begin
  Set_Parameter ('Growth', Value);
end;

procedure TLoads.Set_IsDelta(Value: WordBool);
var
  elem: TLoadObj;
begin
  elem := ActiveLoad;
  if elem <> nil then elem.Connection := Integer (Value);
end;

procedure TLoads.Set_kva(Value: Double);
begin
  Set_Parameter ('kva', FloatToStr (Value));
end;

procedure TLoads.Set_kwh(Value: Double);
begin
  Set_Parameter ('kwh', FloatToStr (Value));
end;

procedure TLoads.Set_kwhdays(Value: Double);
begin
  Set_Parameter ('kwhdays', FloatToStr (Value));
end;

procedure TLoads.Set_Model(Value: LoadModels);
var
  elem: TLoadObj;
begin
  elem := ActiveLoad;
  if elem <> nil then elem.FLoadModel := Value; // enums match the integer codes
end;

procedure TLoads.Set_NumCust(Value: Integer);
begin
  Set_Parameter ('NumCust', IntToStr (Value));
end;

procedure TLoads.Set_PctMean(Value: Double);
begin
  Set_Parameter ('%mean', FloatToStr (Value));
end;

procedure TLoads.Set_PctStdDev(Value: Double);
begin
  Set_Parameter ('%stddev', FloatToStr (Value));
end;

procedure TLoads.Set_Rneut(Value: Double);
begin
  Set_Parameter ('Rneut', FloatToStr (Value));
end;

procedure TLoads.Set_Spectrum(const Value: WideString);
begin
  Set_Parameter ('Spectrum', Value);
end;

procedure TLoads.Set_Status(Value: LoadStatus);
begin
  case Value of
    dssLoadVariable: Set_Parameter('status', 'v');
    dssLoadFixed: Set_Parameter('status', 'f');
    dssLoadExempt: Set_Parameter('status', 'e');
  end;
end;

procedure TLoads.Set_Vmaxpu(Value: Double);
begin
  Set_Parameter ('VmaxPu', FloatToStr (Value));
end;

procedure TLoads.Set_Vminemerg(Value: Double);
begin
  Set_Parameter ('VminEmerg', FloatToStr (Value));
end;

procedure TLoads.Set_Vminnorm(Value: Double);
begin
  Set_Parameter ('VminNorm', FloatToStr (Value));
end;

procedure TLoads.Set_Vminpu(Value: Double);
begin
  Set_Parameter ('VminPu', FloatToStr (Value));
end;

procedure TLoads.Set_xfkVA(Value: Double);
begin
  Set_Parameter ('XfKVA', FloatToStr (Value));
end;

procedure TLoads.Set_Xneut(Value: Double);
begin
  Set_Parameter ('Xneut', FloatToStr (Value));
end;

procedure TLoads.Set_Yearly(const Value: WideString);
begin
  Set_Parameter ('Yearly', Value);
end;

initialization
  TAutoObjectFactory.Create(ComServer, TLoads, Class_Loads,
    ciInternal, tmApartment);
end.
