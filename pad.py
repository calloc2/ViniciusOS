import sys
import os

filename = sys.argv[1]
with open(filename, "rb") as f:
    data = f.read()

pad_len = (512 - (len(data) % 512)) % 512
data += b"\x00" * pad_len

with open(filename, "wb") as f:
    f.write(data)

print(f"Padded {filename} to {len(data)} bytes (next 512 boundary).")
