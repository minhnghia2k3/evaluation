-- ============================================
-- HE THONG QUAN LY KHO THONG MINH
-- Database: SQLite
-- Version: 1.0 - Phase 1
-- ============================================

-- ============================================
-- 1. NHOM BANG CO SO HA TANG
-- ============================================

-- Bang NHA_MAY
CREATE TABLE NHA_MAY (
    ma_nha_may INTEGER PRIMARY KEY AUTOINCREMENT,
    ten_nha_may VARCHAR(200) NOT NULL UNIQUE,
    dia_chi TEXT,
    so_dien_thoai VARCHAR(20),
    ngay_thanh_lap DATE,
    trang_thai BOOLEAN DEFAULT 1,
    ngay_tao DATETIME DEFAULT CURRENT_TIMESTAMP,
    ngay_cap_nhat DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_nha_may_trang_thai ON NHA_MAY(trang_thai);

-- Bang KHO
CREATE TABLE KHO (
    ma_kho INTEGER PRIMARY KEY AUTOINCREMENT,
    ma_nha_may INTEGER NOT NULL,
    ten_kho VARCHAR(200) NOT NULL,
    loai_kho VARCHAR(50) NOT NULL CHECK(loai_kho IN ('NGUYEN_LIEU', 'BAN_THANH_PHAM', 'THANH_PHAM', 'KHO_LANH')),
    dien_tich DECIMAL(10,2) CHECK(dien_tich > 0),
    suc_chua_toi_da DECIMAL(15,2) CHECK(suc_chua_toi_da > 0),
    trang_thai BOOLEAN DEFAULT 1,
    ngay_tao DATETIME DEFAULT CURRENT_TIMESTAMP,
    ngay_cap_nhat DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (ma_nha_may) REFERENCES NHA_MAY(ma_nha_may)
);

CREATE INDEX idx_kho_nha_may ON KHO(ma_nha_may);
CREATE INDEX idx_kho_loai ON KHO(loai_kho);
CREATE INDEX idx_kho_trang_thai ON KHO(trang_thai);

-- Bang VI_TRI_KHO
CREATE TABLE VI_TRI_KHO (
    ma_vi_tri INTEGER PRIMARY KEY AUTOINCREMENT,
    ma_kho INTEGER NOT NULL,
    ma_ke VARCHAR(10) NOT NULL,
    ma_tang VARCHAR(10) NOT NULL,
    ma_ngan VARCHAR(10) NOT NULL,
    suc_chua DECIMAL(10,2) CHECK(suc_chua > 0),
    loai_vi_tri VARCHAR(20) CHECK(loai_vi_tri IN ('THUONG', 'LANH', 'DONG_LANH')),
    trang_thai VARCHAR(20) DEFAULT 'TRONG' CHECK(trang_thai IN ('TRONG', 'DANG_SU_DUNG', 'BAO_TRI')),
    ngay_tao DATETIME DEFAULT CURRENT_TIMESTAMP,
    ngay_cap_nhat DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (ma_kho) REFERENCES KHO(ma_kho),
    UNIQUE(ma_kho, ma_ke, ma_tang, ma_ngan)
);

CREATE UNIQUE INDEX idx_vi_tri_unique ON VI_TRI_KHO(ma_kho, ma_ke, ma_tang, ma_ngan);
CREATE INDEX idx_vi_tri_trang_thai ON VI_TRI_KHO(trang_thai);

-- ============================================
-- 2. NHOM BANG VAT TU VA SAN PHAM
-- ============================================

-- Bang LOAI_VAT_TU
CREATE TABLE LOAI_VAT_TU (
    ma_loai_vat_tu INTEGER PRIMARY KEY AUTOINCREMENT,
    ten_loai VARCHAR(200) NOT NULL UNIQUE,
    mo_ta TEXT,
    loai_cha INTEGER,
    ngay_tao DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (loai_cha) REFERENCES LOAI_VAT_TU(ma_loai_vat_tu)
);

CREATE INDEX idx_loai_vat_tu_cha ON LOAI_VAT_TU(loai_cha);

-- Bang VAT_TU
CREATE TABLE VAT_TU (
    ma_vat_tu INTEGER PRIMARY KEY AUTOINCREMENT,
    ma_loai_vat_tu INTEGER NOT NULL,
    ten_vat_tu VARCHAR(200) NOT NULL,
    ma_vat_tu_code VARCHAR(50) NOT NULL UNIQUE,
    loai_hang VARCHAR(20) NOT NULL CHECK(loai_hang IN ('NGUYEN_LIEU', 'BAN_THANH_PHAM', 'THANH_PHAM')),
    don_vi_tinh VARCHAR(20) NOT NULL,
    gia_nhap_trung_binh DECIMAL(15,2) DEFAULT 0,
    thoi_han_su_dung_ngay INTEGER DEFAULT 0 CHECK(thoi_han_su_dung_ngay >= 0),
    nhiet_do_bao_quan_min DECIMAL(5,2),
    nhiet_do_bao_quan_max DECIMAL(5,2),
    yeu_cau_lo_hang BOOLEAN DEFAULT 1,
    trang_thai BOOLEAN DEFAULT 1,
    ngay_tao DATETIME DEFAULT CURRENT_TIMESTAMP,
    ngay_cap_nhat DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (ma_loai_vat_tu) REFERENCES LOAI_VAT_TU(ma_loai_vat_tu),
    CHECK(nhiet_do_bao_quan_min <= nhiet_do_bao_quan_max)
);

CREATE UNIQUE INDEX idx_vat_tu_ma ON VAT_TU(ma_vat_tu_code);
CREATE INDEX idx_vat_tu_loai ON VAT_TU(loai_hang);
CREATE INDEX idx_vat_tu_ten ON VAT_TU(ten_vat_tu);
CREATE INDEX idx_vat_tu_loai_vat_tu ON VAT_TU(ma_loai_vat_tu);

-- Bang NHA_CUNG_CAP
CREATE TABLE NHA_CUNG_CAP (
    ma_nha_cung_cap INTEGER PRIMARY KEY AUTOINCREMENT,
    ten_nha_cung_cap VARCHAR(200) NOT NULL,
    ma_so_thue VARCHAR(50) UNIQUE,
    dia_chi TEXT,
    so_dien_thoai VARCHAR(20),
    email VARCHAR(100),
    trang_thai BOOLEAN DEFAULT 1,
    ngay_tao DATETIME DEFAULT CURRENT_TIMESTAMP,
    ngay_cap_nhat DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE UNIQUE INDEX idx_ncc_ma_so_thue ON NHA_CUNG_CAP(ma_so_thue);

-- Bang LO_HANG
CREATE TABLE LO_HANG (
    ma_lo_hang INTEGER PRIMARY KEY AUTOINCREMENT,
    ma_vat_tu INTEGER NOT NULL,
    so_lo VARCHAR(100) NOT NULL,
    ngay_san_xuat DATE NOT NULL,
    han_su_dung DATE NOT NULL,
    ma_nha_cung_cap INTEGER,
    chung_nhan_chat_luong VARCHAR(100),
    trang_thai VARCHAR(20) DEFAULT 'MOI' CHECK(trang_thai IN ('MOI', 'DANG_SU_DUNG', 'HET_HAN', 'THU_HOI')),
    ngay_tao DATETIME DEFAULT CURRENT_TIMESTAMP,
    ngay_cap_nhat DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (ma_vat_tu) REFERENCES VAT_TU(ma_vat_tu),
    FOREIGN KEY (ma_nha_cung_cap) REFERENCES NHA_CUNG_CAP(ma_nha_cung_cap),
    UNIQUE(ma_vat_tu, so_lo),
    CHECK(ngay_san_xuat <= han_su_dung)
);

CREATE UNIQUE INDEX idx_lo_hang_unique ON LO_HANG(ma_vat_tu, so_lo);
CREATE INDEX idx_lo_hang_han_su_dung ON LO_HANG(han_su_dung);
CREATE INDEX idx_lo_hang_trang_thai ON LO_HANG(trang_thai);

-- ============================================
-- 3. NHOM BANG NHAN VIEN
-- ============================================

CREATE TABLE NHAN_VIEN (
    ma_nhan_vien INTEGER PRIMARY KEY AUTOINCREMENT,
    ho_ten VARCHAR(200) NOT NULL,
    ma_nhan_vien_code VARCHAR(50) NOT NULL UNIQUE,
    chuc_vu VARCHAR(100),
    so_dien_thoai VARCHAR(20),
    email VARCHAR(100),
    ma_nha_may INTEGER,
    trang_thai BOOLEAN DEFAULT 1,
    ngay_tao DATETIME DEFAULT CURRENT_TIMESTAMP,
    ngay_cap_nhat DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (ma_nha_may) REFERENCES NHA_MAY(ma_nha_may)
);

CREATE UNIQUE INDEX idx_nhan_vien_ma ON NHAN_VIEN(ma_nhan_vien_code);
CREATE INDEX idx_nhan_vien_nha_may ON NHAN_VIEN(ma_nha_may);

-- ============================================
-- 4. NHOM BANG NHAP XUAT KHO
-- ============================================

-- Bang PHIEU_NHAP
CREATE TABLE PHIEU_NHAP (
    ma_phieu_nhap INTEGER PRIMARY KEY AUTOINCREMENT,
    so_phieu_nhap VARCHAR(50) NOT NULL UNIQUE,
    ma_kho INTEGER NOT NULL,
    ma_nha_cung_cap INTEGER,
    ngay_nhap DATETIME NOT NULL,
    ma_nhan_vien INTEGER NOT NULL,
    loai_nhap VARCHAR(20) NOT NULL CHECK(loai_nhap IN ('MUA_HANG', 'TU_SAN_XUAT', 'TRA_LAI', 'DIEU_CHUYEN')),
    trang_thai_phieu VARCHAR(20) DEFAULT 'NHAP' CHECK(trang_thai_phieu IN ('NHAP', 'DA_DUYET', 'DA_NHAP', 'HUY')),
    ghi_chu TEXT,
    ngay_tao DATETIME DEFAULT CURRENT_TIMESTAMP,
    ngay_cap_nhat DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (ma_kho) REFERENCES KHO(ma_kho),
    FOREIGN KEY (ma_nha_cung_cap) REFERENCES NHA_CUNG_CAP(ma_nha_cung_cap),
    FOREIGN KEY (ma_nhan_vien) REFERENCES NHAN_VIEN(ma_nhan_vien)
);

CREATE UNIQUE INDEX idx_phieu_nhap_so ON PHIEU_NHAP(so_phieu_nhap);
CREATE INDEX idx_phieu_nhap_ngay ON PHIEU_NHAP(ngay_nhap);
CREATE INDEX idx_phieu_nhap_trang_thai ON PHIEU_NHAP(trang_thai_phieu);
CREATE INDEX idx_phieu_nhap_kho ON PHIEU_NHAP(ma_kho);

-- Bang CHI_TIET_NHAP
CREATE TABLE CHI_TIET_NHAP (
    ma_chi_tiet_nhap INTEGER PRIMARY KEY AUTOINCREMENT,
    ma_phieu_nhap INTEGER NOT NULL,
    ma_vat_tu INTEGER NOT NULL,
    ma_lo_hang INTEGER NOT NULL,
    so_luong DECIMAL(15,2) NOT NULL CHECK(so_luong > 0),
    don_vi_tinh VARCHAR(20) NOT NULL,
    don_gia DECIMAL(15,2) DEFAULT 0 CHECK(don_gia >= 0),
    thanh_tien DECIMAL(15,2) DEFAULT 0,
    ma_vi_tri INTEGER,
    ngay_tao DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (ma_phieu_nhap) REFERENCES PHIEU_NHAP(ma_phieu_nhap),
    FOREIGN KEY (ma_vat_tu) REFERENCES VAT_TU(ma_vat_tu),
    FOREIGN KEY (ma_lo_hang) REFERENCES LO_HANG(ma_lo_hang),
    FOREIGN KEY (ma_vi_tri) REFERENCES VI_TRI_KHO(ma_vi_tri)
);

CREATE INDEX idx_chi_tiet_nhap_phieu ON CHI_TIET_NHAP(ma_phieu_nhap);
CREATE INDEX idx_chi_tiet_nhap_vat_tu ON CHI_TIET_NHAP(ma_vat_tu);
CREATE INDEX idx_chi_tiet_nhap_lo_hang ON CHI_TIET_NHAP(ma_lo_hang);

-- Bang PHIEU_XUAT
CREATE TABLE PHIEU_XUAT (
    ma_phieu_xuat INTEGER PRIMARY KEY AUTOINCREMENT,
    so_phieu_xuat VARCHAR(50) NOT NULL UNIQUE,
    ma_kho INTEGER NOT NULL,
    ngay_xuat DATETIME NOT NULL,
    ma_nhan_vien INTEGER NOT NULL,
    ma_lenh_san_xuat INTEGER,
    loai_xuat VARCHAR(20) NOT NULL CHECK(loai_xuat IN ('SAN_XUAT', 'BAN_HANG', 'HUY', 'DIEU_CHUYEN')),
    trang_thai_phieu VARCHAR(20) DEFAULT 'NHAP' CHECK(trang_thai_phieu IN ('NHAP', 'DA_DUYET', 'DA_XUAT', 'HUY')),
    ghi_chu TEXT,
    ngay_tao DATETIME DEFAULT CURRENT_TIMESTAMP,
    ngay_cap_nhat DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (ma_kho) REFERENCES KHO(ma_kho),
    FOREIGN KEY (ma_nhan_vien) REFERENCES NHAN_VIEN(ma_nhan_vien)
);

CREATE UNIQUE INDEX idx_phieu_xuat_so ON PHIEU_XUAT(so_phieu_xuat);
CREATE INDEX idx_phieu_xuat_ngay ON PHIEU_XUAT(ngay_xuat);
CREATE INDEX idx_phieu_xuat_trang_thai ON PHIEU_XUAT(trang_thai_phieu);
CREATE INDEX idx_phieu_xuat_kho ON PHIEU_XUAT(ma_kho);

-- Bang CHI_TIET_XUAT
CREATE TABLE CHI_TIET_XUAT (
    ma_chi_tiet_xuat INTEGER PRIMARY KEY AUTOINCREMENT,
    ma_phieu_xuat INTEGER NOT NULL,
    ma_vat_tu INTEGER NOT NULL,
    ma_lo_hang INTEGER NOT NULL,
    so_luong DECIMAL(15,2) NOT NULL CHECK(so_luong > 0),
    don_vi_tinh VARCHAR(20) NOT NULL,
    ma_vi_tri INTEGER,
    ngay_tao DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (ma_phieu_xuat) REFERENCES PHIEU_XUAT(ma_phieu_xuat),
    FOREIGN KEY (ma_vat_tu) REFERENCES VAT_TU(ma_vat_tu),
    FOREIGN KEY (ma_lo_hang) REFERENCES LO_HANG(ma_lo_hang),
    FOREIGN KEY (ma_vi_tri) REFERENCES VI_TRI_KHO(ma_vi_tri)
);

CREATE INDEX idx_chi_tiet_xuat_phieu ON CHI_TIET_XUAT(ma_phieu_xuat);
CREATE INDEX idx_chi_tiet_xuat_vat_tu ON CHI_TIET_XUAT(ma_vat_tu);
CREATE INDEX idx_chi_tiet_xuat_lo_hang ON CHI_TIET_XUAT(ma_lo_hang);

-- ============================================
-- 5. NHOM BANG TON KHO
-- ============================================

CREATE TABLE CHI_TIET_TON_KHO (
    ma_ton_kho INTEGER PRIMARY KEY AUTOINCREMENT,
    ma_vat_tu INTEGER NOT NULL,
    ma_lo_hang INTEGER NOT NULL,
    ma_kho INTEGER NOT NULL,
    ma_vi_tri INTEGER NOT NULL,
    so_luong_ton DECIMAL(15,2) DEFAULT 0 CHECK(so_luong_ton >= 0),
    ngay_cap_nhat DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (ma_vat_tu) REFERENCES VAT_TU(ma_vat_tu),
    FOREIGN KEY (ma_lo_hang) REFERENCES LO_HANG(ma_lo_hang),
    FOREIGN KEY (ma_kho) REFERENCES KHO(ma_kho),
    FOREIGN KEY (ma_vi_tri) REFERENCES VI_TRI_KHO(ma_vi_tri),
    UNIQUE(ma_vat_tu, ma_lo_hang, ma_kho, ma_vi_tri)
);

CREATE UNIQUE INDEX idx_ton_kho_unique ON CHI_TIET_TON_KHO(ma_vat_tu, ma_lo_hang, ma_kho, ma_vi_tri);
CREATE INDEX idx_ton_kho_vat_tu ON CHI_TIET_TON_KHO(ma_vat_tu);
CREATE INDEX idx_ton_kho_kho ON CHI_TIET_TON_KHO(ma_kho);
CREATE INDEX idx_ton_kho_lo_hang ON CHI_TIET_TON_KHO(ma_lo_hang);

-- ============================================
-- 6. NHOM BANG SAN XUAT (Phase 2)
-- ============================================

CREATE TABLE LENH_SAN_XUAT (
    ma_lenh_san_xuat INTEGER PRIMARY KEY AUTOINCREMENT,
    so_lenh VARCHAR(50) NOT NULL UNIQUE,
    ma_nha_may INTEGER NOT NULL,
    ngay_bat_dau DATE NOT NULL,
    ngay_ket_thuc_du_kien DATE NOT NULL,
    ngay_hoan_thanh DATE,
    ma_nhan_vien INTEGER NOT NULL,
    trang_thai VARCHAR(20) DEFAULT 'KE_HOACH' CHECK(trang_thai IN ('KE_HOACH', 'DANG_SAN_XUAT', 'HOAN_THANH', 'HUY')),
    ghi_chu TEXT,
    ngay_tao DATETIME DEFAULT CURRENT_TIMESTAMP,
    ngay_cap_nhat DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (ma_nha_may) REFERENCES NHA_MAY(ma_nha_may),
    FOREIGN KEY (ma_nhan_vien) REFERENCES NHAN_VIEN(ma_nhan_vien),
    CHECK(ngay_bat_dau <= ngay_ket_thuc_du_kien)
);

CREATE UNIQUE INDEX idx_lenh_sx_so ON LENH_SAN_XUAT(so_lenh);
CREATE INDEX idx_lenh_sx_trang_thai ON LENH_SAN_XUAT(trang_thai);
CREATE INDEX idx_lenh_sx_nha_may ON LENH_SAN_XUAT(ma_nha_may);

-- Them foreign key cho PHIEU_XUAT
-- SQLite khong ho tro ALTER TABLE ADD FOREIGN KEY, nen da dinh nghia truoc

CREATE TABLE CHI_TIET_LENH_SAN_XUAT (
    ma_chi_tiet_lenh INTEGER PRIMARY KEY AUTOINCREMENT,
    ma_lenh_san_xuat INTEGER NOT NULL,
    ma_vat_tu INTEGER NOT NULL,
    so_luong_ke_hoach DECIMAL(15,2) NOT NULL CHECK(so_luong_ke_hoach > 0),
    so_luong_thuc_te DECIMAL(15,2) DEFAULT 0 CHECK(so_luong_thuc_te >= 0),
    don_vi_tinh VARCHAR(20) NOT NULL,
    ngay_tao DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (ma_lenh_san_xuat) REFERENCES LENH_SAN_XUAT(ma_lenh_san_xuat),
    FOREIGN KEY (ma_vat_tu) REFERENCES VAT_TU(ma_vat_tu)
);

CREATE INDEX idx_chi_tiet_lenh_sx ON CHI_TIET_LENH_SAN_XUAT(ma_lenh_san_xuat);
CREATE INDEX idx_chi_tiet_lenh_vat_tu ON CHI_TIET_LENH_SAN_XUAT(ma_vat_tu);

CREATE TABLE CONG_THUC_SAN_XUAT (
    ma_cong_thuc INTEGER PRIMARY KEY AUTOINCREMENT,
    ma_san_pham INTEGER NOT NULL,
    ma_nguyen_lieu INTEGER NOT NULL,
    so_luong_can DECIMAL(15,2) NOT NULL CHECK(so_luong_can > 0),
    don_vi_tinh VARCHAR(20) NOT NULL,
    thu_tu_su_dung INTEGER DEFAULT 1,
    bat_buoc BOOLEAN DEFAULT 1,
    ngay_tao DATETIME DEFAULT CURRENT_TIMESTAMP,
    ngay_cap_nhat DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (ma_san_pham) REFERENCES VAT_TU(ma_vat_tu),
    FOREIGN KEY (ma_nguyen_lieu) REFERENCES VAT_TU(ma_vat_tu),
    UNIQUE(ma_san_pham, ma_nguyen_lieu),
    CHECK(ma_san_pham != ma_nguyen_lieu)
);

CREATE INDEX idx_cong_thuc_san_pham ON CONG_THUC_SAN_XUAT(ma_san_pham);
CREATE INDEX idx_cong_thuc_nguyen_lieu ON CONG_THUC_SAN_XUAT(ma_nguyen_lieu);

-- ============================================
-- 7. NHOM BANG LICH SU
-- ============================================

CREATE TABLE LICH_SU_DIEU_CHUYEN (
    ma_lich_su INTEGER PRIMARY KEY AUTOINCREMENT,
    ma_vat_tu INTEGER NOT NULL,
    ma_lo_hang INTEGER NOT NULL,
    ma_vi_tri_cu INTEGER NOT NULL,
    ma_vi_tri_moi INTEGER NOT NULL,
    so_luong DECIMAL(15,2) NOT NULL CHECK(so_luong > 0),
    ngay_dieu_chuyen DATETIME DEFAULT CURRENT_TIMESTAMP,
    ma_nhan_vien INTEGER NOT NULL,
    ly_do TEXT,
    FOREIGN KEY (ma_vat_tu) REFERENCES VAT_TU(ma_vat_tu),
    FOREIGN KEY (ma_lo_hang) REFERENCES LO_HANG(ma_lo_hang),
    FOREIGN KEY (ma_vi_tri_cu) REFERENCES VI_TRI_KHO(ma_vi_tri),
    FOREIGN KEY (ma_vi_tri_moi) REFERENCES VI_TRI_KHO(ma_vi_tri),
    FOREIGN KEY (ma_nhan_vien) REFERENCES NHAN_VIEN(ma_nhan_vien),
    CHECK(ma_vi_tri_cu != ma_vi_tri_moi)
);

CREATE INDEX idx_lich_su_ngay ON LICH_SU_DIEU_CHUYEN(ngay_dieu_chuyen);
CREATE INDEX idx_lich_su_vat_tu ON LICH_SU_DIEU_CHUYEN(ma_vat_tu);
CREATE INDEX idx_lich_su_lo_hang ON LICH_SU_DIEU_CHUYEN(ma_lo_hang);
