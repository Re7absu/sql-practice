--  1-What are all the records in the alerts table?
SELECT * FROM alerts;
-- 2-What are the names of all the buildings in the database?
SELECT name FROM buildings;
-- 3-What are the alerts with a high temperature message?
 SELECT * FROM alerts WHERE message = 'High temperature';
-- 4-What are the alerts that occurred on a specific date?
SELECT * FROM alerts WHERE message_at = '2026-09-08';
-- 5-What are the alerts associated with a specific camera?
SELECT * FROM alerts WHERE camera_id = '4';
-- 6-What are the alerts sorted from newest to oldest?
SELECT * FROM alerts ORDER BY  message_at DESC ;
-- 7-What are the alerts with the type System?
SELECT * FROM alerts WHERE type_message = 'System';
-- 8-What are the alerts with the type Temperature?
SELECT * FROM alerts WHERE Type_message = 'Temperature';
-- 9-What are the alerts with the type Humidity?
SELECT * FROM alerts WHERE Type_message = 'Humidity';
-- 10-What are the last 5 alerts that were recorded?
SELECT * FROM alerts ORDER BY  message_at DESC LIMIT 5 ; 
-- 11-How many alerts are there for each alert type?
SELECT  type_message , COUNT(*) FROM alerts GROUP BY type_message ;
-- 12-How many alerts are there for each camera?
SELECT camera_id, COUNT(*) AS alerts_per_camera FROM alerts GROUP BY camera_id;
-- 13-How many alerts are there for each user?
SELECT user_id , COUNT(*) AS alerts_per_users FROM alerts GROUP BY user_id;
-- 14-What is the average temperature across all sensor readings?
-- 15-What is the average humidity across all sensor readings?


