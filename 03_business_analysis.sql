-- SQL Portfolio 02: Insurance Claims & Risk Analysis
-- Run each query individually in SQLite.

-- QUERY 1: Annual claims KPI summary
SELECT
    strftime('%Y', claim_date) AS year,
    COUNT(*) AS total_claims,
    ROUND(SUM(claim_amount),2) AS claimed_amount,
    ROUND(SUM(approved_amount),2) AS approved_amount,
    ROUND(AVG(claim_amount),2) AS avg_claim_value,
    ROUND(
        100.0 * SUM(CASE WHEN status='Settled' THEN 1 ELSE 0 END) / COUNT(*),
        2
    ) AS settlement_rate_pct
FROM claims
GROUP BY strftime('%Y', claim_date)
ORDER BY year;

-- QUERY 2: Claim status analysis
SELECT
    status,
    COUNT(*) AS total_claims,
    ROUND(SUM(claim_amount),2) AS claimed_amount,
    ROUND(SUM(approved_amount),2) AS approved_amount
FROM claims
GROUP BY status
ORDER BY total_claims DESC;

-- QUERY 3: Average settlement time by year
SELECT
    strftime('%Y', claim_date) AS year,
    COUNT(*) AS settled_claims,
    ROUND(
        AVG(julianday(settlement_date) - julianday(claim_date)),
        2
    ) AS avg_settlement_days
FROM claims
WHERE status='Settled'
  AND settlement_date IS NOT NULL
GROUP BY strftime('%Y', claim_date)
ORDER BY year;

-- QUERY 4: Claim type risk profile
SELECT
    claim_type,
    COUNT(*) AS total_claims,
    ROUND(SUM(claim_amount),2) AS total_claimed,
    ROUND(AVG(claim_amount),2) AS avg_claim_amount,
    ROUND(SUM(approved_amount),2) AS total_approved
FROM claims
GROUP BY claim_type
ORDER BY total_claimed DESC;

-- QUERY 5: Regional claims performance
SELECT
    ph.region,
    COUNT(c.claim_id) AS total_claims,
    ROUND(SUM(c.claim_amount),2) AS claimed_amount,
    ROUND(SUM(c.approved_amount),2) AS approved_amount
FROM claims c
JOIN policies p
    ON c.policy_id = p.policy_id
JOIN policyholders ph
    ON p.policyholder_id = ph.policyholder_id
GROUP BY ph.region
ORDER BY claimed_amount DESC;

-- QUERY 6: Policy type claims vs premiums
WITH premium_by_type AS (
    SELECT
        policy_type,
        SUM(annual_premium) AS total_annual_premium
    FROM policies
    GROUP BY policy_type
),
claims_by_type AS (
    SELECT
        p.policy_type,
        COUNT(c.claim_id) AS total_claims,
        SUM(c.approved_amount) AS approved_claims
    FROM policies p
    LEFT JOIN claims c
        ON p.policy_id = c.policy_id
    GROUP BY p.policy_type
)
SELECT
    p.policy_type,
    ROUND(p.total_annual_premium,2) AS total_annual_premium,
    c.total_claims,
    ROUND(c.approved_claims,2) AS approved_claims,
    ROUND(
        100.0 * c.approved_claims / NULLIF(p.total_annual_premium,0),
        2
    ) AS approved_claims_to_premium_pct
FROM premium_by_type p
JOIN claims_by_type c
    ON p.policy_type = c.policy_type
ORDER BY approved_claims_to_premium_pct DESC;

-- QUERY 7: Largest outstanding claims
SELECT
    c.claim_id,
    ph.policyholder_name,
    p.policy_type,
    c.claim_type,
    c.claim_date,
    c.claim_amount,
    c.approved_amount
FROM claims c
JOIN policies p
    ON c.policy_id = p.policy_id
JOIN policyholders ph
    ON p.policyholder_id = ph.policyholder_id
WHERE c.status='Outstanding'
ORDER BY c.approved_amount DESC;

-- QUERY 8: Year-over-year approved claim growth
WITH yearly AS (
    SELECT
        strftime('%Y', claim_date) AS year,
        SUM(approved_amount) AS approved_amount
    FROM claims
    GROUP BY strftime('%Y', claim_date)
)
SELECT
    year,
    ROUND(approved_amount,2) AS approved_amount,
    ROUND(
        100.0 * (
            approved_amount - LAG(approved_amount) OVER (ORDER BY year)
        ) / NULLIF(LAG(approved_amount) OVER (ORDER BY year),0),
        2
    ) AS yoy_growth_pct
FROM yearly
ORDER BY year;

-- QUERY 9: Data-quality checks
SELECT 'claims_missing_policy' AS check_name, COUNT(*) AS issue_count
FROM claims c
LEFT JOIN policies p ON c.policy_id = p.policy_id
WHERE p.policy_id IS NULL

UNION ALL

SELECT 'policies_missing_policyholder', COUNT(*)
FROM policies p
LEFT JOIN policyholders ph ON p.policyholder_id = ph.policyholder_id
WHERE ph.policyholder_id IS NULL

UNION ALL

SELECT 'negative_claim_values', COUNT(*)
FROM claims
WHERE claim_amount < 0 OR approved_amount < 0

UNION ALL

SELECT 'settled_without_date', COUNT(*)
FROM claims
WHERE status='Settled' AND settlement_date IS NULL;
