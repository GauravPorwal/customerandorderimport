create database migration_db;
use migration_db;

SELECT "Starting the import of delta customer and order" as "";

source dump_prod_stus_21062022.sql;

SELECT "Database Migration DB is Ready" as "";

#create and copy customer id in another column
ALTER TABLE `migration_db`.`sales_flat_order` ADD COLUMN `new_customer_id` INT NULL AFTER `customer_id`;
ALTER TABLE `migration_db`.`sales_flat_order_address` ADD COLUMN `new_customer_id` INT NULL AFTER `customer_id`;
ALTER TABLE `migration_db`.`sales_flat_order_grid` ADD COLUMN `new_customer_id` INT NULL AFTER `customer_id`;
ALTER TABLE `migration_db`.`sales_flat_order` ADD COLUMN `old_customer_id` INT NULL AFTER `customer_id`;
ALTER TABLE `migration_db`.`sales_flat_order_address` ADD COLUMN `old_customer_id` INT NULL AFTER `customer_id`;
ALTER TABLE `migration_db`.`sales_flat_order_grid` ADD COLUMN `old_customer_id` INT NULL AFTER `customer_id`;
ALTER TABLE `migration_db`.`sales_flat_order_address` ADD COLUMN `old_customer_address_id` INT NULL AFTER `customer_address_id`;
ALTER TABLE `migration_db`.`sales_flat_order_address` ADD COLUMN `new_customer_address_id` INT NULL AFTER `customer_address_id`;

UPDATE migration_db.sales_flat_order sfo set sfo.old_customer_id=customer_id;
UPDATE migration_db.sales_flat_order_address sfo set sfo.old_customer_id=customer_id;
UPDATE migration_db.sales_flat_order_grid sfo set sfo.old_customer_id=customer_id;
UPDATE migration_db.sales_flat_order_address sfo set sfo.old_customer_address_id=customer_address_id;

#Alter the tables of Customer
SET FOREIGN_KEY_CHECKS = 0;
ALTER TABLE migration_db.customer_entity 
CHANGE COLUMN `updated_at` `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Updated At' ;
ALTER TABLE migration_db.customer_address_entity 
CHANGE COLUMN `updated_at` `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Updated At' ;
ALTER TABLE migration_db.customer_address_entity 
CHANGE COLUMN `updated_at` `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Updated At' ;
ALTER TABLE migration_db.customer_address_entity
ADD COLUMN `sap_address_id` varchar(255) DEFAULT NULL,
ADD COLUMN `sap_contact_id` varchar(255) DEFAULT NULL;
SET FOREIGN_KEY_CHECKS = 1;

#Create a new column new_id in the customer_entity table to update the new customer id from the target system.
ALTER TABLE `migration_db`.`customer_entity` ADD COLUMN `new_id` INT NULL AFTER `entity_id`;
ALTER TABLE `migration_db`.`customer_address_entity` ADD COLUMN `new_id` INT NULL AFTER `entity_id`;

SELECT "Script Successfully finished" as "";

SELECT "Update below values in script 1" as "";

select concat("Delta customer id = ", max(t.entity_id) - min(s.entity_id) + 100 ) as "" FROM prod_gcus.customer_entity as t, migration_db.customer_entity s WHERE s.entity_id > '211782';

select concat("Delta customer addresss id = ", max(t.entity_id) - min(s.entity_id) + 100 ) as "" FROM prod_gcus.customer_address_entity as t, migration_db.customer_address_entity s WHERE s.parent_id > '211782';