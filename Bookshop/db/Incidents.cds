using { cuid, managed} from '@sap/cds/common';
using sap.capire.incidents.Customers from './Customers';
using sap.capire.incidents.Urgency from './enum/Urgency';
using sap.capire.incidents.Status from './enum/Status';

namespace sap.capire.incidents;

/**
 * Incidents created by Customers.
 */
entity Incidents : cuid, managed {
  customer       : Association to Customers;
  title          : String @title: 'Title';
  urgency        : Association to Urgency default 'M';
  status         : Association to Status default 'N';
  conversation   : Composition of many {
    key ID    : UUID;
    timestamp : type of managed:createdAt;
    author    : type of managed:createdBy;
    message   : String;
  };
}

entity Incidents2 : cuid, managed {
  customer       : Association to Customers;
  title          : String @title: 'Title';
  urgency        : Association to Urgency default 'M';
  status         : Association to Status default 'N';
  conversation   : Composition of many Incidents2_Conversation on conversation.incident_ID = ID 
}

entity Incidents2_Conversation {
    key ID    : UUID;
    incident_ID : UUID;
    timestamp : type of managed:createdAt;
    author    : type of managed:createdBy;
    message   : String;
}