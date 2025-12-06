namespace ust.saikumar.db;
using {common as t}  from './common';
using {
    managed ,
    Currency,
    cuid
} from '@sap/cds/common';

aspect Verified{
    VerifiedBy: String(10);
    VerifiedAt: Timestamp;
}
aspect Posted{
    PostedBy:String(10);
    PostedAt :Timestamp;
}
aspect audit :managed{
    VerifiedBy: String(10);
    VerifiedAt: Timestamp;
    ApprovedBy:String(20) ;
    ApprovedAt:Timestamp; 
}
type audit_aspect {
    auditby : String(10) @cds.on.insert: $user;
    auditat : DateTime @cds.on.insert: $now;
    verifiedby : String(10);
    verifiedat: DateTime;
    approvedby : String(10);
    approvedat:DateTime;
}

type isActive : String(20) enum { Active;
Inactive};

type MaterialType:String(20) enum {RawMaterial;
Service;
Other}

type uom {
    uom : String(2) default 'KG';
}

type Status : String(15) enum{Draft; 
Submitted;
Approved;
Rejected;
Closed;
Cancelled}

type po_status : String(15) enum{Open;
 Partially;
    Received;
   FullyReceived; 
   Cancelled

}


context MasterData{
    @Core.AutoExpand : true
    entity VendorMaster : managed {
        key VendorID : UUID not null @title : 'Vendor ID' @mandatory;
        VendorCode : Integer @title : 'Vendor Code';
        VendorName : String(30) @title : 'Vendor Name';
        Address : t.Address @title : 'Address';
        TaxId:String(15) @title : 'Tax ID';
        contact:t.contact @title : 'Contact';
        PaymentTerms:String(30) @title : 'Payment Terms';
        @assert.enum
        Flag:isActive default #Inactive;
        to_poorders : Composition of many PurchaseOrderManagement.POHeader on to_poorders.Vendor=$self;
        to_Veninvc : Composition of many invoiceManagement.InvoiceHeader on to_Veninvc.Vendor=$self;
    }
    entity MaterialMaster : managed{
        key MaterialID : UUID not null @title : 'Material ID';
        MaterialCode : String(10) not null @title : 'Material Code';
        MaterialDescription : String(50) @title : 'Material Description';
        @assert.enum
        MaterialType: MaterialType @title : 'Material Type';
        UoM:uom @title : 'Unit of Measurements';
        StandardPrice:Decimal(10,2) @title : 'Satandard Price';
        GSTPercent:Decimal(10,2) @title : 'GST%';
        @assert.enum
        Flag:isActive default #Inactive;
        to_poitems : Composition of many PurchaseOrderManagement.POItems on to_poitems.Material = $self;
    }
}

context PurchaseOrderManagement{

    entity POHeader : managed{
        key POID : UUID not null @title : 'Purchase Order ID';
        PONumber : String @title : 'Purchase Order Number';
        Vendor : Association to MasterData.VendorMaster;
        CompanyCode:String(10) not null @title : 'Company Code';
        Currency : Currency default 'INR';
        DocumentDate : Date @title : 'Document Date';
        DeliveryDate : Date @title : 'Delivery Date';
        PaymentTerms : String(30) @title : 'Payment Terms' ;
        TotalPOValue : Decimal(10, 2) @title : 'Total Purchase Order Value';
        @assert.enum
        Status : Status;
        Approved : t.post_aspect;
        Remarks : String(100);
        to_poitems: Composition of many POItems on to_poitems.POID =$self;
    }

    entity POItems : managed {
        key POItemID: UUID not null @title : 'Purchase Order Item Id';
        POID:Association to POHeader @title : 'Purchase Order ID';
        LineItemNo: Integer @title : 'Line Item Number';
        Material : Association to MasterData.MaterialMaster @title : 'Material ID';
        Description : String(50);
        Quantity : Integer;
        UoM : uom;
        NetPrice : Decimal(10, 2);
        DiscountP : Decimal(10, 2);
        GSTP:Decimal(10, 2);
        NetValue: Decimal(10, 2)= (Quantity * NetPrice) - (Quantity * NetPrice)*DiscountP/100;
        ReceivedQuantity : Integer;
        OpenQuantity :String;
        Status: po_status;
        to_gritems:Composition of many GoodsReceipt.GRItems on to_gritems.POItem=$self;
        to_invcitems:Composition of many  invoiceManagement.InvoiceItem on to_invcitems.POItem =$self;
    }

}

context GoodsReceipt {
    entity GRHeader :managed {
        key GRID :UUID not null @title : 'Goods Receipt';
        GRNumber :String @title: 'Goods Receipt Number';
        POReference : Association to PurchaseOrderManagement.POHeader;
        GRDate :Date;
        Warehouse: String(20);
        Status: String enum {Draft; Posted};  
        to_gritems:Composition of many GRItems on to_gritems.GoodsReceipt = $self;
    }    
 
    entity GRItems : managed {
        key GRItemID :UUID not null;
        GoodsReceipt : Association to GRHeader;
        POItem : Association to PurchaseOrderManagement.POItems;
        ReceivedQuantity : Integer;
        UoM :Integer;
        BatchNumber :Integer;
        Remarks: String(100);
    }
}
 
context invoiceManagement{
    entity InvoiceHeader : managed ,Verified , Posted{
        key InvoiceID : UUID not null;
        Vendor: Association to MasterData.VendorMaster;
        ReferencePO: Association to PurchaseOrderManagement.POHeader;
        ReferenceGR : Association to  GoodsReceipt.GRHeader;
        InvoiceDate:Date;
        PostingDate:Date;
        Currency:Currency;
        AmountBeforeTax:Decimal(10,2);
        TaxAmount :Decimal(10,2);
        TotalAmount :Decimal(10,2);
        @assert.enum
        Status : String enum {Draft; 
        Verified; 
        Posted; 
        Rejected; 
        Cancelled;};
        ReasonforRejection:String(100);
        to_invcitems:Composition of many InvoiceItem on to_invcitems.Invoice =$self;
    }
    entity InvoiceItem : managed {
      key InvoiceItemID:UUID not null;
       Invoice: Association to InvoiceHeader;
       POItem : Association to PurchaseOrderManagement.POItems;
       GRItem : Association to GoodsReceipt.GRItems;
       QuantityInvoiced : Integer;
       UoM:uom;
       NetPrice: Decimal(10,2);
       Discount:Decimal(2,2);
       GSTPercent:Decimal(2,2);
       LineNetAmount : Decimal(10,2);
       LineTaxAmount : Decimal(10,2);
       LineTotalAmount: Decimal(10,2);
    }
}

entity eaudit : managed,cuid{
    // key error_id : UUID not null default 4566677;
    error_po : Association to PurchaseOrderManagement.POHeader;
    error_status: String(10) default '404';
    audit_status : String(10) default 'UnChanged';
    audit_log : audit_aspect;
}