using { sap.capire.orders as my } from '../../db/Orders';

service OrdersService {
  entity Orders as projection on my.Orders;
  entity Orders2 as projection on my.Orders2;
  entity Orders2_Items as projection on my.Orders2_Items;

}
