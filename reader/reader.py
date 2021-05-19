from pyzbar import pyzbar
from PIL import Image
import binascii
import os

image = Image.open("../out/os.jpg")
print("test")
qr_code = pyzbar.decode(image)[0]
data= qr_code.data.decode("utf-8")
type = qr_code.type
text = f"{type}-->, {data}"
f = open("os.txt", "a")
f.write((text[13:]).replace('\'',''))
f.close()

with open('os.txt') as f, open('os.7z', 'wb') as fout:
    for line in f:
        fout.write(
            binascii.unhexlify(''.join(line.split()))
        )
os.system('7z x os.7z')
os.remove("os.7z")
os.remove("os.txt")
os.system('qemu-system-x86_64 bootloader.flp')
os.remove("bootloader.flp")