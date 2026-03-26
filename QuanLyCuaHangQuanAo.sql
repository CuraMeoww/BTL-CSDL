PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS THANHTOAN;
DROP TABLE IF EXISTS CHITIET_HOADON;
DROP TABLE IF EXISTS PHIEUNHAP;
DROP TABLE IF EXISTS HOADON;
DROP TABLE IF EXISTS SANPHAM;
DROP TABLE IF EXISTS NHACUNGCAP;
DROP TABLE IF EXISTS KHACHHANG;
DROP TABLE IF EXISTS NHANVIEN;
DROP TABLE IF EXISTS LUONG;

-- 1. Tạo Bảng Lương
CREATE TABLE LUONG (
    MaLuong TEXT PRIMARY KEY,
    LuongCoBan INTEGER,
    PhuCap INTEGER
);

-- 2. Tạo Bảng Nhân Viên
CREATE TABLE NHANVIEN (
    MaNV TEXT PRIMARY KEY,
    TenNV TEXT NOT NULL,
    SDTNV TEXT,
    ChucVu TEXT,
    GioiTinh TEXT,
    eMail TEXT,
    NgayVaoLam TEXT,
    MaLuong TEXT,
    FOREIGN KEY (MaLuong) REFERENCES LUONG(MaLuong) ON DELETE SET NULL ON UPDATE CASCADE
);

-- 3. Tạo Bảng Khách Hàng
CREATE TABLE KHACHHANG (
    MaKH TEXT PRIMARY KEY,
    TenKH TEXT NOT NULL,
    SDTKH TEXT,
    DiaChi TEXT,
    NgaySinh TEXT,
    GioiTinh TEXT,
    MaNV TEXT,
    FOREIGN KEY (MaNV) REFERENCES NHANVIEN(MaNV) ON DELETE SET NULL ON UPDATE CASCADE
);

-- 4. Tạo Bảng Nhà Cung Cấp
CREATE TABLE NHACUNGCAP (
    MaNCC TEXT PRIMARY KEY,
    TenNCC TEXT NOT NULL,
    DiachiNCC TEXT,
    SDTNCC TEXT
);

-- 5. Tạo Bảng Sản Phẩm
CREATE TABLE SANPHAM (
    MaSP TEXT PRIMARY KEY,
    TenSP TEXT NOT NULL,
    LoaiSP TEXT,
    GiaNhap INTEGER,
    GiaBan INTEGER,
    SoLuongTon INTEGER,
    XuatXu TEXT,
    MaNCC TEXT,
    FOREIGN KEY (MaNCC) REFERENCES NHACUNGCAP(MaNCC) ON DELETE CASCADE ON UPDATE CASCADE
);

-- 6. Tạo Bảng Hóa Đơn
CREATE TABLE HOADON (
    MaHD TEXT PRIMARY KEY,
    NgayTao TEXT DEFAULT CURRENT_TIMESTAMP,
    ThanhTien INTEGER,
    TienThua INTEGER,
    MaNV TEXT,
    MaKH TEXT,
    FOREIGN KEY (MaNV) REFERENCES NHANVIEN(MaNV) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (MaKH) REFERENCES KHACHHANG(MaKH) ON DELETE CASCADE ON UPDATE CASCADE
);

-- 7. Tạo Bảng Phiếu Nhập
CREATE TABLE PHIEUNHAP (
    MaPN TEXT PRIMARY KEY,
    NgayNhap TEXT DEFAULT CURRENT_TIMESTAMP,
    TongTienNhap INTEGER,
    MaNCC TEXT,
    MaNV TEXT,
    FOREIGN KEY (MaNCC) REFERENCES NHACUNGCAP(MaNCC) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (MaNV) REFERENCES NHANVIEN(MaNV) ON DELETE CASCADE ON UPDATE CASCADE
);

-- 8. Tạo Bảng Chi Tiết Hóa Đơn
CREATE TABLE CHITIET_HOADON (
    MaHD TEXT,
    MaSP TEXT,
    SoLuong INTEGER,
    DonGia INTEGER,
    ThanhTien INTEGER,
    PRIMARY KEY (MaHD, MaSP),
    FOREIGN KEY (MaHD) REFERENCES HOADON(MaHD) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (MaSP) REFERENCES SANPHAM(MaSP) ON DELETE CASCADE ON UPDATE CASCADE
);

-- 9. Tạo Bảng Thanh Toán
CREATE TABLE THANHTOAN (
    MaKH TEXT,
    MaHD TEXT,
    MaNV TEXT,
    PRIMARY KEY (MaKH, MaHD, MaNV),
    FOREIGN KEY (MaKH) REFERENCES KHACHHANG(MaKH) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (MaHD) REFERENCES HOADON(MaHD) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (MaNV) REFERENCES NHANVIEN(MaNV) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Thêm dữ liệu Bảng Lương
INSERT INTO LUONG (MaLuong, LuongCoBan, PhuCap) VALUES
('L01', 5000000, 0), ('L02', 5000000, 200000), ('L03', 7000000, 0), ('L04', 8000000, 500000),
('L05', 9000000, 500000), ('L06', 10000000, 800000), ('L07', 12000000, 0), ('L08', 12000000, 1000000),
('L09', 13000000, 1200000), ('L10', 14000000, 1500000), ('L11', 15000000, 2000000), ('L12', 17000000, 2500000),
('L13', 20000000, 0), ('L14', 25000000, 4000000), ('L15', 30000000, 5000000);

-- Thêm dữ liệu Bảng Nhân Viên
INSERT INTO NHANVIEN (MaNV, TenNV, SDTNV, ChucVu, GioiTinh, eMail, NgayVaoLam, MaLuong) 
VALUES
('NV01', 'Nguyễn Văn Anh', '0901234567', 'Quản lý', 'Nam', 'annv@gmail.com', '2022-01-10', 'L15'),
('NV02', 'Nguyễn Phương Anh', '0912345678', 'Bán hàng', 'Nữ', 'anhnp@gmail.com', '2022-03-15', 'L10'),
('NV03', 'Lê Thị Lan Hương', '0923456789', 'Kế toán', 'Nữ', 'huongltl@gmail.com', '2022-05-20', 'L04'),
('NV04', 'Nguyễn Thị Thu Hoài', '0934567890', 'Kế toán', 'Nữ', 'hoaintt@gmail.com', '2026-02-12', 'L02'),
('NV05', 'Hoàng Văn Em', '0945678901', 'Kho', 'Nam', 'emhv@gmail.com', '2022-06-01', 'L07'),
('NV06', 'Ngô Thị Giang', '0956789012', 'Bán hàng', 'Nữ', 'giangnt@gmail.com', '2023-01-05', 'L07'),
('NV07', 'Đặng Văn Hải', '0967890123', 'Bảo vệ', 'Nam', 'haidv@gmail.com', '2023-02-10', 'L06'),
('NV08', 'Dương Trà My', '0978901234', 'Bán hàng', 'Nữ', 'mydt@gmail.com', '2025-03-15', 'L04'),
('NV09', 'Đặng Thị Quỳnh Trang', '0989012345', 'Quản lý', 'Nữ', 'trangdtq@gmail.com', '2021-11-20', 'L12'),
('NV10', 'Nguyễn Trúc Ly', '0990123456', 'Bán hàng', 'Nữ', 'lynt@gmail.com', '2022-08-14', 'L09'),
('NV11', 'Bạch Minh Trí', '0812345678', 'Kho', 'Nam', 'tribm@gmail.com', '2023-04-20', 'L08'),
('NV12', 'Vũ Lê Phương Thảo', '0823456789', 'Bán hàng', 'Nữ', 'thaovlp@gmail.com', '2023-05-25', 'L09'),
('NV13', 'Tạ Đăng Sơn', '0834567890', 'Bán hàng', 'Nam', 'sontd@gmail.com', '2023-06-30', 'L08'),
('NV14', 'Hà Minh Châu', '0845678901', 'Tạp vụ', 'Nữ', 'chauhm@gmail.com', '2023-07-05', 'L10'),
('NV15', 'Trịnh Tuấn Linh', '0856789012', 'Bảo vệ', 'Nam', 'linhtt@gmail.com', '2023-08-12', 'L09');

-- Thêm dữ liệu Bảng Khách Hàng
INSERT INTO KHACHHANG (MaKH, TenKH, SDTKH, DiaChi, NgaySinh, GioiTinh, MaNV) 
VALUES
('KH01', 'Nguyễn Thị Mai', '0321456789', 'Hà Nội', '1995-05-12', 'Nữ', 'NV02'),
('KH02', 'Trần Văn Nam', '0332567890', 'Hải Phòng', '1990-10-20', 'Nam', 'NV03'),
('KH03', 'Lê Văn Tám', '0343678901', 'Đà Nẵng', '1988-02-15', 'Nam', 'NV02'),
('KH04', 'Trần Thị Ngọc Huyền', '0354789012', 'Bắc Ninh', '2006-01-24', 'Nữ', 'NV03'),
('KH05', 'Trịnh Đắc Nam', '0365890123', 'TP HCM', '1992-07-08', 'Nam', 'NV06'),
('KH06', 'Đỗ Thùy Chi', '0376901234', 'Bắc Ninh', '1997-04-30', 'Nữ', 'NV08'),
('KH07', 'Trần Minh Thành', '0387012345', 'Hà Nội', '1993-08-16', 'Nam', 'NV06'),
('KH08', 'Hoàng Diệp Linh', '0398123456', 'Bắc Ninh', '2006-03-18', 'Nữ', 'NV02'),
('KH09', 'Lưu Hải Nam', '0319234567', 'Nam Định', '1991-06-18', 'Nam', 'NV12'),
('KH10', 'Trương Mỹ Hạnh', '0320345678', 'Hà Nội', '1996-11-05', 'Nữ', 'NV13'),
('KH11', 'Lý Công Tuấn', '0331456789', 'Quảng Ninh', '1985-03-22', 'Nam', 'NV12'),
('KH12', 'Đinh Ngọc Diệp', '0342567890', 'Huế', '2002-08-10', 'Nữ', 'NV13'),
('KH13', 'Vương Đình Khôi', '0353678901', 'Hà Nội', '1994-05-05', 'Nam', 'NV02'),
('KH14', 'Bùi Thị Huyền Trinh', '0364789012', 'Hà Nội', '1998-02-28', 'Nữ', 'NV03'),
('KH15', 'Phan Văn Đức', '0375890123', 'Nghệ An', '1990-12-12', 'Nam', 'NV08');

-- Thêm dữ liệu Bảng Nhà Cung Cấp
INSERT INTO NHACUNGCAP (MaNCC, TenNCC, DiachiNCC, SDTNCC) 
VALUES
('NCC01', 'Tổng kho May mặc HN', 'Hà Nội', '0243123456'),
('NCC02', 'Xưởng Jeans Sài Gòn', 'TP HCM', '0283987654'),
('NCC03', 'Công ty Thời trang Việt', 'Đà Nẵng', '0236456789'),
('NCC04', 'Phụ kiện Owen', 'Hà Nội', '0243555666'),
('NCC05', 'Dệt may Thành Công', 'TP HCM', '0283111222'),
('NCC06', 'Vải vóc Thượng Hải', 'Lào Cai', '0214888999'),
('NCC07', 'Đồ lót Triumph VN', 'Bình Dương', '0274123123'),
('NCC08', 'Giày dép Biti’s', 'Đồng Nai', '0251345345'),
('NCC09', 'Local Brand Teelab', 'Thái Nguyên', '0208123456'),
('NCC10', 'Xưởng may mặc An Phát', 'Nam Định', '0226999000'),
('NCC11', 'Thời trang trẻ em Kiddo', 'Hà Nội', '0243999999'),
('NCC12', 'Hàn Quốc Fashion', 'Hàn Quốc', '0821234567'),
('NCC13', 'Đồ thể thao Adidas VN', 'TP HCM', '0283777888'),
('NCC14', 'Túi xách Juno', 'Long An', '0272123789'),
('NCC15', 'Đồ đông ấm áp', 'Lạng Sơn', '0205123456');

-- Thêm dữ liệu Bảng Sản Phẩm
INSERT INTO SANPHAM (MaSP, TenSP, LoaiSP, GiaNhap, GiaBan, SoLuongTon, XuatXu, MaNCC) 
VALUES
('SP01', 'Áo Sơ Mi Trắng', 'Áo', 150000, 250000, 0,  'Việt Nam', 'NCC01'),
('SP02', 'Quần Jean Nam Xanh', 'Quần', 300000, 550000,67,  'Việt Nam', 'NCC02'),
('SP03', 'Áo Thun Basic', 'Áo', 80000, 150000, 69, 'Việt Nam', 'NCC01'),
('SP04', 'Váy Công Sở', 'Váy', 250000, 450000, 34, 'Việt Nam', 'NCC03'),
('SP05', 'Thắt Lưng Da', 'Phụ kiện', 100000, 200000,129, 'Trung Quốc', 'NCC04'),
('SP06', 'Áo Khoác Gió', 'Áo', 350000, 600000,5, 'Việt Nam', 'NCC05'),
('SP07', 'Quần Tây Âu', 'Quần', 200000, 380000,123, 'Việt Nam', 'NCC03'),
('SP08', 'Túi Xách Da', 'Phụ kiện', 400000, 850000,81, 'Trung Quốc', 'NCC14'),
('SP09', 'Giày Sneaker', 'Giày', 500000, 950000,40, 'Việt Nam', 'NCC08'),
('SP10', 'Áo Hoodie', 'Áo', 200000, 350000,0, 'Việt Nam', 'NCC09'),
('SP11', 'Quần Short Thun', 'Quần', 70000, 130000,0, 'Việt Nam', 'NCC10'),
('SP12', 'Áo Ba Lỗ Trắng', 'Áo', 920000, 2220000,120, 'Việt Nam', 'NCC11'),
('SP13', 'Váy Len Mùa Đông', 'Váy', 300000, 500000,23, 'Hàn Quốc', 'NCC12'),
('SP14', 'Áo Nỉ Có Mũ', 'Áo', 180000, 320000,2, 'Việt Nam', 'NCC09'),
('SP15', 'Quần Kaki Nam', 'Quần', 220000, 420000,13, 'Việt Nam', 'NCC02');

-- Thêm dữ liệu Bảng Hoá Đơn
INSERT INTO HOADON (MaHD, NgayTao, ThanhTien, TienThua, MaNV, MaKH) 
VALUES
('HD01', '2023-09-01 08:30:00', 400000, 0, 'NV02', 'KH01'),
('HD02', '2023-09-01 09:15:00', 550000, 50000, 'NV03', 'KH02'),
('HD03', '2023-09-02 10:00:00', 1100000, 0, 'NV02', 'KH03'),
('HD04', '2023-09-02 14:00:00', 200000, 0, 'NV06', 'KH05'),
('HD05', '2023-09-03 16:30:00', 850000, 150000, 'NV08', 'KH06'),
('HD06', '2023-09-04 08:00:00', 150000, 0, 'NV02', 'KH08'),
('HD07', '2023-09-04 19:20:00', 950000, 50000, 'NV12', 'KH09'),
('HD08', '2023-09-05 10:45:00', 1300000, 0, 'NV13', 'KH10'),
('HD09', '2023-09-05 11:30:00', 350000, 0, 'NV03', 'KH14'),
('HD10', '2023-09-06 15:00:00', 450000, 50000, 'NV02', 'KH01'),
('HD11', '2023-09-06 17:00:00', 600000, 0, 'NV06', 'KH07'),
('HD12', '2023-09-07 09:00:00', 420000, 80000, 'NV02', 'KH13'),
('HD13', '2023-09-07 20:15:00', 500000, 0, 'NV03', 'KH04'),
('HD14', '2023-09-08 14:30:00', 800000, 0, 'NV12', 'KH11'),
('HD15', '2023-09-08 16:00:00', 380000, 20000, 'NV08', 'KH15');

-- Thêm dữ liệu Bảng Phiếu Nhập
INSERT INTO PHIEUNHAP (MaPN, NgayNhap, TongTienNhap, MaNCC, MaNV) 
VALUES
('PN01', '2023-08-20', 5000000, 'NCC01', 'NV05'),
('PN02', '2023-08-21', 10000000, 'NCC02', 'NV11'),
('PN03', '2023-08-22', 4500000, 'NCC03', 'NV05'),
('PN04', '2023-08-23', 2000000, 'NCC04', 'NV11'),
('PN05', '2023-08-24', 7000000, 'NCC05', 'NV05'),
('PN06', '2023-08-25', 1500000, 'NCC10', 'NV11'),
('PN07', '2023-08-26', 8000000, 'NCC14', 'NV05'),
('PN08', '2023-08-27', 12000000, 'NCC08', 'NV11'),
('PN09', '2023-08-28', 3000000, 'NCC09', 'NV05'),
('PN10', '2023-08-29', 6000000, 'NCC12', 'NV11'),
('PN11', '2023-08-30', 2500000, 'NCC11', 'NV05'),
('PN12', '2023-08-31', 9000000, 'NCC02', 'NV11'),
('PN13', '2023-09-01', 1000000, 'NCC01', 'NV05'),
('PN14', '2023-09-02', 4000000, 'NCC03', 'NV11'),
('PN15', '2023-09-03', 5500000, 'NCC05', 'NV05');

-- Thêm dữ liệu Bảng Chi Tiết Hoá Đơn
INSERT INTO CHITIET_HOADON (MaHD, MaSP, SoLuong, DonGia, ThanhTien) 
VALUES
('HD01', 'SP01', 1, 250000, 250000), ('HD01', 'SP03', 1, 150000, 150000),
('HD02', 'SP02', 1, 550000, 550000),
('HD03', 'SP02', 2, 550000, 1100000),
('HD04', 'SP05', 1, 200000, 200000),
('HD05', 'SP08', 1, 850000, 850000),
('HD06', 'SP03', 1, 150000, 150000),
('HD07', 'SP09', 1, 950000, 950000),
('HD08', 'SP06', 1, 600000, 600000), ('HD08', 'SP13', 1, 500000, 500000), ('HD08', 'SP05', 1, 200000, 200000),
('HD09', 'SP10', 1, 350000, 350000),
('HD10', 'SP04', 1, 450000, 450000),
('HD11', 'SP06', 1, 600000, 600000),
('HD12', 'SP15', 1, 420000, 420000),
('HD13', 'SP13', 1, 500000, 500000),
('HD14', 'SP02', 1, 550000, 550000), ('HD14', 'SP01', 1, 250000, 250000),
('HD15', 'SP07', 1, 380000, 380000);

-- Thêm dữ liệu Bảng Thanh Toán
INSERT INTO THANHTOAN (MaKH, MaHD, MaNV) 
VALUES
('KH01', 'HD01', 'NV02'), ('KH02', 'HD02', 'NV03'), ('KH03', 'HD03', 'NV02'), ('KH05', 'HD04', 'NV06'),
('KH06', 'HD05', 'NV08'), ('KH08', 'HD06', 'NV02'), ('KH09', 'HD07', 'NV12'), ('KH10', 'HD08', 'NV13'),
('KH14', 'HD09', 'NV03'), ('KH01', 'HD10', 'NV02'), ('KH07', 'HD11', 'NV06'), ('KH13', 'HD12', 'NV02'),
('KH04', 'HD13', 'NV03'), ('KH11', 'HD14', 'NV12'), ('KH15', 'HD15', 'NV08');
