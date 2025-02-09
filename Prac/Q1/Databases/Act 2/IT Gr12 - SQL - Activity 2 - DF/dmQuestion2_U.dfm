object dmQuestion2: TdmQuestion2
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 146
  Width = 277
  object connFoodOrders: TADOConnection
    ConnectionString = 
      'Provider=Microsoft.Jet.OLEDB.4.0;Data Source=D:\1 Skool\OneDrive' +
      ' - Ho'#235'rskool Garsfontein\1 Skool 2018\Rekord\IT Prelim P1 2018 -' +
      ' Draft 1\DataPRELIM2018\Question 3\ClientOrders.mdb;Mode=ReadWri' +
      'te;Persist Security Info=False'
    LoginPrompt = False
    Provider = 'Microsoft.Jet.OLEDB.4.0'
    Left = 40
    Top = 40
  end
  object qryQ2: TADOQuery
    Connection = connFoodOrders
    Parameters = <>
    Left = 112
    Top = 40
  end
  object dsrQ2: TDataSource
    DataSet = qryQ2
    Left = 176
    Top = 40
  end
end
