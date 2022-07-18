-- +-------------+---------+
-- | Column Name | Type    |
-- +-------------+---------+
-- | product_id  | int     |
-- | low_fats    | enum    |
-- | recyclable  | enum    |
-- +-------------+---------+
-- product_id is the primary key for this table.
-- low_fats is an ENUM of type ('Y', 'N') where 'Y' means this product is low fat and 'N' means it is not.
-- recyclable is an ENUM of types ('Y', 'N') where 'Y' means this product is recyclable and 'N' means it is not.

    SELECT product_id 
    FROM Products
    WHERE low_fats = 'Y' AND recyclable = 'Y';

    Runtime: 532 ms, faster than 62.35% of MySQL online submissions for Recyclable and Low Fat Products.
Memory Usage: 0B, less than 100.00% of MySQL online submissions for Recyclable and Low Fat Products.

