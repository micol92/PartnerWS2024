sap.ui.require(
    [
        'sap/fe/test/JourneyRunner',
        'fioriapp01/test/integration/FirstJourney',
		'fioriapp01/test/integration/pages/OrdersList',
		'fioriapp01/test/integration/pages/OrdersObjectPage'
    ],
    function(JourneyRunner, opaJourney, OrdersList, OrdersObjectPage) {
        'use strict';
        var JourneyRunner = new JourneyRunner({
            // start index.html in web folder
            launchUrl: sap.ui.require.toUrl('fioriapp01') + '/index.html'
        });

       
        JourneyRunner.run(
            {
                pages: { 
					onTheOrdersList: OrdersList,
					onTheOrdersObjectPage: OrdersObjectPage
                }
            },
            opaJourney.run
        );
    }
);