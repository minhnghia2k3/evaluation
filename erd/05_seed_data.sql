-- ============================================
-- DU LIEU MAU (SEED DATA)
-- He thong Quan ly Kho Thong minh - Vinamilk
-- ============================================

-- ============================================
-- 1. DU LIEU NHA MAY
-- ============================================

INSERT INTO NHA_MAY (ten_nha_may, dia_chi, so_dien_thoai, ngay_thanh_lap, trang_thai) VALUES
('Nha may Vinamilk Binh Duong', 'KCN Viet Nam Singapore, Binh Duong', '0274 3750 555', '2000-05-15', 1),
('Nha may Vinamilk Ha Nam', 'KCN Dong Van II, Ha Nam', '0226 3851 888', '2005-08-20', 1),
('Nha may Vinamilk Nghe An', 'KCN WHA, Nghe An', '0238 3842 999', '2015-03-10', 1);

-- ============================================
-- 2. DU LIEU KHO
-- ============================================

INSERT INTO KHO (ma_nha_may, ten_kho, loai_kho, dien_tich, suc_chua_toi_da, trang_thai) VALUES
-- Nha may Binh Duong
(1, 'Kho nguyen lieu A1', 'NGUYEN_LIEU', 500.00, 1000.00, 1),
(1, 'Kho lanh B1', 'KHO_LANH', 300.00, 500.00, 1),
(1, 'Kho thanh pham C1', 'THANH_PHAM', 800.00, 2000.00, 1),
-- Nha may Ha Nam
(2, 'Kho nguyen lieu A2', 'NGUYEN_LIEU', 400.00, 800.00, 1),
(2, 'Kho ban thanh pham B2', 'BAN_THANH_PHAM', 350.00, 700.00, 1),
(2, 'Kho thanh pham C2', 'THANH_PHAM', 600.00, 1500.00, 1);

-- ============================================
-- 3. DU LIEU VI TRI KHO
-- ============================================

-- Kho nguyen lieu A1 (ma_kho = 1)
INSERT INTO VI_TRI_KHO (ma_kho, ma_ke, ma_tang, ma_ngan, suc_chua, loai_vi_tri, trang_thai) VALUES
(1, 'A', '1', '01', 100.00, 'THUONG', 'TRONG'),
(1, 'A', '1', '02', 100.00, 'THUONG', 'TRONG'),
(1, 'A', '2', '01', 100.00, 'THUONG', 'TRONG'),
(1, 'A', '2', '02', 100.00, 'THUONG', 'TRONG'),
(1, 'B', '1', '01', 100.00, 'THUONG', 'TRONG'),
(1, 'B', '1', '02', 100.00, 'THUONG', 'TRONG');

-- Kho lanh B1 (ma_kho = 2)
INSERT INTO VI_TRI_KHO (ma_kho, ma_ke, ma_tang, ma_ngan, suc_chua, loai_vi_tri, trang_thai) VALUES
(2, 'A', '1', '01', 80.00, 'LANH', 'TRONG'),
(2, 'A', '1', '02', 80.00, 'LANH', 'TRONG'),
(2, 'A', '2', '01', 80.00, 'LANH', 'TRONG'),
(2, 'B', '1', '01', 80.00, 'DONG_LANH', 'TRONG');

-- Kho thanh pham C1 (ma_kho = 3)
INSERT INTO VI_TRI_KHO (ma_kho, ma_ke, ma_tang, ma_ngan, suc_chua, loai_vi_tri, trang_thai) VALUES
(3, 'A', '1', '01', 150.00, 'THUONG', 'TRONG'),
(3, 'A', '1', '02', 150.00, 'THUONG', 'TRONG'),
(3, 'A', '2', '01', 150.00, 'THUONG', 'TRONG'),
(3, 'B', '1', '01', 150.00, 'LANH', 'TRONG'),
(3, 'B', '1', '02', 150.00, 'LANH', 'TRONG');

-- ============================================
-- 4. DU LIEU LOAI VAT TU
-- ============================================

INSERT INTO LOAI_VAT_TU (ten_loai, mo_ta, loai_cha) VALUES
-- Cap 1
('Nguyen lieu', 'Nguyen lieu tho', NULL),
('Ban thanh pham', 'San pham ban thanh pham', NULL),
('Thanh pham', 'San pham hoan chinh', NULL),
('Bao bi', 'Vat lieu bao bi', NULL);

-- Cap 2 - Con cua Nguyen lieu
INSERT INTO LOAI_VAT_TU (ten_loai, mo_ta, loai_cha) VALUES
('Sua tuoi', 'Sua tuoi nguyen chat', 1),
('Duong', 'Cac loai duong', 1),
('Huong lieu', 'Huong lieu thuc pham', 1),
('Chat phu gia', 'Chat phu gia thuc pham', 1);

-- Cap 2 - Con cua Thanh pham
INSERT INTO LOAI_VAT_TU (ten_loai, mo_ta, loai_cha) VALUES
('Sua tuoi dong hop', 'Sua tuoi dong hop', 3),
('Sua chua', 'Cac loai sua chua', 3),
('Sua bot', 'Sua bot danh cho tre em va nguoi lon', 3);

-- ============================================
-- 5. DU LIEU VAT TU
-- ============================================

-- Nguyen lieu
INSERT INTO VAT_TU (ma_loai_vat_tu, ten_vat_tu, ma_vat_tu_code, loai_hang, don_vi_tinh, gia_nhap_trung_binh, thoi_han_su_dung_ngay, nhiet_do_bao_quan_min, nhiet_do_bao_quan_max, yeu_cau_lo_hang) VALUES
(5, 'Sua tuoi nguyen chat A', 'NL-MILK-001', 'NGUYEN_LIEU', 'Lit', 15000, 7, 2, 6, 1),
(5, 'Sua tuoi huu co', 'NL-MILK-002', 'NGUYEN_LIEU', 'Lit', 25000, 5, 2, 6, 1),
(6, 'Duong tinh luyen', 'NL-SUGAR-001', 'NGUYEN_LIEU', 'Kg', 18000, 365, 15, 30, 1),
(6, 'Duong lactose', 'NL-SUGAR-002', 'NGUYEN_LIEU', 'Kg', 35000, 365, 15, 30, 1),
(7, 'Huong dau', 'NL-FLAVOR-001', 'NGUYEN_LIEU', 'Kg', 120000, 180, 15, 25, 1),
(7, 'Huong socola', 'NL-FLAVOR-002', 'NGUYEN_LIEU', 'Kg', 150000, 180, 15, 25, 1),
(8, 'Men sua chua', 'NL-CULTURE-001', 'NGUYEN_LIEU', 'Goi', 80000, 90, -18, -10, 1);

-- Ban thanh pham
INSERT INTO VAT_TU (ma_loai_vat_tu, ten_vat_tu, ma_vat_tu_code, loai_hang, don_vi_tinh, gia_nhap_trung_binh, thoi_han_su_dung_ngay, nhiet_do_bao_quan_min, nhiet_do_bao_quan_max, yeu_cau_lo_hang) VALUES
(2, 'Sua tiet trung chua dong goi', 'BTP-MILK-001', 'BAN_THANH_PHAM', 'Lit', 18000, 30, 2, 6, 1),
(2, 'Sua chua chua dong goi', 'BTP-YOGURT-001', 'BAN_THANH_PHAM', 'Kg', 22000, 15, 2, 6, 1);

-- Thanh pham
INSERT INTO VAT_TU (ma_loai_vat_tu, ten_vat_tu, ma_vat_tu_code, loai_hang, don_vi_tinh, gia_nhap_trung_binh, thoi_han_su_dung_ngay, nhiet_do_bao_quan_min, nhiet_do_bao_quan_max, yeu_cau_lo_hang) VALUES
(9, 'Vinamilk Sua tuoi 1L', 'TP-MILK-1L-001', 'THANH_PHAM', 'Hop', 25000, 7, 2, 6, 1),
(9, 'Vinamilk Sua tuoi 180ml', 'TP-MILK-180ML-001', 'THANH_PHAM', 'Hop', 6000, 7, 2, 6, 1),
(10, 'Vinamilk Sua chua uong 180ml', 'TP-YOGURT-180ML-001', 'THANH_PHAM', 'Chai', 7000, 30, 2, 6, 1),
(10, 'Vinamilk Sua chua an 100g', 'TP-YOGURT-100G-001', 'THANH_PHAM', 'Hop', 5000, 21, 2, 6, 1),
(11, 'Vinamilk Dielac Alpha Gold 900g', 'TP-POWDER-900G-001', 'THANH_PHAM', 'Hop', 350000, 730, 15, 30, 1);

-- Bao bi
INSERT INTO VAT_TU (ma_loai_vat_tu, ten_vat_tu, ma_vat_tu_code, loai_hang, don_vi_tinh, gia_nhap_trung_binh, thoi_han_su_dung_ngay, nhiet_do_bao_quan_min, nhiet_do_bao_quan_max, yeu_cau_lo_hang) VALUES
(4, 'Hop giay 1L', 'BB-BOX-1L-001', 'NGUYEN_LIEU', 'Cai', 2000, 1095, 15, 30, 1),
(4, 'Hop giay 180ml', 'BB-BOX-180ML-001', 'NGUYEN_LIEU', 'Cai', 500, 1095, 15, 30, 1),
(4, 'Chai nhua 180ml', 'BB-BOTTLE-180ML-001', 'NGUYEN_LIEU', 'Cai', 800, 1095, 15, 30, 1);

-- ============================================
-- 6. DU LIEU NHA CUNG CAP
-- ============================================

INSERT INTO NHA_CUNG_CAP (ten_nha_cung_cap, ma_so_thue, dia_chi, so_dien_thoai, email, trang_thai) VALUES
('Hop tac xa Sua Bo Moc Chau', '0102345678', 'Moc Chau, Son La', '0212 3867 999', 'contact@mocchau.vn', 1),
('Cong ty Duong Bien Hoa', '0301234567', 'Bien Hoa, Dong Nai', '0251 3891 888', 'sales@bienhoa-sugar.vn', 1),
('Cong ty Huong lieu Viet Nam', '0401234567', 'Binh Duong', '0274 3888 777', 'info@vnflavor.vn', 1),
('Cong ty Bao bi Tan Tien', '0501234567', 'Binh Duong', '0274 3777 666', 'sales@tantien.vn', 1),
('Cong ty Men sua chua Chr. Hansen', '0601234567', 'TP. Ho Chi Minh', '028 3999 8888', 'vietnam@chr-hansen.com', 1);

-- ============================================
-- 7. DU LIEU NHAN VIEN
-- ============================================

INSERT INTO NHAN_VIEN (ho_ten, ma_nhan_vien_code, chuc_vu, so_dien_thoai, email, ma_nha_may, trang_thai) VALUES
-- Nha may Binh Duong
('Nguyen Van An', 'NV-001', 'Quan ly kho', '0901234567', 'an.nguyen@vinamilk.com.vn', 1, 1),
('Tran Thi Binh', 'NV-002', 'Nhan vien kho', '0901234568', 'binh.tran@vinamilk.com.vn', 1, 1),
('Le Van Cuong', 'NV-003', 'Truong phong san xuat', '0901234569', 'cuong.le@vinamilk.com.vn', 1, 1),
-- Nha may Ha Nam
('Pham Thi Dung', 'NV-004', 'Quan ly kho', '0901234570', 'dung.pham@vinamilk.com.vn', 2, 1),
('Hoang Van Em', 'NV-005', 'Nhan vien kho', '0901234571', 'em.hoang@vinamilk.com.vn', 2, 1),
-- Nha may Nghe An
('Vo Thi Phuong', 'NV-006', 'Quan ly kho', '0901234572', 'phuong.vo@vinamilk.com.vn', 3, 1);

-- ============================================
-- 8. DU LIEU LO HANG
-- ============================================

INSERT INTO LO_HANG (ma_vat_tu, so_lo, ngay_san_xuat, han_su_dung, ma_nha_cung_cap, chung_nhan_chat_luong, trang_thai) VALUES
-- Sua tuoi nguyen chat A
(1, 'MILK-20260201-001', '2026-02-01', '2026-02-08', 1, 'CQ-2026-001', 'DANG_SU_DUNG'),
(1, 'MILK-20260205-001', '2026-02-05', '2026-02-12', 1, 'CQ-2026-002', 'DANG_SU_DUNG'),
-- Duong tinh luyen
(3, 'SUGAR-20251201-001', '2025-12-01', '2026-11-30', 2, 'CQ-2025-150', 'DANG_SU_DUNG'),
-- Huong dau
(5, 'FLAVOR-20260101-001', '2026-01-01', '2026-06-30', 3, 'CQ-2026-010', 'DANG_SU_DUNG'),
-- Men sua chua
(7, 'CULTURE-20260115-001', '2026-01-15', '2026-04-15', 5, 'CQ-2026-020', 'DANG_SU_DUNG'),
-- Hop giay 1L
(15, 'BOX-20260101-001', '2026-01-01', '2028-12-31', 4, 'CQ-2026-030', 'DANG_SU_DUNG'),
-- Hop giay 180ml
(16, 'BOX-20260101-002', '2026-01-01', '2028-12-31', 4, 'CQ-2026-031', 'DANG_SU_DUNG');

-- ============================================
-- 9. DU LIEU PHIEU NHAP
-- ============================================

INSERT INTO PHIEU_NHAP (so_phieu_nhap, ma_kho, ma_nha_cung_cap, ngay_nhap, ma_nhan_vien, loai_nhap, trang_thai_phieu, ghi_chu) VALUES
('PN-20260201-001', 1, 1, '2026-02-01 08:30:00', 1, 'MUA_HANG', 'DA_NHAP', 'Nhap sua tuoi nguyen chat'),
('PN-20260201-002', 1, 2, '2026-02-01 10:00:00', 1, 'MUA_HANG', 'DA_NHAP', 'Nhap duong tinh luyen'),
('PN-20260205-001', 1, 1, '2026-02-05 09:00:00', 2, 'MUA_HANG', 'DA_NHAP', 'Nhap sua tuoi nguyen chat'),
('PN-20260210-001', 1, 3, '2026-02-10 14:00:00', 1, 'MUA_HANG', 'DA_NHAP', 'Nhap huong lieu'),
('PN-20260210-002', 2, 5, '2026-02-10 15:00:00', 1, 'MUA_HANG', 'DA_NHAP', 'Nhap men sua chua');

-- ============================================
-- 10. DU LIEU CHI TIET NHAP
-- ============================================

INSERT INTO CHI_TIET_NHAP (ma_phieu_nhap, ma_vat_tu, ma_lo_hang, so_luong, don_vi_tinh, don_gia, thanh_tien, ma_vi_tri) VALUES
-- Phieu PN-20260201-001
(1, 1, 1, 5000.00, 'Lit', 15000, 75000000, 1),
-- Phieu PN-20260201-002
(2, 3, 3, 2000.00, 'Kg', 18000, 36000000, 2),
-- Phieu PN-20260205-001
(3, 1, 2, 3000.00, 'Lit', 15000, 45000000, 3),
-- Phieu PN-20260210-001
(4, 5, 4, 100.00, 'Kg', 120000, 12000000, 4),
-- Phieu PN-20260210-002
(5, 7, 5, 50.00, 'Goi', 80000, 4000000, 10);

-- ============================================
-- 11. DU LIEU TON KHO
-- ============================================

INSERT INTO CHI_TIET_TON_KHO (ma_vat_tu, ma_lo_hang, ma_kho, ma_vi_tri, so_luong_ton, ngay_cap_nhat) VALUES
-- Sua tuoi nguyen chat A - Lo 1
(1, 1, 1, 1, 4500.00, '2026-02-12 10:00:00'),
-- Sua tuoi nguyen chat A - Lo 2
(1, 2, 1, 3, 2800.00, '2026-02-12 10:00:00'),
-- Duong tinh luyen
(3, 3, 1, 2, 1850.00, '2026-02-12 10:00:00'),
-- Huong dau
(5, 4, 1, 4, 95.00, '2026-02-12 10:00:00'),
-- Men sua chua
(7, 5, 2, 10, 48.00, '2026-02-12 10:00:00');

-- ============================================
-- 12. DU LIEU CONG THUC SAN XUAT
-- ============================================

-- Cong thuc san xuat Vinamilk Sua tuoi 1L (ma_vat_tu = 10)
INSERT INTO CONG_THUC_SAN_XUAT (ma_san_pham, ma_nguyen_lieu, so_luong_can, don_vi_tinh, thu_tu_su_dung, bat_buoc) VALUES
(10, 1, 1.05, 'Lit', 1, 1),  -- Sua tuoi nguyen chat
(10, 3, 0.05, 'Kg', 2, 1),   -- Duong
(10, 15, 1.00, 'Cai', 3, 1); -- Hop giay 1L

-- Cong thuc san xuat Vinamilk Sua tuoi 180ml (ma_vat_tu = 11)
INSERT INTO CONG_THUC_SAN_XUAT (ma_san_pham, ma_nguyen_lieu, so_luong_can, don_vi_tinh, thu_tu_su_dung, bat_buoc) VALUES
(11, 1, 0.19, 'Lit', 1, 1),  -- Sua tuoi nguyen chat
(11, 3, 0.01, 'Kg', 2, 1),   -- Duong
(11, 16, 1.00, 'Cai', 3, 1); -- Hop giay 180ml

-- Cong thuc san xuat Vinamilk Sua chua uong 180ml (ma_vat_tu = 12)
INSERT INTO CONG_THUC_SAN_XUAT (ma_san_pham, ma_nguyen_lieu, so_luong_can, don_vi_tinh, thu_tu_su_dung, bat_buoc) VALUES
(12, 1, 0.18, 'Lit', 1, 1),  -- Sua tuoi nguyen chat
(12, 3, 0.015, 'Kg', 2, 1),  -- Duong
(12, 5, 0.002, 'Kg', 3, 1),  -- Huong dau
(12, 7, 0.001, 'Goi', 4, 1), -- Men sua chua
(12, 17, 1.00, 'Cai', 5, 1); -- Chai nhua 180ml

-- ============================================
-- 13. DU LIEU LENH SAN XUAT
-- ============================================

INSERT INTO LENH_SAN_XUAT (so_lenh, ma_nha_may, ngay_bat_dau, ngay_ket_thuc_du_kien, ngay_hoan_thanh, ma_nhan_vien, trang_thai, ghi_chu) VALUES
('LSX-20260210-001', 1, '2026-02-10', '2026-02-10', '2026-02-10', 3, 'HOAN_THANH', 'San xuat sua tuoi 1L'),
('LSX-20260211-001', 1, '2026-02-11', '2026-02-11', NULL, 3, 'DANG_SAN_XUAT', 'San xuat sua chua uong'),
('LSX-20260212-001', 1, '2026-02-12', '2026-02-12', NULL, 3, 'KE_HOACH', 'San xuat sua tuoi 180ml');

-- ============================================
-- 14. DU LIEU CHI TIET LENH SAN XUAT
-- ============================================

INSERT INTO CHI_TIET_LENH_SAN_XUAT (ma_lenh_san_xuat, ma_vat_tu, so_luong_ke_hoach, so_luong_thuc_te, don_vi_tinh) VALUES
-- Lenh LSX-20260210-001 (Hoan thanh)
(1, 10, 1000.00, 980.00, 'Hop'),
-- Lenh LSX-20260211-001 (Dang san xuat)
(2, 12, 2000.00, 1500.00, 'Chai'),
-- Lenh LSX-20260212-001 (Ke hoach)
(3, 11, 5000.00, 0.00, 'Hop');

-- ============================================
-- 15. DU LIEU PHIEU XUAT
-- ============================================

INSERT INTO PHIEU_XUAT (so_phieu_xuat, ma_kho, ngay_xuat, ma_nhan_vien, ma_lenh_san_xuat, loai_xuat, trang_thai_phieu, ghi_chu) VALUES
('PX-20260210-001', 1, '2026-02-10 07:00:00', 2, 1, 'SAN_XUAT', 'DA_XUAT', 'Xuat nguyen lieu cho LSX-20260210-001'),
('PX-20260211-001', 1, '2026-02-11 07:30:00', 2, 2, 'SAN_XUAT', 'DA_XUAT', 'Xuat nguyen lieu cho LSX-20260211-001');

-- ============================================
-- 16. DU LIEU CHI TIET XUAT
-- ============================================

INSERT INTO CHI_TIET_XUAT (ma_phieu_xuat, ma_vat_tu, ma_lo_hang, so_luong, don_vi_tinh, ma_vi_tri) VALUES
-- Phieu PX-20260210-001 (cho san xuat 1000 hop sua 1L)
(1, 1, 1, 1050.00, 'Lit', 1),  -- Sua tuoi nguyen chat
(1, 3, 3, 50.00, 'Kg', 2),     -- Duong
-- Phieu PX-20260211-001 (cho san xuat 2000 chai sua chua)
(2, 1, 2, 360.00, 'Lit', 3),   -- Sua tuoi nguyen chat
(2, 3, 3, 30.00, 'Kg', 2),     -- Duong
(2, 5, 4, 4.00, 'Kg', 4),      -- Huong dau
(2, 7, 5, 2.00, 'Goi', 10);    -- Men sua chua

-- ============================================
-- 17. DU LIEU LICH SU DIEU CHUYEN
-- ============================================

INSERT INTO LICH_SU_DIEU_CHUYEN (ma_vat_tu, ma_lo_hang, ma_vi_tri_cu, ma_vi_tri_moi, so_luong, ngay_dieu_chuyen, ma_nhan_vien, ly_do) VALUES
(1, 1, 1, 3, 500.00, '2026-02-08 14:00:00', 2, 'Tai phan bo kho de toi uu khong gian'),
(3, 3, 2, 5, 100.00, '2026-02-09 10:00:00', 2, 'Dieu chuyen den vi tri gan day chuyen san xuat');

-- ============================================
-- KET THUC SEED DATA
-- ============================================

-- Kiem tra du lieu
SELECT 'Tong so nha may: ' || COUNT(*) FROM NHA_MAY;
SELECT 'Tong so kho: ' || COUNT(*) FROM KHO;
SELECT 'Tong so vi tri kho: ' || COUNT(*) FROM VI_TRI_KHO;
SELECT 'Tong so vat tu: ' || COUNT(*) FROM VAT_TU;
SELECT 'Tong so lo hang: ' || COUNT(*) FROM LO_HANG;
SELECT 'Tong so phieu nhap: ' || COUNT(*) FROM PHIEU_NHAP;
SELECT 'Tong so phieu xuat: ' || COUNT(*) FROM PHIEU_XUAT;
SELECT 'Tong so lenh san xuat: ' || COUNT(*) FROM LENH_SAN_XUAT;
