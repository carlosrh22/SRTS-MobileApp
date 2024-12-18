#!/bin/bash
echo "Instalando Firefox en el emulador..."
adb -s localhost:5555 install-multiple firefox-base.apk firefox-split-x86_64.apk firefox-split-xxhdpi.apk
echo "Firefox instalado con éxito."
