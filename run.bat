@echo off
setlocal

REM Keep this script self-contained to avoid 8191-char PATH overflows.
SET "PortableJekyll=Z:\longtf\opensource\PortableJekyll"

REM Optional proxies (comment out if not needed)
SET "http_proxy=http://192.168.66.105:7890"
SET "https_proxy=http://192.168.66.105:7890"

REM Build a minimal PATH required by PortableJekyll, plus System32 for built-ins like chcp
SET "PATH=%SystemRoot%\System32;%PortableJekyll%\ruby\bin;%PortableJekyll%\devkit\bin;%PortableJekyll%\git\bin;%PortableJekyll%\Python\App;%PortableJekyll%\Python\App\Scripts;%PortableJekyll%\devkit\mingw\bin;%PortableJekyll%\curl\bin"
SET "SSL_CERT_FILE=%PortableJekyll%\curl\bin\cacert.pem"

IF NOT EXIST "%PortableJekyll%" (
  echo [ERROR] PortableJekyll not found at %PortableJekyll%
  goto :END
)

REM Use the bundled Python to avoid relying on system PATH
IF NOT EXIST "%PortableJekyll%\Python\App\python.exe" (
  echo [ERROR] Python not found in PortableJekyll. Check installation.
  goto :END
)

"%PortableJekyll%\Python\App\python.exe" upload.py
"%PortableJekyll%\Python\App\python.exe" publish.py

:END
endlocal
pause
