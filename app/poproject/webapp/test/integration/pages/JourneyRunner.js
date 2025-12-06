sap.ui.define([
    "sap/fe/test/JourneyRunner",
	"com/ust/poproject/test/integration/pages/VendorsList",
	"com/ust/poproject/test/integration/pages/VendorsObjectPage",
	"com/ust/poproject/test/integration/pages/POHeaderObjectPage"
], function (JourneyRunner, VendorsList, VendorsObjectPage, POHeaderObjectPage) {
    'use strict';

    var runner = new JourneyRunner({
        launchUrl: sap.ui.require.toUrl('com/ust/poproject') + '/test/flp.html#app-preview',
        pages: {
			onTheVendorsList: VendorsList,
			onTheVendorsObjectPage: VendorsObjectPage,
			onThePOHeaderObjectPage: POHeaderObjectPage
        },
        async: true
    });

    return runner;
});

