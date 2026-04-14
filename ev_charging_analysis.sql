-- 1. Basic row count
SELECT COUNT(*) AS total_rows
FROM ev_data;

-- 2. Date range
SELECT MIN(date_time) AS start_date, MAX(date_time) AS end_date
FROM ev_data;

-- 3. Zone-wise KPI summary
SELECT
    city_zone,
    SUM(vehicles_charged) AS total_vehicles,
    ROUND(AVG(energy_dispensed_kwh),2) AS avg_energy_kwh,
    ROUND(AVG(grid_load_mw),2) AS avg_grid_load_mw,
    ROUND(AVG(renewable_energy_used_percent),2) AS avg_renewable_pct
FROM ev_data
GROUP BY city_zone
ORDER BY total_vehicles DESC;

-- 4. Station type performance
SELECT
    station_type,
    SUM(vehicles_charged) AS total_vehicles,
    ROUND(AVG(avg_charging_duration_minutes),2) AS avg_duration_min,
    ROUND(AVG(energy_dispensed_kwh),2) AS avg_energy_kwh
FROM ev_data
GROUP BY station_type
ORDER BY total_vehicles DESC;

-- 5. Peak hours by avg vehicles charged
SELECT
    hour,
    ROUND(AVG(vehicles_charged),2) AS avg_vehicles,
    ROUND(AVG(grid_load_mw),2) AS avg_grid_load
FROM ev_data
GROUP BY hour
ORDER BY avg_vehicles DESC
LIMIT 5;

-- 6. Risk distribution
SELECT
    peak_load_risk,
    COUNT(*) AS records_count,
    ROUND(100.0 * COUNT(*) / (SELECT COUNT(*) FROM ev_data), 2) AS pct_share
FROM ev_data
GROUP BY peak_load_risk
ORDER BY records_count DESC;

-- 7. Renewable usage by risk
SELECT
    peak_load_risk,
    ROUND(AVG(renewable_energy_used_percent),2) AS avg_renewable_pct
FROM ev_data
GROUP BY peak_load_risk
ORDER BY avg_renewable_pct DESC;

-- 8. High risk hours
SELECT
    hour,
    COUNT(*) AS high_risk_records
FROM ev_data
WHERE peak_load_risk = 'High'
GROUP BY hour
ORDER BY high_risk_records DESC
LIMIT 10;

-- 9. Weekend vs weekday demand
SELECT
    CASE WHEN is_weekend = 1 THEN 'Weekend' ELSE 'Weekday' END AS day_type,
    ROUND(AVG(vehicles_charged),2) AS avg_vehicles,
    ROUND(AVG(grid_load_mw),2) AS avg_grid_load
FROM ev_data
GROUP BY day_type;

-- 10. Top 10 highest grid load events
SELECT
    date_time, city_zone, station_type, vehicles_charged, grid_load_mw, peak_load_risk
FROM ev_data
ORDER BY grid_load_mw DESC
LIMIT 10;

-- 11. Daily demand trend
SELECT
    date,
    SUM(vehicles_charged) AS total_vehicles,
    ROUND(AVG(grid_load_mw),2) AS avg_grid_load
FROM ev_data
GROUP BY date
ORDER BY date;

-- 12. Energy efficiency by station type
SELECT
    station_type,
    ROUND(SUM(energy_dispensed_kwh) / NULLIF(SUM(vehicles_charged),0), 2) AS energy_per_vehicle
FROM ev_data
GROUP BY station_type
ORDER BY energy_per_vehicle DESC;

-- 13. Zone + station matrix
SELECT
    city_zone,
    station_type,
    SUM(vehicles_charged) AS total_vehicles,
    ROUND(AVG(grid_load_mw),2) AS avg_grid_load
FROM ev_data
GROUP BY city_zone, station_type
ORDER BY city_zone, total_vehicles DESC;

-- 14. Monthly summary
SELECT
    month,
    SUM(vehicles_charged) AS total_vehicles,
    ROUND(AVG(renewable_energy_used_percent),2) AS avg_renewable
FROM ev_data
GROUP BY month
ORDER BY total_vehicles DESC;

-- 15. Priority zones (high demand + high risk + high load)
SELECT
    city_zone,
    SUM(vehicles_charged) AS total_vehicles,
    ROUND(AVG(grid_load_mw),2) AS avg_grid,
    ROUND(AVG(CASE WHEN peak_load_risk='High' THEN 1.0 ELSE 0 END),3) AS high_risk_ratio
FROM ev_data
GROUP BY city_zone
ORDER BY total_vehicles DESC, high_risk_ratio DESC, avg_grid DESC;
