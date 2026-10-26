-- Ex No: 11
-- SET UP A DISTRIBUTED DATABASE CLUSTER USING OPEN-SOURCE TOOLS (APACHE CASSANDRA)
-- STORE AND RETRIEVE DATA IN A DISTRIBUTED ENVIRONMENT

-- ============================================
-- cassandra.yaml (on every node)
-- ============================================
-- cluster_name: 'CollegeCluster'
-- seeds: "192.168.1.10"
-- listen_address: <node's own IP>

-- ============================================
-- Start Cassandra
-- ============================================
-- sudo service cassandra start

-- ============================================
-- Verify cluster
-- ============================================
-- nodetool status

-- ============================================
-- Open CQL shell
-- ============================================
-- cqlsh

-- ============================================
-- Create Keyspace
-- ============================================
CREATE KEYSPACE college_ks
WITH REPLICATION = {
  'class': 'SimpleStrategy',
  'replication_factor': 3
};

USE college_ks;

-- ============================================
-- Create Table
-- ============================================
CREATE TABLE student (
  rollno INT PRIMARY KEY,
  name TEXT,
  dept TEXT
);

-- ============================================
-- Insert Data
-- ============================================
INSERT INTO student (rollno, name, dept)
VALUES (101, 'RAJA', 'CSE');

INSERT INTO student (rollno, name, dept)
VALUES (102, 'PRIYA', 'IT');

-- ============================================
-- Query Data
-- ============================================
SELECT * FROM student;

/*
OUTPUT:

Datacenter: datacenter1
Status=Up/Down | State=Normal/Leaving/Joining
--  Address       Load      Owns    Host ID    Rack
UN  192.168.1.10  95 KB     34.0%   ...        rack1
UN  192.168.1.11  102 KB    33.0%   ...        rack1
UN  192.168.1.12  98 KB     33.0%   ...        rack1

rollno | dept | name
-------+------+-------
   101 | CSE  | RAJA
   102 | IT   | PRIYA
*/
