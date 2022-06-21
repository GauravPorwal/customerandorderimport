#!bin/bash

sed 's/INSERT INTO `customer_address_entity_text`/INSERT INTO `customer_address_entity_text` \(`entity_type_id`, `attribute_id`, `entity_id`, `value`\)/' update_customer_data.sql > customer.sql && mv customer.sql update_customer_data.sql
sed 's/INSERT INTO `customer_address_entity_int`/INSERT INTO `customer_address_entity_int` \(`entity_type_id`, `attribute_id`, `entity_id`, `value`\)/' update_customer_data.sql > customer.sql && mv customer.sql update_customer_data.sql
sed 's/INSERT INTO `customer_address_entity_datetime`/INSERT INTO `customer_address_entity_datetime` \(`entity_type_id`, `attribute_id`, `entity_id`, `value`\)/' update_customer_data.sql > customer.sql && mv customer.sql update_customer_data.sql
sed 's/INSERT INTO `customer_address_entity_varchar`/INSERT INTO `customer_address_entity_varchar` \(`entity_type_id`, `attribute_id`, `entity_id`, `value`\)/' update_customer_data.sql > customer.sql && mv customer.sql update_customer_data.sql
sed 's/INSERT INTO `customer_address_entity_decimal`/INSERT INTO `customer_address_entity_decimal` \(`entity_type_id`, `attribute_id`, `entity_id`, `value`\)/' update_customer_data.sql > customer.sql && mv customer.sql update_customer_data.sql
sed 's/INSERT INTO `customer_entity_int`/INSERT INTO `customer_entity_int` \(`entity_type_id`, `attribute_id`, `entity_id`, `value`\)/' update_customer_data.sql > customer.sql && mv customer.sql update_customer_data.sql
sed 's/INSERT INTO `customer_entity_datetime`/INSERT INTO `customer_entity_datetime` \(`entity_type_id`, `attribute_id`, `entity_id`, `value`\)/' update_customer_data.sql > customer.sql && mv customer.sql update_customer_data.sql
sed 's/INSERT INTO `customer_entity_decimal`/INSERT INTO `customer_entity_decimal` \(`entity_type_id`, `attribute_id`, `entity_id`, `value`\)/' update_customer_data.sql > customer.sql && mv customer.sql update_customer_data.sql
sed 's/INSERT INTO `customer_entity_varchar`/INSERT INTO `customer_entity_varchar` \(`entity_type_id`, `attribute_id`, `entity_id`, `value`\)/' update_customer_data.sql > customer.sql && mv customer.sql update_customer_data.sql
sed 's/INSERT INTO `customer_entity_text`/INSERT INTO `customer_entity_text` \(`entity_type_id`, `attribute_id`, `entity_id`, `value`\)/' update_customer_data.sql > customer.sql && mv customer.sql update_customer_data.sql