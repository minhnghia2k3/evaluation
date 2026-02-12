# Mô tả Chi tiết Cơ sở Dữ liệu

## 1. Nhóm Bảng Cơ sở Hạ tầng

### NHA_MAY
**Mục đích**: Quản lý thông tin các nhà máy trong hệ thống

**Các trường**:
- `ma_nha_may` (PK): Mã định danh duy nhất
- `ten_nha_may`: Tên nhà máy
- `dia_chi`: Địa chỉ đầy đủ
- `so_dien_thoai`: Số điện thoại liên hệ
- `ngay_thanh_lap`: Ngày thành lập
- `trang_thai`: Hoạt động/Ngừng hoạt động

**Ràng buộc**:
- `ten_nha_may` NOT NULL, UNIQUE
- `trang_thai` DEFAULT TRUE

**Indexes**:
- PRIMARY KEY: `ma_nha_may`
- INDEX: `idx_nha_may_trang_thai` trên `trang_thai`

---

### KHO
**Mục đích**: Quản lý các kho hàng thuộc nhà máy

**Các trường**:
- `ma_kho` (PK): Mã định danh kho
- `ma_nha_may` (FK): Thuộc nhà máy nào
- `ten_kho`: Tên kho
- `loai_kho`: Kho nguyên liệu/Kho bán thành phẩm/Kho thành phẩm/Kho lạnh
- `dien_tich`: Diện tích (m2)
- `suc_chua_toi_da`: Sức chứa tối đa (tấn)
- `trang_thai`: Hoạt động/Bảo trì/Đóng cửa

**Ràng buộc**:
- `ten_kho` NOT NULL
- `loai_kho` IN ('NGUYEN_LIEU', 'BAN_THANH_PHAM', 'THANH_PHAM', 'KHO_LANH')
- `dien_tich` > 0
- `suc_chua_toi_da` > 0

**Indexes**:
- PRIMARY KEY: `ma_kho`
- FOREIGN KEY: `ma_nha_may` REFERENCES NHA_MAY
- INDEX: `idx_kho_nha_may` trên `ma_nha_may`
- INDEX: `idx_kho_loai` trên `loai_kho`

---

### VI_TRI_KHO
**Mục đích**: Quản lý vị trí cụ thể trong kho (kệ, tầng, ngăn)

**Các trường**:
- `ma_vi_tri` (PK): Mã vị trí
- `ma_kho` (FK): Thuộc kho nào
- `ma_ke`: Mã kệ (A, B, C...)
- `ma_tang`: Mã tầng (1, 2, 3...)
- `ma_ngan`: Mã ngăn (01, 02, 03...)
- `suc_chua`: Sức chứa của vị trí (kg)
- `loai_vi_tri`: Thường/Lạnh/Đông lạnh
- `trang_thai`: Trống/Đang sử dụng/Bảo trì

**Ràng buộc**:
- `ma_ke`, `ma_tang`, `ma_ngan` NOT NULL
- UNIQUE (`ma_kho`, `ma_ke`, `ma_tang`, `ma_ngan`)
- `suc_chua` > 0
- `loai_vi_tri` IN ('THUONG', 'LANH', 'DONG_LANH')

**Indexes**:
- PRIMARY KEY: `ma_vi_tri`
- FOREIGN KEY: `ma_kho` REFERENCES KHO
- UNIQUE INDEX: `idx_vi_tri_unique` trên (`ma_kho`, `ma_ke`, `ma_tang`, `ma_ngan`)
- INDEX: `idx_vi_tri_trang_thai` trên `trang_thai`

---

## 2. Nhóm Bảng Vật tư và Sản phẩm

### LOAI_VAT_TU
**Mục đích**: Phân loại vật tư theo cấu trúc cây (hỗ trợ phân cấp)

**Các trường**:
- `ma_loai_vat_tu` (PK): Mã loại vật tư
- `ten_loai`: Tên loại (Nguyên liệu, Bán thành phẩm, Thành phẩm...)
- `mo_ta`: Mô tả chi tiết
- `loai_cha` (FK): Loại cha (NULL nếu là loại gốc)

**Ràng buộc**:
- `ten_loai` NOT NULL, UNIQUE
- `loai_cha` REFERENCES LOAI_VAT_TU (tự tham chiếu)

**Indexes**:
- PRIMARY KEY: `ma_loai_vat_tu`
- INDEX: `idx_loai_vat_tu_cha` trên `loai_cha`

**Ví dụ cấu trúc**:
```
Nguyên liệu
├── Sữa tươi
├── Đường
└── Hương liệu
Bán thành phẩm
├── Sữa tiệt trùng
└── Sữa chua không đường
Thành phẩm
├── Sữa tươi đóng hộp
└── Sữa chua có đường
```

---

### VAT_TU
**Mục đích**: Quản lý thông tin chi tiết về vật tư, nguyên liệu, sản phẩm

**Các trường**:
- `ma_vat_tu` (PK): Mã vật tư
- `ma_loai_vat_tu` (FK): Thuộc loại nào
- `ten_vat_tu`: Tên vật tư
- `ma_vat_tu`: Mã vật tư (SKU)
- `loai_hang`: NGUYEN_LIEU/BAN_THANH_PHAM/THANH_PHAM
- `don_vi_tinh`: Lít/Kg/Thùng/Hộp...
- `gia_nhap_trung_binh`: Giá nhập trung bình
- `thoi_han_su_dung_ngay`: Thời hạn sử dụng (số ngày)
- `nhiet_do_bao_quan_min`: Nhiệt độ bảo quản tối thiểu (°C)
- `nhiet_do_bao_quan_max`: Nhiệt độ bảo quản tối đa (°C)
- `yeu_cau_lo_hang`: Có yêu cầu quản lý theo lô không
- `trang_thai`: Đang sử dụng/Ngừng sử dụng

**Ràng buộc**:
- `ten_vat_tu` NOT NULL
- `ma_vat_tu` UNIQUE, NOT NULL
- `loai_hang` IN ('NGUYEN_LIEU', 'BAN_THANH_PHAM', 'THANH_PHAM')
- `don_vi_tinh` NOT NULL
- `thoi_han_su_dung_ngay` >= 0
- `nhiet_do_bao_quan_min` <= `nhiet_do_bao_quan_max`

**Indexes**:
- PRIMARY KEY: `ma_vat_tu`
- UNIQUE INDEX: `idx_vat_tu_ma` trên `ma_vat_tu`
- INDEX: `idx_vat_tu_loai` trên `loai_hang`
- INDEX: `idx_vat_tu_ten` trên `ten_vat_tu`

---

### LO_HANG
**Mục đích**: Quản lý thông tin lô hàng, truy xuất nguồn gốc

**Các trường**:
- `ma_lo_hang` (PK): Mã lô hàng
- `ma_vat_tu` (FK): Vật tư thuộc lô
- `so_lo`: Số lô (batch number)
- `ngay_san_xuat`: Ngày sản xuất
- `han_su_dung`: Hạn sử dụng
- `ma_nha_cung_cap` (FK): Nhà cung cấp (NULL nếu tự sản xuất)
- `chung_nhan_chat_luong`: Số chứng nhận chất lượng
- `trang_thai`: Mới/Đang sử dụng/Hết hạn/Thu hồi

**Ràng buộc**:
- `so_lo` NOT NULL
- UNIQUE (`ma_vat_tu`, `so_lo`)
- `ngay_san_xuat` <= `han_su_dung`
- `han_su_dung` NOT NULL

**Indexes**:
- PRIMARY KEY: `ma_lo_hang`
- UNIQUE INDEX: `idx_lo_hang_unique` trên (`ma_vat_tu`, `so_lo`)
- INDEX: `idx_lo_hang_han_su_dung` trên `han_su_dung`
- INDEX: `idx_lo_hang_trang_thai` trên `trang_thai`

---

## 3. Nhóm Bảng Nhập Xuất Kho

### PHIEU_NHAP
**Mục đích**: Quản lý phiếu nhập kho

**Các trường**:
- `ma_phieu_nhap` (PK): Mã phiếu nhập
- `so_phieu_nhap`: Số phiếu (PN-YYYYMMDD-XXX)
- `ma_kho` (FK): Nhập vào kho nào
- `ma_nha_cung_cap` (FK): Từ nhà cung cấp nào (NULL nếu nhập từ sản xuất)
- `ngay_nhap`: Ngày giờ nhập
- `ma_nhan_vien` (FK): Nhân viên xử lý
- `loai_nhap`: Mua hàng/Nhập từ sản xuất/Nhập trả lại/Điều chuyển
- `trang_thai_phieu`: Nháp/Đã duyệt/Đã nhập/Hủy
- `ghi_chu`: Ghi chú

**Ràng buộc**:
- `so_phieu_nhap` UNIQUE, NOT NULL
- `ngay_nhap` NOT NULL
- `loai_nhap` IN ('MUA_HANG', 'TU_SAN_XUAT', 'TRA_LAI', 'DIEU_CHUYEN')
- `trang_thai_phieu` IN ('NHAP', 'DA_DUYET', 'DA_NHAP', 'HUY')

**Indexes**:
- PRIMARY KEY: `ma_phieu_nhap`
- UNIQUE INDEX: `idx_phieu_nhap_so` trên `so_phieu_nhap`
- INDEX: `idx_phieu_nhap_ngay` trên `ngay_nhap`
- INDEX: `idx_phieu_nhap_trang_thai` trên `trang_thai_phieu`

---

### CHI_TIET_NHAP
**Mục đích**: Chi tiết các vật tư trong phiếu nhập

**Các trường**:
- `ma_chi_tiet_nhap` (PK): Mã chi tiết
- `ma_phieu_nhap` (FK): Thuộc phiếu nhập nào
- `ma_vat_tu` (FK): Vật tư nhập
- `ma_lo_hang` (FK): Lô hàng
- `so_luong`: Số lượng nhập
- `don_vi_tinh`: Đơn vị tính
- `don_gia`: Đơn giá
- `thanh_tien`: Thành tiền
- `ma_vi_tri` (FK): Vị trí lưu kho

**Ràng buộc**:
- `so_luong` > 0
- `don_gia` >= 0
- `thanh_tien` = `so_luong` * `don_gia`

**Indexes**:
- PRIMARY KEY: `ma_chi_tiet_nhap`
- INDEX: `idx_chi_tiet_nhap_phieu` trên `ma_phieu_nhap`
- INDEX: `idx_chi_tiet_nhap_vat_tu` trên `ma_vat_tu`

---

### PHIEU_XUAT
**Mục đích**: Quản lý phiếu xuất kho

**Các trường**:
- `ma_phieu_xuat` (PK): Mã phiếu xuất
- `so_phieu_xuat`: Số phiếu (PX-YYYYMMDD-XXX)
- `ma_kho` (FK): Xuất từ kho nào
- `ngay_xuat`: Ngày giờ xuất
- `ma_nhan_vien` (FK): Nhân viên xử lý
- `ma_lenh_san_xuat` (FK): Xuất cho lệnh sản xuất nào (NULL nếu xuất bán)
- `loai_xuat`: Xuất sản xuất/Xuất bán/Xuất hủy/Điều chuyển
- `trang_thai_phieu`: Nháp/Đã duyệt/Đã xuất/Hủy
- `ghi_chu`: Ghi chú

**Ràng buộc**:
- `so_phieu_xuat` UNIQUE, NOT NULL
- `ngay_xuat` NOT NULL
- `loai_xuat` IN ('SAN_XUAT', 'BAN_HANG', 'HUY', 'DIEU_CHUYEN')
- `trang_thai_phieu` IN ('NHAP', 'DA_DUYET', 'DA_XUAT', 'HUY')

**Indexes**:
- PRIMARY KEY: `ma_phieu_xuat`
- UNIQUE INDEX: `idx_phieu_xuat_so` trên `so_phieu_xuat`
- INDEX: `idx_phieu_xuat_ngay` trên `ngay_xuat`
- INDEX: `idx_phieu_xuat_trang_thai` trên `trang_thai_phieu`

---

### CHI_TIET_XUAT
**Mục đích**: Chi tiết các vật tư trong phiếu xuất

**Các trường**:
- `ma_chi_tiet_xuat` (PK): Mã chi tiết
- `ma_phieu_xuat` (FK): Thuộc phiếu xuất nào
- `ma_vat_tu` (FK): Vật tư xuất
- `ma_lo_hang` (FK): Lô hàng
- `so_luong`: Số lượng xuất
- `don_vi_tinh`: Đơn vị tính
- `ma_vi_tri` (FK): Xuất từ vị trí nào

**Ràng buộc**:
- `so_luong` > 0

**Indexes**:
- PRIMARY KEY: `ma_chi_tiet_xuat`
- INDEX: `idx_chi_tiet_xuat_phieu` trên `ma_phieu_xuat`
- INDEX: `idx_chi_tiet_xuat_vat_tu` trên `ma_vat_tu`

---

## 4. Nhóm Bảng Tồn kho

### CHI_TIET_TON_KHO
**Mục đích**: Theo dõi số lượng tồn kho theo vật tư, lô hàng, vị trí

**Các trường**:
- `ma_ton_kho` (PK): Mã tồn kho
- `ma_vat_tu` (FK): Vật tư
- `ma_lo_hang` (FK): Lô hàng
- `ma_kho` (FK): Kho
- `ma_vi_tri` (FK): Vị trí
- `so_luong_ton`: Số lượng tồn
- `ngay_cap_nhat`: Ngày cập nhật cuối

**Ràng buộc**:
- UNIQUE (`ma_vat_tu`, `ma_lo_hang`, `ma_kho`, `ma_vi_tri`)
- `so_luong_ton` >= 0

**Indexes**:
- PRIMARY KEY: `ma_ton_kho`
- UNIQUE INDEX: `idx_ton_kho_unique` trên (`ma_vat_tu`, `ma_lo_hang`, `ma_kho`, `ma_vi_tri`)
- INDEX: `idx_ton_kho_vat_tu` trên `ma_vat_tu`
- INDEX: `idx_ton_kho_kho` trên `ma_kho`

**Chiến lược cập nhật**:
- Cập nhật real-time khi có nhập/xuất
- Trigger tự động cập nhật `ngay_cap_nhat`

---

## 5. Nhóm Bảng Sản xuất

### LENH_SAN_XUAT
**Mục đích**: Quản lý lệnh sản xuất

**Các trường**:
- `ma_lenh_san_xuat` (PK): Mã lệnh
- `so_lenh`: Số lệnh (LSX-YYYYMMDD-XXX)
- `ma_nha_may` (FK): Sản xuất tại nhà máy nào
- `ngay_bat_dau`: Ngày bắt đầu
- `ngay_ket_thuc_du_kien`: Ngày kết thúc dự kiến
- `ngay_hoan_thanh`: Ngày hoàn thành thực tế
- `ma_nhan_vien` (FK): Người quản lý
- `trang_thai`: Kế hoạch/Đang sản xuất/Hoàn thành/Hủy
- `ghi_chu`: Ghi chú

**Ràng buộc**:
- `so_lenh` UNIQUE, NOT NULL
- `ngay_bat_dau` <= `ngay_ket_thuc_du_kien`
- `trang_thai` IN ('KE_HOACH', 'DANG_SAN_XUAT', 'HOAN_THANH', 'HUY')

**Indexes**:
- PRIMARY KEY: `ma_lenh_san_xuat`
- UNIQUE INDEX: `idx_lenh_sx_so` trên `so_lenh`
- INDEX: `idx_lenh_sx_trang_thai` trên `trang_thai`

---

### CHI_TIET_LENH_SAN_XUAT
**Mục đích**: Chi tiết sản phẩm trong lệnh sản xuất

**Các trường**:
- `ma_chi_tiet_lenh` (PK): Mã chi tiết
- `ma_lenh_san_xuat` (FK): Thuộc lệnh nào
- `ma_vat_tu` (FK): Sản phẩm sản xuất
- `so_luong_ke_hoach`: Số lượng kế hoạch
- `so_luong_thuc_te`: Số lượng thực tế
- `don_vi_tinh`: Đơn vị tính

**Ràng buộc**:
- `so_luong_ke_hoach` > 0
- `so_luong_thuc_te` >= 0

**Indexes**:
- PRIMARY KEY: `ma_chi_tiet_lenh`
- INDEX: `idx_chi_tiet_lenh_sx` trên `ma_lenh_san_xuat`

---

### CONG_THUC_SAN_XUAT
**Mục đích**: Định nghĩa công thức sản xuất (BOM - Bill of Materials)

**Các trường**:
- `ma_cong_thuc` (PK): Mã công thức
- `ma_san_pham` (FK): Sản phẩm đầu ra
- `ma_nguyen_lieu` (FK): Nguyên liệu đầu vào
- `so_luong_can`: Số lượng nguyên liệu cần
- `don_vi_tinh`: Đơn vị tính
- `thu_tu_su_dung`: Thứ tự sử dụng trong quy trình
- `bat_buoc`: Nguyên liệu bắt buộc hay tùy chọn

**Ràng buộc**:
- UNIQUE (`ma_san_pham`, `ma_nguyen_lieu`)
- `so_luong_can` > 0
- `ma_san_pham` != `ma_nguyen_lieu` (không tự tham chiếu)

**Indexes**:
- PRIMARY KEY: `ma_cong_thuc`
- INDEX: `idx_cong_thuc_san_pham` trên `ma_san_pham`
- INDEX: `idx_cong_thuc_nguyen_lieu` trên `ma_nguyen_lieu`

---

## 6. Nhóm Bảng Hỗ trợ

### NHA_CUNG_CAP
**Mục đích**: Quản lý thông tin nhà cung cấp

**Các trường**:
- `ma_nha_cung_cap` (PK): Mã nhà cung cấp
- `ten_nha_cung_cap`: Tên nhà cung cấp
- `ma_so_thue`: Mã số thuế
- `dia_chi`: Địa chỉ
- `so_dien_thoai`: Số điện thoại
- `email`: Email
- `trang_thai`: Đang hợp tác/Ngừng hợp tác

**Ràng buộc**:
- `ten_nha_cung_cap` NOT NULL
- `ma_so_thue` UNIQUE

**Indexes**:
- PRIMARY KEY: `ma_nha_cung_cap`
- UNIQUE INDEX: `idx_ncc_ma_so_thue` trên `ma_so_thue`

---

### NHAN_VIEN
**Mục đích**: Quản lý thông tin nhân viên

**Các trường**:
- `ma_nhan_vien` (PK): Mã nhân viên
- `ho_ten`: Họ tên
- `ma_nhan_vien`: Mã nhân viên (NV-XXX)
- `chuc_vu`: Chức vụ
- `so_dien_thoai`: Số điện thoại
- `email`: Email
- `ma_nha_may` (FK): Làm việc tại nhà máy
- `trang_thai`: Đang làm việc/Nghỉ việc

**Ràng buộc**:
- `ho_ten` NOT NULL
- `ma_nhan_vien` UNIQUE, NOT NULL

**Indexes**:
- PRIMARY KEY: `ma_nhan_vien`
- UNIQUE INDEX: `idx_nhan_vien_ma` trên `ma_nhan_vien`

---

### LICH_SU_DIEU_CHUYEN
**Mục đích**: Theo dõi lịch sử điều chuyển vật tư giữa các vị trí

**Các trường**:
- `ma_lich_su` (PK): Mã lịch sử
- `ma_vat_tu` (FK): Vật tư điều chuyển
- `ma_lo_hang` (FK): Lô hàng
- `ma_vi_tri_cu` (FK): Vị trí cũ
- `ma_vi_tri_moi` (FK): Vị trí mới
- `so_luong`: Số lượng điều chuyển
- `ngay_dieu_chuyen`: Ngày giờ điều chuyển
- `ma_nhan_vien` (FK): Nhân viên thực hiện
- `ly_do`: Lý do điều chuyển

**Ràng buộc**:
- `so_luong` > 0
- `ma_vi_tri_cu` != `ma_vi_tri_moi`

**Indexes**:
- PRIMARY KEY: `ma_lich_su`
- INDEX: `idx_lich_su_ngay` trên `ngay_dieu_chuyen`
- INDEX: `idx_lich_sux#_vat_tu` trên `ma_vat_tu`

---

## 7. Chiến lược Tối ưu hóa

### Indexes tổng hợp
1. **Truy vấn tồn kho**: Index trên (`ma_kho`, `ma_vat_tu`, `so_luong_ton`)
2. **Truy vấn hạn sử dụng**: Index trên (`han_su_dung`, `trang_thai`)
3. **Truy vấn theo thời gian**: Index trên các trường ngày tháng

### Partitioning
- Partition bảng `CHI_TIET_NHAP`, `CHI_TIET_XUAT` theo năm
- Partition bảng `LICH_SU_DIEU_CHUYEN` theo tháng

### Caching
- Cache danh sách vật tư thường dùng
- Cache công thức sản xuất
- Cache thông tin kho và vị trí

### Archiving
- Archive phiếu nhập/xuất sau 2 năm
- Archive lịch sử điều chuyển sau 1 năm
- Giữ dữ liệu tồn kho hiện tại

---

## 8. Validation Rules

### Nghiệp vụ
1. Không xuất kho khi số lượng tồn không đủ
2. Không nhập vào vị trí đã đầy
3. Cảnh báo khi vật tư gần hết hạn (trước 30 ngày)
4. Kiểm tra nhiệt độ bảo quản phù hợp với loại vị trí
5. Áp dụng FIFO/FEFO cho xuất kho

### Dữ liệu
1. Số lượng phải > 0
2. Ngày hết hạn > Ngày sản xuất
3. Giá trị tiền >= 0
4. Email đúng format
5. Số điện thoại đúng format
