using { cuid, managed } from '@sap/cds/common';
using sap.capire.incidents.Customers from '../Customers';

namespace sap.capire.incidents;

entity Addresses : cuid, managed {
  customer       : Association to Customers;
  city           : String;
  postCode       : String;
  streetAddress  : String;
}

