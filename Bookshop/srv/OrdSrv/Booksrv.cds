using { sap.capire.bookshop as my } from '../../db/index';
service CatalogService @(path:'/books') {

  //s4hana api hub
  @readonly
  entity Suppliers as projection on my.Suppliers;    

  /** For displaying lists of Books */
  entity ListOfBooks as projection on Books
  excluding { descr };



  /** For display in details pages */
  //entity Books as projection on my.Books;
  @(requires: 'support')
  entity Books as projection on my.Books;

  @(restrict: [
     { grant: '*',
       to: ['support']   } ])
  entity Authors as projection on my.Authors ;
  //entity GenreType as projection on my.GenreType;

 // entity Authors as projection on my.Authors{name, books.title};
  @requires: 'authenticated-user'
  //automatic tx management
  action insActBooks ( ID: Integer, title: String, stock: Integer ) returns { ID: Integer; stock: Integer };
  //manual tx managment
  action insActBooks2 ( ID: Integer, title: String, stock: Integer ) returns { ID: Integer; stock: Integer };


  action submitOrder ( book: Books:ID, quantity: Integer ) returns { stock: Integer };
 // event OrderedBook : { book: Books2:ID; quantity: Integer; buyer: String };
}
