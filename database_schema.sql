-- =============================================
-- Project: Kenya Tourism Budget Analytics
-- Author: Eng. Paul Kioko 
-- Description: Database Schema and Financial Analysis
-- =============================================

-- 1. Create the Database Architecture
CREATE TABLE tourism_hubs (
    hub_id SERIAL PRIMARY KEY,
    hub_name VARCHAR(100) NOT NULL UNIQUE,
    region VARCHAR(100) NOT NULL,
    travel_type VARCHAR(50) DEFAULT 'Budget Travel'
);

CREATE TABLE development_allocations (
    allocation_id SERIAL PRIMARY KEY,
    hub_id INT REFERENCES tourism_hubs(hub_id) ON DELETE CASCADE,
    project_name VARCHAR(255) NOT NULL,
    allocated_amount NUMERIC(12, 2) NOT NULL,
    amount_spent NUMERIC(12, 2) NOT NULL,
    launch_date DATE NOT NULL,
    CONSTRAINT chk_positive_funds CHECK (allocated_amount > 0 AND amount_spent >= 0)
);

-- 2. Seed Production Data
INSERT INTO tourism_hubs (hub_name, region, travel_type) VALUES
('Nairobi City Guide', 'Inland', 'Digital Resource'),
('Mombasa Marine Coast', 'Coast', 'Beach & Culture'),
('Naivasha Camping Trails', 'Rift Valley', 'Eco-Tourism / Budget'),
('Diani Hidden Gems', 'Coast', 'Affordable Luxury');

INSERT INTO development_allocations (hub_id, project_name, allocated_amount, amount_spent, launch_date) VALUES
(1, 'Hidden Gems Directory App', 500000.00, 420000.00, '2026-01-10'),
(2, 'Public Beach Wi-Fi Portal', 350000.00, 310000.00, '2026-02-14'),
(3, 'Campground Infrastructure Map', 200000.00, 240000.00, '2026-03-01'),
(4, 'Backpacker Marketing Campaign', 400000.00, 150000.00, '2026-03-15'),
(1, 'Nairobi Eco-Trail Virtual Tour', 300000.00, 315000.00, '2026-04-05');

-- 3. Final Financial Analytics View
CREATE VIEW budget_variance_report AS
SELECT 
    project_name,
    allocated_amount,
    amount_spent,
    (allocated_amount - amount_spent) AS budget_variance,
    CASE 
        WHEN amount_spent > allocated_amount THEN 'Over Budget'
        ELSE 'Under Budget'
    END AS financial_status
FROM development_allocations;

SELECT * FROM budget_variance_report;