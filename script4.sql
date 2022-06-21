set foreign_key_checks=0;
ALTER TABLE migration_db.sales_flat_order_payment ADD COLUMN new_entity_id INT NULL AFTER entity_id;
update migration_db.sales_flat_order_payment SET new_entity_id= entity_id + 1195;
update migration_db.sales_flat_order_payment SET entity_id= entity_id + 10000;
update migration_db.sales_flat_order_payment SET entity_id= new_entity_id;
ALTER TABLE migration_db.sales_flat_order_payment DROP COLUMN new_entity_id;

set foreign_key_checks=0;
ALTER TABLE migration_db.sales_order_tax_item ADD COLUMN new_tax_item_id INT NULL AFTER tax_item_id;
update migration_db.sales_order_tax_item SET new_tax_item_id= tax_item_id + 2464;
update migration_db.sales_order_tax_item SET tax_item_id= tax_item_id + 10000;
update migration_db.sales_order_tax_item SET tax_item_id= new_tax_item_id;
ALTER TABLE migration_db.sales_order_tax_item DROP COLUMN new_tax_item_id;

SELECT "Removing Extra cloumns created in sales tables" as "";
ALTER TABLE migration_db.sales_flat_order_status_history DROP COLUMN entity_id;
ALTER TABLE migration_db.sales_flat_order DROP COLUMN old_customer_id;
ALTER TABLE migration_db.sales_flat_order DROP COLUMN new_customer_id;
ALTER TABLE migration_db.sales_flat_order_address DROP COLUMN new_customer_address_id;
ALTER TABLE migration_db.sales_flat_order_address DROP COLUMN old_customer_address_id;
ALTER TABLE migration_db.sales_flat_order_address DROP COLUMN old_customer_id;
ALTER TABLE migration_db.sales_flat_order_address DROP COLUMN new_customer_id;
ALTER TABLE migration_db.sales_flat_order_grid DROP COLUMN old_customer_id;
ALTER TABLE migration_db.sales_flat_order_grid DROP COLUMN new_customer_id;
ALTER TABLE migration_db.sales_flat_order_item DROP COLUMN new_parent_item_id;

SELECT "=============== SALES TABLES ARE READY ==============================" as "";
SELECT "Run the below commands" as "";
SELECT "mysqldump -u root -p migration_db --no-create-info sales_flat_order sales_flat_order_address  sales_flat_order_grid sales_flat_order_item sales_flat_order_payment sales_flat_order_status_history sales_order_tax sales_order_tax_item  > order_update.sql" as "";

SELECT "bash addordercolumn.sh" as "";