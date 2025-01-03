unit dm;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs,
  FireDAC.Phys.SQLiteWrapper.Stat, FireDAC.VCLUI.Wait, FireDAC.Comp.Client,
  Data.DB, REST.Types, REST.Client, Data.Bind.Components, Data.Bind.ObjectScope;

type
  Tbd = class(TDataModule)
    con1: TFDConnection;
    FDTransaction1: TFDTransaction;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  bd: Tbd;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

end.
