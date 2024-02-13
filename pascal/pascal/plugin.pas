unit plugin;
{$mode delphi}

interface

uses
  ASTBINTF;

procedure Init(Context: PContext);
procedure ProcessToken(Context: PContext);

implementation

uses
  SysUtils;

function SubStr(S: PChar; FromIndex: integer; Len: integer): PChar;
begin
  Result := StrAlloc(Len + 1);
  Move(S[FromIndex], Result[0], Len * SizeOf(char));
  Result[Len] := #0;
end;

procedure Init(Context: PContext);
begin
  Context^.RegisterTermRule('@HEREDOC_END');
end;

procedure ProcessToken(Context: PContext);
var
  mMode, mTokenValue, mTokenKind: PChar;
  mHereDocId: PChar;
begin
  mMode := Context^.GetMode;
  mTokenValue := Context^.GetTokenValue;
  mTokenKind := Context^.GetTokenKind;
  if StrComp(mMode, 'hereDoc') <> 0 then
    exit;
  if StrComp(mTokenKind, 'START_HEREDOC') = 0 then
  begin
    mHereDocId := SubStr(mTokenValue, 3, StrLen(mTokenValue) - 3);
    exit;
  end;
  if (StrComp(mTokenKind, 'HEREDOC_TEXT') = 0) and
    (StrPos(mTokenValue, mHereDocId) = mTokenValue) then
  begin
    Context^.InsertToken('@HEREDOC_END', mHereDocId);
    Context^.PopMode;
    StrDispose(mHereDocId);
    exit;
  end;
end;

end.
