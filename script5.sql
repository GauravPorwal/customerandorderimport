SELECT "Start of deleting customer data from migration db it will take few min" as "";

SET foreign_key_checks=1;
DELETE FROM migration_db.customer_entity  WHERE entity_id < '211783';

SELECT "End of deleting customer data from migration db" as "";

set sql_safe_updates=0;
SET foreign_key_checks=0;

SELECT "Updating customer id's in respective tables" as "";

update migration_db.customer_entity_varchar v set v.entity_id = (select new_id from migration_db.customer_entity ce where ce.entity_id = v.entity_id);
update migration_db.customer_entity_int v set v.entity_id = (select new_id from migration_db.customer_entity ce where ce.entity_id = v.entity_id);
update migration_db.customer_entity_text v set v.entity_id = (select new_id from migration_db.customer_entity ce where ce.entity_id = v.entity_id);
update migration_db.customer_entity_decimal v set v.entity_id = (select new_id from migration_db.customer_entity ce where ce.entity_id = v.entity_id);
update migration_db.customer_entity_datetime v set v.entity_id = (select new_id from migration_db.customer_entity ce where ce.entity_id = v.entity_id);
update migration_db.customer_address_entity_varchar v set v.entity_id = (select new_id from migration_db.customer_address_entity ce where ce.entity_id = v.entity_id);
update migration_db.customer_address_entity_int v set v.entity_id = (select new_id from migration_db.customer_address_entity ce where ce.entity_id = v.entity_id);
update migration_db.customer_address_entity_text v set v.entity_id = (select new_id from migration_db.customer_address_entity ce where ce.entity_id = v.entity_id);
update migration_db.customer_address_entity_datetime v set v.entity_id = (select new_id from migration_db.customer_address_entity ce where ce.entity_id = v.entity_id);
update migration_db.customer_address_entity_decimal v set v.entity_id = (select new_id from migration_db.customer_address_entity ce where ce.entity_id = v.entity_id);
update migration_db.customer_address_entity v set v.parent_id = (select new_id from migration_db.customer_entity ce where ce.entity_id = v.parent_id);

#Need to check and see if it updates default billing and shipping address
update migration_db.customer_entity_int v set v.value = (select new_id from migration_db.customer_address_entity ce where ce.entity_id = v.value)
WHERE v.attribute_id=13;
update migration_db.customer_entity_int v set v.value = (select new_id from migration_db.customer_address_entity ce where ce.entity_id = v.value)
WHERE v.attribute_id=14;

SELECT "End of Script 5" as "";
SELECT "Updating below customer id's in script 6 to be deleted" as "";

SELECT concat("Common customer id = ", group_concat(m.entity_id)) as "" FROM migration_db.customer_entity m LEFT JOIN prod_gcus.customer_entity n ON  m.email=n.email WHERE n.entity_id is not null;