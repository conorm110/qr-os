import binascii
import pyqrcode
import png
from pyqrcode import QRCode
from zipfile import ZipFile

filename = 'bin/out.7z'
with open(filename, 'rb') as f:
    content = f.read()
s = str(binascii.hexlify(content))
print(s)

# Generate QR code
url = pyqrcode.create(s)
  
# Create and save the svg file naming "myqr.svg"
url.svg("os.svg", scale = 8)