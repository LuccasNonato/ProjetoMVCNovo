unit uFuncoes;

interface

uses
  System.SysUtils, System.JSON, REST.Client, Data.Bind.Components, Data.Bind.ObjectScope, REST.Types,
  Vcl.Dialogs, Vcl.Forms, Vcl.Controls, Vcl.StdCtrls, System.RegularExpressions, system.Classes;

  type

     TFunctions = class
       private

       public
       FLogradouro  : string;
       FComplemento : string;
       FBairro      : string;
       FLocalidade  : string;
       FUF          : string;
       FIBGE        : string;
       FGia         : string;
       Fddd         : string;
       Fsiafi       : string;
       Function BuscarCEP(CEP: string): boolean;
       procedure LimparTodosEdits(AFormulario: TForm);
       function  ValidarCPF(const CPF: string): Boolean;
       function  ValidarEmail(const Email: string): Boolean;
       function  ValidarRG(const RG: string): Boolean;
       function  ValidarTelefone(const Telefone: string): Boolean;
       function  VerificarCamposEmBranco(Form: TForm): Boolean;
     end;

implementation

{ TControllerUsuarios }

function TFunctions.BuscarCEP(CEP: string): Boolean;
var
  RESTClient: TRESTClient;
  RESTRequest: TRESTRequest;
  RESTResponse: TRESTResponse;
  JSONValue: TJSONValue;
  Erro : Boolean;
  FMenssagem: string;
begin
  if Length(CEP) < 8 then
  begin
    ShowMessage('Erro ao consultar CEP, verifique se o CEP digitado está correto');
    Result := False;
    exit;
  end;


  RESTClient := TRESTClient.Create('https://viacep.com.br/ws/');
  RESTRequest := TRESTRequest.Create(nil);
  RESTResponse := TRESTResponse.Create(nil);
  FMenssagem := 'CEP não encontrado ou inválido.';
  Erro := JSONValue.GetValue<Boolean>('erro', False);

  try
    RESTRequest.Client := RESTClient;
    RESTRequest.Response := RESTResponse;
    RESTRequest.Resource := Format('%s/json/', [CEP]);

    RESTRequest.Execute;

    if RESTResponse.StatusCode = 200 then
    begin
      JSONValue := TJSONObject.ParseJSONValue(RESTResponse.Content);

      if Erro then
      showmessage(FMenssagem);

      if Assigned(JSONValue) then
      begin
        Erro := JSONValue.GetValue<Boolean>('erro', False);

        if Erro then
        begin
         showmessage(FMenssagem);
         exit;
         Result := False;
        end;


        FLogradouro := JSONValue.GetValue<string>('logradouro');
        FComplemento := JSONValue.GetValue<string>('complemento');
        FBairro := JSONValue.GetValue<string>('bairro');
        FLocalidade := JSONValue.GetValue<string>('localidade');
        FUF := JSONValue.GetValue<string>('uf');
        FIBGE := JSONValue.GetValue<string>('ibge');
        FGia := JSONValue.GetValue<string>('gia');
        Fddd := JSONValue.GetValue<string>('ddd');
        Fsiafi := JSONValue.GetValue<string>('siafi');

        Result := True;
      end
      else
      begin
        showmessage(FMenssagem);
        Result := False;
      end;
    end
    else
    begin
      ShowMessage('Erro ao consultar CEP, verifique se as informações estão corretas ' + #13 +
      'LOG: ' + RESTResponse.StatusText);
    end;

  finally
    RESTClient.Free;
    RESTRequest.Free;
    RESTResponse.Free;
  end;
end;

procedure TFunctions.LimparTodosEdits(AFormulario: TForm);
var
  i: Integer;
  Controle: TControl;
begin
  for i := 0 to AFormulario.ControlCount - 1 do
  begin
    Controle := AFormulario.Controls[i];

    if Controle is TEdit then
      TEdit(Controle).Clear;
  end;
end;

function TFunctions.ValidarCPF(const CPF: string): Boolean;
var
  i, Soma, Resto: Integer;
  Digito1, Digito2: Integer;
  CPFNumeros: string;
begin
  Result := False;

  CPFNumeros := '';
  for i := 1 to Length(CPF) do
  begin
    if CPF[i] in ['0'..'9'] then
      CPFNumeros := CPFNumeros + CPF[i];
  end;

  if Length(CPFNumeros) <> 11 then
    Exit;

  if (CPFNumeros = StringOfChar(CPFNumeros[1], 11)) then
    Exit;

  Soma := 0;
  for i := 1 to 9 do
    Soma := Soma + StrToInt(CPFNumeros[i]) * (11 - i);

  Resto := Soma mod 11;
  if (Resto < 2) then
    Digito1 := 0
  else
    Digito1 := 11 - Resto;

  Soma := 0;
  for i := 1 to 10 do
    Soma := Soma + StrToInt(CPFNumeros[i]) * (12 - i);

  Resto := Soma mod 11;
  if (Resto < 2) then
    Digito2 := 0
  else
    Digito2 := 11 - Resto;

  if (StrToInt(CPFNumeros[10]) = Digito1) and (StrToInt(CPFNumeros[11]) = Digito2) then
    Result := True;
end;

function TFunctions.ValidarEmail(const Email: string): Boolean;
var
  Regex: TRegEx;
begin
  Regex := TRegEx.Create('^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');

  Result := Regex.IsMatch(Email);
end;

function TFunctions.ValidarRG(const RG: string): Boolean;
var
  i: Integer;
begin
  var RGLimpo := RG;
  RGLimpo := StringReplace(RGLimpo, '.', '', [rfReplaceAll]);
  RGLimpo := StringReplace(RGLimpo, '-', '', [rfReplaceAll]);
  RGLimpo := Trim(RGLimpo);

  if (Length(RGLimpo) < 7) or (Length(RGLimpo) > 9) then
  begin
    Result := False;
    Exit;
  end;

  for i := 1 to Length(RGLimpo) do
  begin
    if not (RGLimpo[i] in ['0'..'9', 'A'..'Z']) then
    begin
      Result := False;
      Exit;
    end;
  end;

  Result := True;
end;

function TFunctions.ValidarTelefone(const Telefone: string): Boolean;
var
  Regex: TRegEx;
begin
  Regex := TRegEx.Create('^\(\d{2}\)\s?\d{4,5}-\d{4}$');

  Result := Regex.IsMatch(Telefone);
end;

function TFunctions.VerificarCamposEmBranco(Form: TForm): Boolean;
var
  i: Integer;
  Ctrl: TComponent;
begin
  Result := True;

  for i := 0 to Form.ComponentCount - 1 do
  begin
    Ctrl := Form.Components[i];

    if Ctrl is TEdit then
    begin
      if TEdit(Ctrl).Text = '' then
      begin
        TEdit(Ctrl).SetFocus;
        Result := False;
        Exit;
      end;
    end;
  end;

end;

end.
