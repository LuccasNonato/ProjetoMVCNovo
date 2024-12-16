object DataModule1: TDataModule1
  Height = 526
  Width = 719
  object con1: TFDConnection
    Params.Strings = (
      'Database=C:\Users\Luccas\Desktop\projeto 13-12\bd\Banco.db'
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
  object RESTClient1: TRESTClient
    BaseURL = 'https://viacep.com.br/ws/17522410/json'
    Params = <>
    SynchronizedEvents = False
    Left = 256
    Top = 352
  end
  object RESTRequest1: TRESTRequest
    AssignedValues = [rvConnectTimeout, rvReadTimeout]
    Client = RESTClient1
    Params = <>
    Response = RESTResponse1
    SynchronizedEvents = False
    Left = 344
    Top = 352
  end
  object RESTResponse1: TRESTResponse
    Left = 440
    Top = 352
  end
end
