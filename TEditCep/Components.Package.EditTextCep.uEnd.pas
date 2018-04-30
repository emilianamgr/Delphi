unit Components.Package.EditTextCep.uEnd;

interface

type
  IEndereco = interface
    ['{EDB26F70-E7DB-4ECB-8A81-043CB3BB70BC}']
  end;

type
TEndereco = class(TInterfacedObject, IEndereco)
private
    FIbge: Integer;
    FBairro: string;
    FUF: string;
    FCep: string;
    FNumero: string;
    FComplemento: string;
    FLocalidade: string;
    FLogradouro: string;
    procedure SetBairro(const Value: string);
    procedure SetCep(const Value: string);
    procedure SetLocalidade(const Value: string);
    procedure SetComplemento(const Value: string);
    procedure SetIbge(const Value: Integer);
    procedure SetNumero(const Value: string);
    procedure SetLogradouro(const Value: string);
    procedure SetUF(const Value: string);
  { private declarations }
protected
  { protected declarations }
public
  function ToString: string;
  { public declarations }
published
  property Cep: string read FCep write SetCep;
  property Logradouro: string read FLogradouro write SetLogradouro;
  property Bairro: string read FBairro write SetBairro;
  property Numero: string read FNumero write SetNumero;
  property Localidade: string read FLocalidade write SetLocalidade;
  property UF: string read FUF write SetUF;
  property Complemento: string read FComplemento write SetComplemento;
  property Ibge: Integer read FIbge write SetIbge;
  { published declarations }
end;
implementation

uses
  Components.Package.EditTextCep.uEditCep;

{ TEndereco }

procedure TEndereco.SetBairro(const Value: string);
begin
  FBairro := Value;
end;

procedure TEndereco.SetCep(const Value: string);
begin
  FCep := Value;
end;

procedure TEndereco.SetLocalidade(const Value: string);
begin
  FLocalidade := Value;
end;

procedure TEndereco.SetComplemento(const Value: string);
begin
  FComplemento := Value;
end;

procedure TEndereco.SetIbge(const Value: Integer);
begin
  FIbge := Value;
end;

procedure TEndereco.SetNumero(const Value: string);
begin
  FNumero := Value;
end;

procedure TEndereco.SetLogradouro(const Value: string);
begin
  FLogradouro := Value;
end;

procedure TEndereco.SetUF(const Value: string);
begin
  FUF := Value;
end;

function TEndereco.ToString: string;
begin
  Result := Self.Logradouro + ', ' +
            Self.Numero + ' - ' +
            Self.Bairro + ', ' +
            Self.Localidade + ' - ' +
            Self.UF + ' ' ;
end;

end.
