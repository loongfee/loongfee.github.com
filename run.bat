@echo off
SET PortableJekyll=Z:\longtf\opensource\PortableJekyll
@set http_proxy=http://192.168.66.126:7890
@set https_proxy=http://192.168.66.126:7890
SET PATH=%PortableJekyll%\ruby\bin;%PortableJekyll%\devkit\bin;%PortableJekyll%\git\bin;%PortableJekyll%\Python\App;%PortableJekyll%\Python\App\Scripts;%PortableJekyll%\devkit\mingw\bin;%PortableJekyll%\curl\bin;%PATH%;

set SSL_CERT_FILE=%PortableJekyll%\curl\bin\cacert.pem

:: reset account
:: git config --global --unset credential.helper
:: git config credential.helper store

python upload.py
python publish.py

pause