# Nhóm 8 - Triển khai OpenWrt (Flash firmware) lên router TP-Link

## 1. Giới thiệu

Mục tiêu của repo là chứng minh quá trình nhóm đã thực hiện triển khai thực tế, bao gồm flash firmware, cấu hình mạng cơ bản và demo các tính năng nâng cao trên OpenWrt.

## 2. Thành viên

| Thành viên | MSSV | Công việc chính |
|---|---:|---|
| Trương Danh Nhân | 24521245 | Chuẩn bị router, tải firmware, kiểm tra checksum, flash OpenWrt |
| Trần Thanh Nguyên | 24521213 | Cấu hình Multi-WAN Failover và host website |
| Đào Mạnh Nhân | 24521227 | Cài package, cấu hình SQM/QoS và đo trước/sau |
| Trương Vĩnh Nguyên | 24521216 | Cấu hình LAN/WAN/DHCP/Wi-Fi chính và Guest Wi-Fi |

## 3. Thiết bị và môi trường

| Thành phần | Thông tin |
|---|---|
| Router | TP-Link Archer C7 AC1750 v5 |
| Firmware | OpenWrt 25.12.4 |
| Giao diện quản trị | LuCI |
| LAN | 192.168.1.1/24 |
| Guest Wi-Fi | 192.168.50.1/24 |
| WAN chính | usbwan - USB tethering từ điện thoại 4G |
| WAN phụ | wwan - Wi-Fi WAN từ hotspot/mạng Wi-Fi khác |

## 4. Các demo đã thực hiện

### Demo 1: Cài package và mở rộng chức năng router

Cài các gói phục vụ demo:

```sh
apk update
apk add --scripts=no htop luci-app-sqm sqm-scripts mwan3 luci-app-mwan3
```

Minh chứng:
- Ảnh cài package thành công.
- Giao diện `htop`.
- Menu SQM QoS.
- Menu MultiWAN Manager.

### Demo 2: Tạo Wi-Fi Guest tách biệt LAN và giới hạn băng thông

Cấu hình chính:
- SSID Guest: `OpenWrt-Nhom8-Guest`
- Network Guest: `guest`
- Gateway Guest: `192.168.50.1/24`
- Firewall: `guest -> wan`, không forward `guest -> lan`
- Giới hạn băng thông bằng SQM hoặc công cụ giới hạn phù hợp.

Minh chứng:
- Client Guest nhận IP `192.168.50.x`.
- Client Guest truy cập Internet được.
- Client Guest bị chặn truy cập LAN/router.
- Speedtest cho thấy Guest bị giới hạn băng thông.

### Demo 3: SQM/QoS giảm lag khi mạng tải nặng

Mục tiêu:
- So sánh ping trước và sau khi bật SQM.
- Tạo tải bằng cách tải file lớn hoặc chạy Speedtest.
- Dùng `ping` để kiểm tra độ trễ.

Ví dụ kiểm tra:

```cmd
ping -t 1.1.1.1
```

Kết quả ghi nhận:
- Chưa bật SQM: ping tăng cao khi tải nặng.
- Đã bật SQM: ping ổn định hơn, ít spike hơn.

### Demo 4: Multi-WAN Failover

Mục tiêu:
- `usbwan` là WAN chính.
- `wwan` là WAN phụ.
- `mwan3` tự chuyển sang `wwan` khi `usbwan` mất kết nối.

Cấu hình đề xuất:
- `usbwan` metric 1.
- `wwan` metric 2.
- Policy: ưu tiên `usbwan`, failover sang `wwan`.

Kiểm tra trạng thái:

```sh
mwan3 status
```

Minh chứng:
- Hai đường WAN online.
- Tắt USB tethering làm `usbwan` offline.
- `wwan` vẫn online.
- Client vẫn ping/truy cập Internet được.

### Demo 5: Host website tĩnh nội bộ bằng uHTTPd

Website đặt tại:

```sh
/www/nhom8/index.html
```

Truy cập từ LAN/Wi-Fi chính:

```text
http://192.168.1.1/nhom8/
```

## 5. Cấu trúc repo

```text
openwrt-nhom8/
├── README.md
├── docs/
│   └── BaoCao-OpenWrt-Nhom8.docx
├── configs/
│   ├── openwrt/
│   ├── guest-wifi/
│   ├── sqm/
│   ├── mwan3/
│   └── uhttpd/
├── scripts/
│   ├── install-packages.sh
│   ├── check-network.sh
│   └── create-uhttpd-site.sh
└── images/
    ├── demo1-package/
    ├── demo2-guest-wifi/
    ├── demo3-sqm/
    ├── demo4-multiwan/
    └── demo5-uhttpd/
```

## 7. Kết luận

Repo này đóng vai trò như nhật ký triển khai của nhóm, thể hiện quá trình cấu hình thực tế trên OpenWrt và lưu lại các minh chứng kỹ thuật phục vụ báo cáo đồ án.
