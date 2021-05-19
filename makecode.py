import binascii
import pyqrcode
import png
from pyqrcode import QRCode
import cairosvg
from PIL import Image
filename = 'bin/out.7z'
with open(filename, 'rb') as f:
    content = f.read()
s = str(binascii.hexlify(content))
print(s)
url = pyqrcode.create(s)
url.svg("out/os.svg", scale = 8)
cairosvg.svg2pdf(url='out/os.svg', write_to='out/os.pdf')
cairosvg.svg2png(url='out/os.svg', write_to='out/os.png')
from PIL import Image

image = Image.open('out/os.png')
new_image = Image.new("RGBA", image.size, "WHITE") # Create a white rgba background
new_image.paste(image, (0, 0), image)              # Paste the image on the background. Go to the links given below for details.
new_image.convert('RGB').save('out/os.jpg', "JPEG")  # Save as JPEG