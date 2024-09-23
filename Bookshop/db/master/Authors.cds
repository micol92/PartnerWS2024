namespace sap.capire.bookshop;

using { managed } from '@sap/cds/common';
using sap.capire.bookshop.Books from './Books';


entity Authors : managed {
  key ID       : Integer;
  name         : String(111) @mandatory;
  dateOfBirth  : Date;
  dateOfDeath  : Date;
  placeOfBirth : String;
  placeOfDeath : String;
  books        : Association to many Books on books.author = $self;
}
