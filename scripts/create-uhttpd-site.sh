#!/bin/sh
# Tạo website tĩnh nội bộ cho demo uHTTPd

mkdir -p /www/nhom8

cat > /www/nhom8/index.html <<'EOF'
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Nhóm 8 - OpenWrt</title>
</head>
<body>
    <h1>Hello World</h1>
    <p>Nhóm 8: Triển khai OpenWrt lên router TP-Link Archer C7 v5.</p>
</body>
</html>
EOF

/etc/init.d/uhttpd restart

echo "Website created: http://192.168.1.1/nhom8/"
