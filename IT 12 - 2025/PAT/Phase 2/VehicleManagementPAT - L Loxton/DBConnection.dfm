object DataModule1: TDataModule1
  OnCreate = DataModuleCreate
  Height = 960
  Width = 1280
  object tblUsers: TADOTable
    Left = 144
    Top = 228
  end
  object tblTestApplications: TADOTable
    Left = 232
    Top = 228
  end
  object tblLicensingStations: TADOTable
    Left = 144
    Top = 308
  end
  object tblLicenses: TADOTable
    Left = 232
    Top = 308
  end
  object tblFines: TADOTable
    Left = 316
    Top = 308
  end
  object dsTblUsers: TDataSource
    Left = 476
    Top = 236
  end
  object dsTestApplications: TDataSource
    Left = 560
    Top = 228
  end
  object dsLicensingStations: TDataSource
    Left = 472
    Top = 292
  end
  object dsLicenses: TDataSource
    Left = 560
    Top = 296
  end
  object dsFines: TDataSource
    Left = 648
    Top = 292
  end
  object VehicleManagementDB: TADOConnection
    Left = 132
    Top = 108
  end
  object ADOQuery1: TADOQuery
    FieldOptions.UpdatePersistent = True
    Parameters = <>
    Left = 524
    Top = 472
  end
  object tblPayments: TADOTable
    Left = 136
    Top = 388
  end
  object dsPayments: TDataSource
    Left = 616
    Top = 372
  end
end
