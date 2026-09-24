-- Synthetic insurance portfolio data for 2024-2026

INSERT INTO policyholders
(policyholder_id, policyholder_name, region, customer_since)
VALUES
(1,'Aisha Khan','North','2022-04-10'),
(2,'Ben Carter','Midlands','2023-01-18'),
(3,'Chloe Martin','South','2021-09-05'),
(4,'Daniel Evans','North','2024-02-14'),
(5,'Eva Schmidt','South','2022-11-20'),
(6,'Farah Ali','Midlands','2023-07-08'),
(7,'George Wilson','North','2024-05-19'),
(8,'Hannah Brown','South','2021-03-30');

INSERT INTO policies
(policy_id, policyholder_id, policy_type, start_date, annual_premium, sum_insured)
VALUES
(101,1,'Motor','2024-01-01',780,25000),
(102,2,'Home','2024-01-01',620,180000),
(103,3,'Motor','2024-02-01',840,30000),
(104,4,'Travel','2024-03-01',240,10000),
(105,5,'Home','2024-03-01',690,220000),
(106,6,'Motor','2024-04-01',760,28000),
(107,7,'Travel','2024-05-01',210,12000),
(108,8,'Home','2024-05-01',710,200000),
(109,1,'Travel','2025-01-01',260,15000),
(110,2,'Motor','2025-01-01',820,27000),
(111,3,'Home','2025-02-01',735,210000),
(112,5,'Motor','2025-03-01',790,26000);

INSERT INTO claims
(claim_id, policy_id, claim_date, claim_type, claim_amount, approved_amount, status, settlement_date)
VALUES
(1001,101,'2024-01-18','Collision',3200,2800,'Settled','2024-02-02'),
(1002,102,'2024-02-11','Water Damage',5400,4700,'Settled','2024-03-01'),
(1003,103,'2024-03-09','Theft',6800,6000,'Settled','2024-04-05'),
(1004,104,'2024-04-14','Medical',1200,1100,'Settled','2024-04-22'),
(1005,105,'2024-05-07','Storm Damage',9100,8200,'Outstanding',NULL),
(1006,106,'2024-06-19','Collision',2500,0,'Rejected',NULL),
(1007,107,'2024-07-02','Baggage',900,700,'Settled','2024-07-12'),
(1008,108,'2024-08-21','Water Damage',4300,3900,'Settled','2024-09-08'),

(2001,101,'2025-01-13','Collision',4100,3600,'Settled','2025-01-29'),
(2002,110,'2025-02-06','Theft',7500,6600,'Settled','2025-03-02'),
(2003,111,'2025-03-16','Fire Damage',12500,11000,'Outstanding',NULL),
(2004,109,'2025-04-04','Medical',1600,1450,'Settled','2025-04-15'),
(2005,112,'2025-05-12','Collision',3500,3100,'Settled','2025-05-30'),
(2006,102,'2025-06-22','Water Damage',6200,5400,'Settled','2025-07-14'),
(2007,103,'2025-08-10','Theft',7200,0,'Rejected',NULL),
(2008,108,'2025-09-05','Storm Damage',8400,7600,'Settled','2025-09-26'),

(3001,101,'2026-01-09','Collision',3900,3500,'Settled','2026-01-23'),
(3002,110,'2026-02-18','Theft',8100,7200,'Settled','2026-03-08'),
(3003,111,'2026-03-11','Water Damage',6900,6100,'Settled','2026-04-02'),
(3004,109,'2026-04-15','Medical',1800,1650,'Settled','2026-04-24'),
(3005,112,'2026-05-21','Collision',4600,4100,'Outstanding',NULL),
(3006,105,'2026-06-07','Storm Damage',9800,8800,'Settled','2026-07-01'),
(3007,103,'2026-07-12','Theft',7700,6900,'Settled','2026-08-03'),
(3008,108,'2026-08-20','Fire Damage',11800,10400,'Outstanding',NULL);
