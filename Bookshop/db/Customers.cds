
using { managed} from '@sap/cds/common';
using sap.capire.incidents.Addresses from './master/Addresses';
using sap.capire.incidents.Incidents from './Incidents';

namespace sap.capire.incidents;
/**
 * Customers using products sold by our company.
 * Customers can create support Incidents.
 */
entity Customers : managed {
  key ID         : String;
  firstName      : String;
  lastName       : String;
  name           : String = firstName ||' '|| lastName;
  email          : String;
  phone          : String;
  creditCardNo   : String(16) @assert.format: '^[1-9]\d{15}$';
  addresses      : Composition of many Addresses on addresses.customer = $self;
  incidents      : Association to many Incidents on incidents.customer = $self;
}
