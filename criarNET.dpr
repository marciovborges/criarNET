program criarNET;

{$R *.dres}

uses
  Forms,
  Unit1 in 'Unit1.pas' {toPajek},
  Unit2 in 'Unit2.pas' {info},
  Unit3 in 'Unit3.pas' {Form3};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'criar.net';
  Application.CreateForm(TtoPajek, toPajek);
  Application.CreateForm(Tinfo, info);
  Application.CreateForm(TForm3, Form3);
  Application.Run;
end.
