const cds = require('@sap/cds');
module.exports = cds.service.impl(function () {
    const { Vendors } = this.entities;
    this.before(['CREATE'], 'Vendors', (req) => {
        if (req.data.PaymentTerms > 45) {
            req.error(403, 'Payment Terms should not be greater than 45');
        }

    });
    this.before('CREATE', 'Vendors', async (req) => {
        const { VendorCode } = req.data;

        if (VendorCode) {
            const existing = await SELECT.one.from('ust.saikumar.db.MasterData.VendorMaster')
                .where({ VendorCode: VendorCode });

            if (existing) {
                req.error(400, `Vendor Code ${VendorCode} already exists`);
            }
        }
    });

    this.before('UPDATE', 'Vendors', (req) => {

        if (req.data.PaymentTerms > 45) {
            req.error(400, 'Payment Terms cannot be greater than 45');
        }
    });
    this.after('CREATE', 'Vendors', (data) => {
        console.log(`Vendor Created: ${data.VendorName}`);
    });

    this.after('UPDATE', 'Vendors', (data) => {
        console.log(`Vendor Updated: ${data.VendorID}`);
    });

    this.after('DELETE', 'Vendors', (data, req) => {
        console.log(`Vendor Deleted: ${req.data.VendorID}`);
    });
})


