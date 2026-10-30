
import pandas as pd
from pathlib import Path

# Locate the project and input file
project_dir = Path(__file__).resolve().parent.parent
csv_path = project_dir / "data" / "sales_data.csv"

# Read the semicolon-separated CSV
df = pd.read_csv(csv_path, sep=";")

# Inspect the dataset
print("DATASET SHAPE:", df.shape)

print("\nCOLUMN NAMES:")
print(df.columns.tolist())

print("\nFIRST FIVE ROWS:")
print(df.head())

print("\nDATA TYPES:")
print(df.dtypes)

print("\nMISSING VALUES:")
print(df.isnull().sum())

print("\nDUPLICATE ROWS:", df.duplicated().sum())

# Save a basic profiling report
report_path = project_dir / "reports" / "data_profile.txt"

with open(report_path, "w", encoding="utf-8") as file:
    file.write(f"Dataset shape: {df.shape}\n")
    file.write("\nColumn names:\n")
    file.write(str(df.columns.tolist()))
    file.write("\n\nData types:\n")
    file.write(df.dtypes.to_string())
    file.write("\n\nMissing values:\n")
    file.write(df.isnull().sum().to_string())
    file.write(f"\n\nDuplicate rows: {df.duplicated().sum()}\n")

print("\nProfile saved to:", report_path)
