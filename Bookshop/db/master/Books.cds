namespace sap.capire.bookshop;

using { Currency, managed } from '@sap/cds/common';
using sap.capire.bookshop.Authors from './Authors';
using sap.capire.bookshop.GenreType from '../enum/GenreType';


entity Books : managed {
  key ID   : Integer;
  title    : localized String(111)  @mandatory;
  descr    : localized String(1111);
  author   : Association to Authors @mandatory;
  genre    : Association to GenreType;
  stock    : Integer;
  price    : Decimal;
  currency : Currency;
  image    : LargeBinary @Core.MediaType: 'image/png';
}

using {  API_BUSINESS_PARTNER_0001 as bupa } from '../../srv/external/API_BUSINESS_PARTNER_0001';

    entity Suppliers as projection on bupa.A_BusinessPartner {
        key BusinessPartner as ID,
        BusinessPartnerFullName as fullName,
        BusinessPartnerIsBlocked as isBlocked,
}