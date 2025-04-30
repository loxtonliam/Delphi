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
  object tblProvinces: TADOTable
    Left = 128
    Top = 388
  end
  object tblLicenseTypes: TADOTable
    Left = 320
    Top = 228
  end
  object dsTblUsers: TDataSource
    Left = 476
    Top = 236
  end
  object dsProvinces: TDataSource
    Left = 472
    Top = 360
  end
  object dsTestApplications: TDataSource
    Left = 560
    Top = 228
  end
  object dsLicenseTypes: TDataSource
    Left = 648
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
    Parameters = <>
    Left = 556
    Top = 472
  end
  object tblUserRoles: TADOTable
    Left = 248
    Top = 396
  end
  object dsUserRoles: TDataSource
    Left = 536
    Top = 368
  end
end
