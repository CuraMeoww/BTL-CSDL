--Xuất ra Mã + Tên Nhân Viên kho xử lý nhiều phiếu nhập

SELECT NV.MaNV, NV.TenNV, NV.ChucVu, 
       COUNT(PN.MaPN) 
       AS SoPhieuNhapDaXuLy
FROM NHANVIEN NV
JOIN PHIEUNHAP PN
ON NV.MaNV = PN.MaNV
WHERE NV.ChucVu = N'Kho'
GROUP BY NV.MaNV, NV.TenNV, NV.ChucVu