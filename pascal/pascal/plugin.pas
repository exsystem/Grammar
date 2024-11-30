Unit plugin;
{$mode delphi}

Interface

Uses
  ASTBINTF;

Procedure Init(Context: PContext); Cdecl;
Procedure ProcessToken(Context: PContext); Cdecl;

Implementation

Uses
  SysUtils;

Var
  mHereDocId: PChar;

Function SubStr(S: PChar; FromIndex: Integer; Len: Integer): PChar;
Begin
  Result := StrAlloc(Len + 1);
  Move(S[FromIndex], Result[0], Len * SizeOf(Char));
  Result[Len] := #0;
End;

Procedure Init(Context: PContext); Cdecl;
Begin
  Context^.RegisterTermRule(PChar('@HEREDOC_END'));
End;

Procedure ProcessToken(Context: PContext); Cdecl;
Var
  mMode, mTokenValue, mTokenKind: PChar;
Begin
  mMode := Context^.GetMode;
  mTokenValue := Context^.GetTokenValue;
  mTokenKind := Context^.GetTokenKind;
  If StrComp(mMode, PChar('hereDoc')) <> 0 Then
  Begin
    exit;
  End;
  If StrComp(mTokenKind, PChar('START_HEREDOC')) = 0 Then
  Begin
    mHereDocId := SubStr(mTokenValue, 3, StrLen(mTokenValue) - 3);
    exit;
  End;
  If (StrComp(mTokenKind, PChar('HEREDOC_TEXT')) = 0) And
    (StrPos(mTokenValue, mHereDocId) = mTokenValue) Then
  Begin
    Context^.InsertToken(PChar('@HEREDOC_END'), mHereDocId);
    Context^.PopMode;
    StrDispose(mHereDocId);
    exit;
  End;
End;

End.
