# ⚡ EV Charging Network & Grid Load Intelligence

## 📌 Project Objective
This project analyzes EV charging usage patterns, grid load behavior, and peak risk indicators to identify operational stress points and potential expansion priorities.

## 📂 Files
- `ev_charging_station_usage_grid_load.csv` → source dataset
- `ev_charging_analysis.ipynb` → Python EDA + feature engineering
- `ev_charging_analysis.sql` → SQL analytics queries
- `EV_Charging_Analysis.pbix` → Power BI dashboard
- `README.md` → project documentation

## 🛠️ Tech Stack
- Python (Pandas, NumPy, Matplotlib, Seaborn)
- SQL
- Power BI

## 📊 Dataset Fields
- `date_time`
- `city_zone` (Central, North, South, East, West)
- `station_type` (Normal, Fast, Supercharger)
- `vehicles_charged`
- `avg_charging_duration_minutes`
- `energy_dispensed_kwh`
- `grid_load_mw`
- `renewable_energy_used_percent`
- `peak_load_risk` (Low, Medium, High)

## 🔎 Analysis Performed
1. Data quality checks (nulls, duplicates, value consistency)
2. Feature engineering (`hour`, `day_name`, `is_weekend`, `energy_per_vehicle`)
3. Zone-wise and station-wise demand analysis
4. Hourly demand vs grid load pattern analysis
5. Peak load risk and renewable usage relationship
6. Priority scoring for zones based on demand and risk

## 📈 Key Insights (example)
- Identified demand-heavy zones with higher grid stress.
- Detected hourly windows with elevated peak risk frequency.
- Compared station types for energy efficiency and throughput.
- Evaluated renewable share behavior across risk categories.
