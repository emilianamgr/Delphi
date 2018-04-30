unit Components.Package.StringGridObject.uEditor;


interface

uses
  Vcl.Grids, System.Classes;

type
  TStringEditor = class(TInplaceEdit)

  private
    function UpDateObject: Boolean;
    { private declarations }
  protected
    procedure KeyDown
    (var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char); override;
    procedure UpdateContents; override;
    function Update: Boolean;
    { protected declarations }
  public
    constructor Create(AOwner: TComponent); override;
    procedure EditorExit(Sender: TObject);
    function ForcarUpdate: Boolean;
    { public declarations }

  published
    { published declarations }

  end;

implementation

uses
   Vcl.Forms, Winapi.Windows, Components.Package.StringGridObject.uStringGrid;

{ TStringEditor }

{ TEditor }

constructor TStringEditor.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Self.OnExit := EditorExit;
  ParentCtl3D := false;
  Ctl3D := false;
  TabStop := false;
  BorderStyle := bsNone;
  DoubleBuffered := false;
end;

procedure TStringEditor.EditorExit(Sender: TObject);
begin
  Self.Update;
end;

function TStringEditor.ForcarUpdate: Boolean;
begin
  Result := True;
  if Assigned(Self.Owner) then
  begin
    if TStringGridObject(Self.Owner).EditorMode then
    begin
      Result := Update;
    end;
  end;
end;

procedure TStringEditor.KeyDown(var Key: Word; Shift: TShiftState);
begin
  case Key of
    VK_UP, VK_DOWN, VK_PRIOR, VK_NEXT, VK_ESCAPE, VK_TAB:

      if not UpDateObject then
        TStringGridObject(Self.Owner).CancelEdit;
  end;

  inherited;
end;

procedure TStringEditor.KeyPress(var Key: Char);
begin

  if (Key = #13) then
  begin
    if UpDateObject then
    begin
      inherited;
      TStringGridObject(Self.Owner).EditorMode := false;
    end
    else
      TStringGridObject(Self.Owner).CancelEdit;

  end
  else if Key = #27 then
    TStringGridObject(Self.Owner).CancelEdit
  else if Key = #8 then
    Self.SelectAll
  else
  begin
    inherited;
    case TStringGridObject(Self.Owner).Columns.Items[TStringGridObject(Self.Owner).Col].ColType of
      ctInteger, ctNumeric:
        begin
          if not(Key in ['0' .. '9']) then
            Key := #0;
        end;
      ctFloat:
        begin
          if not(Key in ['0' .. '9', ',']) then
            Key := #0;
        end
    else
      inherited;
      // ctDate: ;
      // ctString: ;
      // ctBoolean: ;
    end;
  end;
end;

function TStringEditor.Update: Boolean;
begin
  Result := false;
  if Assigned(Self.Grid) then
  begin
    if TStringGridObject(Self.Grid).EditorMode then
    begin
      if TStringGridObject(Self.Grid).Cells[TStringGridObject(Self.Grid).Col, TStringGridObject(Self.Grid).Row] <> TStringGridObject(Self.Grid).FOldValue then
      begin
        Result := UpDateObject;
      end;
    end;
  end;
end;

procedure TStringEditor.UpdateContents;
begin
  if TStringGridObject(Self.Grid).FOldValue = '?' then
    TStringGridObject(Self.Grid).FOldValue := TStringGridObject(Self.Grid).Cells[TStringGridObject(Self.Grid).Col, TStringGridObject(Self.Grid).Row];
  inherited;
end;

function TStringEditor.UpDateObject: Boolean;
var
  CanUpDate: Boolean;
  valorCampo: string;
begin
  CanUpDate := True;

  valorCampo := Self.Text;

  if Assigned(TStringGridObject(Self.Grid).OnEditEvent) then
  begin
    TStringGridObject(Self.Grid).OnEditEvent(TStringGridObject(Self.Grid), TStringGridObject(Self.Grid).Col, TStringGridObject(Self.Grid).Row, valorCampo);

    Self.Text := valorCampo
  end;

  if Assigned(TStringGridObject(Self.Grid).OnValidateEdit) then
    TStringGridObject(Self.Grid).OnValidateEdit(TStringGridObject(Self.Grid), TStringGridObject(Self.Grid).Col, TStringGridObject(Self.Grid).Row, Self.Text, CanUpDate);

  if CanUpDate then
    TStringGridObject(Self.Grid).UpdateObjectRow(TStringGridObject(Self.Grid).Col, TStringGridObject(Self.Grid).Row, Self.Text);

  Result := CanUpDate;
end;

end.
