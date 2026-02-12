# Hệ thống Quản lý Kho Thông minh - Vinamilk

## Tổng quan

Hệ thống quản lý kho thông minh được thiết kế cho nhà máy sản xuất sữa Vinamilk, hỗ trợ quản lý toàn bộ quy trình từ nguyên liệu đầu vào, sản xuất, đến thành phẩm.

## Cấu trúc Dự án

```
erd/
├── 01_ERD_DIAGRAM.md           # Sơ đồ ERD với Mermaid
├── 02_MO_TA_CHI_TIET.md        # Mô tả chi tiết các bảng
├── 03_CHIEN_LUOC_MO_RONG.md    # Chiến lược mở rộng theo giai đoạn
├── 04_schema.sql               # SQL schema (SQLite)
├── 05_seed_data.sql            # Dữ liệu mẫu
└── README.md                   # File này
```

## Tính năng Chính

### Phase 1: Cơ bản (Hiện tại)
Quản lý nhà máy và kho, vị trí lưu kho (kệ, tầng, ngăn), vật tư và nguyên liệu, lô hàng và hạn sử dụng, nhập xuất kho, theo dõi tồn kho real-time.

### Phase 2: Sản xuất
Quản lý lệnh sản xuất, công thức sản xuất (BOM), tính toán nguyên liệu tự động, xuất nguyên liệu cho sản xuất, nhập thành phẩm, lịch sử điều chuyển, báo cáo hiệu suất.

### Phase 3: Tối ưu
Cảnh báo tự động (tồn thấp, hết hạn, quá tải), dự báo nhu cầu với AI/ML, tối ưu vị trí lưu kho, phân tích ABC, dashboard real-time, báo cáo phân tích nâng cao.

### Phase 4: Mở rộng
Quản lý đa nhà máy, điều chuyển giữa nhà máy, kế hoạch sản xuất tổng thể, tích hợp ERP/WMS/TMS, API cho đối tác, mobile app.

## Cơ sở Dữ liệu

### Thống kê
- **Tổng số bảng**: 17 bảng
- **Nhóm chức năng**: 7 nhóm
- **Database**: SQLite (có thể chuyển sang PostgreSQL)

### Các nhóm bảng

| Nhóm | Bảng | Mô tả |
|------|------|-------|
| Cơ sở hạ tầng | `NHA_MAY`, `KHO`, `VI_TRI_KHO` | Quản lý nhà máy, kho và vị trí |
| Vật tư | `LOAI_VAT_TU`, `VAT_TU`, `LO_HANG` | Quản lý vật tư và lô hàng |
| Nhập xuất | `PHIEU_NHAP`, `CHI_TIET_NHAP`, `PHIEU_XUAT`, `CHI_TIET_XUAT` | Quản lý nhập xuất kho |
| Tồn kho | `CHI_TIET_TON_KHO` | Theo dõi tồn kho real-time |
| Sản xuất | `LENH_SAN_XUAT`, `CHI_TIET_LENH_SAN_XUAT`, `CONG_THUC_SAN_XUAT` | Quản lý sản xuất |
| Hỗ trợ | `NHA_CUNG_CAP`, `NHAN_VIEN` | Quản lý nhà cung cấp và nhân viên |
| Lịch sử | `LICH_SU_DIEU_CHUYEN` | Theo dõi lịch sử điều chuyển |

## Cài đặt và Sử dụng

### Yêu cầu
- SQLite 3.x hoặc PostgreSQL
- Database client (CLI hoặc GUI)

### Khởi tạo Database

```bash
# Tạo database SQLite
sqlite3 warehouse.db < 04_schema.sql
sqlite3 warehouse.db < 05_seed_data.sql

# Hoặc PostgreSQL
psql -U username -d dbname -f 04_schema.sql
psql -U username -d dbname -f 05_seed_data.sql
```

### Kết nối Database

```bash
# SQLite CLI
sqlite3 warehouse.db

# PostgreSQL CLI
psql -U username -d dbname

# Hoặc sử dụng GUI tools: DB Browser for SQLite, DBeaver, DataGrip
```

## Truy vấn Mẫu

### 1. Xem tồn kho theo kho

```sql
SELECT 
    k.ten_kho,
    vt.ten_vat_tu,
    lh.so_lo,
    lh.han_su_dung,
    ct.so_luong_ton,
    vt.don_vi_tinh,
    CASE 
        WHEN lh.han_su_dung < DATE('now', '+30 days') THEN 'Sap het han'
        ELSE 'Binh thuong'
    END as trang_thai_han
FROM CHI_TIET_TON_KHO ct
JOIN KHO k ON ct.ma_kho = k.ma_kho
JOIN VAT_TU vt ON ct.ma_vat_tu = vt.ma_vat_tu
JOIN LO_HANG lh ON ct.ma_lo_hang = lh.ma_lo_hang
WHERE ct.so_luong_ton > 0
ORDER BY k.ten_kho, lh.han_su_dung;
```

### 2. Báo cáo nhập xuất theo ngày

```sql
-- Nhap kho
SELECT 
    pn.so_phieu_nhap,
    pn.ngay_nhap,
    k.ten_kho,
    ncc.ten_nha_cung_cap,
    vt.ten_vat_tu,
    ctn.so_luong,
    ctn.don_vi_tinh,
    ctn.thanh_tien
FROM PHIEU_NHAP pn
JOIN CHI_TIET_NHAP ctn ON pn.ma_phieu_nhap = ctn.ma_phieu_nhap
JOIN KHO k ON pn.ma_kho = k.ma_kho
LEFT JOIN NHA_CUNG_CAP ncc ON pn.ma_nha_cung_cap = ncc.ma_nha_cung_cap
JOIN VAT_TU vt ON ctn.ma_vat_tu = vt.ma_vat_tu
WHERE DATE(pn.ngay_nhap) = '2026-02-10'
ORDER BY pn.ngay_nhap;

-- Xuat kho
SELECT 
    px.so_phieu_xuat,
    px.ngay_xuat,
    k.ten_kho,
    px.loai_xuat,
    vt.ten_vat_tu,
    ctx.so_luong,
    ctx.don_vi_tinh
FROM PHIEU_XUAT px
JOIN CHI_TIET_XUAT ctx ON px.ma_phieu_xuat = ctx.ma_phieu_xuat
JOIN KHO k ON px.ma_kho = k.ma_kho
JOIN VAT_TU vt ON ctx.ma_vat_tu = vt.ma_vat_tu
WHERE DATE(px.ngay_xuat) = '2026-02-10'
ORDER BY px.ngay_xuat;
```

### 3. Công thức sản xuất

```sql
SELECT 
    sp.ten_vat_tu as san_pham,
    nl.ten_vat_tu as nguyen_lieu,
    ct.so_luong_can,
    ct.don_vi_tinh,
    ct.thu_tu_su_dung,
    CASE WHEN ct.bat_buoc = 1 THEN 'Bat buoc' ELSE 'Tuy chon' END as loai
FROM CONG_THUC_SAN_XUAT ct
JOIN VAT_TU sp ON ct.ma_san_pham = sp.ma_vat_tu
JOIN VAT_TU nl ON ct.ma_nguyen_lieu = nl.ma_vat_tu
WHERE sp.ma_vat_tu = 10  -- Vinamilk Sua tuoi 1L
ORDER BY ct.thu_tu_su_dung;
```

### 4. Lô hàng sắp hết hạn

```sql
SELECT 
    vt.ten_vat_tu,
    lh.so_lo,
    lh.ngay_san_xuat,
    lh.han_su_dung,
    SUM(ct.so_luong_ton) as tong_ton,
    vt.don_vi_tinh,
    CAST((JULIANDAY(lh.han_su_dung) - JULIANDAY('now')) AS INTEGER) as so_ngay_con_lai
FROM LO_HANG lh
JOIN VAT_TU vt ON lh.ma_vat_tu = vt.ma_vat_tu
LEFT JOIN CHI_TIET_TON_KHO ct ON lh.ma_lo_hang = ct.ma_lo_hang
WHERE lh.han_su_dung BETWEEN DATE('now') AND DATE('now', '+30 days')
    AND lh.trang_thai = 'DANG_SU_DUNG'
GROUP BY lh.ma_lo_hang
HAVING SUM(ct.so_luong_ton) > 0
ORDER BY lh.han_su_dung;
```

### 5. Hiệu suất sản xuất

```sql
SELECT 
    lsx.so_lenh,
    lsx.ngay_bat_dau,
    lsx.ngay_ket_thuc_du_kien,
    lsx.ngay_hoan_thanh,
    lsx.trang_thai,
    vt.ten_vat_tu,
    ct.so_luong_ke_hoach,
    ct.so_luong_thuc_te,
    ROUND(ct.so_luong_thuc_te * 100.0 / ct.so_luong_ke_hoach, 2) as ty_le_hoan_thanh
FROM LENH_SAN_XUAT lsx
JOIN CHI_TIET_LENH_SAN_XUAT ct ON lsx.ma_lenh_san_xuat = ct.ma_lenh_san_xuat
JOIN VAT_TU vt ON ct.ma_vat_tu = vt.ma_vat_tu
ORDER BY lsx.ngay_bat_dau DESC;
```

### 6. Tổng hợp tồn kho theo loại

```sql
SELECT 
    vt.loai_hang,
    COUNT(DISTINCT vt.ma_vat_tu) as so_loai_vat_tu,
    COUNT(DISTINCT ct.ma_lo_hang) as so_lo_hang,
    SUM(ct.so_luong_ton) as tong_so_luong
FROM VAT_TU vt
LEFT JOIN CHI_TIET_TON_KHO ct ON vt.ma_vat_tu = ct.ma_vat_tu
GROUP BY vt.loai_hang;
```

## Dữ liệu Mẫu

| Loại | Số lượng | Chi tiết |
|------|----------|----------|
| Nhà máy | 3 | Bình Dương, Hà Nam, Nghệ An |
| Kho | 6 | Nguyên liệu, Bán thành phẩm, Thành phẩm, Kho lạnh |
| Vật tư | 18 | Nguyên liệu (sữa, đường, hương liệu), Bán thành phẩm, Thành phẩm (sữa tươi, sữa chua, sữa bột), Bao bì |
| Phiếu nhập | 5 | Từ nhà cung cấp |
| Phiếu xuất | 2 | Cho sản xuất |
| Lệnh sản xuất | 3 | Kế hoạch, đang sản xuất, hoàn thành |

## Tối ưu hóa

### Indexes
Primary keys trên tất cả bảng, foreign keys với indexes, composite indexes cho truy vấn phức tạp, unique indexes cho mã code.

### Best Practices
Áp dụng FIFO/FEFO khi xuất lô hàng cũ trước. Kiểm tra số lượng tồn trước khi xuất. Lưu lịch sử thay đổi cho audit trail. Chuẩn hóa database đến 3NF. Sử dụng CHECK constraints cho validation.

## Mở rộng

Chi tiết chiến lược mở rộng xem file `03_CHIEN_LUOC_MO_RONG.md`:

| Phase | Thời gian | Trọng tâm |
|-------|-----------|-----------|
| Phase 1 | Tháng 1-3 | Nhập xuất kho cơ bản |
| Phase 2 | Tháng 4-6 | Tích hợp sản xuất, công thức BOM |
| Phase 3 | Tháng 7-12 | AI/ML, cảnh báo tự động, tối ưu |
| Phase 4 | Năm 2+ | Đa nhà máy, tích hợp ERP |

## Backup và Recovery

### Backup
```bash
# Backup database
sqlite3 warehouse.db ".backup warehouse_backup_$(date +%Y%m%d).db"

# Export to SQL
sqlite3 warehouse.db .dump > warehouse_backup.sql
```

### Restore
```bash
# Restore from backup
cp warehouse_backup_20260212.db warehouse.db

# Restore from SQL
sqlite3 warehouse_new.db < warehouse_backup.sql
```

## Migration sang PostgreSQL

```sql
-- Thay doi cac dieu sau:
-- 1. AUTOINCREMENT -> SERIAL
-- 2. DATETIME -> TIMESTAMP
-- 3. BOOLEAN -> BOOLEAN (PostgreSQL native)
-- 4. VARCHAR lengths
-- 5. CHECK constraints syntax

-- Vi du:
CREATE TABLE NHA_MAY (
    ma_nha_may SERIAL PRIMARY KEY,
    ten_nha_may VARCHAR(200) NOT NULL UNIQUE,
    ...
    ngay_tao TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

## Tài liệu Tham khảo

- [SQLite Documentation](https://www.sqlite.org/docs.html)
- [Database Design Best Practices](https://www.sqlshack.com/database-design-best-practices/)
- [Warehouse Management Systems](https://en.wikipedia.org/wiki/Warehouse_management_system)

## Liên hệ

Dự án được thiết kế cho mục đích học tập và demo.

## License

MIT License
