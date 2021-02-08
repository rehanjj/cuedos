@echo off

REM Script to generate a CSR
REM Also generatea a local certificate (no CA) for testing purposes
REM See sample config file server.cfg for inputs
REM rehanj@etherzine.com


if "%~1"=="" (
	echo.
	echo Usage: %0% ^<config_file^>
	echo.
	goto :eof
)

set CFG=%1
if not exist %CFG% (
	echo.
	echo Error: file "%CFG%" not found!
	echo.
	goto :eof
)


REM Generate Key
openssl req -new -nodes -out server.csr -keyout rui-orig.key -config %CFG%

REM Remove Private Key Passphrase
openssl rsa -in rui-orig.key -out rui.key
del rui-orig.key

REM Check csr:
openssl req -text -noout -in server.csr > csrcheck.txt 2>&1
echo.
echo - Certificate Check file csrcheck.txt written
echo.

REM Generate Certificate
openssl x509 -req -sha256 -days 365 -extfile %CFG% -extensions v3_req -in server.csr -signkey rui.key -out server.cer

echo.
echo - Certificate Request: "server.csr" created
echo - Certificate "server.cer" generated
echo.
