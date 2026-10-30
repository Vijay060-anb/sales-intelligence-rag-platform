
import pandas as pd
from pathlib import Path
from decimal import Decimal, InvalidOperation

# ============================================================
# 1. PROJECT PATHS AND CONFIGURATION
# ============================================================

project_dir = Path(__file__).resolve().parent.parent

input_path = project_dir / "data" / "sales_data.csv"
output_path = project_dir / "data" / "sales_data_clean.csv"
report_path = project_dir / "reports" / "data_quality_report.txt"
issues_path = project_dir / "reports" / "discount_mismatches.csv"

report_path.parent.mkdir(parents=True, exist_ok=True)

# Prices are stored to two decimal places.
# Differences of exactly half a cent are allowed.
MONEY_TOLERANCE = Decimal("0.005")

# ============================================================
# 2. LOAD SOURCE DATA
# ============================================================

if not input_path.exists():
    raise FileNotFoundError(
        f"Source CSV not found: {input_path}"
    )

df = pd.read_csv(input_path, sep=";")

original_rows = len(df)
original_columns = len(df.columns)

required_columns = [
    "order_id",
    "order_date",
    "state",
    "zone",
    "category",
    "brand_type",
    "customer_gender",
    "customer_age",
    "base_price",
    "discount_percent",
    "final_price",
    "units_sold",
    "revenue",
    "sales_event",
    "competition_intensity",
    "inventory_pressure",
]

missing_columns = [
    column for column in required_columns
    if column not in df.columns
]

if missing_columns:
    raise ValueError(
        f"Required columns are missing: {missing_columns}"
    )

# ============================================================
# 3. CLEAN DATA TYPES
# ============================================================

df["order_date"] = pd.to_datetime(
    df["order_date"],
    format="%d/%m/%Y",
    errors="coerce",
)

numeric_columns = [
    "customer_age",
    "base_price",
    "discount_percent",
    "final_price",
    "units_sold",
    "revenue",
]

for column in numeric_columns:
    df[column] = pd.to_numeric(
        df[column],
        errors="coerce",
    )

# ============================================================
# 4. DATA QUALITY CHECKS
# ============================================================

missing_by_column = df.isna().sum()
missing_cells = int(missing_by_column.sum())

duplicate_rows = int(df.duplicated().sum())
duplicate_order_ids = int(
    df["order_id"].duplicated().sum()
)

invalid_dates = int(df["order_date"].isna().sum())

negative_prices = int(
    (
        (df["base_price"] < 0)
        | (df["final_price"] < 0)
    ).sum()
)

negative_units = int(
    (df["units_sold"] < 0).sum()
)

invalid_discount_range = int(
    (
        (df["discount_percent"] < 0)
        | (df["discount_percent"] > 100)
    ).sum()
)

invalid_customer_age = int(
    (
        (df["customer_age"] < 0)
        | (df["customer_age"] > 120)
    ).sum()
)

# ============================================================
# 5. DISCOUNT FORMULA VALIDATION
# ============================================================

def to_decimal(value):
    """Convert a numeric value safely to Decimal."""
    if pd.isna(value):
        return None

    try:
        return Decimal(str(value))
    except (InvalidOperation, ValueError):
        return None


def calculate_discount_difference(row):
    """
    Compare recorded final price against the unrounded
    mathematical price. Return the absolute difference.
    """

    base_price = to_decimal(row["base_price"])
    discount = to_decimal(row["discount_percent"])
    recorded_price = to_decimal(row["final_price"])

    if (
        base_price is None
        or discount is None
        or recorded_price is None
    ):
        return None

    expected_price = base_price * (
        Decimal("1") - discount / Decimal("100")
    )

    return abs(recorded_price - expected_price)


discount_differences = df.apply(
    calculate_discount_difference,
    axis=1,
)

discount_mismatch_mask = discount_differences.apply(
    lambda difference: (
        difference is None
        or difference > MONEY_TOLERANCE
    )
)

discount_mismatches = int(
    discount_mismatch_mask.sum()
)

# Export discount exceptions for investigation.
discount_issues = df.loc[
    discount_mismatch_mask,
    [
        "order_id",
        "base_price",
        "discount_percent",
        "final_price",
    ],
].copy()

discount_issues["expected_price_unrounded"] = [
    str(
        to_decimal(row["base_price"])
        * (
            Decimal("1")
            - to_decimal(row["discount_percent"])
            / Decimal("100")
        )
    )
    if (
        to_decimal(row["base_price"]) is not None
        and to_decimal(row["discount_percent"]) is not None
    )
    else ""
    for _, row in discount_issues.iterrows()
]

discount_issues["absolute_difference"] = [
    str(discount_differences.loc[index])
    for index in discount_issues.index
]

discount_issues.to_csv(
    issues_path,
    index=False,
)

# ============================================================
# 6. REVENUE FORMULA VALIDATION
# ============================================================

def calculate_revenue_difference(row):
    """
    Validate revenue = final_price * units_sold.
    Allow a half-cent tolerance for stored monetary values.
    """

    final_price = to_decimal(row["final_price"])
    units_sold = to_decimal(row["units_sold"])
    recorded_revenue = to_decimal(row["revenue"])

    if (
        final_price is None
        or units_sold is None
        or recorded_revenue is None
    ):
        return None

    expected_revenue = final_price * units_sold

    return abs(recorded_revenue - expected_revenue)


revenue_differences = df.apply(
    calculate_revenue_difference,
    axis=1,
)

revenue_mismatch_mask = revenue_differences.apply(
    lambda difference: (
        difference is None
        or difference > MONEY_TOLERANCE
    )
)

revenue_mismatches = int(
    revenue_mismatch_mask.sum()
)

# ============================================================
# 7. DATE RANGE AND BUSINESS METRICS
# ============================================================

valid_dates = df["order_date"].dropna()

first_date = (
    valid_dates.min().strftime("%Y-%m-%d")
    if not valid_dates.empty
    else "N/A"
)

last_date = (
    valid_dates.max().strftime("%Y-%m-%d")
    if not valid_dates.empty
    else "N/A"
)

total_units = (
    df["units_sold"].sum()
    if df["units_sold"].notna().any()
    else 0
)

total_revenue = (
    df["revenue"].sum()
    if df["revenue"].notna().any()
    else 0
)

# ============================================================
# 8. EXPORT CLEANED DATA
# ============================================================

df.to_csv(
    output_path,
    index=False,
    date_format="%Y-%m-%d",
)

rows_retained = len(df)

# ============================================================
# 9. BUILD COMPLETE QUALITY REPORT
# ============================================================

report_lines = [
    "SALES DATA QUALITY REPORT",
    "=" * 25,
    "",
    "DATASET OVERVIEW",
    "-" * 16,
    f"Rows loaded: {original_rows}",
    f"Columns: {original_columns}",
    f"Rows retained: {rows_retained}",
    f"First date: {first_date}",
    f"Last date: {last_date}",
    f"Total units sold: {total_units:,.0f}",
    f"Total revenue: {total_revenue:,.2f}",
    "",
    "MISSING VALUES",
    "-" * 14,
    f"Total missing cells: {missing_cells}",
    "",
    "Missing values by column:",
]

for column, count in missing_by_column.items():
    report_lines.append(f"{column:<25} {count}")

report_lines.extend([
    "",
    "DUPLICATES",
    "-" * 10,
    f"Duplicate rows: {duplicate_rows}",
    f"Duplicate order IDs: {duplicate_order_ids}",
    "",
    "DATE VALIDATION",
    "-" * 15,
    f"Invalid dates: {invalid_dates}",
    "",
    "NUMERICAL VALIDATION",
    "-" * 20,
    f"Negative prices: {negative_prices}",
    f"Negative units sold: {negative_units}",
    f"Discounts outside 0-100%: {invalid_discount_range}",
    f"Customer ages outside 0-120: {invalid_customer_age}",
    "",
    "BUSINESS RULE VALIDATION",
    "-" * 24,
    f"Discount formula mismatches: {discount_mismatches}",
    f"Revenue formula mismatches: {revenue_mismatches}",
    f"Money tolerance: {MONEY_TOLERANCE}",
    "",
    "FILES CREATED",
    "-" * 13,
    f"Cleaned CSV: {output_path}",
    f"Quality report: {report_path}",
    f"Discount issues: {issues_path}",
    "",
])

report_text = "\n".join(report_lines)

report_path.write_text(
    report_text,
    encoding="utf-8",
)

# ============================================================
# 10. DISPLAY RESULTS
# ============================================================

print(report_text)

print("\nPROCESS COMPLETED")
print(f"Cleaned CSV saved to: {output_path}")
print(f"Quality report saved to: {report_path}")
print(f"Discount issues saved to: {issues_path}")
