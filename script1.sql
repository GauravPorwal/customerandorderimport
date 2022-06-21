SELECT "Create new customer id's" as "";

UPDATE migration_db.customer_entity ce SET ce.new_id = ce.entity_id + 403 WHERE ce.entity_type_id = 1;
UPDATE migration_db.customer_address_entity SET new_id= entity_id + 239825	WHERE entity_type_id = 2;

SELECT "Start of deletion of old orders in migration database started" as "";

SET sql_safe_updates=0;
DELETE FROM migration_db.sales_flat_order  WHERE entity_id < 261496;

SELECT "End Deletion of old orders in migration database started $$$ sit tight !!  $$$" as "";

#Alter the tables with respect to target database
ALTER TABLE migration_db.sales_flat_order
ADD COLUMN `customer_customer_type` VARCHAR(50) CHARACTER SET utf8 DEFAULT NULL AFTER `customer_is_guest`,
ADD COLUMN `customer_sap_payer_account_number` VARCHAR(20) CHARACTER SET utf8 DEFAULT NULL 
AFTER `customer_customer_type`,
ADD COLUMN `customer_tax_code1` VARCHAR(40) CHARACTER SET utf8 DEFAULT NULL AFTER `customer_taxvat`,
ADD COLUMN `customer_tax_code4` VARCHAR(40) CHARACTER SET utf8 DEFAULT NULL AFTER `customer_tax_code1`,
ADD COLUMN `customer_certified_email` VARCHAR(255) CHARACTER SET utf8 DEFAULT NULL AFTER `customer_tax_code4`,
ADD COLUMN customer_invoice_email VARCHAR(255) after customer_email,
ADD COLUMN quote_verification_key VARCHAR(255) DEFAULT NULL,
ADD COLUMN subscription_jobid INT DEFAULT NULL;

ALTER TABLE migration_db.sales_flat_order_address
ADD COLUMN `company2` VARCHAR(255) CHARACTER SET utf8 DEFAULT NULL AFTER `company`,
ADD COLUMN `job_department` VARCHAR(4) CHARACTER SET utf8 DEFAULT NULL AFTER `function`,
ADD COLUMN `designator` VARCHAR(10) CHARACTER SET utf8 DEFAULT NULL AFTER `company2`,
ADD COLUMN `service` VARCHAR(255) CHARACTER SET utf8 DEFAULT NULL AFTER `company`,
ADD COLUMN `cedex` VARCHAR(255) CHARACTER SET utf8 DEFAULT NULL AFTER `company`,
ADD COLUMN `numsignals` VARCHAR(255) CHARACTER SET utf8 DEFAULT NULL AFTER `company`,
ADD COLUMN `number_of_employees` VARCHAR(255) CHARACTER SET utf8 DEFAULT NULL AFTER `company`,
ADD COLUMN `customer_type` VARCHAR(255) CHARACTER SET utf8 DEFAULT NULL AFTER `company`,
ADD COLUMN `code_ape` VARCHAR(255) CHARACTER SET utf8 DEFAULT NULL AFTER `company`,
ADD COLUMN `sap_address_id` VARCHAR(255) CHARACTER SET utf8 DEFAULT NULL,
ADD COLUMN `sap_contact_id` VARCHAR(255) CHARACTER SET UTF8 DEFAULT NULL AFTER `sap_address_id`,
ADD COLUMN `sap_xml` text COLLATE utf8mb4_general_ci,
ADD COLUMN `shipping_preference` int NOT NULL,
ADD COLUMN `shipping_preference_desc` text COLLATE utf8mb4_general_ci NOT NULL,
ADD COLUMN `freight_company` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'Freight Company',
ADD COLUMN `freight_account` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'Freight Account';

ALTER TABLE migration_db.sales_flat_order_address RENAME COLUMN `function` TO `customer_function`;

SELECT "Start of updating customer Id's in Sales tables" as "";

#update customer id in all the respective tables
SET foreign_key_checks=0;
UPDATE migration_db.sales_flat_order sfo set sfo.new_customer_id=
(SELECT ce.new_id FROM migration_db.customer_entity ce where ce.entity_id= sfo.customer_id);
UPDATE migration_db.sales_flat_order_address sfo set sfo.new_customer_id=
(SELECT ce.new_id FROM migration_db.customer_entity ce where ce.entity_id= sfo.customer_id);
UPDATE migration_db.sales_flat_order_grid sfo set sfo.new_customer_id=
(SELECT ce.new_id FROM migration_db.customer_entity ce where ce.entity_id= sfo.customer_id);
UPDATE migration_db.sales_flat_order_address sfo set sfo.new_customer_address_id=
(SELECT ce.new_id FROM migration_db.customer_address_entity ce where ce.entity_id= sfo.customer_address_id);


UPDATE migration_db.sales_flat_order SET customer_id = new_customer_id;
UPDATE migration_db.sales_flat_order_address SET customer_id = new_customer_id;
UPDATE migration_db.sales_flat_order_grid SET customer_id = new_customer_id;
UPDATE migration_db.sales_flat_order_address SET customer_address_id = new_customer_address_id;

SET foreign_key_checks=0;
UPDATE migration_db.sales_flat_order SET customer_id = old_customer_id WHERE old_customer_id < 211783;
UPDATE migration_db.sales_flat_order_address SET customer_id = old_customer_id WHERE old_customer_id < 211783;
UPDATE migration_db.sales_flat_order_grid SET customer_id = old_customer_id WHERE old_customer_id < 211783;
UPDATE migration_db.sales_flat_order_address set customer_address_id = old_customer_address_id WHERE old_customer_address_id IN (
SELECT entity_id FROM migration_db.customer_address_entity WHERE parent_id < 211783
);

SELECT "End of Updating Customer Id's in Sales tables" as "";

#Add extra cloumn for primary key update in sales_flat_order
ALTER TABLE migration_db.sales_flat_order ADD COLUMN new_entity_id INT NULL AFTER entity_id;

SELECT "End of script 1" as "";

SELECT "Update below values in script 2" as "";

select concat("Delta order id = ", max(t.entity_id) - min(s.entity_id) + 100 )  as delta_order_id FROM prod_gcus.sales_flat_order as t, migration_db.sales_flat_order s WHERE s.entity_id > '261495';

select concat("Delta order address id = ", max(t.entity_id) - min(s.entity_id) + 100 ) as delta_order_address_id FROM prod_gcus.sales_flat_order_address as t, migration_db.sales_flat_order_address s WHERE s.parent_id > '261495'; 
