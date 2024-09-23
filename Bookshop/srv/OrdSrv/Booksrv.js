const cds = require('@sap/cds');

/**
* Implementation for Risk Management service defined in ./risk-service.cds
*/
//module.exports = cds.service.impl(async function() {

  module.exports = class CatalogService extends cds.ApplicationService {
    
    init(){
      const { Books, Authors } = cds.entities('sap.capire.bookshop');

  
      this.on('READ', 'Suppliers', async req => {
          const bupa =  await cds.connect.to('API_BUSINESS_PARTNER_0001');
          return bupa.run(req.query);
      });

      this.before('CREATE', 'Books', async(req) => {
          console.log("req.user:"+req.user.attr);
          if (req.user.attr != 'management')
          {
              req.reject(403, 'Access restricted to users from management department');
          }

          if (req.stock > 100) {
            req.title += ` -- 11% discount!`;
          }
      });


      this.before('SELECT', 'Authors', async(req) => {
         let rt = await cds.db.run("select * from SAP_CAPIRE_BOOKSHOP_AUTHORS");
         if ( rt && rt.length > 0) {
           console.log(rt[0].name);
         } else {
           console.log("data is nothing")
         }  
      });

      this.on('insActBooks', async req => {

          let { ID, title, stock } = req.data;
    
          //consistent distributed TX (one commit / one rollback)
          //insert local Books;
          let book = await INSERT.into( Books, {ID, title, stock})
          //let book = await INSERT.into( 'SAP_CAPIRE_BOOKSHOP_BOOKS', {ID, title, stock})

          //insert remote Books;
          //let ql = INSERT.into('Books', {ID, title, stock})
      
          return cds.run(book);   

        })

        this.on('insActBooks2', async req => {
          let { ID, title, stock } = req.data;

          let dbconn, dbtx;
          try {

            dbconn = await cds.connect.to('db');
            console.log("step1;;;")

            if ( !dbconn ) {
              throw new Error("Fail : db connection");
            }

            dbtx = dbconn.tx();
            console.log("step2;;;")

            if( !dbtx) {
              throw new Error("Fail : DB Tx Ceation")
            }
            console.log("step3;;;")

            let dbrt = await dbtx.run(INSERT.into( Books, {ID, title, stock}));
            await dbtx.commit();
            console.log("step4;;;")

            return dbrt;  
          }
          catch (err){
            console.log("tx error:"+err.message);
            await dbtx.rollback();
            return "fail";
          }
          //consistent distributed TX (one commit / one rollback)
          //insert local Books;
          //let book = await INSERT.into( Books, {ID, title, stock})
          //let book = await INSERT.into( 'SAP_CAPIRE_BOOKSHOP_BOOKS', {ID, title, stock})

          //insert remote Books;
          //let ql = INSERT.into('Books', {ID, title, stock})


        })     
        return super.init()

      }    
};
//module.exports = CatalogService

