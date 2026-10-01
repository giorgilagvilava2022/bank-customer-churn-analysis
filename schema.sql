-- Drop table if it exists
DROP TABLE IF EXISTS customer_churn;

-- Create table 
CREATE TABLE customer_churn (
    row_number INT,
    customer_id BIGINT PRIMARY KEY,
    surname VARCHAR(100),
    credit_score INT,
    geography VARCHAR(50),
    gender VARCHAR(20),
    age INT,
    tenure INT,
    balance NUMERIC(15, 2),
    num_of_products INT,
    has_cr_card INT,
    is_active_member INT,
    estimated_salary NUMERIC(15, 2),
    exited INT,
    complain INT,
    satisfaction_score INT,
    card_type VARCHAR(50),
    point_earned INT
);
