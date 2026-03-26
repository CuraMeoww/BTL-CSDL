-- Xác định chi phí nhập hàng từ Xưởng Jeans Sài Gòn trong năm 2023

SELECT SUM(TongTienNhap) AS TongChiPhiNhap
FROM PHIEUNHAP PN
JOIN NHACUNGCAP NCC ON PN.MaNCC = NCC.MaNCC
WHERE NCC.TenNCC = N'Xưởng Jeans Sài Gòn' 
AND YEAR(PN.NgayNhap) = 2023;