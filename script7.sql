SELECT concat("ALTER TABLE prod_gcus.customer_entity AUTO_INCREMENT = ", max(entity_id)+1) as "" from prod_gcus.customer_entity;
#ALTER TABLE prod_gcus.customer_entity AUTO_INCREMENT = 212482;

SELECT concat("ALTER TABLE prod_gcus.customer_address_entity AUTO_INCREMENT = ", max(entity_id)+1) as "" from prod_gcus.customer_address_entity;
#ALTER TABLE prod_gcus.customer_address_entity AUTO_INCREMENT = 232323;

SELECT concat("ALTER TABLE prod_gcus.sales_order_tax AUTO_INCREMENT = ", max(tax_id)+1) as "" from prod_gcus.sales_order_tax;
#ALTER TABLE prod_gcus.sales_order_tax AUTO_INCREMENT = 119150;

SELECT concat("ALTER TABLE prod_gcus.sales_flat_order_address AUTO_INCREMENT = ", max(entity_id)+1 ) as "" from prod_gcus.sales_flat_order_address;
#ALTER TABLE prod_gcus.sales_flat_order_address AUTO_INCREMENT = 524433;

SELECT concat("ALTER TABLE prod_gcus.sales_flat_order AUTO_INCREMENT = ", max(entity_id)+1 ) as "" from prod_gcus.sales_flat_order;
#ALTER TABLE prod_gcus.sales_flat_order AUTO_INCREMENT = 263829;

SELECT concat("ALTER TABLE prod_gcus.sales_flat_order_payment AUTO_INCREMENT = ", max(entity_id)+1 ) as "" from prod_gcus.sales_flat_order_payment;
#ALTER TABLE prod_gcus.sales_flat_order_payment AUTO_INCREMENT = 263451
