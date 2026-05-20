#!/bin/sh
# Cài các package cần thiết cho đồ án OpenWrt Nhóm 8

apk update

apk add --scripts=no \
    htop \
    luci-app-sqm \
    sqm-scripts \
    mwan3 \
    luci-app-mwan3

echo "Done. Please reboot the router if LuCI menu does not appear."
