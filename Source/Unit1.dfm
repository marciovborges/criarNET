object toPajek: TtoPajek
  Left = 464
  Top = 123
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'criar.NET'
  ClientHeight = 607
  ClientWidth = 556
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object RadioGroupSeparador: TRadioGroup
    Left = 8
    Top = 155
    Width = 536
    Height = 54
    Caption = ' Separador '
    Columns = 5
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    Items.Strings = (
      'ponto e v'#237'rgula'
      'espa'#231'o em branco'
      'tab'
      'v'#237'rgula'
      'outro')
    ParentFont = False
    TabOrder = 3
    OnClick = RadioGroupSeparadorClick
  end
  object GroupBoxArquivo: TGroupBox
    Left = 8
    Top = 8
    Width = 537
    Height = 84
    Caption = ' Arquivo '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    object ButtonEntrada: TButton
      Left = 9
      Top = 24
      Width = 80
      Height = 20
      Caption = 'Entrada...'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnClick = ButtonEntradaClick
    end
    object ButtonSaida: TButton
      Left = 9
      Top = 53
      Width = 80
      Height = 20
      Caption = 'Sa'#237'da...'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnClick = ButtonSaidaClick
    end
    object EditEntrada: TEdit
      Left = 92
      Top = 24
      Width = 434
      Height = 21
      Color = clInfoBk
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
    end
    object EditSaida: TEdit
      Left = 92
      Top = 53
      Width = 434
      Height = 21
      Color = clInfoBk
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
    end
  end
  object PageControlES: TPageControl
    Left = 8
    Top = 216
    Width = 539
    Height = 345
    ActivePage = TabSheetEntrada
    TabOrder = 1
    OnChange = PageControlESChange
    object TabSheetEntrada: TTabSheet
      Caption = 'Entrada'
      object GroupBox1: TGroupBox
        Left = 3
        Top = 213
        Width = 519
        Height = 55
        Caption = ' Informa'#231#245'es '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        object Label3: TLabel
          Left = 11
          Top = 28
          Width = 165
          Height = 13
          Caption = 'Quantidade de linhas do arquivo: 0'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label1: TLabel
          Left = 323
          Top = 28
          Width = 184
          Height = 13
          Alignment = taRightJustify
          Caption = 'Quantidade de colunas encontradas: 0'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
      end
      object GroupBox2: TGroupBox
        Left = 3
        Top = 3
        Width = 520
        Height = 205
        Caption = ' Preview '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 1
        object RichEditEntrada: TRichEdit
          Left = 11
          Top = 23
          Width = 498
          Height = 169
          Color = clInfoBk
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          Lines.Strings = (
            'a'
            'b'
            'c'
            'd'
            'e'
            'f'
            'g'
            'h'
            'i'
            'j')
          ParentFont = False
          ReadOnly = True
          ScrollBars = ssHorizontal
          TabOrder = 0
        end
      end
    end
    object TabSheet1: TTabSheet
      Caption = 'Configura'#231#245'es'
      ImageIndex = 2
      object Label2: TLabel
        Left = 433
        Top = 181
        Width = 8
        Height = 13
        Caption = '%'
      end
      object GroupBox3: TGroupBox
        Left = 3
        Top = 5
        Width = 520
        Height = 56
        Caption = ' Suprimir caractere '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        object CheckBoxInicio: TCheckBox
          Left = 171
          Top = 27
          Width = 127
          Height = 17
          Caption = 'No in'#237'cio da string'
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
        end
        object CheckBoxFim: TCheckBox
          Left = 297
          Top = 27
          Width = 127
          Height = 17
          Caption = 'No final da string'
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
        end
        object CheckBoxToda: TCheckBox
          Left = 416
          Top = 27
          Width = 97
          Height = 17
          Caption = 'Em toda a string'
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
        end
        object ComboBoxSuprimir: TComboBox
          Left = 11
          Top = 24
          Width = 137
          Height = 21
          Style = csDropDownList
          Color = clInfoBk
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 3
          Items.Strings = (
            ''
            'Barra'
            'Barra Invertida'
            'Barra Vertical'
            'Chaves'
            'Colchetes'
            'Espa'#231'o em Branco'
            'Maior que e menor que'
            'Par'#234'nteses'
            'Ponto')
        end
      end
      object CheckBoxCaseSensitive: TCheckBox
        Left = 14
        Top = 133
        Width = 105
        Height = 17
        Caption = 'CASE SENSITIVE '
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
      end
      object CheckBoxOrdem: TCheckBox
        Left = 14
        Top = 87
        Width = 203
        Height = 17
        Caption = 'Classificar do menor para o maior'
        Enabled = False
        TabOrder = 2
      end
      object CheckBoxSimilaridade: TCheckBox
        Left = 14
        Top = 179
        Width = 361
        Height = 17
        Caption = 
          'Gerar relat'#243'rio de v'#233'rtices similares - taxa de similaridade mai' +
          'or ou igual a a'
        Enabled = False
        TabOrder = 3
      end
      object EditSimilaridade: TEdit
        Left = 379
        Top = 178
        Width = 36
        Height = 21
        Enabled = False
        ReadOnly = True
        TabOrder = 4
        Text = '80'
      end
      object UpDownSimilaridade: TUpDown
        Left = 415
        Top = 178
        Width = 16
        Height = 21
        Associate = EditSimilaridade
        Enabled = False
        Position = 80
        TabOrder = 5
      end
    end
    object TabSheetSaida: TTabSheet
      Caption = 'Sa'#237'da'
      ImageIndex = 1
      object GroupBoxSaida: TGroupBox
        Left = 3
        Top = 177
        Width = 517
        Height = 137
        Caption = ' Sa'#237'da '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        object RichEditSaida: TRichEdit
          Left = 11
          Top = 23
          Width = 494
          Height = 105
          Color = clInfoBk
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          Lines.Strings = (
            'RichEditSaida')
          ParentFont = False
          PlainText = True
          ReadOnly = True
          ScrollBars = ssBoth
          TabOrder = 0
        end
        object RichEditSimilaridade: TRichEdit
          Left = 37
          Top = 44
          Width = 180
          Height = 66
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          Lines.Strings = (
            'RichEditSimilaridade')
          ParentFont = False
          ScrollBars = ssBoth
          TabOrder = 1
          Visible = False
        end
        object RichEditLinhas: TRichEdit
          Left = 301
          Top = 44
          Width = 188
          Height = 66
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          Lines.Strings = (
            'RichEditLinhas')
          ParentFont = False
          PlainText = True
          ScrollBars = ssBoth
          TabOrder = 2
          Visible = False
        end
      end
      object GroupBoxOpcoes: TGroupBox
        Left = 3
        Top = 5
        Width = 520
        Height = 169
        Caption = ' Op'#231#245'es '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 1
        object LabelPriCo: TLabel
          Left = 11
          Top = 24
          Width = 76
          Height = 13
          Caption = 'Primeira Coluna:'
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object LabelSegCo: TLabel
          Left = 190
          Top = 24
          Width = 82
          Height = 13
          Caption = 'Segunda Coluna:'
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object LabelModo: TLabel
          Left = 11
          Top = 72
          Width = 74
          Height = 13
          Caption = 'Modo da Rede:'
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object LabelTipo: TLabel
          Left = 191
          Top = 72
          Width = 68
          Height = 13
          Caption = 'Tipo da Rede:'
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object LabelValor: TLabel
          Left = 362
          Top = 24
          Width = 78
          Height = 13
          Caption = 'Coluna de Valor:'
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object LabelDesprezar: TLabel
          Left = 11
          Top = 120
          Width = 90
          Height = 13
          Caption = 'Ignorar Cabe'#231'alho:'
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object LabelMetodo: TLabel
          Left = 362
          Top = 72
          Width = 152
          Height = 13
          Caption = 'M'#233'todo de Constru'#231#227'o da Rede'
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          Visible = False
        end
        object Label4: TLabel
          Left = 189
          Top = 120
          Width = 66
          Height = 13
          Caption = 'Fun'#231#227'o Peso:'
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object ComboBoxPriCo: TComboBox
          Left = 11
          Top = 40
          Width = 145
          Height = 21
          Style = csDropDownList
          Color = clInfoBk
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          OnChange = ComboBoxPriCoChange
        end
        object ComboBoxSegCo: TComboBox
          Left = 190
          Top = 40
          Width = 145
          Height = 21
          Style = csDropDownList
          Color = clInfoBk
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          OnChange = ComboBoxSegCoChange
        end
        object ComboBoxModo: TComboBox
          Left = 11
          Top = 88
          Width = 145
          Height = 21
          Style = csDropDownList
          Color = clInfoBk
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
          OnChange = ComboBoxModoChange
          Items.Strings = (
            '1-Modo'
            '2-Modos')
        end
        object ComboBoxTipo: TComboBox
          Left = 191
          Top = 88
          Width = 145
          Height = 21
          Style = csDropDownList
          Color = clInfoBk
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 3
          Items.Strings = (
            'N'#227'o dirigido'
            'Dirigido')
        end
        object ComboBoxValor: TComboBox
          Left = 363
          Top = 40
          Width = 145
          Height = 21
          Style = csDropDownList
          Color = clInfoBk
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 4
          OnChange = ComboBoxValorChange
        end
        object EditDesprezar: TEdit
          Left = 11
          Top = 136
          Width = 69
          Height = 21
          Color = clInfoBk
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 5
          Text = '0'
        end
        object UpDownDesprezar: TUpDown
          Left = 80
          Top = 136
          Width = 16
          Height = 21
          Associate = EditDesprezar
          Enabled = False
          Max = 5
          TabOrder = 6
        end
        object ComboBoxMetodo: TComboBox
          Left = 362
          Top = 88
          Width = 145
          Height = 21
          Style = csDropDownList
          Color = clInfoBk
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 7
          Visible = False
          Items.Strings = (
            'Clique'
            'Linha')
        end
        object ComboBoxFuncaoPeso: TComboBox
          Left = 190
          Top = 136
          Width = 145
          Height = 21
          Style = csDropDownList
          Color = clInfoBk
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 8
          OnChange = ComboBoxValorChange
          Items.Strings = (
            ''
            'Somat'#243'rio'
            'M'#225'ximo'
            'M'#237'nimo')
        end
      end
    end
  end
  object ButtonInfo: TButton
    Left = 8
    Top = 571
    Width = 80
    Height = 25
    Caption = 'Info'
    TabOrder = 2
    OnClick = ButtonInfoClick
  end
  object EditSeparador: TEdit
    Left = 506
    Top = 176
    Width = 28
    Height = 21
    Color = clInfoBk
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    MaxLength = 1
    ParentFont = False
    TabOrder = 4
    Visible = False
    OnChange = EditSeparadorChange
  end
  object ButtonTXT: TButton
    Left = 412
    Top = 571
    Width = 135
    Height = 25
    Caption = 'Criar .net'
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 5
    Visible = False
    OnClick = ButtonTXTClick
  end
  object RadioGroupOrganizacao: TRadioGroup
    Left = 8
    Top = 96
    Width = 537
    Height = 54
    Caption = ' Organiza'#231#227'o dos Dados '
    Columns = 2
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    Items.Strings = (
      'colunas'
      'linhas')
    ParentFont = False
    TabOrder = 6
    OnClick = RadioGroupOrganizacaoClick
  end
  object ButtonReset: TButton
    Left = 267
    Top = 571
    Width = 135
    Height = 25
    Caption = 'Reiniciar Configura'#231#245'es'
    Enabled = False
    TabOrder = 7
    Visible = False
    OnClick = ButtonResetClick
  end
  object OpenDialogArquivo: TOpenDialog
    Filter = 'Todos|*.csv;*.txt|TXT|*.txt|CSV|*.csv'
    Left = 488
    Top = 14
  end
  object TimerMSG: TTimer
    Enabled = False
    Interval = 500
    Left = 400
    Top = 13
  end
  object IdHTTP1: TIdHTTP
    AllowCookies = True
    ProxyParams.BasicAuthentication = False
    ProxyParams.ProxyPort = 0
    Request.ContentLength = -1
    Request.ContentRangeEnd = -1
    Request.ContentRangeStart = -1
    Request.ContentRangeInstanceLength = -1
    Request.Accept = 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8'
    Request.BasicAuthentication = False
    Request.UserAgent = 'Mozilla/3.0 (compatible; Indy Library)'
    Request.Ranges.Units = 'bytes'
    Request.Ranges = <>
    HTTPOptions = [hoForceEncodeParams]
    Left = 312
    Top = 16
  end
end
