object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 550
  ClientWidth = 1039
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  WindowState = wsMaximized
  OnCreate = FormCreate
  TextHeight = 15
  object lbl2: TLabel
    Left = 9
    Top = 24
    Width = 89
    Height = 15
    Caption = 'Nome Completo'
  end
  object lbl3: TLabel
    Left = 76
    Top = 52
    Width = 21
    Height = 15
    Caption = 'CPF'
  end
  object lbl4: TLabel
    Left = 278
    Top = 24
    Width = 29
    Height = 15
    Caption = 'Email'
  end
  object lbl5: TLabel
    Left = 286
    Top = 52
    Width = 21
    Height = 15
    Caption = 'Cep'
  end
  object lbl6: TLabel
    Left = 475
    Top = 22
    Width = 31
    Height = 15
    Caption = 'Bairro'
  end
  object lbl7: TLabel
    Left = 444
    Top = 53
    Width = 62
    Height = 15
    Caption = 'Tipo Pessoa'
  end
  object lbl8: TLabel
    Left = 15
    Top = 97
    Width = 91
    Height = 15
    Caption = 'Data Nascimento'
  end
  object lbl9: TLabel
    Left = 83
    Top = 121
    Width = 15
    Height = 15
    Caption = 'RG'
  end
  object lbl10: TLabel
    Left = 263
    Top = 97
    Width = 44
    Height = 15
    Caption = 'Telefone'
  end
  object lbl11: TLabel
    Left = 245
    Top = 121
    Width = 62
    Height = 15
    Caption = 'Logradouro'
  end
  object lbl12: TLabel
    Left = 469
    Top = 92
    Width = 37
    Height = 15
    Caption = 'Cidade'
  end
  object lbl13: TLabel
    Left = 471
    Top = 121
    Width = 35
    Height = 15
    Caption = 'Estado'
  end
  object lbl14: TLabel
    Left = 766
    Top = 56
    Width = 20
    Height = 15
    Caption = 'Log'
  end
  object lbl15: TLabel
    Left = 386
    Top = 253
    Width = 31
    Height = 15
    Caption = 'Busca'
  end
  object dbgrd1: TDBGrid
    Left = 0
    Top = 274
    Width = 1039
    Height = 276
    Align = alBottom
    DataSource = DataSource
    Options = [dgTitles, dgIndicator, dgColumnResize, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = 'Segoe UI'
    TitleFont.Style = []
    OnCellClick = dbgrd1CellClick
    OnKeyDown = dbgrd1KeyDown
    OnKeyUp = dbgrd1KeyUp
  end
  object btn1: TButton
    Left = 96
    Top = 233
    Width = 85
    Height = 25
    Align = alCustom
    Caption = 'Salvar'
    TabOrder = 14
    OnClick = btn1Click
  end
  object btn2: TButton
    Left = 187
    Top = 233
    Width = 75
    Height = 25
    Align = alCustom
    Caption = 'Deletar'
    TabOrder = 15
    OnClick = btn2Click
  end
  object btn3: TButton
    Left = 268
    Top = 233
    Width = 75
    Height = 25
    Align = alCustom
    Caption = 'Editar'
    TabOrder = 16
    OnClick = btn3Click
  end
  object edtNomeCompleto: TEdit
    Left = 120
    Top = 21
    Width = 121
    Height = 23
    TabOrder = 1
  end
  object edtCpf: TEdit
    Left = 120
    Top = 49
    Width = 121
    Height = 23
    TabOrder = 2
    OnExit = edtCpfExit
  end
  object edtRg: TEdit
    Left = 120
    Top = 118
    Width = 121
    Height = 23
    TabOrder = 8
    OnExit = edtRgExit
  end
  object edtEmail: TEdit
    Left = 320
    Top = 21
    Width = 121
    Height = 23
    TabOrder = 3
    OnExit = edtEmailExit
  end
  object dtpNascimento: TDateTimePicker
    Left = 120
    Top = 89
    Width = 121
    Height = 23
    Date = 45640.000000000000000000
    Time = 0.688704027779749600
    TabOrder = 7
  end
  object edtTelefone: TEdit
    Left = 320
    Top = 89
    Width = 121
    Height = 23
    TabOrder = 9
    OnExit = edtTelefoneExit
  end
  object edtCep: TEdit
    Left = 320
    Top = 49
    Width = 121
    Height = 23
    TabOrder = 4
    OnExit = edtCepExit
  end
  object edtLogradouro: TEdit
    Left = 320
    Top = 118
    Width = 121
    Height = 23
    TabOrder = 10
  end
  object edtBairro: TEdit
    Left = 527
    Top = 21
    Width = 121
    Height = 23
    TabOrder = 5
  end
  object edtCidade: TEdit
    Left = 528
    Top = 89
    Width = 121
    Height = 23
    TabOrder = 11
  end
  object edtEstado: TEdit
    Left = 528
    Top = 118
    Width = 121
    Height = 23
    TabOrder = 12
  end
  object edtTipoPessoa: TComboBox
    Left = 528
    Top = 50
    Width = 145
    Height = 23
    ItemIndex = 0
    TabOrder = 6
    Text = 'Cliente'
    Items.Strings = (
      'Cliente'
      'Fornecedor'
      'Transportador'
      'Funcionario')
  end
  object mmoLog: TMemo
    Left = 734
    Top = 77
    Width = 405
    Height = 163
    Lines.Strings = (
      'mmoLog')
    TabOrder = 17
  end
  object btn4: TButton
    Left = 5
    Top = 233
    Width = 85
    Height = 25
    Align = alCustom
    Caption = 'Novo'
    TabOrder = 13
    OnClick = btn4Click
  end
  object edtBusca: TMaskEdit
    Left = 432
    Top = 246
    Width = 553
    Height = 23
    TabOrder = 18
    Text = ''
    OnExit = edtBuscaExit
  end
  object DataSource: TDataSource
    Left = 560
    Top = 136
  end
end
