using { ust.saikumar.db as db } from '../db/schema';



@path : 'MasterService'
service MasterService {
    @odata.draft.enabled
    @Capabilities : { Insertable:true,Updatable:true,Deletable:true}
    entity Vendors as projection on db.MasterData.VendorMaster;

    entity Materials as projection on db.MasterData.MaterialMaster;
}


@path : 'PurchaseService'
service PurchaseService {

    entity PurchaseOrders as projection on db.PurchaseOrderManagement.POHeader;

    entity PurchaseOrderItems as projection on db.PurchaseOrderManagement.POItems;
}


@path : 'GRService'
service GRService {

    @odata.draft.enabled
    entity GoodsReceipts as projection on db.GoodsReceipt.GRHeader;

    
    entity GoodsReceiptItems as projection on db.GoodsReceipt.GRItems;
}



@path : 'InvoiceService'
service InvoiceService {

    @odata.draft.enabled
    entity Invoices as projection on db.invoiceManagement.InvoiceHeader;

    
    entity InvoiceItems as projection on db.invoiceManagement.InvoiceItem;
}


@path : 'AuditService'
service AuditService {

    entity ErrorAudits as projection on db.eaudit;
}
