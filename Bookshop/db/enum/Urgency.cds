using {  sap.common.CodeList } from '@sap/cds/common';
namespace sap.capire.incidents;

entity Urgency : CodeList {
  key code : String enum {
    high   = 'H';
    medium = 'M';
    low    = 'L';
  };
}