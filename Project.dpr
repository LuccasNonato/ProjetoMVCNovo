program Project;

uses
  Vcl.Forms,
  view in 'view\view.pas' {Form1},
  uDataModule in 'model\uDataModule.pas' {dm: TDataModule},
  model.pessoas in 'model\model.pessoas.pas',
  entidade.Pessoas in 'model\entidade.Pessoas.pas',
  controller.Pessoas in 'controller\controller.Pessoas.pas',
  uFuncoes in 'funcoes\uFuncoes.pas',
  entidade.log in 'model\entidade.log.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(Tdm, dm);
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
