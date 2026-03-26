--Xuất ra tất cả thông tin của nhân viên nữ bán hàng vào làm từ năm 2023

SELECT * 
FROM NHANVIEN 
WHERE GioiTinh = N'Nữ' 
AND ChucVu = N'Bán hàng' 
AND YEAR(NgayVaoLam) >= 2023;