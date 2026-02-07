---
name: api-data-fetcher
description: Fetch economic data from FRED, World Bank, Census Bureau, and BLS APIs using Python.
disable-model-invocation: true
argument-hint: "[data source or indicator description]"
---

# API Data Fetcher

Generate Python scripts to fetch economic data from major APIs. Saves data to `data/raw/` with documentation.

## Steps

1. **Identify Data Requirements**
   - What data is needed? (GDP, unemployment, inflation, microdata, etc.)
   - What time period and frequency?
   - What countries/regions?
   - Output format? (CSV for cross-language use, Parquet for large datasets)

2. **Select the Appropriate API**

   | Data Type | Best Source | Python Package |
   |-----------|------------|---------------|
   | US macro (GDP, CPI, rates) | FRED | `fredapi` |
   | Global development indicators | World Bank | `wbdata` |
   | US labor statistics | BLS | `requests` (REST API) |
   | US Census/ACS microdata | Census Bureau | `census` |
   | Cross-country macro | OECD | `pandasdmx` |
   | Financial markets | Yahoo Finance | `yfinance` |

3. **Generate the Script**

   All generated scripts must follow these conventions:

   - **API key security:** Load from environment variables, never hardcode
     ```python
     import os
     api_key = os.environ.get("FRED_API_KEY")
     if not api_key:
         raise ValueError("Set FRED_API_KEY environment variable")
     ```
   - **Save to `data/raw/`:** All fetched data goes to `data/raw/<descriptive_name>.csv`
   - **Document the data:** Include a header comment with series IDs, date fetched, and source URL
   - **Error handling:** Wrap API calls in try/except with informative messages
   - **Rate limiting:** Add `time.sleep()` for bulk downloads
   - **Type hints and docstrings** on all functions

4. **Provide R Loading Instructions**

   Since R is the primary analysis language, always include a note on loading the fetched data into R:

   ```r
   # Load data fetched by api-data-fetcher
   library(readr)
   df <- read_csv("data/raw/<filename>.csv")

   # For Parquet files (faster for large data)
   library(arrow)
   df <- read_parquet("data/raw/<filename>.parquet")
   ```

5. **Verify**
   - Run the script to confirm data downloads successfully
   - Check that output file exists and has expected dimensions
   - Confirm no API keys are hardcoded in the script

## Common API References

### FRED Series IDs
| Category | Series | Description |
|----------|--------|-------------|
| GDP | `GDPC1` | Real GDP |
| Labor | `UNRATE` | Unemployment Rate |
| Prices | `CPIAUCSL` | CPI All Items |
| Rates | `FEDFUNDS` | Federal Funds Rate |
| Rates | `DGS10` | 10-Year Treasury |

### Census Bureau
```python
from census import Census
c = Census(os.environ["CENSUS_API_KEY"])
# ACS 5-year estimates
data = c.acs5.state(("NAME", "B19013_001E"), Census.ALL)
```

### BLS API
```python
import requests
headers = {"Content-type": "application/json"}
payload = {
    "seriesid": ["LNS14000000"],  # Unemployment rate
    "startyear": "2020",
    "endyear": "2024",
    "registrationkey": os.environ.get("BLS_API_KEY")
}
response = requests.post(
    "https://api.bls.gov/publicAPI/v2/timeseries/data/",
    json=payload, headers=headers
)
```

## API Key Setup

```bash
# Add to your shell profile (~/.bashrc or ~/.zshrc) or .env file
export FRED_API_KEY="your_key_here"        # https://fred.stlouisfed.org/docs/api/api_key.html
export CENSUS_API_KEY="your_key_here"      # https://api.census.gov/data/key_signup.html
export BLS_API_KEY="your_key_here"         # https://www.bls.gov/developers/
```

**Never commit `.env` files or API keys to git.** Ensure `.env` is in `.gitignore`.

## Required Python Packages

```bash
pip install fredapi wbdata pandas requests
# Optional: census pandasdmx yfinance pyarrow
```

## Data Directory Convention

```
data/
├── raw/              # Unmodified API downloads (fetched by this skill)
│   ├── fred_macro_2024-01-15.csv
│   └── worldbank_gdp_panel.csv
└── clean/            # Processed data (created by analysis scripts)
```
