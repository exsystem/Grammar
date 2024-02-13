unit ASTBINTF;

interface

type
  TRegisterTermRule = procedure(Name: PChar);
  TGetMode = function: PChar;
  TGetTokenKind = function: PChar;
  TGetTokenValue = function: PChar;
  TInsertToken = procedure(Kind, Value: PChar);
  TPopMode = procedure;

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
