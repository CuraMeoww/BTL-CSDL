--Xuất ra số lần mua của từng khách hàng

SELECT KH.TenKH, COUNT(HD.MaHD) AS SoLanMua
FROM KHACHHANG KH LEFT JOIN HOADON HD
ON KH.MaKH = HD.MaKH
GROUP BY KH.MaKH, KH.TenKH
