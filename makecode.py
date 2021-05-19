import binascii
import pyqrcode
import png
from pyqrcode import QRCode
import cairosvg
filename = 'bin/out.7z'
with open(filename, 'rb') as f:
    content = f.read()
s = str(binascii.hexlify(content))
print(s)
url = pyqrcode.create(s)
url.svg("out/os.svg", scale = 8)
cairosvg.svg2pdf(url='out/os.svg', write_to='out/os.pdf')
cairosvg.svg2png(url='out/os.svg', write_to='out/os.png')