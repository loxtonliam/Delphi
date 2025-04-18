object DataModule1: TDataModule1
  OnCreate = DataModuleCreate
  Height = 1920
  Width = 2560
  PixelsPerInch = 192
  object tblUsers: TADOTable
    Left = 288
    Top = 456
  end
  object tblTestApplications: TADOTable
    Left = 464
    Top = 456
  end
  object tblLicensingStations: TADOTable
    Left = 288
    Top = 616
  end
  object tblLicenses: TADOTable
    Left = 464
    Top = 616
  end
  object tblFines: TADOTable
    Left = 632
    Top = 616
  end
  object tblCarOwners: TADOTable
    Left = 288
    Top = 792
  end
  object tblAdminAccounts: TADOTable
    Left = 640
    Top = 456
  end
  object dsTblUsers: TDataSource
    Left = 952
    Top = 472
  end
  object dsCarOwners: TDataSource
    Left = 944
    Top = 720
  end
  object dsTestApplications: TDataSource
    Left = 1120
    Top = 456
  end
  object dsAdminAccounts: TDataSource
    Left = 1296
    Top = 456
  end
  object dsLicensingStations: TDataSource
    Left = 944
    Top = 584
  end
  object dsLicenses: TDataSource
    Left = 1120
    Top = 592
  end
  object dsFines: TDataSource
    Left = 1296
    Top = 584
  end
  object VehicleManagementDB: TADOConnection
    Left = 264
    Top = 216
  end
  object ADOQuery1: TADOQuery
    Parameters = <>
    Left = 1144
    Top = 864
  end
end
