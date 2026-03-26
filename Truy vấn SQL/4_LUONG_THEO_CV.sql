-- TRUY VẤN TÍNH TỔNG LƯƠNG NHẬN THEO TỪNG CHỨC VỤ

SELECT 
    NV.ChucVu, 
    SUM(L.LuongCoBan + L.PhuCap) AS TongLuongNhanDuoc
FROM NHANVIEN NV
JOIN LUONG L ON NV.MaLuong = L.MaLuong
GROUP BY NV.ChucVu
