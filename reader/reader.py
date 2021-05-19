from pyzbar import pyzbar
from PIL import Image

#load qr code imge
image = Image.open("../out/os-1.png")

qr_code = pyzbar.decode(image)[0]

#convert into string
data= qr_code.data.decode("utf-8")
type = qr_code.type
text = f"{type}-->, {data}"
print("----")
print(text)
print("----")

import binascii

with open('os.txt') as f, open('test.7z', 'wb') as fout:
    for line in f:
        fout.write(
            binascii.unhexlify(''.join(line.split()))
        )