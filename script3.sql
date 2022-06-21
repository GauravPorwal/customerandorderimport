#update Order item table

SELECT "More sales tables are getting updated" as "";

ALTER TABLE migration_db.sales_flat_order_item ADD COLUMN new_item_id INT NULL AFTER item_id;
ALTER TABLE migration_db.sales_flat_order_item ADD COLUMN new_parent_item_id INT NULL AFTER parent_item_id;

UPDATE migration_db.sales_flat_order_item SET new_item_id = item_id + 3794 WHERE store_id = 4;

UPDATE migration_db.sales_flat_order_item sfqi 
	SET sfqi.new_parent_item_id = parent_item_id + 3794 WHERE parent_item_id IS NOT NULL;

#Update Tax Id 
ALTER TABLE migration_db.sales_order_tax ADD COLUMN new_tax_id INT NULL AFTER tax_id;
UPDATE migration_db.sales_order_tax SET new_tax_id = tax_id + 1128;

set foreign_key_checks=0;
UPDATE migration_db.sales_flat_order_item SET parent_item_id = new_parent_item_id;
set foreign_key_checks=1;

#update sales order tax tables
SET FOREIGN_KEY_CHECKS=0;
ALTER TABLE migration_db.sales_order_tax_item ADD COLUMN new_item_id INT NULL AFTER item_id;
update migration_db.sales_order_tax_item soti set soti.new_item_id = 
(select sfoi.new_item_id from  migration_db.sales_flat_order_item sfoi WHERE sfoi.item_id=soti.item_id);
update migration_db.sales_order_tax_item soti set soti.item_id = soti.item_id + 10000;
update migration_db.sales_order_tax_item soti set soti.item_id = soti.new_item_id;
ALTER TABLE migration_db.sales_order_tax_item DROP COLUMN new_item_id;

#Update Tax Id 
SET FOREIGN_KEY_CHECKS=0;
ALTER TABLE migration_db.sales_order_tax_item ADD COLUMN new_tax_id INT NULL AFTER tax_id;

update migration_db.sales_order_tax_item soti SET soti.new_tax_id= 
(SELECT sot.new_tax_id FROM migration_db.sales_order_tax sot WHERE sot.tax_id=soti.tax_id) ;
update migration_db.sales_order_tax_item soti set soti.tax_id = soti.tax_id + 10000;
update migration_db.sales_order_tax_item soti set soti.tax_id = soti.new_tax_id;
ALTER TABLE migration_db.sales_order_tax_item DROP COLUMN new_tax_id;
SET FOREIGN_KEY_CHECKS=1;

set foreign_key_checks=0;
UPDATE migration_db.sales_order_tax SET tax_id =  tax_id + 10000;
UPDATE migration_db.sales_order_tax SET tax_id = new_tax_id; 
ALTER TABLE migration_db.sales_order_tax DROP COLUMN new_tax_id;
set foreign_key_checks=1;

set foreign_key_checks=0;
UPDATE migration_db.sales_flat_order_item SET item_id = item_id + 10000;
UPDATE migration_db.sales_flat_order_item SET item_id = new_item_id;
set foreign_key_checks=1;

SET foreign_key_checks=0;
UPDATE migration_db.sales_flat_order SET entity_id = entity_id + 10000;
UPDATE migration_db.sales_flat_order SET entity_id = new_entity_id;
SET foreign_key_checks=1;

ALTER TABLE migration_db.sales_flat_order_item DROP COLUMN new_item_id;
ALTER TABLE migration_db.sales_flat_order DROP COLUMN new_entity_id;

SELECT "End of script 3" as ""; 
SELECT "Update below values in script 4" as "";

SELECT concat("Delta payment id = ", max(t.entity_id) - min(s.entity_id) + 100 )  as "" FROM prod_gcus.sales_flat_order_payment as t, migration_db.sales_flat_order_payment s;

select concat("Delta TAX ITEM id = ",max(t.tax_item_id) - min(s.tax_item_id) + 100)  as "" FROM prod_gcus.sales_order_tax_item as t, migration_db.sales_order_tax_item s;