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
    MaLuong VARCHAR(10) PRIMARY KEY,
    LuongCoBan INT,
    PhuCap INT
);

-- 2. Tạo Bảng Nhân Viên
CREATE TABLE NHANVIEN (
    MaNV VARCHAR(10) PRIMARY KEY,
    TenNV NVARCHAR(100) NOT NULL,
    SDTNV VARCHAR(10),
    ChucVu NVARCHAR(50),
    GioiTinh NVARCHAR(5),
    eMail VARCHAR(100),
    NgayVaoLam DATE,
    MaLuong VARCHAR(10),
    FOREIGN KEY (MaLuong) REFERENCES LUONG(MaLuong)
);

-- 3. Tạo Bảng Khách Hàng
CREATE TABLE KHACHHANG (
    MaKH VARCHAR(10) PRIMARY KEY,
    TenKH NVARCHAR(100) NOT NULL,
    SDTKH VARCHAR(10),
    DiaChi NVARCHAR(255),
    NgaySinh DATE,
    GioiTinh NVARCHAR(10),
    MaNV VARCHAR(10),
    FOREIGN KEY (MaNV) REFERENCES NHANVIEN(MaNV)
);

-- 4. Tạo Bảng Nhà Cung Cấp
CREATE TABLE NHACUNGCAP (
    MaNCC VARCHAR(10) PRIMARY KEY,
    TenNCC NVARCHAR(100) NOT NULL,
    DiachiNCC NVARCHAR(255),
    SDTNCC VARCHAR(10)
);

-- 5. Tạo Bảng Sản Phẩm
CREATE TABLE SANPHAM (
    MaSP VARCHAR(10) PRIMARY KEY,
    TenSP NVARCHAR(100) NOT NULL,
    LoaiSP NVARCHAR(50),
    GiaNhap INT,
    GiaBan INT,
    SoLuongTon INT,
    XuatXu NVARCHAR(50),
    MaNCC VARCHAR(10),
    FOREIGN KEY (MaNCC) REFERENCES NHACUNGCAP(MaNCC)
);

-- 6. Tạo Bảng Hóa Đơn
CREATE TABLE HOADON (
    MaHD VARCHAR(10) PRIMARY KEY,
    NgayTao DATETIME DEFAULT GETDATE(),
    ThanhTien INT,
    TienThua INT,
    MaNV VARCHAR(10),
    MaKH VARCHAR(10),
    FOREIGN KEY (MaNV) REFERENCES NHANVIEN(MaNV),
    FOREIGN KEY (MaKH) REFERENCES KHACHHANG(MaKH)
);

-- 7. Tạo Bảng Phiếu Nhập
CREATE TABLE PHIEUNHAP (
    MaPN VARCHAR(10) PRIMARY KEY,
    NgayNhap DATETIME DEFAULT GETDATE(),
    TongTienNhap INT,
    MaNCC VARCHAR(10),
    MaNV VARCHAR(10),
    FOREIGN KEY (MaNCC) REFERENCES NHACUNGCAP(MaNCC),
    FOREIGN KEY (MaNV) REFERENCES NHANVIEN(MaNV)
);

-- 8. Tạo Bảng Chi Tiết Hóa Đơn
CREATE TABLE CHITIET_HOADON (
    MaHD VARCHAR(10),
    MaSP VARCHAR(10),
    SoLuong INT,
    DonGia INT,
    ThanhTien INT,
    PRIMARY KEY (MaHD, MaSP),
    FOREIGN KEY (MaHD) REFERENCES HOADON(MaHD),
    FOREIGN KEY (MaSP) REFERENCES SANPHAM(MaSP)
);

-- 9. Tạo Bảng Thanh Toán
CREATE TABLE THANHTOAN (
    MaKH VARCHAR(10),
    MaHD VARCHAR(10),
    MaNV VARCHAR(10),
    PRIMARY KEY (MaKH, MaHD, MaNV),
    FOREIGN KEY (MaKH) REFERENCES KHACHHANG(MaKH),
    FOREIGN KEY (MaHD) REFERENCES HOADON(MaHD),
    FOREIGN KEY (MaNV) REFERENCES NHANVIEN(MaNV)
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
('NV01', N'Nguyễn Văn Anh', '0901234567', N'Quản lý', N'Nam', 'annv@gmail.com', '2022-01-10', 'L15'),
('NV02', N'Nguyễn Phương Anh', '0912345678', N'Bán hàng', N'Nữ', 'anhnp@gmail.com', '2022-03-15', 'L10'),
('NV03', N'Lê Thị Lan Hương', '0923456789', N'Kế toán', N'Nữ', 'huongltl@gmail.com', '2022-05-20', 'L04'),
('NV04', N'Nguyễn Thị Thu Hoài', '0934567890', N'Kế toán', N'Nữ', 'hoaintt@gmail.com', '2026-02-12', 'L02'),
('NV05', N'Hoàng Văn Em', '0945678901', N'Kho', N'Nam', 'emhv@gmail.com', '2022-06-01', 'L07'),
('NV06', N'Ngô Thị Giang', '0956789012', N'Bán hàng', N'Nữ', 'giangnt@gmail.com', '2023-01-05', 'L07'),
('NV07', N'Đặng Văn Hải', '0967890123', N'Bảo vệ', N'Nam', 'haidv@gmail.com', '2023-02-10', 'L06'),
('NV08', N'Dương Trà My', '0978901234', N'Bán hàng', N'Nữ', 'mydt@gmail.com', '2025-03-15', 'L04'),
('NV09', N'Đặng Thị Quỳnh Trang', '0989012345', N'Quản lý', N'Nữ', 'trangdtq@gmail.com', '2021-11-20', 'L12'),
('NV10', N'Nguyễn Trúc Ly', '0990123456', N'Bán hàng', N'Nữ', 'lynt@gmail.com', '2022-08-14', 'L09'),
('NV11', N'Bạch Minh Trí', '0812345678', N'Kho', N'Nam', 'tribm@gmail.com', '2023-04-20', 'L08'),
('NV12', N'Vũ Lê Phương Thảo', '0823456789', N'Bán hàng', N'Nữ', 'thaovlp@gmail.com', '2023-05-25', 'L09'),
('NV13', N'Tạ Đăng Sơn', '0834567890', N'Bán hàng', N'Nam', 'sontd@gmail.com', '2023-06-30', 'L08'),
('NV14', N'Hà Minh Châu', '0845678901', N'Tạp vụ', N'Nữ', 'chauhm@gmail.com', '2023-07-05', 'L10'),
('NV15', N'Trịnh Tuấn Linh', '0856789012', N'Bảo vệ', N'Nam', 'linhtt@gmail.com', '2023-08-12', 'L09');


-- Thêm dữ liệu Bảng Khách Hàng
INSERT INTO KHACHHANG (MaKH, TenKH, SDTKH, DiaChi, NgaySinh, GioiTinh, MaNV) 
VALUES
('KH01', N'Nguyễn Thị Mai', '0321456789', N'Hà Nội', '1995-05-12', N'Nữ', 'NV02'),
('KH02', N'Trần Văn Nam', '0332567890', N'Hải Phòng', '1990-10-20', N'Nam', 'NV03'),
('KH03', N'Lê Văn Tám', '0343678901', N'Đà Nẵng', '1988-02-15', N'Nam', 'NV02'),
('KH04', N'Trần Thị Ngọc Huyền', '0354789012', N'Bắc Ninh', '2006-01-24', N'Nữ', 'NV03'),
('KH05', N'Trịnh Đắc Nam', '0365890123', N'TP HCM', '1992-07-08', N'Nam', 'NV06'),
('KH06', N'Đỗ Thùy Chi', '0376901234', N'Bắc Ninh', '1997-04-30', N'Nữ', 'NV08'),
('KH07', N'Trần Minh Thành', '0387012345', N'Hà Nội', '1993-08-16', N'Nam', 'NV06'),
('KH08', N'Hoàng Diệp Linh', '0398123456', N'Bắc Ninh', '2006-03-18', N'Nữ', 'NV02'),
('KH09', N'Lưu Hải Nam', '0319234567', N'Nam Định', '1991-06-18', N'Nam', 'NV12'),
('KH10', N'Trương Mỹ Hạnh', '0320345678', N'Hà Nội', '1996-11-05', N'Nữ', 'NV13'),
('KH11', N'Lý Công Tuấn', '0331456789', N'Quảng Ninh', '1985-03-22', N'Nam', 'NV12'),
('KH12', N'Đinh Ngọc Diệp', '0342567890', N'Huế', '2002-08-10', N'Nữ', 'NV13'),
('KH13', N'Vương Đình Khôi', '0353678901', N'Hà Nội', '1994-05-05', N'Nam', 'NV02'),
('KH14', N'Bùi Thị Huyền Trinh', '0364789012', N'Hà Nội', '1998-02-28', N'Nữ', 'NV03'),
('KH15', N'Phan Văn Đức', '0375890123', N'Nghệ An', '1990-12-12', N'Nam', 'NV08');

-- Thêm dữ liệu Bảng Nhà Cung Cấp
INSERT INTO NHACUNGCAP (MaNCC, TenNCC, DiachiNCC, SDTNCC) 
VALUES
('NCC01', N'Tổng kho May mặc HN', N'Hà Nội', '0243123456'),
('NCC02', N'Xưởng Jeans Sài Gòn', N'TP HCM', '0283987654'),
('NCC03', N'Công ty Thời trang Việt', N'Đà Nẵng', '0236456789'),
('NCC04', N'Phụ kiện Owen', N'Hà Nội', '0243555666'),
('NCC05', N'Dệt may Thành Công', N'TP HCM', '0283111222'),
('NCC06', N'Vải vóc Thượng Hải', N'Lào Cai', '0214888999'),
('NCC07', N'Đồ lót Triumph VN', N'Bình Dương', '0274123123'),
('NCC08', N'Giày dép Biti’s', N'Đồng Nai', '0251345345'),
('NCC09', N'Local Brand Teelab', N'Thái Nguyên', '0208123456'),
('NCC10', N'Xưởng may mặc An Phát', N'Nam Định', '0226999000'),
('NCC11', N'Thời trang trẻ em Kiddo', N'Hà Nội', '0243999999'),
('NCC12', N'Hàn Quốc Fashion', N'Hàn Quốc', '0821234567'),
('NCC13', N'Đồ thể thao Adidas VN', N'TP HCM', '0283777888'),
('NCC14', N'Túi xách Juno', N'Long An', '0272123789'),
('NCC15', N'Đồ đông ấm áp', N'Lạng Sơn', '0205123456');

-- Thêm dữ liệu Bảng Sản Phẩm
INSERT INTO SANPHAM (MaSP, TenSP, LoaiSP, GiaNhap, GiaBan, SoLuongTon, XuatXu, MaNCC) 
VALUES
('SP01', N'Áo Sơ Mi Trắng', N'Áo', 150000, 250000, 0,  N'Việt Nam', 'NCC01'),
('SP02', N'Quần Jean Nam Xanh', N'Quần', 300000, 550000,67,  N'Việt Nam', 'NCC02'),
('SP03', N'Áo Thun Basic', N'Áo', 80000, 150000, 69, N'Việt Nam', 'NCC01'),
('SP04', N'Váy Công Sở', N'Váy', 250000, 450000, 34, N'Việt Nam', 'NCC03'),
('SP05', N'Thắt Lưng Da', N'Phụ kiện', 100000, 200000,129, N'Trung Quốc', 'NCC04'),
('SP06', N'Áo Khoác Gió', N'Áo', 350000, 600000,5, N'Việt Nam', 'NCC05'),
('SP07', N'Quần Tây Âu', N'Quần', 200000, 380000,123, N'Việt Nam', 'NCC03'),
('SP08', N'Túi Xách Da', N'Phụ kiện', 400000, 850000,81, N'Trung Quốc', 'NCC14'),
('SP09', N'Giày Sneaker', N'Giày', 500000, 950000,40, N'Việt Nam', 'NCC08'),
('SP10', N'Áo Hoodie', N'Áo', 200000, 350000,0, N'Việt Nam', 'NCC09'),
('SP11', N'Quần Short Thun', N'Quần', 70000, 130000,0, N'Việt Nam', 'NCC10'),
('SP12', N'Áo Ba Lỗ Trắng', N'Áo', 920000, 2220000,120, N'Việt Nam', 'NCC11'),
('SP13', N'Váy Len Mùa Đông', N'Váy', 300000, 500000,23, N'Hàn Quốc', 'NCC12'),
('SP14', N'Áo Nỉ Có Mũ', N'Áo', 180000, 320000,2, N'Việt Nam', 'NCC09'),
('SP15', N'Quần Kaki Nam', N'Quần', 220000, 420000,13, N'Việt Nam', 'NCC02');

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