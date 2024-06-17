object DataModule3: TDataModule3
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 407
  Width = 580
  object CDBio: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 24
    Top = 16
  end
  object CDCust: TClientDataSet
    Aggregates = <>
    FieldDefs = <>
    IndexDefs = <>
    IndexFieldNames = 'Company'
    Params = <>
    StoreDefs = True
    Left = 504
    Top = 16
  end
  object CDCross: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 120
    Top = 16
  end
  object CDUnicode: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 168
    Top = 16
  end
  object CDCountry: TClientDataSet
    Aggregates = <>
    IndexFieldNames = 'Continent'
    Params = <>
    Left = 312
    Top = 208
  end
  object CDCurQuote: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 72
    Top = 88
  end
  object CDCustQuery: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 400
    Top = 16
  end
  object CDEmpl: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 144
    Top = 112
  end
  object CDItems: TClientDataSet
    Aggregates = <>
    IndexFieldNames = 'OrderNo'
    MasterFields = 'OrderNo'
    MasterSource = OrdersDS
    PacketRecords = 0
    Params = <>
    Left = 504
    Top = 232
  end
  object CDnextcust: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 24
    Top = 168
  end
  object CDnextitem: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 80
    Top = 232
  end
  object CDnextord: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 136
    Top = 168
  end
  object CDorders: TClientDataSet
    Aggregates = <>
    IndexFieldNames = 'CustNo'
    MasterFields = 'CustNo'
    MasterSource = CustDS
    PacketRecords = 0
    Params = <>
    Left = 504
    Top = 120
  end
  object CDparts: TClientDataSet
    Aggregates = <>
    IndexFieldNames = 'PartNo'
    MasterFields = 'PartNo'
    MasterSource = ItemsDS
    PacketRecords = 0
    Params = <>
    Left = 504
    Top = 344
  end
  object CDVendors: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 16
    Top = 224
  end
  object CustDS: TDataSource
    DataSet = CDCust
    Left = 504
    Top = 65
  end
  object OrdersDS: TDataSource
    DataSet = CDorders
    Left = 504
    Top = 176
  end
  object ItemsDS: TDataSource
    DataSet = CDItems
    Left = 504
    Top = 288
  end
end
