object dm: Tdm
  OnCreate = DataModuleCreate
  Height = 526
  Width = 719
  object con1: TFDConnection
    Params.Strings = (
      'Database=C:\Users\Luccas\Desktop\projeto\bd\Banco.db'
      'DriverID=SQLite')
    LoginPrompt = False
    Left = 248
    Top = 184
  end
  object FDTransaction1: TFDTransaction
    Connection = con1
    Left = 336
    Top = 184
  end
  object FDQuery1: TFDQuery
    Connection = con1
    Left = 320
    Top = 328
  end
end
