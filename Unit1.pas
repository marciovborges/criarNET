unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, Grids, Vcl.ExtCtrls, Vcl.Samples.Gauges, FileCtrl,
  IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, IdHTTP, wininet,
  Vcl.Menus;

type
  TtoPajek = class(TForm)
    GroupBoxArquivo: TGroupBox;
    ButtonEntrada: TButton;
    ButtonSaida: TButton;
    EditEntrada: TEdit;
    EditSaida: TEdit;
    OpenDialogArquivo: TOpenDialog;
    PageControlES: TPageControl;
    TabSheetEntrada: TTabSheet;
    TabSheetSaida: TTabSheet;
    ButtonTXT: TButton;
    ButtonInfo: TButton;
    RichEditEntrada: TRichEdit;
    RadioGroupSeparador: TRadioGroup;
    EditSeparador: TEdit;
    GroupBox1: TGroupBox;
    Label3: TLabel;
    Label1: TLabel;
    GroupBox2: TGroupBox;
    TabSheet1: TTabSheet;
    GroupBoxSaida: TGroupBox;
    GroupBox3: TGroupBox;
    CheckBoxInicio: TCheckBox;
    CheckBoxFim: TCheckBox;
    CheckBoxToda: TCheckBox;
    CheckBoxCaseSensitive: TCheckBox;
    GroupBoxOpcoes: TGroupBox;
    LabelPriCo: TLabel;
    LabelSegCo: TLabel;
    LabelModo: TLabel;
    LabelTipo: TLabel;
    LabelValor: TLabel;
    LabelDesprezar: TLabel;
    ComboBoxPriCo: TComboBox;
    ComboBoxSegCo: TComboBox;
    ComboBoxModo: TComboBox;
    ComboBoxTipo: TComboBox;
    ComboBoxValor: TComboBox;
    EditDesprezar: TEdit;
    UpDownDesprezar: TUpDown;
    ComboBoxSuprimir: TComboBox;
    CheckBoxOrdem: TCheckBox;
    RichEditSaida: TRichEdit;
    TimerMSG: TTimer;
    IdHTTP1: TIdHTTP;
    CheckBoxSimilaridade: TCheckBox;
    EditSimilaridade: TEdit;
    Label2: TLabel;
    UpDownSimilaridade: TUpDown;
    RichEditSimilaridade: TRichEdit;
    RadioGroupOrganizacao: TRadioGroup;
    RichEditLinhas: TRichEdit;
    LabelMetodo: TLabel;
    ComboBoxMetodo: TComboBox;
    ButtonReset: TButton;
    Label4: TLabel;
    ComboBoxFuncaoPeso: TComboBox;
    procedure ButtonTXTClick(Sender: TObject);
    procedure EditSeparadorChange(Sender: TObject);
    procedure ComboBoxPriCoChange(Sender: TObject);
    procedure ComboBoxSegCoChange(Sender: TObject);
    procedure ButtonEntradaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Esconde;
    procedure Mostra;
    procedure ResetaOpcoes;
    procedure ComboBoxModoChange(Sender: TObject);
    procedure ComboBoxValorChange(Sender: TObject);
    procedure MarcaPalavra(RichEdit: TRichEdit; TextoAbuscar: string; cor: TColor);
    procedure CarregaEntrada;
    procedure RadioGroupSeparadorClick(Sender: TObject);
    procedure ButtonSaidaClick(Sender: TObject);
    function SuprimirCaractere(palavra:string):string;
    procedure ButtonInfoClick(Sender: TObject);
    procedure PageControlESChange(Sender: TObject);
    procedure RadioGroupOrganizacaoClick(Sender: TObject);
    procedure ButtonResetClick(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  toPajek: TtoPajek;
  Arquivo, ArquivoTemporario, ArquivoTemporarioSE, ArquivoLog: TextFile;
  Linha, ArquivoEntrada, ArquivoSaida, ArquivoTemp, ArquivoSaidaSE: String;
  Separador: Char;
  ContaTAB, PrimeiraColuna, SegundaColuna, ColunaValor, desprezaLinha: Integer;
  corMSG:boolean;
  F: TForm;
  MSG: Tlabel;


implementation

{$R *.dfm}

uses Unit2, Unit3;

procedure  TtoPajek.MarcaPalavra(RichEdit: TRichEdit; TextoAbuscar: string; cor: TColor);
var
  FoundAt: LongInt;
  StartPos, StartPos2, ToEnd: Integer;
begin
 while StartPos <> StartPos2 do
  begin
   StartPos2:=StartPos;
   with RichEdit do
    begin
     if SelLength <> 0 then StartPos := SelStart + SelLength
     else StartPos := 0;
     ToEnd := Length(Text) - StartPos;
     FoundAt := FindText(TextoAbuscar, StartPos, ToEnd, [stMatchCase]);
     if FoundAt <> -1 then
      begin
       SelStart := FoundAt;
       SelLength := Length(TextoAbuscar);
       RichEdit.SelAttributes.Color := cor;
       RichEdit.SelAttributes.Style := [fsBold];
      end;
    end;
  end;
end;

Function ExtraiNome(const Filename: String): String;
var
 aExt : String;
 aPos : Integer;
begin
 aExt := ExtractFileExt(Filename);
 Result := ExtractFileName(Filename);
 if aExt <> '' then
  begin
   aPos := Pos(aExt,Result);
    if aPos > 0 then
     begin
      Delete(Result,aPos,Length(aExt));
     end;
  end;
end;

procedure TtoPajek.ButtonInfoClick(Sender: TObject);
begin
 info.show;
end;

procedure TtoPajek.ButtonResetClick(Sender: TObject);
begin
if MessageBox(Handle, 'Esta função reinicia todas as configurações que você selecionou para gerar a sua rede, deseja continuar?', 'Confirmação', MB_ICONQUESTION + MB_YESNO) = ID_NO then exit;
EditEntrada.Text := '';
EditSaida.Text := '';

resetaopcoes();
esconde();


RadioGroupOrganizacao.ItemIndex := 0;
RadioGroupSeparador.ItemIndex := -1;

RichEditEntrada.Clear;

ComboBoxSuprimir.Text := '';
CheckBoxInicio.Checked := false;
CheckBoxFim.Checked := false;
CheckBoxToda.Checked := false;
CheckBoxOrdem.Checked := false;
CheckBoxCaseSensitive.Checked := false;
CheckBoxsimilaridade.Checked := false;
EditSimilaridade.Text := '80';

ComboBoxPriCo.Text := '';
ComboBoxSegCo.Text := '';
ComboBoxValor.Text := '';
ComboBoxModo.Text := '';
ComboBoxTipo.Text := '';
ComboBoxMetodo.Text := '';
EditDesprezar.Text := '0';

RichEditSaida.Clear;
RichEditSimilaridade.Clear;
RichEditLinhas.Clear;

Label3.Caption := 'Quantidade de linhas do arquivo: 0';
end;

procedure TtoPajek.ButtonSaidaClick(Sender: TObject);
var
SelDir: String;
begin
 SelectDirectory('Selecione um diretório...', 'C:\', SelDir);
 EditSaida.Text := SelDir+'\';
 EditSaida.SetFocus;
end;


function DamerauLevenshteinDistance(const Str1, Str2: String): Integer;

  function Min(const A, B, C: Integer): Integer;
  begin
    Result := A;
    if B < Result then
      Result := B;
    if C < Result then
      Result := C;
  end;

var
  LenStr1, LenStr2: Integer;
  I, J, T, Cost, PrevCost: Integer;
  pStr1, pStr2, S1, S2: PChar;
  D: PIntegerArray;
begin
  LenStr1 := Length(Str1);
  LenStr2 := Length(Str2);

  // save a bit memory by making the second index points to the shorter string
  if LenStr1 < LenStr2 then
  begin
    T := LenStr1;
    LenStr1 := LenStr2;
    LenStr2 := T;
    pStr1 := PChar(Str2);
    pStr2 := PChar(Str1);
  end
  else
  begin
    pStr1 := PChar(Str1);
    pStr2 := PChar(Str2);
  end;

  // bypass leading identical characters
  while (LenStr2 <> 0) and (pStr1^ = pStr2^) do
  begin
    Inc(pStr1);
    Inc(pStr2);
    Dec(LenStr1);
    Dec(LenStr2);
  end;

  // bypass trailing identical characters
  while (LenStr2 <> 0) and ((pStr1 + LenStr1 - 1)^ = (pStr2 + LenStr2 - 1)^) do
  begin
    Dec(LenStr1);
    Dec(LenStr2);
  end;

  // is the shorter string empty? so, the edit distance is length of the longer one
  if LenStr2 = 0 then
  begin
    Result := LenStr1;
    Exit;
  end;

  // calculate the edit distance
  GetMem(D, (LenStr2 + 1) * SizeOf(Integer));

  for I := 0 to LenStr2 do
    D[I] := I;

  S1 := pStr1;
  for I := 1 to LenStr1 do
  begin
    PrevCost := I - 1;
    Cost := I;
    S2 := pStr2;
    for J := 1 to LenStr2 do
    begin
      if (S1^ = S2^) or ((I > 1) and (J > 1) and (S1^ = (S2 - 1)^) and (S2^ = (S1 - 1)^)) then
        Cost := PrevCost
      else
        Cost := 1 + Min(Cost, PrevCost, D[J]);
      PrevCost := D[J];
      D[J] := Cost;
      Inc(S2);
    end;
    Inc(S1);
  end;
  Result := D[LenStr2];
  FreeMem(D);
end;

function StringSimilarityRatio(const Str1, Str2: String; IgnoreCase: Boolean): Double;
var
  MaxLen: Integer;
  Distance: Integer;
begin
  Result := 1.0;
  if Length(Str1) > Length(Str2) then
    MaxLen := Length(Str1)
  else
    MaxLen := Length(Str2);
  if MaxLen <> 0 then
  begin
    if IgnoreCase then
      Distance := DamerauLevenshteinDistance(LowerCase(Str1), LowerCase(Str2))
    else
      Distance := DamerauLevenshteinDistance(Str1, Str2);
    Result := Result - (Distance / MaxLen);
  end;
end;



procedure TtoPajek.ButtonTXTClick(Sender: TObject);
var
 i, j, l, m, x, idx1, idx2, contaSimilaridade, index: integer;
 Colunas, vertice, vertice2modo, aresta, verticeDEF, vertice2modoDEF, arestaDEF, Linhas, LinhasAux, peso: TStringList;
 modo, valor, ajustaVertice, arquivoSimilaridade, Cabecalho: string;
 Borda: TShape;
 MarcaMeio: boolean;
 valorSimilaridade: double;

begin
 MarcaMeio := false;
 F := TForm.Create(Application);
 F.BorderStyle := bsNone;
 F.Position := poMainFormCenter;
 F.Width := 400;
 F.Height := 84;

 Borda := TShape.Create(Application);
 Borda.Parent := F;
 Borda.Align := alClient;
 Borda.Brush.Color := clBlack;

 MSG := Tlabel.Create(Application);
 MSG.Parent := F;
 MSG.Transparent := true;
 MSG.AutoSize := false;
 MSG.Top := 34;
 MSG.Width := 394;
 TimerMSG.Enabled := true;
 MSG.Alignment := taCenter;

 //Altera nome de arquivo de saida cada vez que executa!!!
 EditSaida.Text := ExtractFileDir(OpenDialogArquivo.FileName)+'\'+ExtraiNome(OpenDialogArquivo.FileName)+' - '+formatdatetime('DDMMYYYY_HHMMSS', now)+'.net';
 ArquivoSaidaSE :=  ExtractFileDir(OpenDialogArquivo.FileName)+'\'+ExtraiNome(OpenDialogArquivo.FileName)+' - '+formatdatetime('DDMMYYYY_HHMMSS', now);

 arquivoSaida := EditSaida.Text;
 if not(ExtraiNome(ArquivoSaida)<>'') then
  begin
   Showmessage('O arquivo de saída não foi selecionado!');
   exit;
  end;

 if fileExists(ArquivoSaida) then
  begin
   if MessageBox(Handle, 'O arquivo que você está tentando criar já existe, deseja sobrescrevê-lo?', 'Confirmação', MB_ICONQUESTION + MB_YESNO) = ID_NO then exit;
  end;


 MSG.Font.Color := clWhite;
 MSG.Font.Size := 8;
 MSG.Caption := '    Aguarde o final do processamento!';

 F.Show;
 F.Update;

 if ExtractFileExt(ArquivoSaida) <> '.net' then ArquivoSaida := ArquivoSaida + '.net';
 RichEditSaida.Clear;
 RichEditSimilaridade.Clear;
 RichEditLinhas.Clear;
 Colunas := TStringList.Create;

 vertice := TStringList.Create;
 vertice.Sorted := false;
 vertice.CaseSensitive := CheckBoxCaseSensitive.Checked;

 vertice2modo := TStringList.Create;
 vertice2modo.Sorted := false;
 vertice2modo.CaseSensitive := CheckBoxCaseSensitive.Checked;

 verticeDEF := TStringList.Create;
 verticeDEF.Sorted := CheckBoxOrdem.checked;
 verticeDEF.Duplicates := dupignore;

 vertice2modoDEF := TStringList.Create;
 vertice2modoDEF.Sorted := false;
 vertice2modoDEF.CaseSensitive := CheckBoxCaseSensitive.Checked;

 aresta := TStringList.Create;
 arestaDEF := TStringList.Create;

 Linhas := TStringList.Create;
 LinhasAux := TStringList.Create;

 AssignFile(Arquivo, arquivoEntrada);
 Reset(Arquivo);
 i:=0;

 primeiraColuna := ComboBoxPriCo.ItemIndex;
 segundaColuna  := ComboBoxSegCo.ItemIndex;
 colunaValor:= ComboBoxValor.ItemIndex;
 desprezaLinha := StrtoInt(EditDesprezar.Text);


 // Aqui começa a função de gerar .net em linhas (cliques) =============================================================
 if RadioGroupOrganizacao.Items[RadioGroupOrganizacao.ItemIndex] = 'linhas' then
   begin
     segundaColuna:=primeiraColuna+1;

     while not EOF(Arquivo) do
      begin

       if i = 0 then
        begin
         for x:=0 to desprezaLinha-1 do
           begin
            readln(Arquivo);
           end;
        end;
       readln(Arquivo, Linha);

       if (StringReplace(Linha,separador,'',[rfReplaceAll]) <> '') then
        begin
         if separador = ' ' then
         begin
          Linha := stringreplace(Linha, '      ', ' ',[rfReplaceAll]);
          Linha := stringreplace(Linha, '     ', ' ',[rfReplaceAll]);
          Linha := stringreplace(Linha, '    ', ' ',[rfReplaceAll]);
          Linha := stringreplace(Linha, '   ', ' ',[rfReplaceAll]);
          Linha := stringreplace(Linha, '  ', ' ',[rfReplaceAll]);
         end;
         Colunas.text := StringReplace(Linha,separador,#13,[rfReplaceAll]);
         if colunaValor >= 1 then Linhas.Add(Colunas.Strings[ColunaValor-1]) else Linhas.Add('');
         for l:=primeiraColuna to Colunas.Count-1 do
         begin
           LinhasAux.Add(Colunas.Strings[l]);
         end;

         if ComboBoxMetodo.Text = 'Clique' then
         begin
          for l:=0 to LinhasAux.Count-1 do
          begin
          if (LinhasAux.Count-1)-l > 0 then
           begin
            if LinhasAux.Count > 2 then
             begin
              for m:=l+1 to LinhasAux.Count-1 do
               begin
                 RichEditLinhas.Lines.Add(LinhasAux.Strings[l]+separador+LinhasAux.Strings[m]+separador+Linhas.Strings[i])
               end;
             end
            else
             begin
              if LinhasAux.Count = 2 then
               RichEditLinhas.Lines.Add(LinhasAux.Strings[l]+separador+LinhasAux.Strings[l+1]+separador+Linhas.Strings[i])
             end;
           end
          else // ATENCAO!!! Este else permite a criacao de uma aresta quando existe apenas um vertice
           if LinhasAux.Count = 1 then RichEditLinhas.Lines.Add(LinhasAux.Strings[l]+separador+LinhasAux.Strings[0]+separador+Linhas.Strings[0])
          end;

          if comboBoxTipo.Text = 'Dirigido' then
            begin
            for l:=LinhasAux.Count-1 downto 0 do
            begin
            if (LinhasAux.Count-1)-l > 0 then
             begin
              if LinhasAux.Count > 2 then
               begin
                for m:=LinhasAux.Count-1 downto l+1 do
                 begin
                   RichEditLinhas.Lines.Add(LinhasAux.Strings[m]+separador+LinhasAux.Strings[l]+separador+Linhas.Strings[i])
                 end;
               end
              else
               begin
                if LinhasAux.Count = 2 then
                 RichEditLinhas.Lines.Add(LinhasAux.Strings[l+1]+separador+LinhasAux.Strings[l]+separador+Linhas.Strings[i])
               end;
             end;
            end;
          end;



         end;

         if ComboBoxMetodo.Text = 'Linha' then
         begin
          for l:=0 to LinhasAux.Count-2 do
          begin
          if (LinhasAux.Count-1) > 0 then
           begin
            RichEditLinhas.Lines.Add(LinhasAux.Strings[l]+separador+LinhasAux.Strings[l+1]+separador+Linhas.Strings[i])
           end
          else
           begin
            RichEditLinhas.Lines.Add(LinhasAux.Strings[l]+separador+LinhasAux.Strings[0]+separador+Linhas.Strings[i])
           end;
          end;
         end;

        LinhasAux.Free;
        LinhasAux:=nil;
        LinhasAux := TStringList.Create;
        end;
      i:=i+1;
      end;

     Colunas.Free;
     Colunas:=nil;

     Linhas.Free;
     Linhas:=nil;

     Colunas := TStringList.Create;

     ArquivoTemp := ArquivoSaidaSE+'.lin';

     RichEditLinhas.Lines.SaveToFile(ArquivoTemp);

     colunaValor := 3;
     primeiraColuna := 0;
     segundaColuna := 1;
     desprezaLinha := 0;

     closefile(Arquivo);

     AssignFile(Arquivo, ArquivoTemp);
     Reset(Arquivo);
     i:=0;
   end;
  // Aqui termina a função de gerar .net em linhas (cliques) =============================================================






 //GERANDO VÉRTICES ===========================================================
 //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 MSG.Caption := '    Iniciando geração de vértices!';
 F.Update;
 //Armazenando vértices na stringlist removendo duplicatas ====================
   while not EOF(Arquivo) do
    begin
     readln(Arquivo, Linha);
     if i >= desprezaLinha then
      begin
       Colunas.text := StringReplace(Linha,separador,'¶'+#13+'¶',[rfReplaceAll]);
       if vertice.IndexOf(SuprimirCaractere(Colunas.Strings[primeiraColuna])) < 0 then vertice.Add(SuprimirCaractere(Colunas.Strings[primeiraColuna]));
       if comboboxModo.Text = '1-Modo' then
        begin
         if vertice.IndexOf(SuprimirCaractere(Colunas.Strings[segundaColuna])) < 0 then vertice.Add(SuprimirCaractere(Colunas.Strings[segundaColuna]));
        end
       else
        begin
         if vertice2modo.IndexOf(SuprimirCaractere(Colunas.Strings[segundaColuna])) < 0 then vertice2modo.Add(SuprimirCaractere(Colunas.Strings[segundaColuna]));
        end;
      end;
     i:=i+1;
    end;
 //FIM Armazenando vértices na stringlist =====================================
 //Showmessage('Vertices:'+#13+vertice.text);

 //Limpando vértices em branco ================================================
 MSG.Caption := '    Limpando vértices em Branco!';
 F.Update;
 if vertice.IndexOf('¶') <> -1 then vertice.delete(vertice.IndexOf('¶'));
 if vertice.IndexOf('¶¶') <> -1 then vertice.delete(vertice.IndexOf('¶¶'));
 //Showmessage('Vertices sem branco:'+#13+vertice.text);
 //FIM Limpando vértices em branco ============================================

 //Ajustando o caractere ¶ para somente o final da string =====================
   for i := 0 to vertice.Count-1 do
    begin
       begin
        if (length(vertice.Strings[i]) > 1) and (copy(vertice.Strings[i],1,1) = '¶') then
         begin
          if copy(vertice.Strings[i],length(vertice.Strings[i]),length(vertice.Strings[i])) <> '¶' then
           vertice.Strings[i] := copy(vertice.Strings[i],2,length(vertice.Strings[i]))+'¶'
          else
           vertice.Strings[i] := copy(vertice.Strings[i],2,length(vertice.Strings[i]));
         end;
       end;
    end;

   if comboboxModo.Text = '2-Modos' then
    begin
     for i := 0 to vertice2modo.Count-1 do
      begin
       begin
        if (length(vertice2modo.Strings[i]) > 1) and (copy(vertice2modo.Strings[i],1,1) = '¶') then
         begin
          if copy(vertice2modo.Strings[i],length(vertice2modo.Strings[i]),length(vertice2modo.Strings[i])) <> '¶' then
           vertice2modo.Strings[i] := copy(vertice2modo.Strings[i],2,length(vertice2modo.Strings[i]))+'¶'
          else
           vertice2modo.Strings[i] := copy(vertice2modo.Strings[i],2,length(vertice2modo.Strings[i]));
         end;
       end;
      end;
    end;

   //Showmessage('Vertices ajustado ¶:'+#13+vertice.text);
 //FIM Ajustando o caractere ¶ para o final da string =========================

 //Inserindo vertices na stringlist definitiva ================================
  MSG.Caption := '    Gerando vértices definitivos!';
  F.Update;

   for i := 0 to vertice.Count-1 do
    begin
     if verticeDEF.IndexOf(vertice.Strings[i]) < 0 then verticeDEF.Add(vertice.Strings[i]);
    end;

   for i := 0 to vertice2modo.Count-1 do
    begin
     if vertice2modoDEF.IndexOf(vertice2modo.Strings[i]) < 0 then vertice2modoDEF.Add(vertice2modo.Strings[i]);
    end;

 //Showmessage('Vertices definitivos 1:'+#13+verticeDEF.text);
 //Showmessage('Vertices definitivos 2:'+#13+vertice2ModoDEF.text);
 //FIM Inserindo vertices na stringlist definitiva ============================
 //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 //FIM GERANDO VÉRTICES =======================================================






 MSG.Caption := '    Gerando arestas!';
 F.Update;

 Colunas.Free;
 Colunas:=nil;
 closefile(Arquivo);

 if RadioGroupOrganizacao.Items[RadioGroupOrganizacao.ItemIndex] = 'linhas' then
 AssignFile(Arquivo, arquivoTemp) else AssignFile(Arquivo, arquivoEntrada);

 Reset(Arquivo);
 Colunas := TStringList.Create;

 i:=0;

 while not EOF(Arquivo) do
  begin
   readln(Arquivo, Linha);
   if (i >= desprezaLinha) and (StringReplace(Linha,separador,'',[rfReplaceAll]) <> '') then
    begin
     Colunas.text := StringReplace(Linha,separador,'¶'+#13+'¶',[rfReplaceAll]);
     aresta.Add(SuprimirCaractere(Colunas.Strings[primeiraColuna]));
     aresta.Add(SuprimirCaractere(Colunas.Strings[segundaColuna]));
     // AQUI a funcao de peso!!!
     if colunaValor >= 1 then aresta.Add(Colunas.Strings[ColunaValor-1])else aresta.Add('');
    end;
   i:=i+1;
  end;

  //showmessage(aresta.text);


 //Ajustando o caractere ¶ para somente o final da string =====================
 for i := 0 to aresta.Count-1 do
  begin
   begin
    if (length(aresta.Strings[i]) > 1) and (copy(aresta.Strings[i],1,1) = '¶') then
     begin
      if copy(aresta.Strings[i],length(aresta.Strings[i]),length(aresta.Strings[i])) <> '¶' then aresta.Strings[i] := copy(aresta.Strings[i],2,length(aresta.Strings[i]))+'¶'
      else aresta.Strings[i] := copy(aresta.Strings[i],2,length(aresta.Strings[i]));
     end;
   end;
  end;
 //FIM Ajustando o caractere ¶ para o final da string =========================

 //showmessage(aresta.text);

 i:=0;
 while i < aresta.Count do
  begin
   idx1 := 0;
   idx2 := 0;
   //if (aresta.Strings[primeiraColuna] <> '¶') and (aresta.Strings[segundaColuna] <> '¶') then
    begin
     idx1 := verticeDEF.IndexOf(aresta.Strings[i]);
     if comboboxModo.Text = '1-Modo' then
      begin
       idx2 := verticeDEF.IndexOf(aresta.Strings[i+1]);
      end
     else
      begin
       idx2 := vertice2ModoDEF.IndexOf(aresta.Strings[i+1])+verticeDEF.count;
      end;
     if comboboxValor.Text <> '' then valor := ' ' + aresta.Strings[i+2] else valor:='';
     arestaDEF.Add(inttostr(idx1+1) + ' ' + inttostr(idx2+1) + valor);
    end;
  i:=i+3;
  end;

  //showmessage(arestaDEF.text);

 if comboboxModo.Text <> '1-Modo' then modo := ' ' + inttostr(verticeDEF.count)
 else modo := '';

 MSG.Caption := '    Salvando arquivo .net!';
 F.Update;

 RichEditSaida.Lines.Add('*Vertices '+inttostr(verticeDEF.count+vertice2ModoDEF.count)+modo);

 for i := 0 to verticeDEF.Count-1 do
  begin
   RichEditSaida.Lines.Add(inttostr(i+1) + ' "' + StringReplace(verticeDEF.strings[i],'¶','',[rfReplaceAll]) + '"');
  end;

 // ATENÇÃO AQUI PARA A GERAÇÃO DA SIMILARIDADE!!!
 if checkboxsimilaridade.Checked = true then
  begin
   contaSimilaridade := 0;
   RichEditSimilaridade.Lines.Add('Relatório de vértices Similares');
   RichEditSimilaridade.Lines.Add('---------------------------------------------------------------------------------------------------------');
   for i := 0 to verticeDEF.Count-1 do
    begin
     for j := i+1 to verticeDEF.Count-1 do
       begin
         valorSimilaridade := StringSimilarityRatio(StringReplace(verticeDEF.strings[i],'¶','',[rfReplaceAll]), StringReplace(verticeDEF.strings[j],'¶','',[rfReplaceAll]), true)*100;
         if (valorSimilaridade >= strtoint(editSimilaridade.text)) then
           begin
             RichEditSimilaridade.Lines.Add('|'+StringReplace(verticeDEF.strings[i],'¶','',[rfReplaceAll])+'| -> |'+StringReplace(verticeDEF.strings[j],'¶','',[rfReplaceAll])+'| = '+formatFloat('#,##0.00',(valorSimilaridade))+'%');
             inc(contaSimilaridade);
           end;
       end;
    end;
   if contaSimilaridade = 0 then
    RichEditSimilaridade.Lines.Add('Não foram encontrados vértices similares usando a taxa de similaridade igual a '+editSimilaridade.text+'%')
   else
    begin
      RichEditSimilaridade.Lines.Add('---------------------------------------------------------------------------------------------------------');
      RichEditSimilaridade.Lines.Add('Foram encontrados '+inttostr(contaSimilaridade)+' vértices similares usando a taxa de similaridade igual a '+editSimilaridade.text+'%');
    end;
   arquivoSimilaridade := ExtractFileDir(EditSaida.text)+'\Similaridade_'+ExtraiNome(EditSaida.text)+'.rtf';
   RichEditSimilaridade.Lines.SaveToFile(arquivoSimilaridade, TEncoding.UTF8);
  end;

 if comboboxModo.Text = '2-Modos' then
  begin
   for i := 0 to vertice2ModoDEF.Count-1 do
    begin
     RichEditSaida.Lines.Add(inttostr(i+1+verticeDEF.count) + ' "' + StringReplace(vertice2ModoDEF.strings[i],'¶','',[rfReplaceAll]) + '"');
   end;
  end;






 // Aqui inicia a funcao do peso!!!

 if comboboxValor.text <> '' then
   begin
     if comboboxFuncaoPeso.Text <> '' then
       begin
          peso:=TStringList.Create;
          peso.NameValueSeparator:=' ';

          for i := 0 to arestaDEF.Count-1 do
          begin
           Index:= peso.IndexOfName(arestaDEF.Names[i]);
           if index < 0 then
             peso.Add(arestaDEF.Strings[i])
           else
            peso.ValueFromIndex[Index]:= floattostr((strtofloat(peso.ValueFromIndex[Index])+strtofloat(arestaDEF.ValueFromIndex[i])));
          end;
       showmessage(peso.text);
       end;

   end;



 // Aqui finaliza a funcao do peso!!!








 if comboboxTipo.Text = 'Não dirigido' then RichEditSaida.Lines.Add('*Edges')
 else RichEditSaida.Lines.Add('*Arcs');
 for i := 0 to arestaDEF.Count-1 do
  begin
   RichEditSaida.Lines.Add(StringReplace(arestaDEF.strings[i],'¶','',[rfReplaceAll]));
  end;

 Colunas.Free;
 Colunas:=nil;
 vertice.Free;
 vertice:=nil;
 vertice2modo.Free;
 vertice2modo:=nil;

 verticeDEF.Free;
 verticeDEF:=nil;
 vertice2modoDEF.Free;
 vertice2modoDEF:=nil;

 aresta.Free;
 aresta:=nil;

 arestaDEF.Free;
 arestaDEF:=nil;

 RichEditSaida.Lines.SaveToFile(arquivoSaida, TEncoding.UTF8);
 F.Free;
 TimerMSG.Enabled := false;


 if checkboxsimilaridade.Checked = true then
  begin
   ShowMessage('Arquivos gravados com sucesso! O arquivo com a extensão .net refere-se à rede no formato Pajek, enquanto o arquivo com a extensão .rtf contém o relatório de similaridade de vértices.');
  end
 else
  begin
   ShowMessage('Arquivo gravado com sucesso!');
  end;

  closefile(Arquivo);


  //Aqui gera o arquivo de log!!!
  AssignFile(Arquivo, ArquivoSaidaSE+'.log');
  Rewrite(Arquivo);
  writeln(Arquivo,'############################################ Arquivo de log do criarNET ############################################');
  writeln(Arquivo,'');
  writeln(Arquivo,'=>ARQUIVO');
  writeln(Arquivo,'Arquivo de entrada de dados = '+EditEntrada.text);
  writeln(Arquivo,'Arquivo de saída de dados = '+EditSaida.text);
  if RadioGroupOrganizacao.Items[RadioGroupOrganizacao.ItemIndex] = 'linhas' then writeln(Arquivo,'Arquivo de linhas: '+ArquivoSaidaSE+'.lin');
  writeln(Arquivo,'');
  writeln(Arquivo,'=>ORGANIZAÇÃO DOS DADOS');
  writeln(Arquivo,'Organização dos Dados = '+RadioGroupOrganizacao.Items[RadioGroupOrganizacao.ItemIndex]);
  writeln(Arquivo,'');
  writeln(Arquivo,'=>SEPARADOR');
  writeln(Arquivo,'Separador Utilizado = <'+separador+'>');
  writeln(Arquivo,'');
  writeln(Arquivo,'=>CONFIGURAÇÕES');
  if ComboBoxSuprimir.Text <> '' then
  begin
   writeln(Arquivo,'Suprimir caractere = '+ComboBoxSuprimir.Text);
   if checkboxInicio.Checked = true then writeln(Arquivo,'   Posição = '+checkboxInicio.Caption);
   if checkboxFim.Checked = true then writeln(Arquivo,'   Posição = '+checkboxFim.Caption);
   if checkboxToda.Checked = true then writeln(Arquivo,'   Posição = '+checkboxToda.Caption);
  end;
  if checkboxOrdem.Checked = true then writeln(Arquivo, checkboxOrdem.Caption+' = Sim');
  if checkboxCaseSensitive.Checked = true then writeln(Arquivo, checkboxCaseSensitive.Caption+' = Sim');
  if checkboxSimilaridade.Checked = true then writeln(Arquivo, checkboxSimilaridade.Caption+' = '+EditSimilaridade.Text+'%');
  writeln(Arquivo,'');
  writeln(Arquivo,'=>SAÍDA');
  writeln(Arquivo,'Primeira Coluna = '+ComboboxPriCo.text);
  if RadioGroupOrganizacao.Items[RadioGroupOrganizacao.ItemIndex] <> 'linhas' then writeln(Arquivo,'Segunda Coluna = '+ComboboxSegCo.text);
  writeln(Arquivo,'Coluna de Valor = '+ComboboxValor.text);
  if RadioGroupOrganizacao.Items[RadioGroupOrganizacao.ItemIndex] <> 'linhas' then writeln(Arquivo,'Modo da Rede = '+ComboboxModo.text);
  writeln(Arquivo,'Tipo da Rede = '+ComboboxTipo.text);
  if RadioGroupOrganizacao.Items[RadioGroupOrganizacao.ItemIndex] = 'linhas' then writeln(Arquivo,'Método de Construção da Rede = '+ComboboxMetodo.text);
  writeln(Arquivo,'Ignorar Cabeçalho = '+EditDesprezar.Text);

  writeln(Arquivo,'');
  writeln(Arquivo,'                                               Data / Hora do final do processamento do arquivo: '+formatdatetime('DD/MM/YYYY HH:MM:SS', now));
  writeln(Arquivo,'####################################################################################################################');
  CloseFile(Arquivo);


end;

procedure TtoPajek.EditSeparadorChange(Sender: TObject);
begin
 RadioGroupSeparador.onClick(sender);
end;

procedure TtoPajek.ComboBoxPriCoChange(Sender: TObject);
begin
 primeiraColuna := ComboBoxPriCo.ItemIndex;
end;

procedure TtoPajek.ComboBoxSegCoChange(Sender: TObject);
begin
 segundaColuna := ComboBoxSegCo.ItemIndex;
end;

procedure TtoPajek.CarregaEntrada;
var
 ControlaLinha, MaxLinha: Integer;
begin
 MaxLinha := 10;
 ControlaLinha := 0;
 RichEditEntrada.Clear;
 AssignFile(Arquivo, OpenDialogArquivo.FileName);
 Reset(Arquivo);
 while not EOF(Arquivo) do
  begin
   readln(Arquivo, Linha);
   if controlaLinha < MaxLinha then RichEditEntrada.Lines.Add(Linha);
   ControlaLinha := ControlaLinha + 1;
  end;
 label3.Caption := 'Quantidade de linhas do arquivo: ' + inttostr(ControlaLinha);
 closefile(Arquivo);
end;

procedure TtoPajek.ButtonEntradaClick(Sender: TObject);
begin
 if opendialogArquivo.Execute then
  begin
   EditEntrada.Text := OpenDialogArquivo.FileName;
   EditSaida.Text := ExtractFileDir(OpenDialogArquivo.FileName)+'\'+ExtraiNome(OpenDialogArquivo.FileName)+' - '+formatdatetime('DDMMYYYY_HHMMSS', now)+'.net';
   ArquivoSaidaSE :=  ExtractFileDir(OpenDialogArquivo.FileName)+'\'+ExtraiNome(OpenDialogArquivo.FileName)+' - '+formatdatetime('DDMMYYYY_HHMMSS', now);
   //arquivoEntrada := EditEntrada.Text;
   //arquivoSaida := EditSaida.Text;
   CarregaEntrada();
   RadioGroupSeparador.Enabled := true;
   RadioGroupOrganizacao.Enabled := true;
   RadioGroupSeparador.ItemIndex := -1;
   ResetaOpcoes();
   PageControlES.ActivePageIndex := 0;
  end;
end;

procedure TtoPajek.Mostra;
begin
 LabelPriCo.Enabled := true;
 LabelSegCo.Enabled := true;
 LabelModo.Enabled := true;
 LabelTipo.Enabled := true;
 LabelValor.Enabled := true;
 LabelDesprezar.Enabled := true;
 LabelMetodo.Enabled := true;
 ComboBoxModo.Enabled := true;
 ComboBoxPriCo.Enabled := true;
 ComboBoxSegCo.Enabled := true;
 ComboBoxTipo.Enabled := true;
 ComboBoxValor.Enabled := true;
 ComboBoxMetodo.Enabled := true;
 ButtonTXT.Enabled := true;
 Buttonreset.Enabled := true;
 updownDesprezar.Enabled := true;
 EditDesprezar.Enabled := true;
 ComboBoxSuprimir.Enabled := true;
 CheckBoxInicio.Enabled := true;
 CheckBoxFim.Enabled := true;
 CheckBoxToda.Enabled := true;
 CheckBoxOrdem.Enabled := true;
 CheckBoxSimilaridade.Enabled := true;
 EditSimilaridade.Enabled := true;
 UpDownSimilaridade.Enabled := true;
 CheckBoxCaseSensitive.Enabled := true;
 ComboBoxFuncaoPeso.Enabled := true;

end;

procedure TtoPajek.PageControlESChange(Sender: TObject);
begin
 if PageControlES.ActivePageIndex = 2 then
  begin
    buttonTXT.Visible :=true;
    buttonReset.Visible :=true;
    //ButtonInfo.Left := 332;
  end
 else
  begin
    buttonTXT.Visible :=false;
    buttonReset.Visible :=false;
    //ButtonInfo.Left := 472;
  end;
end;

procedure TtoPajek.Esconde;
begin
 editSeparador.Visible := false;
 LabelPriCo.Enabled := false;
 LabelSegCo.Enabled := false;
 LabelModo.Enabled := false;
 LabelTipo.Enabled := false;
 LabelValor.Enabled := false;
 LabelDesprezar.Enabled := false;
 LabelMetodo.Enabled := false;
 ComboBoxPriCo.Enabled := false;
 ComboBoxSegCo.Enabled := false;
 ComboBoxModo.Enabled := false;
 ComboBoxTipo.Enabled := false;
 ComboBoxValor.Enabled := false;
 ComboBoxMetodo.Enabled := false;
 EditDesprezar.Enabled := false;
 updownDesprezar.Enabled := false;
 ButtonTXT.Enabled := false;
 ButtonReset.Enabled := false;
 ComboBoxSuprimir.Enabled := false;
 CheckBoxInicio.Enabled := false;
 CheckBoxFim.Enabled := false;
 CheckBoxToda.Enabled := false;
 CheckBoxOrdem.Enabled := false;
 CheckBoxSimilaridade.Enabled := false;
 EditSimilaridade.Enabled := false;
 UpDownSimilaridade.Enabled := false;
 CheckBoxCaseSensitive.Enabled := false;
 ComboBoxFuncaoPeso.Enabled := false;
 resetaOpcoes();
end;

procedure TtoPajek.RadioGroupOrganizacaoClick(Sender: TObject);
begin
 if (RadioGroupOrganizacao.Items[RadioGroupOrganizacao.ItemIndex] = 'linhas') and (RadioGroupOrganizacao.Enabled=true) then
   begin
     ComboBoxSegCo.visible := false;
     LabelSegCo.visible := false;
     ComboBoxModo.visible := false;
     LabelModo.visible := false;
     LabelTipo.Top := 24;
     ComboBoxTipo.Top := 40;
     ComboBoxMetodo.visible := true;
     LabelMetodo.visible := true;

   end;
 if (RadioGroupOrganizacao.Items[RadioGroupOrganizacao.ItemIndex] <> 'linhas') and (RadioGroupOrganizacao.Enabled=true) then
   begin
     ComboBoxSegCo.visible := true;
     LabelSegCo.visible := true;
     ComboBoxModo.visible := true;
     LabelModo.visible := true;
     LabelTipo.Top := 72;
     ComboBoxTipo.Top := 88;
     ComboBoxMetodo.visible := false;
     LabelMetodo.visible := false;

   end;
end;

procedure TtoPajek.RadioGroupSeparadorClick(Sender: TObject);
var
contador, i: integer;
Colunas: TStringList;
SeparadorTemp: String;
begin
 arquivoEntrada := EditEntrada.Text;
 if not(fileexists(arquivoEntrada)) then
  begin
   Showmessage('O arquivo de entrada não existe ou não foi selecionado!');
   exit;
  end;
 esconde();
 carregaEntrada();
 Colunas := TStringList.Create;
 contaTAB:=0;
 if RadioGroupSeparador.Items[RadioGroupSeparador.ItemIndex] = 'tab' then separador := #9;
 if RadioGroupSeparador.Items[RadioGroupSeparador.ItemIndex] = 'vírgula' then separador := ',';
 if RadioGroupSeparador.Items[RadioGroupSeparador.ItemIndex] = 'ponto e vírgula' then separador := ';';
 if RadioGroupSeparador.Items[RadioGroupSeparador.ItemIndex] = 'espaço em branco' then separador := ' ';
 if RadioGroupSeparador.Items[RadioGroupSeparador.ItemIndex] = 'outro' then
  begin
   EditSeparador.Visible := true;
   if trim(editseparador.text) <> '' then separador := editseparador.text[1];
  end;
 if Separador = #9 then RichEditEntrada.Text := stringreplace(RichEditEntrada.Text, #9, '<tab>',[rfReplaceAll])
 else
 begin
  if Separador = ' ' then
  begin
   RichEditEntrada.Text := stringreplace(RichEditEntrada.Text, '      ', ' ',[rfReplaceAll]);
   RichEditEntrada.Text := stringreplace(RichEditEntrada.Text, '     ', ' ',[rfReplaceAll]);
   RichEditEntrada.Text := stringreplace(RichEditEntrada.Text, '    ', ' ',[rfReplaceAll]);
   RichEditEntrada.Text := stringreplace(RichEditEntrada.Text, '   ', ' ',[rfReplaceAll]);
   RichEditEntrada.Text := stringreplace(RichEditEntrada.Text, '  ', ' ',[rfReplaceAll]);
   RichEditEntrada.Text := stringreplace(RichEditEntrada.Text, ' ', '< >',[rfReplaceAll])
  end
  else
  RichEditEntrada.Text := stringreplace(RichEditEntrada.Text, Separador, '<'+Separador+'>',[rfReplaceAll]);

 end;


 if (RadioGroupSeparador.Items[RadioGroupSeparador.ItemIndex] <> 'outro') or (trim(editseparador.text) <> '') then
  begin
   AssignFile(Arquivo, arquivoEntrada);
   Reset(Arquivo);
   readln(Arquivo, Linha);
   Colunas.text := StringReplace(Linha,separador,#13,[rfReplaceAll]);
   for contador := 0 to length(Linha) do
    begin
     if Linha[contador] = separador then contaTAB:=contaTAB+1;
    end;
   closefile(Arquivo);
   if (contaTAB > 0) then
    begin
     mostra();
     EditDesprezar.Text := '0';
     RichEditSaida.Clear;
     ComboBoxPriCo.Items.Clear;
     ComboBoxSegCo.Items.Clear;
     ComboBoxValor.Items.Clear;
     ComboBoxModo.ItemIndex := 0;
     ComboBoxTipo.ItemIndex := 0;
     ComboBoxMetodo.ItemIndex := 0;
     ComboBoxFuncaoPeso.ItemIndex := 0;

     ComboBoxValor.Items.Add('');
     ComboBoxValor.ItemIndex := 0;

     for i := 0 to Colunas.Count-1 do
      begin
       if trim(Colunas.strings[i])  <> '' then
       begin
        ComboBoxPriCo.Items.Add(Colunas.strings[i]);
        ComboBoxSegCo.Items.Add(Colunas.strings[i]);
        ComboBoxValor.Items.Add(Colunas.strings[i]);
       end;
      end;
     ComboBoxSegCo.ItemIndex := 1;
     ComboBoxPriCo.ItemIndex := 0;
     ComboBoxValor.ItemIndex := 0;
     primeiraColuna := ComboBoxPriCo.ItemIndex;
     segundaColuna := ComboBoxSegCo.ItemIndex;
    end;
  end;
 //GroupboxOpcoes.Caption := ' Opções - Quantidade de colunas encontradas: ' + inttostr(contaTAB+1) + ' ';
 Label1.Caption := 'Quantidade de colunas encontradas: ' + inttostr(contaTAB+1);
 Colunas.Free;
 Colunas:=nil;
 SeparadorTemp := Separador;
 if SeparadorTemp = #9 then SeparadorTemp := '<tab>' else
 SeparadorTemp := '<'+SeparadorTemp+'>';
 marcaPalavra(RichEditEntrada,SeparadorTemp,clRed);
 with RichEditEntrada do selStart := Perform(EM_LINEINDEX, 0,0);
 RadioGroupOrganizacao.OnClick(Sender);
end;

procedure TtoPajek.ResetaOpcoes;
begin
 ComboBoxPriCo.ItemIndex := -1;
 ComboBoxSegCo.ItemIndex := -1;
 ComboBoxModo.ItemIndex := -1;
 ComboBoxTipo.ItemIndex := -1;
 ComboBoxValor.ItemIndex := -1;
 ComboboxFuncaoPeso.ItemIndex := -1;
 EditDesprezar.Text :='0';
 RichEditSaida.Clear;
 GroupBoxOpcoes.Caption := ' Opções ';
 Label1.Caption := 'Quantidade de colunas encontradas: 0';
 EditSeparador.Visible := false;
 CheckBoxOrdem.Checked := false;
 CheckBoxSimilaridade.Checked := false;
 EditSimilaridade.Text := '80';
 CheckBoxCaseSensitive.Checked := false;
 ComboboxSuprimir.ItemIndex := -1;
 CheckBoxInicio.Checked := false;
 CheckBoxFim.Checked := false;
 CheckBoxToda.Checked := false;
end;

function CheckUrl(url: string): boolean;
var
  hSession, hfile, hRequest: hInternet;
  dwindex, dwcodelen: dword;
  dwcode: array[1..20] of char;
  res: pchar;
begin
  if pos('http://', lowercase(url)) = 0 then
    url := 'http://' + url;
  Result := false;
  hSession := InternetOpen('InetURL:/1.0', INTERNET_OPEN_TYPE_PRECONFIG, nil, nil, 0);
  if assigned(hsession) then
  begin
    hfile := InternetOpenUrl(hsession, pchar(url), nil, 0, INTERNET_FLAG_RELOAD, 0);
    dwIndex := 0;
    dwCodeLen := 10;
    HttpQueryInfo(hfile, HTTP_QUERY_STATUS_CODE, @dwcode, dwcodeLen, dwIndex);
    res := pchar(@dwcode);
    result := (res = '200') or (res = '302');
    if assigned(hfile) then
      InternetCloseHandle(hfile);
    InternetCloseHandle(hsession);
  end;
end;


procedure TtoPajek.FormShow(Sender: TObject);
var
lastVersion, countDownload: string;
begin
 RicheditEntrada.Clear;
 RichEditSaida.Clear;

 TRadioButton(RadioGroupSeparador.Controls[0]).Left := 11;
 TRadioButton(RadioGroupSeparador.Controls[1]).Left := 130;
 TRadioButton(RadioGroupSeparador.Controls[2]).Left := 270;
 TRadioButton(RadioGroupSeparador.Controls[3]).Left := 340;

 TRadioButton(RadioGroupSeparador.Controls[0]).font.Style := TRadioButton(RadioGroupSeparador.Controls[0]).font.Style - [fsBold];
 TRadioButton(RadioGroupSeparador.Controls[1]).font.Style := TRadioButton(RadioGroupSeparador.Controls[0]).font.Style - [fsBold];
 TRadioButton(RadioGroupSeparador.Controls[2]).font.Style := TRadioButton(RadioGroupSeparador.Controls[0]).font.Style - [fsBold];
 TRadioButton(RadioGroupSeparador.Controls[3]).font.Style := TRadioButton(RadioGroupSeparador.Controls[0]).font.Style - [fsBold];
 TRadioButton(RadioGroupSeparador.Controls[4]).font.Style := TRadioButton(RadioGroupSeparador.Controls[0]).font.Style - [fsBold];

 TRadioButton(RadioGroupOrganizacao.Controls[0]).Left := 11;
 TRadioButton(RadioGroupOrganizacao.Controls[0]).font.Style := TRadioButton(RadioGroupOrganizacao.Controls[0]).font.Style - [fsBold];
 TRadioButton(RadioGroupOrganizacao.Controls[1]).font.Style := TRadioButton(RadioGroupOrganizacao.Controls[0]).font.Style - [fsBold];
 TRadioButton(RadioGroupOrganizacao.Controls[0]).checked := true;

 LabelMetodo.Left := 11;
 ComboBoxMetodo.Left := 11;
 ComboBoxMetodo.Width := 145;


 // ATENÇÃO! Atualização do sistema!

 IdHTTP1.Request.Accept := 'text/html, */*';
 IdHTTP1.Request.UserAgent := 'Mozilla/3.0 (compatible; IndyLibrary)';
 IdHTTP1.Request.ContentType := 'application/x-www-form-urlencoded';
 IdHTTP1.HandleRedirects := True;

 if  InternetCheckConnection('http://www.criarnet.mxminformatica.com.br/',  1,  0) and (CheckUrl('www.criarnet.mxminformatica.com.br/dataLastVersion.html')) then
  begin
   lastVersion := idHTTP1.get('http://www.criarnet.mxminformatica.com.br/dataLastVersion.html');
   countDownload := idHTTP1.get('http://www.criarnet.mxminformatica.com.br/countDownload.html');
   if FormatDateTime('yyyy/mm/dd',FileDateToDateTime(FileAge(Application.ExeName))) < FormatDateTime('yyyy/mm/dd', strtodate(lastVersion)) then
     begin
       form3.Label2.Caption := 'Nova versão disponível! Liberada em: '+lastVersion;
       form3.Label3.Caption := 'Até o momento já foram efetuados '+countDownload+' downloads do criarNET!';
       form3.showModal;
     end;
  end;
end;

procedure TtoPajek.ComboBoxModoChange(Sender: TObject);
begin
 if ComboBoxModo.Text = '1-Modo' then
  begin
   LabelTipo.Visible := true;
   ComboBoxTipo.Visible := true
  end
 else
  begin
   LabelTipo.Visible := false;
   ComboBoxTipo.Visible := false;
  end;
end;

procedure TtoPajek.ComboBoxValorChange(Sender: TObject);
begin
 ColunaValor := ComboBoxValor.ItemIndex;
end;

function TtoPajek.SuprimirCaractere(Palavra:string):string;
var
 PalavraModificada: string;
 Caractere: array[0..12] of Char;
 primeira, segunda: integer;
begin
 PalavraModificada := Palavra;
 //showmessage('Entrada: '+'|'+PalavraModificada+'|');
 Caractere[0] := '/';
 Caractere[1] := '\';
 Caractere[2] := '|';
 Caractere[3] := ' ';
 Caractere[4] := '{';
 Caractere[5] := '}';
 Caractere[6] := '[';
 Caractere[7] := ']';
 Caractere[8] := '<';
 Caractere[9] := '>';
 Caractere[10] := '(';
 Caractere[11] := ')';
 Caractere[12] := '.';
 //if PalavraModificada = '¶¶' then PalavraModificada := '¶';
 if (comboboxSuprimir.Text <> '') then
  begin
   if comboboxSuprimir.Text = 'Barra' then
    begin
     primeira := 0;
     segunda := 0;
    end;
   if comboboxSuprimir.Text = 'Barra Invertida' then
    begin
     primeira := 1;
     segunda := 1;
    end;
   if comboboxSuprimir.Text = 'Barra Vertical' then
    begin
     primeira := 2;
     segunda := 2;
    end;
   if comboboxSuprimir.Text = 'Espaço em Branco' then
    begin
     primeira := 3;
     segunda := 3;
    end;
   if comboboxSuprimir.Text = 'Chaves' then
    begin
     primeira := 4;
     segunda := 5;
    end;
   if comboboxSuprimir.Text = 'Colchetes' then
    begin
     primeira := 6;
     segunda := 7;
    end;
   if comboboxSuprimir.Text = 'Maior que e menor que' then
    begin
     primeira := 8;
     segunda := 9;
    end;
   if comboboxSuprimir.Text = 'Parênteses' then
    begin
     primeira := 10;
     segunda := 11;
    end;

   if comboboxSuprimir.Text = 'Ponto' then
    begin
     primeira := 12;
     segunda := 12;
    end;


   //showmessage(inttostr(primeira)+caractere[primeira]+'-'+caractere[segunda]);
   if CheckBoxToda.Checked = true then
    begin
     PalavraModificada := StringReplace(PalavraModificada, caractere[primeira],'',[rfReplaceAll]);
     PalavraModificada := StringReplace(PalavraModificada, caractere[segunda],'',[rfReplaceAll]);
    end
   else
    begin
     if CheckBoxInicio.Checked = true then
      begin
       while (PalavraModificada <> '') and ((PalavraModificada[2] = caractere[primeira]) or (PalavraModificada[2] = caractere[segunda])) do delete(PalavraModificada,2,1);
       if ((PalavraModificada[1] = caractere[primeira]) or (PalavraModificada[1] = caractere[segunda])) then delete(PalavraModificada,1,1);
      end;
     if CheckBoxFim.Checked = true then
      begin
       while (PalavraModificada <> '') and ((PalavraModificada[length(PalavraModificada)-1] = caractere[primeira]) or (PalavraModificada[length(PalavraModificada)-1] = caractere[segunda])) do PalavraModificada := copy(PalavraModificada,1,length(PalavraModificada)-2)+'¶';
       if ((PalavraModificada[length(PalavraModificada)] = caractere[primeira]) or (PalavraModificada[length(PalavraModificada)] = caractere[segunda])) then PalavraModificada := copy(PalavraModificada,1,length(PalavraModificada)-1)+'¶';
      end;
    end;
  end;
 Result := PalavraModificada;
end;


end.
