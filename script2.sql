SELECT "Start updating order ids in respective tables" as "";

#update new order ids, address ids and tax ids in respective tables
UPDATE migration_db.sales_flat_order SET new_entity_id = entity_id + 1195 WHERE store_id = 4;

set foreign_key_checks=0;
ALTER TABLE migration_db.sales_flat_order_address ADD COLUMN new_entity_id INT NULL AFTER entity_id;
UPDATE migration_db.sales_flat_order_address sfoa SET sfoa.new_entity_id = entity_id + 2291;

set foreign_key_checks=1;
DELETE FROM migration_db.sales_order_tax WHERE order_id NOT IN (select entity_id FROM migration_db.sales_flat_order);

#Update order id in respective tables

#sales_flat_order_address
set foreign_key_checks=0;
ALTER TABLE migration_db.sales_flat_order_address ADD COLUMN new_parent_id INT NULL AFTER parent_id;
update migration_db.sales_flat_order_address v set v.new_parent_id = (select new_entity_id from migration_db.sales_flat_order ce where ce.entity_id = v.parent_id);
update migration_db.sales_flat_order_address v set v.parent_id = v.parent_id + 10000;
update migration_db.sales_flat_order_address v set v.parent_id = v.new_parent_id;
ALTER TABLE migration_db.sales_flat_order_address DROP COLUMN new_parent_id;

#sales_flat_order_grid
ALTER TABLE migration_db.sales_flat_order_grid ADD COLUMN new_entity_id INT NULL AFTER entity_id;
update migration_db.sales_flat_order_grid v set v.new_entity_id = (select new_entity_id from migration_db.sales_flat_order ce where ce.entity_id = v.entity_id);
update migration_db.sales_flat_order_grid v set v.entity_id = v.entity_id + 10000;
update migration_db.sales_flat_order_grid v set v.entity_id = v.new_entity_id;
ALTER TABLE migration_db.sales_flat_order_grid DROP COLUMN new_entity_id;

#sales_flat_order_item
set foreign_key_checks=0;
ALTER TABLE migration_db.sales_flat_order_item CHANGE COLUMN `updated_at` `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Updated At';
ALTER TABLE migration_db.sales_flat_order_item ADD COLUMN new_order_id INT NULL AFTER order_id;
update migration_db.sales_flat_order_item v set v.new_order_id = (select new_entity_id from migration_db.sales_flat_order ce where ce.entity_id = v.order_id);
update migration_db.sales_flat_order_item v set v.order_id = v.order_id + 10000;
update migration_db.sales_flat_order_item v set v.order_id = v.new_order_id;
ALTER TABLE migration_db.sales_flat_order_item DROP COLUMN new_order_id;

#sales_flat_order_payment
ALTER TABLE migration_db.sales_flat_order_payment ADD COLUMN new_parent_id INT NULL AFTER parent_id;
update migration_db.sales_flat_order_payment v set v.new_parent_id = (select new_entity_id from migration_db.sales_flat_order ce where ce.entity_id = v.parent_id);
update migration_db.sales_flat_order_payment v set v.parent_id = v.parent_id + 10000;
update migration_db.sales_flat_order_payment v set v.parent_id = v.new_parent_id;
ALTER TABLE migration_db.sales_flat_order_payment DROP COLUMN new_parent_id;

#sales_flat_order_status_history
ALTER TABLE migration_db.sales_flat_order_status_history ADD COLUMN new_parent_id INT NULL AFTER parent_id;
update migration_db.sales_flat_order_status_history v set v.new_parent_id = (select new_entity_id from migration_db.sales_flat_order ce where ce.entity_id = v.parent_id);
update migration_db.sales_flat_order_status_history v set v.parent_id = v.parent_id + 10000;
update migration_db.sales_flat_order_status_history v set v.parent_id = v.new_parent_id;
ALTER TABLE migration_db.sales_flat_order_status_history DROP COLUMN new_parent_id;

#sales_order_tax
ALTER TABLE migration_db.sales_order_tax ADD COLUMN new_order_id INT NULL AFTER order_id;
update migration_db.sales_order_tax v set v.new_order_id = (select new_entity_id from migration_db.sales_flat_order ce where ce.entity_id = v.order_id);
update migration_db.sales_order_tax v set v.order_id = v.order_id + 10000;
update migration_db.sales_order_tax v set v.order_id = v.new_order_id;
ALTER TABLE migration_db.sales_order_tax DROP COLUMN new_order_id;

SELECT "End updating order ids in respective tables" as "";

SELECT "Updating billing and shipping address" as "";

#update billing and shipping address id in sales_flat_order
ALTER TABLE migration_db.sales_flat_order ADD COLUMN new_billing_address_id INT NULL AFTER billing_address_id;
UPDATE migration_db.sales_flat_order sfo SET new_billing_address_id = 
(SELECT new_entity_id from migration_db.sales_flat_order_address sfoa 
WHERE sfoa.entity_id=sfo.billing_address_id);
update migration_db.sales_flat_order v set v.billing_address_id = v.billing_address_id + 10000;
update migration_db.sales_flat_order v set v.billing_address_id = v.new_billing_address_id;
ALTER TABLE migration_db.sales_flat_order DROP COLUMN new_billing_address_id;

ALTER TABLE migration_db.sales_flat_order ADD COLUMN new_shipping_address_id INT NULL AFTER shipping_address_id;
UPDATE migration_db.sales_flat_order sfo SET new_shipping_address_id = 
(SELECT new_entity_id from migration_db.sales_flat_order_address sfoa 
WHERE sfoa.entity_id=sfo.shipping_address_id);
update migration_db.sales_flat_order v set v.shipping_address_id = v.shipping_address_id + 10000;
update migration_db.sales_flat_order v set v.shipping_address_id = v.new_shipping_address_id;
ALTER TABLE migration_db.sales_flat_order DROP COLUMN new_shipping_address_id;

set foreign_key_checks=0;
UPDATE migration_db.sales_flat_order_address sfoa SET sfoa.entity_id = entity_id + 10000;
UPDATE migration_db.sales_flat_order_address sfoa SET sfoa.entity_id = new_entity_id;
ALTER TABLE migration_db.sales_flat_order_address DROP COLUMN new_entity_id;

SELECT "End of script 2" as "";

SELECT "Update below values in script 3" as "";

select concat("Delta ORDER item id = ", max(t.item_id) - min(s.item_id) + 100)  as delta_customer_id FROM prod_gcus.sales_flat_order_item as t, migration_db.sales_flat_order_item s;

select concat("Delta TAX  id = ",max(t.tax_id) - min(s.tax_id) + 100)  as delta_tax_id FROM prod_gcus.sales_order_tax as t, migration_db.sales_order_tax s;
