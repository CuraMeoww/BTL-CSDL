--Liệt kê khách hàng đã mua sản phẩm của nhà cung cấp Xưởng Jeans Sài Gòn

SELECT DISTINCT 
    KH.TenKH, 
    KH.SDTKH, 
    NCC.TenNCC AS NhaCungCapUaThich
FROM KHACHHANG KH
JOIN HOADON HD ON KH.MaKH = HD.MaKH
JOIN CHITIET_HOADON CTHD ON HD.MaHD = CTHD.MaHD
JOIN SANPHAM SP ON CTHD.MaSP = SP.MaSP
JOIN NHACUNGCAP NCC ON SP.MaNCC = NCC.MaNCC
WHERE NCC.TenNCC = N'Xưởng Jeans Sài Gòn';