NAME = "Devansh Tanna"
name_bits = ''
for i in NAME:
    name_bits += bin(ord(i))[2:]

print(name_bits)