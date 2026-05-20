#!/bin/sh
# Kiểm tra nhanh trạng thái mạng trên OpenWrt

echo "=== System board ==="
ubus call system board

echo
echo "=== Interfaces ==="
ip addr show

echo
echo "=== Routes ==="
ip route

echo
echo "=== Ping Internet IP ==="
ping -c 4 1.1.1.1

echo
echo "=== DNS test ==="
nslookup uit.edu.vn

echo
echo "=== mwan3 status ==="
mwan3 status 2>/dev/null || echo "mwan3 is not installed or not running"
