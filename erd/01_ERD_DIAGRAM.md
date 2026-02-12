# Sơ đồ ERD - Hệ thống Quản lý Kho Thông minh

## Sơ đồ tổng quan

```mermaid
erDiagram
    NHA_MAY ||--o{ KHO : co
    NHA_MAY {
        int ma_nha_may PK
        varchar ten_nha_may
        varchar dia_chi
        varchar so_dien_thoai
        datetime ngay_thanh_lap
        boolean trang_thai
    }
    
    KHO ||--o{ VI_TRI_KHO : chua
    KHO ||--o{ PHIEU_NHAP : nhan
    KHO ||--o{ PHIEU_XUAT : xuat
    KHO {
        int ma_kho PK
        int ma_nha_may FK
        varchar ten_kho
        varchar loai_kho
        decimal dien_tich
        decimal suc_chua_toi_da
        boolean trang_thai
    }
    
    VI_TRI_KHO ||--o{ CHI_TIET_TON_KHO : luu_tru
    VI_TRI_KHO {
        int ma_vi_tri PK
        int ma_kho FK
        varchar ma_ke
        varchar ma_tang
        varchar ma_ngan
        decimal suc_chua
        varchar loai_vi_tri
        boolean trang_thai
    }
    
    LOAI_VAT_TU ||--o{ VAT_TU : phan_loai
    LOAI_VAT_TU {
        int ma_loai_vat_tu PK
        varchar ten_loai
        varchar mo_ta
        int loai_cha FK
    }
    
    VAT_TU ||--o{ CHI_TIET_TON_KHO : ton_kho
    VAT_TU ||--o{ CHI_TIET_NHAP : duoc_nhap
    VAT_TU ||--o{ CHI_TIET_XUAT : duoc_xuat
    VAT_TU ||--o{ CONG_THUC_SAN_XUAT : nguyen_lieu
    VAT_TU ||--o{ CONG_THUC_SAN_XUAT : san_pham
    VAT_TU {
        int ma_vat_tu PK
        int ma_loai_vat_tu FK
        varchar ten_vat_tu
        varchar ma_vat_tu
        varchar loai_hang
        varchar don_vi_tinh
        decimal gia_nhap_trung_binh
        int thoi_han_su_dung_ngay
        decimal nhiet_do_bao_quan_min
        decimal nhiet_do_bao_quan_max
        boolean yeu_cau_lo_hang
        boolean trang_thai
    }
    
    LO_HANG ||--o{ CHI_TIET_TON_KHO : theo_lo
    LO_HANG ||--o{ CHI_TIET_NHAP : nhap_lo
    LO_HANG ||--o{ CHI_TIET_XUAT : xuat_lo
    LO_HANG {
        int ma_lo_hang PK
        int ma_vat_tu FK
        varchar so_lo
        date ngay_san_xuat
        date han_su_dung
        int ma_nha_cung_cap FK
        varchar chung_nhan_chat_luong
        boolean trang_thai
    }
    
    NHA_CUNG_CAP ||--o{ LO_HANG : cung_cap
    NHA_CUNG_CAP ||--o{ PHIEU_NHAP : giao_hang
    NHA_CUNG_CAP {
        int ma_nha_cung_cap PK
        varchar ten_nha_cung_cap
        varchar ma_so_thue
        varchar dia_chi
        varchar so_dien_thoai
        varchar email
        boolean trang_thai
    }
    
    PHIEU_NHAP ||--o{ CHI_TIET_NHAP : chua
    PHIEU_NHAP {
        int ma_phieu_nhap PK
        varchar so_phieu_nhap
        int ma_kho FK
        int ma_nha_cung_cap FK
        datetime ngay_nhap
        int ma_nhan_vien FK
        varchar loai_nhap
        varchar trang_thai_phieu
        text ghi_chu
    }
    
    CHI_TIET_NHAP {
        int ma_chi_tiet_nhap PK
        int ma_phieu_nhap FK
        int ma_vat_tu FK
        int ma_lo_hang FK
        decimal so_luong
        varchar don_vi_tinh
        decimal don_gia
        decimal thanh_tien
        int ma_vi_tri FK
    }
    
    PHIEU_XUAT ||--o{ CHI_TIET_XUAT : chua
    PHIEU_XUAT {
        int ma_phieu_xuat PK
        varchar so_phieu_xuat
        int ma_kho FK
        datetime ngay_xuat
        int ma_nhan_vien FK
        int ma_lenh_san_xuat FK
        varchar loai_xuat
        varchar trang_thai_phieu
        text ghi_chu
    }
    
    CHI_TIET_XUAT {
        int ma_chi_tiet_xuat PK
        int ma_phieu_xuat FK
        int ma_vat_tu FK
        int ma_lo_hang FK
        decimal so_luong
        varchar don_vi_tinh
        int ma_vi_tri FK
    }
    
    CHI_TIET_TON_KHO {
        int ma_ton_kho PK
        int ma_vat_tu FK
        int ma_lo_hang FK
        int ma_kho FK
        int ma_vi_tri FK
        decimal so_luong_ton
        datetime ngay_cap_nhat
    }
    
    NHAN_VIEN ||--o{ PHIEU_NHAP : xu_ly_nhap
    NHAN_VIEN ||--o{ PHIEU_XUAT : xu_ly_xuat
    NHAN_VIEN ||--o{ LENH_SAN_XUAT : quan_ly
    NHAN_VIEN {
        int ma_nhan_vien PK
        varchar ho_ten
        varchar ma_nhan_vien
        varchar chuc_vu
        varchar so_dien_thoai
        varchar email
        int ma_nha_may FK
        boolean trang_thai
    }
    
    LENH_SAN_XUAT ||--o{ CHI_TIET_LENH_SAN_XUAT : chua
    LENH_SAN_XUAT ||--o{ PHIEU_XUAT : tieu_thu_nguyen_lieu
    LENH_SAN_XUAT {
        int ma_lenh_san_xuat PK
        varchar so_lenh
        int ma_nha_may FK
        date ngay_bat_dau
        date ngay_ket_thuc_du_kien
        date ngay_hoan_thanh
        int ma_nhan_vien FK
        varchar trang_thai
        text ghi_chu
    }
    
    CHI_TIET_LENH_SAN_XUAT {
        int ma_chi_tiet_lenh PK
        int ma_lenh_san_xuat FK
        int ma_vat_tu FK
        decimal so_luong_ke_hoach
        decimal so_luong_thuc_te
        varchar don_vi_tinh
    }
    
    CONG_THUC_SAN_XUAT {
        int ma_cong_thuc PK
        int ma_san_pham FK
        int ma_nguyen_lieu FK
        decimal so_luong_can
        varchar don_vi_tinh
        int thu_tu_su_dung
        boolean bat_buoc
    }
    
    LICH_SU_DIEU_CHUYEN {
        int ma_lich_su PK
        int ma_vat_tu FK
        int ma_lo_hang FK
        int ma_vi_tri_cu FK
        int ma_vi_tri_moi FK
        decimal so_luong
        datetime ngay_dieu_chuyen
        int ma_nhan_vien FK
        text ly_do
    }
```

## Giải thích các mối quan hệ chính

### Quan hệ 1-N (One-to-Many)
- Một NHA_MAY có nhiều KHO
- Một KHO có nhiều VI_TRI_KHO
- Một VAT_TU có nhiều LO_HANG
- Một PHIEU_NHAP có nhiều CHI_TIET_NHAP
- Một PHIEU_XUAT có nhiều CHI_TIET_XUAT

### Quan hệ đặc biệt
- VAT_TU tự tham chiếu trong CONG_THUC_SAN_XUAT (một vật tư có thể là nguyên liệu hoặc sản phẩm)
- LOAI_VAT_TU tự tham chiếu (hỗ trợ phân cấp loại vật tư)

### Bảng trung gian
- CHI_TIET_TON_KHO: Kết nối VAT_TU, LO_HANG, KHO, VI_TRI_KHO
- CONG_THUC_SAN_XUAT: Kết nối VAT_TU với chính nó (nguyên liệu -> sản phẩm)
