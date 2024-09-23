using { Currency, User, managed, cuid } from '@sap/cds/common';
using sap.capire.bookshop.Books from './master/Books';

namespace sap.capire.orders;

entity Orders :  managed {
  key OrderNo  : String(22); 
  Items    : Composition of many {
    key ID    : UUID;
    books_id  : Integer;
    books     : Association to Books on books.ID = books_id;
    quantity  : Integer;
    title     : String; //> intentionally replicated as snapshot from product.title
    price     : Double; //> materialized calculated field
  };
  buyer    : User;
  currency : Currency;
  orddate : Date;

}

/** This is a stand-in for arbitrary ordered Products */
//entity Products {
//  key ID : String;
//}


entity Orders2 : managed {
  key OrderNo  : String(22); 
  items: Composition of many Orders2_Items on items.OrderNo = OrderNo;
  buyer    : User;
  currency : Currency;
  orddate : Date;
}

entity Orders2_Items {
    key ID    : UUID;
    OrderNo : String(22);
    books_id  : Integer;
    books     : Association to Books on books.ID = books_id;
    quantity  : Integer;
    title     : String; //> intentionally replicated as snapshot from product.title
    price     : Double; //> materialized calculated field
  
};