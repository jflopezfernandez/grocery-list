
DROP DATABASE IF EXISTS GroceryList;

CREATE DATABASE IF NOT EXISTS GroceryList;

USE GroceryList;

CREATE TABLE IF NOT EXISTS Items(
    id INT UNSIGNED AUTO_INCREMENT NOT NULL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    price DOUBLE(7,2) UNSIGNED NOT NULL DEFAULT 0.0,
    INDEX(name)
) ENGINE INNODB;

INSERT INTO Items(name, price)
VALUES
	("Milk 2% - Publix", 3.82),
    ("Ground Beef - 1lb", 7.99);

CREATE TABLE IF NOT EXISTS GroceryLists(
    id INT UNSIGNED AUTO_INCREMENT NOT NULL PRIMARY KEY,
    list_date DATETIME NOT NULL DEFAULT(NOW())
) ENGINE INNODB;

CREATE TABLE IF NOT EXISTS GroceryListItems(
    list_id INT UNSIGNED NOT NULL,
    item_id INT UNSIGNED NOT NULL,
    quantity INT UNSIGNED NOT NULL DEFAULT 1,
    FOREIGN KEY(list_id) REFERENCES GroceryLists(id),
    FOREIGN KEY(list_id) REFERENCES Items(id)
) ENGINE INNODB;

INSERT INTO GroceryLists(list_date)
VALUES
    (NOW());

-- Create a test shopping list to verify everything is working as it's supposed
-- to during development.
SELECT @TEST_LIST := LAST_INSERT_ID();

-- Populate the test list.
INSERT INTO GroceryListItems(list_id, item_id)
VALUES
    (@TEST_LIST, 1),
    (@TEST_LIST, 2);

-- Select all items in the test shopping list.
SELECT Items.name AS 'Item', Items.price AS 'Unit Price', GroceryListItems.quantity AS 'Quantity' FROM GroceryListItems INNER JOIN Items WHERE GroceryListItems.list_id=@TEST_LIST AND GroceryListItems.item_id=Items.id;
