unit ASTBINTF;

interface

type
  TRegisterTermRule = procedure(Name: PChar); cdecl;
  TGetMode = function: PChar; cdecl;
  TGetTokenKind = function: PChar; cdecl;
  TGetTokenValue = function: PChar; cdecl;
  TInsertToken = procedure(Kind, Value: PChar); cdecl;
  TPopMode = procedure; cdecl;

  PContext = ^TContext;
  TContext = record
    RegisterTermRule: TRegisterTermRule;
    GetMode: TGetMode;
    GetTokenKind: TGetTokenKind;
    GetTokenValue: TGetTokenValue;
    InsertToken: TInsertToken;
    PopMode: TPopMode;
  end;

implementation

end.
