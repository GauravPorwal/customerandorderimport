SET FOREIGN_KEY_CHECKS=0;
SET SQL_SAFE_UPDATES=0;

SELECT "Start of Cleaning customer Id's and extra column" as "";
DELETE FROM migration_db.customer_entity WHERE entity_id IN (212052,211859,212009,211969,212116) ; 
UPDATE migration_db.customer_entity  SET entity_id = new_id;
UPDATE migration_db.customer_address_entity SET entity_id = new_id;

ALTER TABLE migration_db.customer_address_entity DROP COLUMN new_id;
ALTER TABLE migration_db.customer_entity DROP COLUMN new_id;

ALTER TABLE migration_db.customer_entity_varchar DROP COLUMN value_id;
ALTER TABLE migration_db.customer_entity_decimal DROP COLUMN value_id;
ALTER TABLE migration_db.customer_entity_text DROP COLUMN value_id;
ALTER TABLE migration_db.customer_entity_datetime 
CHANGE COLUMN `value` `value` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Updated At' ;
ALTER TABLE migration_db.customer_entity_datetime DROP COLUMN value_id;
ALTER TABLE migration_db.customer_entity_int DROP COLUMN value_id;
ALTER TABLE migration_db.customer_address_entity_decimal DROP COLUMN value_id;
ALTER TABLE migration_db.customer_address_entity_varchar DROP COLUMN value_id;
ALTER TABLE migration_db.customer_address_entity_datetime 
CHANGE COLUMN `value` `value` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Updated At' ;
ALTER TABLE migration_db.customer_address_entity_datetime DROP COLUMN value_id;
ALTER TABLE migration_db.customer_address_entity_int DROP COLUMN value_id;
ALTER TABLE migration_db.customer_address_entity_text DROP COLUMN value_id;

SELECT "End of Cleaning customer Id's and extra column" as "";
SELECT "End of Script 6" as "";
SELECT "Please run the below commands to get the Customer tables to be imported in target database" as "";

SELECT "mysqldump -u root -p migration_db --no-create-info customer_entity customer_address_entity customer_address_entity_datetime customer_address_entity_decimal customer_address_entity_int customer_address_entity_text customer_address_entity_varchar customer_entity_datetime customer_entity_decimal customer_entity_int customer_entity_text customer_entity_varchar > update_customer_data.sql" as "";

SELECT "bash addColumn.sh" as "";