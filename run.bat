@echo off
SET PortableJekyll=D:\opensource\PortableJekyll
SET PATH=%PortableJekyll%\ruby\bin;%PortableJekyll%\devkit\bin;%PortableJekyll%\git\bin;%PortableJekyll%\Python\App;%PortableJekyll%\Python\App\Scripts;%PortableJekyll%\devkit\mingw\bin;%PortableJekyll%\curl\bin;%PATH%;

set SSL_CERT_FILE=%PortableJekyll%\curl\bin\cacert.pem

python upload.py
python publish.py

pause