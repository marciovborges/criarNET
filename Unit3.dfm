object Form3: TForm3
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  Caption = 'Atualiza'#231#245'es'
  ClientHeight = 123
  ClientWidth = 472
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 16
    Top = 8
    Width = 440
    Height = 19
    Alignment = taCenter
    AutoSize = False
    Caption = 'Aten'#231#227'o!'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 12615680
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 16
    Top = 43
    Width = 259
    Height = 13
    Caption = 'Nova vers'#227'o dispon'#237'vel! Liberada em: '#39'+lastVersion+'#39'.'
  end
  object Label3: TLabel
    Left = 16
    Top = 64
    Width = 383
    Height = 13
    Caption = 
      'At'#233' o momento j'#225' foram efetuados '#39'+countDownload+'#39' downloads do ' +
      'criarNET!'#39
  end
  object LinkLabel1: TLinkLabel
    Left = 175
    Top = 98
    Width = 125
    Height = 17
    Caption = 
      '<a href="http://www.mxminformatica.com.br/criarNET/lastVersion/i' +
      'ndex.php">Clique aqui para atualizar</a>'
    TabOrder = 0
    OnLinkClick = LinkLabel1LinkClick
  end
end
