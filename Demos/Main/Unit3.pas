unit Unit3;

interface

uses
  System.SysUtils, System.Classes, Data.DB, Datasnap.DBClient, FMX.frxClass, FMX.frxDBSet;

type
  TDataModule3 = class(TDataModule)
    CDBio: TClientDataSet;
    CDCust: TClientDataSet;
    CDCross: TClientDataSet;
    CDUnicode: TClientDataSet;
    CDCountry: TClientDataSet;
    CDCurQuote: TClientDataSet;
    CDCustQuery: TClientDataSet;
    CDEmpl: TClientDataSet;
    CDItems: TClientDataSet;
    CDnextcust: TClientDataSet;
    CDnextitem: TClientDataSet;
    CDnextord: TClientDataSet;
    CDorders: TClientDataSet;
    CDparts: TClientDataSet;
    CDVendors: TClientDataSet;
    CustDS: TDataSource;
    OrdersDS: TDataSource;
    ItemsDS: TDataSource;
    procedure DataModuleCreate(Sender: TObject);
  private
     FBiolife: TfrxDBDataSet;
     FCustomers: TfrxDBDataSet;
     FCrossTest: TfrxDBDataSet;
     FUnicode: TfrxDBDataSet;
     FOrders: TfrxDBDataset;
     FItems: TfrxDBDataset;
     FPart: TfrxDBDataset;
     FSales: TfrxDBDataset;
     FCountry: TfrxDBDataset;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DataModule3: TDataModule3;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

procedure TDataModule3.DataModuleCreate(Sender: TObject);
var
  DataPath: String;
begin
  DataPath := ExtractFilePath(ParamStr(0)) + PathDelim + 'Data' + PathDelim;
  FBiolife := TfrxDBDataSet.Create(Self);
  FBiolife.Name := 'Biolife';
  FBiolife.UserName := 'Bio';
  CDBio.LoadFromFile(DataPath + 'biolife.xml');
  FBiolife.DataSet := CDBio;
  FBiolife.FieldAliases.Delimiter := ';';
  FBiolife.FieldAliases.StrictDelimiter  := True;
  FBiolife.FieldAliases.DelimitedText := 'Species No=Species No;Category=Category;Common_Name=Common Name;Species Name=Species Name;Length (cm)=Length (cm);Length_In=Length In;Notes=Notes;Graphic=Graphic';

  FCustomers := TfrxDBDataSet.Create(Self);
  FCustomers.Name := 'Customers';
  FCustomers.UserName := 'Customers';
  FCustomers.FieldAliases.Delimiter := ';';
  FCustomers.FieldAliases.StrictDelimiter  := True;
  FCustomers.FieldAliases.DelimitedText := 'CustNo=Cust No;Company=Company;Addr1=Addr1;Addr2=Addr2;City=City;State=State;Zip=Zip;Country=Country;Phone=Phone;FAX=FAX;TaxRate=Tax Rate;Contact=Contact;LastInvoiceDate=Last Invoice Date';


  CDCust.LoadFromFile(DataPath + 'customer.xml');
  FCustomers.DataSet := CDCust;

  FCrossTest := TfrxDBDataSet.Create(Self);
  FCrossTest.Name := 'Cross';
  FCrossTest.UserName := 'Cross';
  CDCross.LoadFromFile(DataPath + 'crosstest.xml');
  FCrossTest.DataSet := CDCross;

  FUnicode := TfrxDBDataSet.Create(Self);

  FUnicode.Name := 'Unicode';
  FUnicode.UserName := 'Unicode';
  CDUnicode.LoadFromFile(DataPath + 'unicode.xml');
  FUnicode.DataSet := CDUnicode;

  FOrders := TfrxDBDataset.Create(Self);
  FOrders.Name := 'Orders';
  FOrders.UserName := 'Orders';
  CDorders.LoadFromFile(DataPath + 'orders.xml');
  FOrders.DataSet := CDorders;
  FOrders.FieldAliases.Delimiter := ';';
  FOrders.FieldAliases.StrictDelimiter  := True;
  FOrders.FieldAliases.DelimitedText := 'OrderNo=Order No;CustNo=Cust No;CustCompany=Cust Company;SaleDate=Sale Date;ShipDate=Ship Date;EmpNo=Emp No;' +
  'ShipToContact=Ship To Contact;ShipToAddr1=Ship To Addr1;ShipToAddr2=Ship To Addr2;ShipToCity=Ship To City;ShipToState=Ship To State;ShipToZip=Ship To Zip;ShipToCountry=Ship To Country;ShipToPhone=Ship To Phone;ShipVIA=Ship VIA;'+
  'PO=PO;Terms=Terms;PaymentMethod=Payment Method;ItemsTotal=Items Total;TaxRate=Tax Rate;Freight=Freight;AmountPaid=Amount Paid';

  FItems := TfrxDBDataset.Create(Self);
  FItems.Name := 'Items';
  FItems.UserName := 'Items';
  CDItems.LoadFromFile(DataPath + 'items.xml');
  FItems.DataSet := CDItems;
  FItems.FieldAliases.Delimiter := ';';
  FItems.FieldAliases.StrictDelimiter  := True;
  //FItems.FieldAliases.DelimitedText := 'OrderNo=Order No;ItemNo=Item No;PartNo=Part No;PartName=Part Name;Qty=Qty;Price=Price;Discount=Discount;Total=Total;ExtendedPrice=Extended Price';

  FPart := TfrxDBDataset.Create(Self);
  FPart.Name := 'Parts';
  FPart.UserName := 'Parts';
  CDParts.LoadFromFile(DataPath + 'parts.xml');
  FPart.DataSet := CDParts;
  FPart.FieldAliases.Delimiter := ';';
  FPart.FieldAliases.StrictDelimiter  := True;
  FPart.FieldAliases.DelimitedText := 'PartNo=Part No;VendorNo=Vendor No;Description=Description;OnHand=On Hand;OnOrder=On Order;Cost=Cost;ListPrice=List Price';

  FSales := TfrxDBDataset.Create(Self);
  FSales.Name := 'Sales';
  FSales.UserName := 'Sales';
  CDCustQuery.LoadFromFile(DataPath + 'customer_query.xml');
  FSales.DataSet := CDCustQuery;
  FSales.FieldAliases.Delimiter := ';';
  FSales.FieldAliases.StrictDelimiter  := True;
//  FSales.FieldAliases.DelimitedText := 'CustNo=Cust No;Company=Company;Addr1=Addr1;Addr2=Addr2;City=City;State=State' +
//      'Zip=Zip;Country=Country;Phone=Phone;FAX=FAX;TaxRate=a.TaxRate;Contact=Contact' +
//      'LastInvoiceDate=LastInvoiceDate;OrderNo=Order No;CustNo=b.CustNo;SaleDate=Sale Date' +
//      'ShipDate=ShipDate;EmpNo=EmpNo;ShipToContact=ShipToContact;ShipToAddr1=ShipToAddr1' +
//      'ShipToAddr2=ShipToAddr2;ShipToCity=ShipToCity;ShipToState=ShipToState;ShipToZip=ShipToZip' +
//      'ShipToCountry=ShipToCountry;ShipToPhone=ShipToPhone;ShipVIA=ShipVIA;PO=PO;Terms=Terms' +
//      'PaymentMethod=PaymentMethod;ItemsTotal=ItemsTotal;TaxRate=b.TaxRate;Freight=Freight;AmountPaid=AmountPaid;OrderNo=c.OrderNo' +
//      'ItemNo=ItemNo;PartNo=Part No;Qty=Qty;Discount=Discount;PartNo=d.PartNo;VendorNo=VendorNo' +
//      'Description=Description;OnHand=OnHand;OnOrder=OnOrder;Cost=Cost;ListPrice=List Price';


  FCountry := TfrxDBDataset.Create(Self);
  FCountry.Name := 'Country';
  FCountry.UserName := 'Country';
  CDCountry.LoadFromFile(DataPath + 'country.xml');
  FCountry.DataSet := CDCountry;
  //FCountry.FieldAliases.Delimiter := ';';
  //FCountry.FieldAliases.DelimitedText :=
end;

end.
