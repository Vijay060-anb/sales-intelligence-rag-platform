from decimal import Decimal, ROUND_HALF_EVEN, ROUND_HALF_UP

base = Decimal("789.9")
discount = Decimal("65.00")

expected = base * (Decimal("1") - discount / Decimal("100"))

print("Unrounded price:", expected)
print(
    "Half-even:",
    expected.quantize(Decimal("0.01"), rounding=ROUND_HALF_EVEN)
)
print(
    "Half-up:",
    expected.quantize(Decimal("0.01"), rounding=ROUND_HALF_UP)
)