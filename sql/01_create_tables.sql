
-- Retail Sales Analysis - Superstore Dataset
-- Create Tables

DROP TABLE IF EXISTS superstore;

CREATE TABLE superstore (
    row_id          INTEGER PRIMARY KEY,
    order_id        VARCHAR(20),
    order_date      DATE,
    ship_date       DATE,
    ship_mode       VARCHAR(50),
    customer_id     VARCHAR(20),
    customer_name   VARCHAR(100),
    segment         VARCHAR(50),
    country         VARCHAR(50),
    city            VARCHAR(100),
    state           VARCHAR(50),
    postal_code     VARCHAR(10),
    region          VARCHAR(50),
    product_id      VARCHAR(20),
    category        VARCHAR(50),
    sub_category    VARCHAR(50),
    product_name    VARCHAR(255),
    sales           NUMERIC(10,4),
    quantity        INTEGER,
    discount        NUMERIC(4,2),
    profit          NUMERIC(10,4)
);