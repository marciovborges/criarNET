unit Unit2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls,
  Vcl.Imaging.pngimage, Vcl.ExtCtrls, Clipbrd;

type
  Tinfo = class(TForm)
    Image1: TImage;
    Label1: TLabel;
    Label6: TLabel;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    RichEditGuia: TRichEdit;
    RichEditApresenta: TRichEdit;
    RichEditExemplo1: TRichEdit;
    RichEditExemplo2: TRichEdit;
    TabSheet5: TTabSheet;
    RichEditVersao: TRichEdit;
    Panel1: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    procedure FormShow(Sender: TObject);
    procedure Label9Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  info: Tinfo;

implementation

{$R *.dfm}

procedure Tinfo.FormShow(Sender: TObject);
begin

// RichEditInfo.Sellength := Length(RichEditInfo.Lines[0]);
// RichEditInfo.SelAttributes.Style := [fsBold];
// RichEditInfo.Paragraph.Alignment := taCenter;
// RichEditInfo.SelAttributes.Size := 11;

 RichEditGuia.SelStart := 0;
 with RichEditGuia do selStart := Perform(EM_LINEINDEX, 0,0);

 RichEditApresenta.SelStart := 0;
 with RichEditApresenta do selStart := Perform(EM_LINEINDEX, 0,0);

 RichEditExemplo1.SelStart := 0;
 with RichEditExemplo1 do selStart := Perform(EM_LINEINDEX, 0,0);

 RichEditExemplo2.SelStart := 0;
 with RichEditExemplo2 do selStart := Perform(EM_LINEINDEX, 0,0);

 RichEditVersao.SelStart := 0;
 with RichEditVersao do selStart := Perform(EM_LINEINDEX, 0,0);

end;

procedure Tinfo.Label9Click(Sender: TObject);
begin
 Clipboard.asText := label7.Caption;
 Showmessage('Referência copiada!');
end;

end.
