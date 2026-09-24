-- SQL Portfolio 02: Insurance Claims & Risk Analysis
-- SQLite schema for a synthetic insurance portfolio.

PRAGMA foreign_keys = ON;

CREATE TABLE policyholders (
    policyholder_id INTEGER PRIMARY KEY,
    policyholder_name TEXT NOT NULL,
    region TEXT NOT NULL,
    customer_since TEXT NOT NULL
);

CREATE TABLE policies (
    policy_id INTEGER PRIMARY KEY,
    policyholder_id INTEGER NOT NULL,
    policy_type TEXT NOT NULL,
    start_date TEXT NOT NULL,
    annual_premium REAL NOT NULL CHECK (annual_premium >= 0),
    sum_insured REAL NOT NULL CHECK (sum_insured >= 0),
    FOREIGN KEY (policyholder_id) REFERENCES policyholders(policyholder_id)
);

CREATE TABLE claims (
    claim_id INTEGER PRIMARY KEY,
    policy_id INTEGER NOT NULL,
    claim_date TEXT NOT NULL,
    claim_type TEXT NOT NULL,
    claim_amount REAL NOT NULL CHECK (claim_amount >= 0),
    approved_amount REAL NOT NULL CHECK (approved_amount >= 0),
    status TEXT NOT NULL CHECK (status IN ('Settled','Outstanding','Rejected')),
    settlement_date TEXT,
    FOREIGN KEY (policy_id) REFERENCES policies(policy_id)
);
